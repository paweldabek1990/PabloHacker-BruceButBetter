# Visual assets and provenance — Pablo Hacker Edition

**Approved reference:** the last five-stage cyan/green design shown in ChatGPT, with hero, OLED → TFT → raw menu → illustrated tiles → Cyber Dashboard V2, five real 240×320 screens and honest development status. Preserve its design direction. The original raster reference is not yet committed here; `hero.svg` is a lightweight stand-in using the same palette.

## Source images from conversation — Codex import checklist
- `overview.png` — overview with two main-menu pages and Bluetooth, Settings, BLE scanner, Scan Results.
- `bluetooth-final-preview.png`
- `scanner-final-preview.png`
- `results-final-preview.png`
- `settings-final-preview.png`
- `ble-scan-card.png`, `ibeacon-card.png` and zooms.

The owner shared these as 240×320 design references. Transfer authentic files to `docs/showcase/screens/` (do not regenerate). Make a 5-screen gallery in both READMEs after import. Reference previews are **not verified firmware screenshots**.

## Five-stage archive to locate on local workstation
1. OLED SH1106 test photo — real historical hardware.
2. First 2.8-inch ILI9341 on breadboard photo.
3. Clipped/misaligned first TFT menu photo.
4. Early plain tile menu before rich tile backgrounds.
5. Current approved V2 reference images, with UI functional status qualified.

Prefer photos from the actual `C:\BruceTouch` project and original prior chat attachments. If a stage has no source image, visibly mark it 'reconstruction' or leave it text-only. NEVER invent success dates, completed tests, repo stats or stars.

## Visual style
Dark navy-black #020e12, neon green #00ffae, cyan #00d6d1. Fine circuit grid, illustrated category tiles and clear 240×320 framing. No giant decorative UI hiding the documented history.

## Workflow
- Work on the documentation-only branch / PR.
- Do not alter firmware, GPIO, PlatformIO, or active Codex workspace.
- Both languages must stay equivalent and all image links must resolve.
- Validate the README renders in GitHub dark and light modes.
- No fabricated photographs, contributors, status badges or released firmware claims.
