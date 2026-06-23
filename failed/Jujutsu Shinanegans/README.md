# Jujutsu Shinanegans Failed Recovery Report

## Files

- PC loader: `OriginalLoader_PC.lua`
- Mobile loader: `OriginalLoader_Mobile.lua`
- Protected payload: `JjsLoader.obfuscated.lua`
- Generic deobfuscator attempt: `attempts/lua_deobfuscator_attempt.log`
- Static constant extractor: `attempts/extract_moonveil_constants.js`
- Decoded static constants: `attempts/decoded_constants.txt`
- Constant extraction log: `attempts/constant_extract.log`

## Source Chain

The PC and mobile loaders shown in the screenshot both fetch:

```lua
https://raw.githubusercontent.com/f2playelias-lab/Loader/refs/heads/main/JjsLoader
```

Fetched payload size: 133,165 bytes.

SHA-256:

```text
bfbd6c271dda748dfb46d4dc6e649ed06166a88fdbcbe632baa4454d10e377c7
```

## Hiding Method

- The user-facing script is a one-line remote loader.
- The fetched file is a single MoonVeil VM payload marked:

```text
MoonVeil Obfuscator v1.4.5
```

- The file contains one large encrypted/compressed VM payload and a custom runtime wrapper.

## Recovery Attempt

The raw GitHub payload was fetched as data and saved without running it in Roblox.

The existing generic Lua deobfuscator was tried first, but its parser could not handle this MoonVeil/Luau output:

```text
[INFO] Generating Syntax Tree...<Keyword `if`> at: 2:23164
 Syntax Error
```

A static MoonVeil string extractor decoded the simple XOR constants used by the wrapper. It recovered 50 printable constants, mostly runtime names such as `bit32`, `string`, `table`, `pcall`, `getfenv`, and `setmetatable`.

The extractor found no visible URL, `HttpGet`, or `loadstring` constants outside the encrypted VM payload:

```text
Detected XOR helper: yd
yd calls decoded: 165
Unique printable constants: 50
URL/loadstring-looking constants: 0
```

## Status

This entry is stored under `failed/` because the loader and protected payload were archived, but the MoonVeil v1.4.5 VM payload was not devirtualized into original source.
