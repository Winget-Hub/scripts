# Script Catalog

Use this page as the quick browse index for Open Source Hub. Each row links to the script folder, shows the main review file, and calls out whether the source is fully readable or still a partial recovery.

## All Scripts

| Script | Status | Main file | Notes |
| --- | --- | --- | --- |
| [Aetherea Bloxburg Auto](Aetherea%20Bloxburg%20Auto/) | Partial Luraph recovery | [`Main.lua`](Aetherea%20Bloxburg%20Auto/Main.lua) | Remote loader and Rubis prompt recovered; protected Luraph tail remains partial. |
| [Anti-afk](Anti-afk/) | Readable source | [`Main.lua`](Anti-afk/Main.lua) | Plain anti-idle helper script. |
| [Arsenic Hub Free](Arsenic%20Hub%20Free/) | Partial VM recovery | [`Main.lua`](Arsenic%20Hub%20Free/Main.lua) | Junkie/Havoc wrapper plus decoded line-299 VM and payload buffer. |
| [Arsenic Hub Free 2](Arsenic%20Hub%20Free%202/) | Partial VM recovery | [`Main.lua`](Arsenic%20Hub%20Free%202/Main.lua) | CDN payload recovered after API became unavailable; decoded line-299 VM and payload buffer included. |
| [Arsenic Hub Free 3](Arsenic%20Hub%20Free%203/) | Partial VM recovery | [`Main.lua`](Arsenic%20Hub%20Free%203/Main.lua) | CDN payload, Luraph artifacts, decoded line-299 VM and payload buffer included. |
| [Murder Duels](Murder%20Duels/) | Combined readable source | [`Main.lua`](Murder%20Duels/Main.lua) | Remote UI dependency was combined into one reviewable file. |
| [NinijaLegendv2](NinijaLegendv2/) | Loader decoded | [`Main.lua`](NinijaLegendv2/Main.lua) | XOR loader decoded to its GitHub source; downstream button loaders are still external. |
| [NinjaLegendsInf$](NinjaLegendsInf$/) | Readable source | [`Main.lua`](NinjaLegendsInf$/Main.lua) | Plain one-file GUI script. |
| [OmniScan V1](OmniScan%20V1/) | Readable source | [`Main.lua`](OmniScan%20V1/Main.lua) | Plain one-file scanner script. |
| [Sell Lemons](Sell%20Lemons/) | Main plus library | [`1/Main.lua`](Sell%20Lemons/1/Main.lua) | Main script and CalmLib dependency archived together. |
| [ShizukiWallHop](ShizukiWallHop/) | Reconstructed source | [`Main.lua`](ShizukiWallHop/Main.lua) | LuaObfuscator/minified source reconstructed into readable Luau. |
| [Spoofers](Spoofers/) | Readable source | [`videospoofer.lua`](Spoofers/videospoofer.lua) | Plain video spoofer source. |
| [Universal 2](Universal%202/) | Partial WRD/Luraph recovery | [`Main.lua`](Universal%202/Main.lua) | Junkie loader resolved; WRD layer exposed; Luraph tail remains partial. |
| [sUNC](sUNC/) | Behavioral reconstruction | [`Main.lua`](sUNC/Main.lua) | Rebuilt readable executor capability tests from a Luraph-protected source. |
| [server38](server38/) | Loader decoded | [`Main.lua`](server38/Main.lua) | MoonSec-protected loader URL recovered and archived. |
| [splotv4.1](splotv4.1/) | Reconstructed source | [`Main.lua`](splotv4.1/Main.lua) | Anundix-style escapes decoded and identifiers/formatting cleaned. |

## Status Key

| Status | Meaning |
| --- | --- |
| Readable source | The archived file is plain source and can be reviewed directly. |
| Combined readable source | Remote dependencies were pulled into the archive so the script can be reviewed without runtime fetches. |
| Loader decoded | The visible wrapper was decoded/resolved, but the script may still load downstream URLs. |
| Reconstructed source | Obfuscation/minification was rewritten into readable Luau. |
| Behavioral reconstruction | The original VM was not instruction-for-instruction recovered; behavior was rebuilt into readable code. |
| Partial VM/Luraph recovery | Some protected layers were opened, but the final virtualized payload is still not readable original source. |

## Folder File Names

| File | Meaning |
| --- | --- |
| `Main.lua` | Main archived source or best current recovered source. |
| `OriginalLoader.lua` | The user-facing loader that started the chain. |
| `Loader.lua` | A cleaned or documented loader-stage file. |
| `Line299DecodedVM.lua` | Decoded Luraph VM source extracted from Arsenic line 299. |
| `Line299Payload.bin` | Binary VM payload passed into the decoded Arsenic VM. |
| `README.md` | Per-script notes, source chain, status, and verification details. |
