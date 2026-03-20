<div align="center">
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:000000,50:0a0a14,100:0a1830&height=200&section=header&text=Trove&fontSize=80&fontColor=ffffff&fontAlignY=55&animation=fadeIn" width="100%"/>

<br/>

[![iOS](https://img.shields.io/badge/iOS-15.0+-007AFF?style=for-the-badge&logo=apple&logoColor=white)](https://trovemobileapp.netlify.app)
[![WebClip](https://img.shields.io/badge/WebClip-Ready-30d158?style=for-the-badge&logo=safari&logoColor=white)](https://trovemobileapp.netlify.app/trove.mobileconfig)
[![Sources](https://img.shields.io/badge/Sources-Active_&_Maintained-ffd60a?style=for-the-badge&logo=bookstack&logoColor=black)](https://trovemobileapp.netlify.app)
[![License](https://img.shields.io/badge/License-Proprietary-ff453a?style=for-the-badge&logo=opensourceinitiative&logoColor=white)](./LICENSE)
[![Made by](https://img.shields.io/badge/Made_by-Strykey-0a84ff?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Strykey)

<br/>

*The iOS app store that Apple didn't want you to have.*

<br/>

[Install Now](#install-in-30-seconds) &nbsp;·&nbsp; [What is this](#what-is-this) &nbsp;·&nbsp; [Sources](#sources) &nbsp;·&nbsp; [Sideload Guide](#sideload-your-ipas) &nbsp;·&nbsp; [Self-host](#self-host) &nbsp;·&nbsp; [FAQ](#faq)

</div>

<br/>

## What is this

Trove is a web-based iOS app store that aggregates a large collection of actively maintained AltStore, SideStore, and LiveContainer repositories into a single clean interface. It fetches each repo's JSON in real time, displays all available apps with their icons, screenshots, descriptions, and version history, and lets you copy the IPA download URL directly or open it straight from Safari.

No account. No subscription. No waiting. Just a very opinionated list of repos and a decent UI.

**It works as a Home Screen web app** thanks to a mobileconfig WebClip. Open it from your home screen and it behaves like a native app: full screen, no browser chrome, splash screen and all.

<br/>

## Screenshots

<div align="center">
<table>
<tr>
<td><img src="https://github.com/user-attachments/assets/5e1e2590-b2a3-48df-8986-15a3251b176f" width="180" style="border-radius:16px"/></td>
<td><img src="https://github.com/user-attachments/assets/00c649a6-42f6-46f9-be1a-7eac19972ae9" width="180" style="border-radius:16px"/></td>
<td><img src="https://github.com/user-attachments/assets/5da7fedc-8ad9-4d47-a7e6-ddfd1aabe8f9" width="180" style="border-radius:16px"/></td>
<td><img src="https://github.com/user-attachments/assets/438feb50-25bb-4c61-822d-dcbb681f7b73" width="180" style="border-radius:16px"/></td>
</tr>
<tr>
<td align="center"><sub>App List</sub></td>
<td align="center"><sub>App Detail</sub></td>
<td align="center"><sub>Sources</sub></td>
<td align="center"><sub>Source info</sub></td>
</tr>
</table>
</div>

<br/>

## Sources

Trove pulls from a large, regularly updated set of repositories on every launch. All source URLs live in `DB.json` and are fetched live via real network requests with a CORS proxy fallback.

The collection covers every major category:

- **Official** sources directly from app developers (AltStore, SideStore, LiveContainer, UTM, PPSSPP, Delta, iSH, and more)
- **Mega libraries** with hundreds to thousands of IPAs (CyPwn, WuXu++, App Testers, Starfiles, AppDB)
- **Tweaked apps** for YouTube, Spotify, Instagram, Snapchat, TikTok, Discord, Twitter, WhatsApp, and more
- **Emulators** for every retro console you can think of (RetroArch, Provenance, DolphiniOS, Flycast, PPSSPP, Mini vMac)
- **Jailbreak tools** for supported iOS versions
- **Utilities** like Feather, UTM, iSH, and various signing tools
- **Streaming apps** and anime players
- **Games** including PokeMMO

Every source has a trust score, a certified badge if it has been verified, and an official badge if it comes straight from the developer. The database is kept up to date and sources that go dead get removed.

<br/>

## Install in 30 seconds

The fastest path. No computer needed.

**Step 1.** Download `trove.mobileconfig` from the [latest release](https://github.com/Strykey/Trove-Store/releases/latest).

**Step 2.** Open the Files app, find the downloaded file and tap it. iOS will prompt you to review the profile.

**Step 3.** Go to `Settings > General > VPN & Device Management`, tap **Trove** and then **Install**. Enter your passcode when prompted.

**Step 4.** Trove appears on your Home Screen. Open it.

Done. The app loads all sources automatically on first launch.

> If the profile does not appear in Settings right after tapping the file, close Settings and reopen it. It usually shows up within a few seconds.

<br/>

## Sideload your IPAs

Found an app you want in Trove. Here is how to actually install it on your iPhone. Three options depending on how deep you want to go.

### Option A - SideStore (recommended, no computer after setup)

SideStore is a fork of AltStore that runs entirely on-device after one initial setup session. One computer session, then freedom forever.

**What you need:** A Windows or Mac computer, a free Apple ID (a burner one is fine), a USB cable.

1. Download [iLoader](https://iloader.site/) on your computer.
2. Open iLoader, tap `Add Account +` and sign in with your Apple ID.
3. Plug your iPhone in via USB and select it under Devices.
4. Under Installers, pick **SideStore (Stable)** and wait for it to install.
5. On your iPhone go to `Settings > General > VPN & Device Management` and trust the developer certificate.
6. Open SideStore. It will ask you to enable LocalDevVPN. Enable it.
7. Sign in with the same Apple ID.

SideStore is now set up. To install any IPA, tap the `+` icon in My Apps and select your file from Files or your Downloads folder.

Apps expire after 7 days. The SideStore docs include a Shortcuts automation that refreshes everything automatically in the background.

### Option B - LiveContainer (unlimited apps, one slot)

LiveContainer is a virtual app launcher. It runs IPA files inside a container so the 3-app free tier limit does not apply. You can have well over a hundred apps installed using exactly one slot on your Apple ID.

**Install LiveContainer via SideStore:**

1. Set up SideStore first using Option A.
2. Download the latest `LiveContainer+SideStore.ipa` from the [official releases page](https://github.com/LiveContainer/LiveContainer/releases).
3. Open SideStore, go to My Apps, tap `+` and select the IPA.
4. When prompted, tap **Keep App Extensions (Use Main Profile)**. This is important.
5. Open LiveContainer from your Home Screen.
6. Tap the SideStore icon in the top-left. Navigate to `On My iPhone > SideStore` and select `ALTPairingFile.mobiledevicepairing`.
7. In My Apps tap `7 DAYS` next to LiveContainer and sign in to refresh it.
8. Go to `Settings > Import Certificate from SideStore` and tap OK.
9. Tap `JIT-less Mode Diagnosis > Test JIT-less Mode`. It should return Success.

**Adding apps to LiveContainer:**

1. Open LiveContainer.
2. Tap the `+` icon in the top-right.
3. Select your IPA from Files.
4. Long-press any installed app to rename it, manage it, or add a Home Screen shortcut.

Apps launched from LiveContainer behave normally. You can pin shortcuts directly to your Home Screen so they open without going through the LiveContainer UI first.

> Not every IPA is compatible. Apps that require kernel entitlements, VPN extensions, or persistent background audio may have issues. Check the [compatibility list](https://github.com/LiveContainer/LiveContainer/blob/main/COMPATIBILITY.md) when something does not work.

### Option C - Sideloadly (simplest, needs a computer each time)

If you just want to install one IPA quickly without any ongoing setup:

1. Download [Sideloadly](https://sideloadly.io) for Windows or Mac.
2. Connect your iPhone via USB.
3. Drag your IPA into Sideloadly, enter your Apple ID, click Start.
4. Trust the certificate at `Settings > General > VPN & Device Management`.
5. Done.

You will need to re-sign every 7 days by repeating the same drag-and-drop process.

<br/>

## Self-host

The entire app is four static files. No backend. No build step. No Node.js. Nothing to install.

```
Trove/
├── index.html          The entire app (UI, logic, everything in one file)
├── DB.json             All repo sources with metadata and trust scores
├── icon.png            180x180 app icon
└── trove.mobileconfig  WebClip profile for Home Screen installation
```

**Deploy to Netlify:**

1. Fork this repository.
2. Go to [netlify.com](https://netlify.com), create a free account, and connect your fork.
3. Deploy. No build command needed, just publish the root directory.
4. Update the URL in `trove.mobileconfig` to your Netlify domain.

**Deploy anywhere else (GitHub Pages, Vercel, Cloudflare Pages, a VPS):**

The only hard requirement is HTTPS. The WebClip profile will not install over plain HTTP and the standalone detection relies on a secure context.

**Adding or updating sources:**

Edit `DB.json`. Each entry looks like this:

```json
{
  "id": 1,
  "name": "Repo Name",
  "url": "https://direct-link-to-altstore-format.json",
  "category": "Tweaked Apps",
  "tags": ["spotify", "premium"],
  "description": "What this repo contains.",
  "maintainer": "Developer Name",
  "github": "https://github.com/...",
  "apps": "50+",
  "update_freq": "Weekly",
  "ios_min": "14.0",
  "trust": 90,
  "certified": true,
  "official": false,
  "working": true,
  "note": "Optional note shown in the app."
}
```

The `url` field must point directly to an AltStore-format JSON file, not a webpage. The app fetches it live on every load.

<br/>

## How it works technically

On load Trove fetches `DB.json` and gets the full repo list. It then fetches each repo's AltStore JSON in parallel batches of 6, using `corsproxy.io` as a CORS fallback when a direct request fails. All parsed app objects are stored in a JavaScript `Map` with numeric integer IDs. Tapping any row calls `openStoredApp(id)` which retrieves the object by key and renders the detail sheet. No JSON is ever serialized into HTML attributes, which was the source of every click bug you have ever seen in a web-based store.

Screenshots are displayed in a horizontally scrollable strip inside the detail sheet. Tapping any screenshot opens a fullscreen lightbox with a blur backdrop. Swipe down anywhere on a detail sheet to close it.

In standalone mode (`navigator.standalone === true`, meaning opened from the Home Screen WebClip), a splash screen plays for 2.8 seconds before the app fades in. In browser mode it cuts to 1.4 seconds because you are clearly just browsing and do not need the full ceremony.

<br/>

## FAQ

**Why does the mobileconfig go through VPN and Device Management?**
That is just how iOS handles WebClip profiles. It is the same system Apple Configurator and enterprise MDM solutions use. No VPN is created, no device management actually occurs. The profile contains only the app URL, icon, and display name. You can inspect the raw XML in `trove.mobileconfig` yourself.

**Can I install without the profile?**
Yes. Open the site in Safari, tap the Share button, and choose Add to Home Screen. You lose the splash screen and full-screen mode but everything else works the same.

**Why is a source not loading?**
The CORS proxy timed out or the source is temporarily down. Tap Retry on that source. Some repos like App Testers are just slow because they have thousands of entries.

**The app is blank when I open it.**
Make sure you are on a network connection. Trove has no offline mode, all data is fetched live.

**Is it safe?**
The mobileconfig installs one WebClip shortcut. It requests zero permissions. You can delete it at any time from `Settings > General > VPN & Device Management > Trove > Remove Profile`. The full source code is in this repository.

**Why does content differ between visits?**
Some repos push updates multiple times a day. Since everything is fetched live you always see the current state of each source.

<br/>

## Contributing

Pull requests are welcome for bug fixes and new well-maintained sources. If you are adding a repo, make sure the URL is a direct AltStore-format JSON, the source has been updated in the last few months, and the trust score you suggest is realistic.

For bugs in the web app, include your iOS version, Safari version, and whether you are in standalone (WebClip) or browser mode.

<br/>

## License

See [LICENSE](./LICENSE). This project is not open for copying, redistribution, or commercial use without explicit written permission from the author.

<br/>

<div align="center">

built with too many `requestAnimationFrame` calls by **Strykey**

<br/>

[![GitHub stars](https://img.shields.io/github/stars/Strykey/Trove-Store?style=for-the-badge&color=ffd60a&labelColor=1a1a1a)](https://github.com/Strykey/Trove-Store/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Strykey/Trove-Store?style=for-the-badge&color=0a84ff&labelColor=1a1a1a)](https://github.com/Strykey/Trove-Store/network)

<br/>

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0a1830,50:0a0a14,100:000000&height=120&section=footer" width="100%"/>

</div>
