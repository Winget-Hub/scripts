# Script Catalog

Use this page as the quick browse index for Open Source Hub. Each row links to the script folder, shows the main review file, and calls out whether the source is fully readable or still a partial recovery.

## All Scripts

| Script | Status | Main file | Notes |
| --- | --- | --- | --- |
| [ABA Free Script](failed/ABA%20Free%20Script/) | Failed VM recovery | [`Payload.obfuscated.lua`](failed/ABA%20Free%20Script/Payload.obfuscated.lua) | Screenshot Junkie loader archived; Luraph v14.7 payload resisted keyed recovery and only produced `noop()`. |
| [ABA Free Script No Key](failed/ABA%20Free%20Script%20No%20Key/) | Failed VM recovery | [`Payload.obfuscated.lua`](failed/ABA%20Free%20Script%20No%20Key/Payload.obfuscated.lua) | Screenshot Junkie loader archived; Luraph v14.7 payload resisted the `no key needed` recovery pass and only produced `noop()` placeholders. |
| [Aetherea Bloxburg Auto](Aetherea%20Bloxburg%20Auto/) | Partial Luraph recovery | [`Main.lua`](Aetherea%20Bloxburg%20Auto/Main.lua) | Remote loader and Rubis prompt recovered; protected Luraph tail remains partial. |
| [Atlas Hub](failed/Atlas%20Hub/) | Failed MoonVeil recovery | [`AtlasHub.lua`](failed/Atlas%20Hub/AtlasHub.lua) | Readable key-system stage recovered; MoonVeil 2.0.14 second stage archived with attempt logs. |
| [Anti-afk](Anti-afk/) | Readable source | [`Main.lua`](Anti-afk/Main.lua) | Plain anti-idle helper script. |
| [Arsenic Hub Free](Arsenic%20Hub%20Free/) | Partial VM recovery | [`Main.lua`](Arsenic%20Hub%20Free/Main.lua) | Junkie/Havoc wrapper plus decoded line-299 VM and payload buffer. |
| [Arsenic Hub Free 2](Arsenic%20Hub%20Free%202/) | Partial VM recovery | [`Main.lua`](Arsenic%20Hub%20Free%202/Main.lua) | CDN payload recovered after API became unavailable; decoded line-299 VM and payload buffer included. |
| [Arsenic Hub Free 3](Arsenic%20Hub%20Free%203/) | Partial VM recovery | [`Main.lua`](Arsenic%20Hub%20Free%203/Main.lua) | CDN payload, Luraph artifacts, decoded line-299 VM and payload buffer included. |
| [Backdoor-darkz](Backdoor-darkz/) | Partial MoonSec recovery | [`Main.lua`](Backdoor-darkz/Main.lua) | DarkX key GUI and Work.ink validation behavior reconstructed; post-unlock payload remains incomplete. |
| [BladeBall 1](BladeBall%201/) | Loader/TOS recovery | [`Main.lua`](BladeBall%201/Main.lua) | NodeX TOS prompt and loader chain archived with decoded loader artifacts. |
| [Bloxberg 1](Bloxberg%201/) | Partial WRD recovery | [`Main.lua`](Bloxberg%201/Main.lua) | Bloxburg UI/control surface reconstructed from a WeAreDevs VM wrapper. |
| [F2Play Aimbot](failed/F2Play%20Aimbot/) | Failed MoonVeil recovery | [`Loader.obfuscated.lua`](failed/F2Play%20Aimbot/Loader.obfuscated.lua) | PC/mobile raw GitHub loader archived; MoonVeil v1.4.5 payload resisted current tooling. |
| [Gag Free Script](failed/Gag%20Free%20Script/) | Failed VM recovery | [`GagFreeScript.lua`](failed/Gag%20Free%20Script/GagFreeScript.lua) | Readable key-system wrapper archived; Luraph v14.7 second stage resisted keyed recovery and only produced placeholders. |
| [Grow a Garden 1](Grow%20a%20Garden%201/) | Loader decoded | [`Main.lua`](Grow%20a%20Garden%201/Main.lua) | VM loader decoded to a GitHub payload URL that returned 404 during recovery. |
| [Jujutsu Shinanegans](failed/Jujutsu%20Shinanegans/) | Failed MoonVeil recovery | [`JjsLoader.obfuscated.lua`](failed/Jujutsu%20Shinanegans/JjsLoader.obfuscated.lua) | Screenshot PC/mobile loaders archived; MoonVeil v1.4.5 payload resisted current tooling. |
| [Junk Drawer](Junk%20Drawer/) | Mixed holding area | [`README.md`](Junk%20Drawer/README.md) | Dirty-only, empty, or partial skid-folder entries that do not fit the main recovered-source list yet. |
| [Mark22028 Anti-Afk](Mark22028%20Anti-Afk/) | Readable source | [`Main.lua`](Mark22028%20Anti-Afk/Main.lua) | Screenshot anti-AFK loader archived as plain source. |
| [Murder Duels](Murder%20Duels/) | Combined readable source | [`Main.lua`](Murder%20Duels/Main.lua) | Remote UI dependency was combined into one reviewable file. |
| [MurderDuels 2](MurderDuels%202/) | Readable source recovery | [`Main.lua`](MurderDuels%202/Main.lua) | Sheriffs Duels/Sniper Assist source and fetch stage archived. |
| [NinijaLegendv2](NinijaLegendv2/) | Loader decoded | [`Main.lua`](NinijaLegendv2/Main.lua) | XOR loader decoded to its GitHub source; downstream button loaders are still external. |
| [Ninja Legends Universal V1](Ninja%20Legends%20Universal%20V1/) | Partial Voltils recovery | [`Main.lua`](Ninja%20Legends%20Universal%20V1/Main.lua) | Analysis scaffold plus runtime-recovered artifacts; control-flow VM remains partial. |
| [NinjaLegends hub 2](NinjaLegends%20hub%202/) | Partial bytecode reconstruction | [`Main.lua`](NinjaLegends%20hub%202/Main.lua) | Readable reconstruction and bytecode notes archived. |
| [NinjaLegendsInf$](NinjaLegendsInf$/) | Readable source | [`Main.lua`](NinjaLegendsInf$/Main.lua) | Plain one-file GUI script. |
| [OmniScan V1](OmniScan%20V1/) | Readable source | [`Main.lua`](OmniScan%20V1/Main.lua) | Plain one-file scanner script. |
| [Proxima Hub](Proxima%20Hub/) | Partial MoonSec recovery | [`Main.lua`](Proxima%20Hub/Main.lua) | Wrapper, telemetry POST, and place payload reconstruction archived. |
| [Sell Lemons](Sell%20Lemons/) | Main plus library | [`1/Main.lua`](Sell%20Lemons/1/Main.lua) | Main script and CalmLib dependency archived together. |
| [ShizukiWallHop](ShizukiWallHop/) | Reconstructed source | [`Main.lua`](ShizukiWallHop/Main.lua) | LuaObfuscator/minified source reconstructed into readable Luau. |
| [Spoofers](Spoofers/) | Readable source | [`videospoofer.lua`](Spoofers/videospoofer.lua) | Plain video spoofer source. |
| [Universal 2](Universal%202/) | Partial WRD/Luraph recovery | [`Main.lua`](Universal%202/Main.lua) | Junkie loader resolved; WRD layer exposed; Luraph tail remains partial. |
| [Universal 1](Universal%201/) | Loader decoded | [`Main.lua`](Universal%201/Main.lua) | WeAreDevs VM wrapper decoded to the FreeezeTrade GitHub loader. |
| [The Strongest Battlegrounds](failed/The%20Strongest%20Battlegrounds/) | Failed MoonVeil recovery | [`TsbLoader.lua`](failed/The%20Strongest%20Battlegrounds/TsbLoader.lua) | Readable key-system wrapper archived; MoonVeil v1.4.5 second stage resisted current tooling. |
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
| Failed VM recovery | A loader or first stage was recovered, but the protected payload could not be devirtualized with the available tools. Failed entries live under `failed/` with attempt logs. |

## Folder File Names

| File | Meaning |
| --- | --- |
| `Main.lua` | Main archived source or best current recovered source. |
| `OriginalLoader.lua` | The user-facing loader that started the chain. |
| `Loader.lua` | A cleaned or documented loader-stage file. |
| `Line299DecodedVM.lua` | Decoded Luraph VM source extracted from Arsenic line 299. |
| `Line299Payload.bin` | Binary VM payload passed into the decoded Arsenic VM. |
| `README.md` | Per-script notes, source chain, status, and verification details. |
