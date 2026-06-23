# Open Source Hub

Open Source Hub is an archive of Roblox scripts that were hidden, obfuscated, or otherwise difficult for users to inspect.

The goal of this repository is transparency. When a script is distributed through a loader, packed behind obfuscation, or tries to keep its real behavior out of sight, a recovered source copy can help people understand what is actually inside before they choose to run, study, or reference it.

Each folder contains a script source or related recovered files for that entry. Some scripts are fully deobfuscated, while others are partial recoveries, readable reconstructions, or public source copies that were originally delivered through a remote loader.

This archive is for review, research, education, and preservation. Always inspect code yourself before running anything from the internet.

## Browse

- [Full script catalog](CATALOG.md) - clean list of every archived script, status, main file, and notes.
- Each script folder now has a `README.md` with the local file map and recovery status.
- Start with `Main.lua` inside a folder unless that folder README points to a more specific file.

## Current Archive

| Script | Recovered files | How it was hidden | How it was opened up |
| --- | --- | --- | --- |
| Aetherea Bloxburg Auto | `Aetherea Bloxburg Auto/Main.lua`, `RubisPrompt.lua`, `OriginalLoader.lua` | The visible script was a remote loader for `https://aetherea.lol/free-bloxburg-auto.luau`. The fetched source is marked Luraph v14.6 and contains a protected initv4-style payload. Before the protected tail runs, it fetches a Rubis raw script. | The Aetherea URL and Rubis raw URL were fetched as data, syntax-checked, hashed, and archived. The Rubis stage is readable and shows a Discord prompt that copies `https://discord.gg/d6B27J2uYm` and can POST to local Discord RPC. The Luraph helper detected `luraph_v14_4_initv4`, but the automation payload still needs the script key for full devirtualization. |
| Atlas Hub | `failed/Atlas Hub/AtlasHub.lua`, `Redliner.obfuscated.lua`, `OriginalLoader.lua`, `attempts/moonsec_attempt.log` | The visible script was a raw GitHub loader. The first stage is readable key-system code, but the actual payload is loaded afterward from `Redliner.lua` and is marked MoonVeil 2.0.14-beta. | The raw GitHub loader and second-stage URL were fetched as data, syntax-checked, hashed, and archived. The existing MoonSec devirtualizer was tested, but the detector did not match and the analyzer failed with `NoBody`, so the entry is stored under `failed/` with the attempt artifacts. |
| Anti-afk | `Anti-afk/Main.lua` | The archived copy was already readable source. The hiding was mostly the normal distribution problem: users receive a script without much context and have to trust what it does. | The readable single-file source was copied into the archive and syntax-checked with Luau tooling. |
| Arsenic Hub Free | `Arsenic Hub Free/Main.lua`, `Loader.lua`, `OriginalLoader.lua`, `Line299DecodedVM.lua`, `Line299Payload.bin` | The user-facing script was a tiny `loadstring(game:HttpGet(...))()` wrapper pointed at the Junkie API. The fetched file used a Havoc/Junkie key-system wrapper and ended in a Luraph v14.7 protected payload. | The public API URL was followed to its CDN target, the second-stage source was saved, URLs and hashes were documented, and the readable wrapper behavior was preserved. The line-299 Luraph loader was run in a Luau harness with fake `loadstring`/`buffer.fromstring` hooks, exposing the decoded VM source and payload buffer. |
| Arsenic Hub Free 2 | `Arsenic Hub Free 2/Main.lua`, `Loader.lua`, `OriginalLoader.lua`, `Line299DecodedVM.lua`, `Line299Payload.bin` | Same hiding pattern as Arsenic Hub Free: a remote Junkie API loader, CDN redirect, key-system wrapper, then Luraph v14.7 payload. The original public API endpoint later returned 404. | The direct CDN payload was still recoverable, so it was archived with its loader chain, hashes, and notes. The line-299 Luraph loader was decoded to its VM source and payload buffer, but the VM payload remains a partial recovery without the script key. |
| Arsenic Hub Free 3 | `Arsenic Hub Free 3/Main.lua`, `Loader.lua`, `OriginalLoader.lua`, `Line299DecodedVM.lua`, `Line299Payload.bin` | Remote Junkie API loader, CDN redirect, Havoc/Junkie key-system wrapper, and Luraph v14.7 protected tail. | The redirect target was fetched and stored. Artifact-only Luraph analysis recovered some constants, and the line-299 Luraph loader was decoded to its VM source plus payload buffer. The archive keeps the protected VM payload clearly marked instead of pretending it is fully cracked. |
| F2Play Aimbot | `failed/F2Play Aimbot/Loader.obfuscated.lua`, `OriginalLoader_PC.lua`, `OriginalLoader_Mobile_Normalized.lua`, `attempts/decoded_constants.txt` | The PC loader and usable mobile target both point at a raw GitHub file. The fetched file is a single MoonVeil v1.4.5 VM payload. The mobile line provided in chat was malformed, so the exact text and normalized loader are both preserved. | The raw GitHub payload was fetched as data, syntax-checked, hashed, and archived. The generic Lua deobfuscator failed on MoonVeil/Luau syntax. A static XOR-string extractor recovered 49 printable wrapper constants but found no visible URL or `loadstring` constants outside the encrypted VM payload, so this entry is stored under `failed/`. |
| Murder Duels | `Murder Duels/Main.lua` | The script depended on a remote/obfuscated UI library named like `obsf.lua`, keeping important behavior outside the visible entry script. | The UI library and script logic were combined into one readable file, so the archived source can be reviewed without pulling the remote dependency at runtime. |
| NinijaLegendv2 | `NinijaLegendv2/Main.lua` | The dirty entry was an XOR-encrypted `loadstring(game:HttpGet(...))` loader that hid the real URL. | The XOR layer was decoded, revealing a raw GitHub source URL. The decoded source was saved as `Main.lua`; it still contains many downstream `loadstring` buttons, so this entry exposes the hub/router source rather than every linked server script. |
| NinjaLegendsInf$ | `NinjaLegendsInf$/Main.lua` | This entry was not strongly protected in the recovered copy; it was a plain one-file GUI script. | The readable source was archived as-is and syntax-checked. |
| OmniScan V1 | `OmniScan V1/Main.lua` | This entry was already readable source in the recovered folder. | The complete one-file source was archived and syntax-checked so it can be reviewed directly. |
| Sell Lemons | `Sell Lemons/1/Main.lua`, `Sell Lemons/1/CalmLib.lua` | The main script loads a public UI library remotely with `loadstring(game:HttpGet(...))`, so part of the behavior was outside the entry file. | The main script and the public CalmLib source were archived together. This is an open-source capture, not a heavy deobfuscation. |
| ShizukiWallHop | `ShizukiWallHop/Main.lua` | The dirty script carried a LuaObfuscator.com Alpha 0.10.8 banner and was mostly minified/renamed rather than VM-protected. It also has one external Shiftlock loader button. | The code was reconstructed into readable Luau with clearer names and structure. The remaining Shiftlock URL is kept explicit instead of hidden inside the script body. |
| Spoofers | `Spoofers/videospoofer.lua` | This entry is plain source and was not meaningfully obfuscated in the archived copy. | The readable source was kept directly for review. |
| Universal 2 | `Universal 2/Main.lua`, `WrdLayer.lua`, `Loader.lua`, `OriginalLoader.lua` | The loader fetched through the Junkie API to a CDN file. The payload used a WeAreDevs obfuscator VM layer followed by a Luraph v14.7 protected tail. | The API redirect was resolved, the CDN payload was archived, and the WRD layer was probed with Roblox/executor stubs to recover readable constants and network fetches. The Luraph tail is documented as partial because full recovery would require the script key. |
| sUNC | `sUNC/Main.lua` | The original dirty script was a Luraph v14.2 VM wrapper around an executor capability test. | Runtime behavior was reconstructed into readable Luau tests. This is a behavioral reconstruction, not a full instruction-level devirtualization of the Luraph VM. |
| server38 | `server38/Main.lua` | The dirty script was protected with MoonSec V3 and hid a raw GitHub loader URL. | A sandboxed runtime probe with Roblox/executor stubs recovered the decoded loader URL, then the source at that URL was archived as readable Luau. |
| splotv4.1 | `splotv4.1/Main.lua` | The original used Anundix-style obfuscation: octal string escapes plus random identifiers, with no hidden remote loader. | Octal escapes were decoded, identifiers and formatting were cleaned up, and the result was saved as a readable one-file GUI script. |

## General Recovery Pattern

Most entries were opened up with the same review workflow:

1. Identify whether the visible file is real source or only a wrapper.
2. If it is a wrapper, extract the URL from `loadstring(game:HttpGet(...))` and save the fetched payload instead of running it blindly.
3. Follow simple redirect chains from public API endpoints to their CDN or raw source targets.
4. Decode simple hiding layers such as XOR strings, octal escapes, minified names, and remote library indirection.
5. For VM obfuscators such as Luraph, MoonSec, or WRD, use sandboxed Roblox/executor stubs to observe constants, URLs, and behavior without executing the script in a real game session.
6. Preserve partial results honestly. If a VM tail is still protected, document that instead of claiming a complete deobfuscation.
7. Run a Luau syntax check on recovered files before adding them to the archive.

The safest mindset is to treat every loader as untrusted. Read the wrapper, fetch the source as data, document the chain, and only then decide what the code is doing.
