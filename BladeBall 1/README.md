# BladeBall 1 Recovery Report

## Files

- Main recovered source: `Main.lua`
- Fetched loader stage: `Loadstring.lua`
- Deobfuscated loader artifact: `Loadstring.deobfuscated.txt`
- Structured loader decode: `Loadstring.json`
- Original loader: `OriginalLoader.lua`

## Status

Readable loader/TOS recovery. The recovered entry shows the NodeX TOS prompt, writes `nodex_confirm_tos.txt`, and fetches `https://4x.wtf/main` after confirmation. The `.txt` deobfuscation artifact is preserved for review because it contains decoder output that is not valid standalone Luau.
