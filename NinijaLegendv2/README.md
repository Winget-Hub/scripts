# NinijaLegendv2

## Status

Loader decoded.

## Files

- `Main.lua` - decoded hub/router source recovered from the original loader chain.

## Notes

The dirty entry used an XOR-encrypted `loadstring(game:HttpGet(...))` wrapper. The XOR layer was decoded to reveal the upstream source URL, and that source was archived here.

Some buttons inside the hub still point to downstream `loadstring` URLs, so this is the hub source rather than a full archive of every linked server script.
