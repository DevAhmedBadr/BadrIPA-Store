# Badr Store backend setup

This repository now includes an initial Supabase schema for the catalog, app versions, user profiles, subscription plans, subscriptions, and private IPA storage.

## Important architecture

- The admin UI and public storefront are browser clients. They must use only the Supabase project URL and anon/publishable key.
- The storefront reads published app metadata and ready version metadata directly through the public RLS policies. IPA objects remain private.
- Never put a Supabase service-role key, payment secret, signing private key, or Apple certificate private key in browser code or Git.
- IPA objects are stored in the private `app-ipa` bucket. Do not make this bucket public.
- App icons are stored in the public `app-icons` bucket.
- User-facing IPA downloads must be authorized by a trusted server/Edge Function that checks the authenticated user, active subscription, app/version status, and then issues a short-lived signed URL.
- Do not trust client-side subscription flags. Payment status must be updated by a verified payment-provider webhook.
- A configuration profile / Web Clip only adds a web shortcut; it does not sign an IPA. iOS installation needs a valid Apple-supported distribution/signing route.

## Setup

1. Create a new Supabase project for Badr Store.
2. Open SQL Editor and run `supabase/schema.sql`.
3. In Authentication settings, enable the sign-in method you intend to use (email/password is the simplest initial option).
4. Create your own user by signing up once.
5. In SQL Editor, promote that account to admin:
   `update public.profiles set role = 'admin' where email = 'YOUR_EMAIL';`
6. Keep the `app-ipa` bucket private. Do not expose service-role credentials.
7. Configure the frontend with the project URL and anon/publishable key only.

## Current status

The public storefront (`index.html`) now reads published apps and ready versions from Supabase. The admin (`admin/index.html`) manages catalog metadata and uploads IPA builds to the private bucket. Secure IPA download delivery still requires a deployed server-side endpoint that checks authorization and issues short-lived signed URLs. Direct installation on iPhone also requires a valid Apple-supported signing/distribution method.

## Starter app catalog

Catalog records are metadata only. They do not include IPA binaries or imply distribution rights. Add only apps and builds you are authorized to distribute.
