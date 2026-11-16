-- Badr Store initial database schema
-- Run in Supabase SQL Editor. Review and apply to a NEW project.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  display_name text,
  role text not null default 'customer' check (role in ('customer','admin')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.apps (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  bundle_id text,
  category text not null default 'Other',
  short_description text,
  description text,
  icon_path text,
  developer_name text,
  is_featured boolean not null default false,
  status text not null default 'draft' check (status in ('draft','published','archived')),
  current_version_id uuid,
  created_by uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.app_versions (
  id uuid primary key default gen_random_uuid(),
  app_id uuid not null references public.apps(id) on delete cascade,
  version text not null,
  build_number integer,
  release_notes text,
  ipa_object_path text,
  ipa_sha256 text,
  file_size_bytes bigint,
  signing_method text,
  minimum_ios_version text,
  status text not null default 'draft' check (status in ('draft','ready','withdrawn')),
  created_by uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  unique(app_id, version, build_number)
);

alter table public.apps
  drop constraint if exists apps_current_version_id_fkey;
alter table public.apps
  add constraint apps_current_version_id_fkey
  foreign key (current_version_id) references public.app_versions(id) on delete set null;

create table if not exists public.subscription_plans (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  billing_interval text not null check (billing_interval in ('monthly','yearly')),
  price_minor integer not null check (price_minor >= 0),
  currency char(3) not null default 'EUR',
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  plan_id uuid references public.subscription_plans(id) on delete set null,
  provider text,
  provider_subscription_id text unique,
  status text not null default 'pending' check (status in ('pending','active','past_due','cancelled','expired')),
  current_period_start timestamptz,
  current_period_end timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists apps_status_category_idx on public.apps(status, category);
create index if not exists app_versions_app_created_idx on public.app_versions(app_id, created_at desc);
create index if not exists subscriptions_user_status_idx on public.subscriptions(user_id, status);

create or replace function public.is_badr_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles(id, email, display_name)
  values (new.id, new.email, coalesce(new.raw_user_meta_data->>'name',''))
  on conflict (id) do update set email = excluded.email;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created_badr on auth.users;
create trigger on_auth_user_created_badr
after insert on auth.users
for each row execute procedure public.handle_new_user();

alter table public.profiles enable row level security;
alter table public.apps enable row level security;
alter table public.app_versions enable row level security;
alter table public.subscription_plans enable row level security;
alter table public.subscriptions enable row level security;

drop policy if exists "profile read self or admin" on public.profiles;
create policy "profile read self or admin" on public.profiles for select to authenticated
using (id = auth.uid() or public.is_badr_admin());
drop policy if exists "profile admin update" on public.profiles;
create policy "profile admin update" on public.profiles for update to authenticated
using (public.is_badr_admin()) with check (public.is_badr_admin());

drop policy if exists "published apps visible" on public.apps;
create policy "published apps visible" on public.apps for select to anon, authenticated
using (status = 'published' or public.is_badr_admin());
drop policy if exists "admin manages apps" on public.apps;
create policy "admin manages apps" on public.apps for all to authenticated
using (public.is_badr_admin()) with check (public.is_badr_admin());

drop policy if exists "ready versions visible for published apps" on public.app_versions;
create policy "ready versions visible for published apps" on public.app_versions for select to anon, authenticated
using (
  public.is_badr_admin() or
  (status = 'ready' and exists (
    select 1 from public.apps a where a.id = app_id and a.status = 'published'
  ))
);
drop policy if exists "admin manages versions" on public.app_versions;
create policy "admin manages versions" on public.app_versions for all to authenticated
using (public.is_badr_admin()) with check (public.is_badr_admin());

drop policy if exists "active plans visible" on public.subscription_plans;
create policy "active plans visible" on public.subscription_plans for select to anon, authenticated
using (is_active or public.is_badr_admin());
drop policy if exists "admin manages plans" on public.subscription_plans;
create policy "admin manages plans" on public.subscription_plans for all to authenticated
using (public.is_badr_admin()) with check (public.is_badr_admin());

drop policy if exists "users read own subscriptions" on public.subscriptions;
create policy "users read own subscriptions" on public.subscriptions for select to authenticated
using (user_id = auth.uid() or public.is_badr_admin());
drop policy if exists "admin manages subscriptions" on public.subscriptions;
create policy "admin manages subscriptions" on public.subscriptions for all to authenticated
using (public.is_badr_admin()) with check (public.is_badr_admin());

-- Private bucket: never expose raw IPA objects as public URLs.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('app-ipa','app-ipa',false,2147483648,array['application/octet-stream','application/zip'])
on conflict (id) do update set public = false;

-- Public bucket only for app icons/artwork.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('app-icons','app-icons',true,10485760,array['image/png','image/jpeg','image/webp','image/svg+xml'])
on conflict (id) do update set public = true;

drop policy if exists "admin upload IPA" on storage.objects;
create policy "admin upload IPA" on storage.objects for insert to authenticated
with check (bucket_id = 'app-ipa' and public.is_badr_admin());
drop policy if exists "admin read IPA" on storage.objects;
create policy "admin read IPA" on storage.objects for select to authenticated
using (bucket_id = 'app-ipa' and public.is_badr_admin());
drop policy if exists "admin update IPA" on storage.objects;
create policy "admin update IPA" on storage.objects for update to authenticated
using (bucket_id = 'app-ipa' and public.is_badr_admin())
with check (bucket_id = 'app-ipa' and public.is_badr_admin());
drop policy if exists "admin delete IPA" on storage.objects;
create policy "admin delete IPA" on storage.objects for delete to authenticated
using (bucket_id = 'app-ipa' and public.is_badr_admin());

drop policy if exists "public read app icons" on storage.objects;
create policy "public read app icons" on storage.objects for select to anon, authenticated
using (bucket_id = 'app-icons');
drop policy if exists "admin upload app icons" on storage.objects;
create policy "admin upload app icons" on storage.objects for insert to authenticated
with check (bucket_id = 'app-icons' and public.is_badr_admin());
drop policy if exists "admin update app icons" on storage.objects;
create policy "admin update app icons" on storage.objects for update to authenticated
using (bucket_id = 'app-icons' and public.is_badr_admin())
with check (bucket_id = 'app-icons' and public.is_badr_admin());
drop policy if exists "admin delete app icons" on storage.objects;
create policy "admin delete app icons" on storage.objects for delete to authenticated
using (bucket_id = 'app-icons' and public.is_badr_admin());

-- Create your first administrator after signing up:
-- update public.profiles set role = 'admin' where email = 'YOUR_EMAIL';
