# Mark22028 Anti-Afk Recovery Report

## Files

- Main readable source: `Main.lua`
- PC loader: `OriginalLoader_PC.lua`
- Mobile loader: `OriginalLoader_Mobile.lua`

## Source Chain

The screenshot loader fetched:

```text
https://raw.githubusercontent.com/Mark22028/Scripts/refs/heads/main/Anti-Afk.txt
```

Fetched source size: 2,747 bytes.

SHA-256:

```text
c13612b3bde7d67fe0052f69550a3248fa6b4433afe6ccaa326c63ee724e36a6
```

## Status

Readable source. This anti-AFK script connects to `Players.LocalPlayer.Idled`, uses `VirtualUser` to send a right-click pulse, shows a temporary GUI notice, and then destroys the notice after a tween.
