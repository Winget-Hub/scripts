# The Strongest Battlegrounds Failed Recovery Report

## Files

- PC loader: `OriginalLoader_PC.lua`
- Mobile loader: `OriginalLoader_Mobile.lua`
- Readable key-system wrapper: `TsbLoader.lua`
- Protected second stage: `TsbMainScript.obfuscated.lua`
- Generic deobfuscator attempt: `attempts/lua_deobfuscator_attempt.log`
- Static constant extractor: `attempts/extract_moonveil_constants.js`
- Decoded static constants: `attempts/decoded_constants.txt`
- Constant extraction log: `attempts/constant_extract.log`

## Source Chain

The PC and mobile loaders shown in the screenshot both fetch:

```text
https://raw.githubusercontent.com/f2playelias-lab/cool/refs/heads/main/TsbLoader
```

Fetched wrapper size: 40,693 bytes.

SHA-256:

```text
dcd826555f178642535b1fd677cff4e9f600c441cda43918951fe8477e596da3
```

The wrapper is readable. It builds a key-system GUI, checks this hardcoded key:

```text
UvuHubHolyMoly
```

The Get Key and Discord buttons copy this invite:

```text
https://discord.gg/Jw4szxjcbJ
```

After successful key validation, the wrapper fetches:

```text
https://raw.githubusercontent.com/f2playelias-lab/TheStrongestBtl/refs/heads/main/TsbMainScript.lua
```

Fetched second-stage size: 73,433 bytes.

SHA-256:

```text
dd44f1166f1df34d50600741b6dd9fb12cbb1115f1ed367742db3bb3b010c355
```

## Hiding Method

- The public script is a one-line raw GitHub loader.
- The first fetched file is readable, but gates the actual payload behind a key-system UI.
- The second stage is a MoonVeil VM payload marked:

```text
MoonVeil Obfuscator v1.4.5
```

## Recovery Attempt

The wrapper and second stage were fetched as data and saved without running them in Roblox.

The generic Lua deobfuscator was tried against the MoonVeil stage, but its parser failed on the protected Luau shape:

```text
[INFO] Generating Syntax Tree...<Keyword `if`> at: 2:29120
 Syntax Error
```

A static MoonVeil string extractor decoded simple XOR constants from the wrapper:

```text
Detected XOR helper: Ca
Ca calls decoded: 161
Unique printable constants: 49
URL/loadstring-looking constants: 0
```

## Status

This entry is stored under `failed/` because the readable key-system wrapper was recovered, but the MoonVeil v1.4.5 second-stage payload was not devirtualized into original source.
