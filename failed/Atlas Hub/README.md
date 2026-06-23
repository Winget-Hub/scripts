# Atlas Hub Failed Recovery Report

## Files

- Original loader: `OriginalLoader.lua`
- Normalized mobile loader: `OriginalLoader_Mobile_Normalized.lua`
- Mobile loader as provided: `OriginalLoader_Mobile_AsProvided.txt`
- Readable first stage: `AtlasHub.lua`
- Protected second stage: `Redliner.obfuscated.lua`
- Attempt log: `attempts/moonsec_attempt.log`
- Attempt script: `attempts/attempt_moonsec_devirtualize.js`

## Source Chain

The original loader fetched:

```lua
https://raw.githubusercontent.com/maddonk1241/Redlinerscript/49bd7f726d16adb11f78fe83faf1dde24a754553/Atlas-Hub
```

The mobile version provided in chat points at the same raw GitHub target, but the pasted text contains Markdown link markup inside the string. The exact text is preserved in `OriginalLoader_Mobile_AsProvided.txt`, and the usable normalized form is stored in `OriginalLoader_Mobile_Normalized.lua`.

Fetched first-stage size: 5,563 bytes.

SHA-256:

```text
1e88013d17ee1401674a445ac95802be8a8828a731a92bc5ae2289982c535efe
```

The first stage is readable Luau. It builds a key-system UI with this hardcoded key:

```text
UvuHubHolyMoly
```

After the key check, it loads the second stage:

```lua
https://raw.githubusercontent.com/maddonk1241/Redlinerscript/eeb49ead830973d40c29b293cbc592b3f3fe76dc/Redliner.lua
```

Fetched second-stage size: 125,834 bytes.

SHA-256:

```text
4ddd429f74d68ceba2ed958e793f88bd8d2e66552320662b30c0dca75dadf8a7
```

## Hiding Method

- The user-facing script is a one-line remote loader.
- The first fetched file is readable, but it gates the real payload behind a key-system UI.
- The real payload is a large MoonVeil VM blob marked:

```text
MoonVeil 2.0.14-beta
```

## Recovery Attempt

The first stage and protected second stage were fetched as data and saved without running them in Roblox. Both stages syntax-check as Luau.

The bundled MoonSec devirtualizer was tried against `Redliner.obfuscated.lua` because the repository already had working MoonSec tooling for earlier entries. That attempt did not match this payload:

```text
MoonSec detector: not matched
Luau parser: parsed and beautified successfully
Attempt failed:
NoBody
```

## Status

This entry is intentionally stored under `failed/` because the readable first stage was recovered, but the MoonVeil-protected second stage was not devirtualized into original source.
