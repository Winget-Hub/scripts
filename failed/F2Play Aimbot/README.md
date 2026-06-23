# F2Play Aimbot Failed Recovery Report

## Files

- PC loader: `OriginalLoader_PC.lua`
- Normalized mobile loader: `OriginalLoader_Mobile_Normalized.lua`
- Mobile loader as provided: `OriginalLoader_Mobile_AsProvided.txt`
- Protected payload: `Loader.obfuscated.lua`
- Generic deobfuscator attempt: `attempts/lua_deobfuscator_attempt.log`
- Static constant extractor: `attempts/extract_moonveil_constants.js`
- Decoded static constants: `attempts/decoded_constants.txt`
- Constant extraction log: `attempts/constant_extract.log`

## Source Chain

Both usable loader forms point to:

```lua
https://raw.githubusercontent.com/f2playelias-lab/Aimbot-/refs/heads/main/Loader
```

Fetched payload size: 75,886 bytes.

SHA-256:

```text
5f70a5f5003a3a122d958cebb8ec8f0413c2b94d9b0cd010733440494c513235
```

The mobile version provided in chat was malformed: it starts with `oadstring` instead of `loadstring` and contains Markdown link markup inside the string. The normalized mobile loader is archived separately because the underlying raw GitHub target is the same as the PC loader.

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
[INFO] Generating Syntax Tree...<Keyword `if`> at: 2:23465
 Syntax Error
```

A static MoonVeil string extractor decoded the simple `Ia(...)` XOR constants used by the wrapper. It recovered 49 printable constants, mostly runtime names such as `bit32`, `string`, `table`, `pcall`, `getfenv`, and `setmetatable`.

The extractor found no visible URL, `HttpGet`, or `loadstring` constants outside the encrypted VM payload:

```text
Ia calls decoded: 161
Unique printable constants: 49
URL/loadstring-looking constants: 0
```

## Status

This entry is stored under `failed/` because the loader and protected payload were archived, but the MoonVeil v1.4.5 VM payload was not devirtualized into original source.
