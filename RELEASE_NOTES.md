# Release notes — publication preparation

## Stable hardware target

- Target: `esp32-s3-n16r8-ili9341-touch`
- Hardware: ESP32-S3-WROOM-1 N16R8, TPM408-2.8 ILI9341/XPT2046
- Stable reference tag: `stable-single-splash-20261009`
- Stable BIN SHA-256: `7DFD47110A0295EC4C2B39FC10A42BC354B52AB31C40D91E897E4F4D963CF868`
- Stable BIN is intentionally kept outside tracked source and should be attached to a release only after repository review.

## BLE diagnostic build

- Branch: `ble-diagnostics-fix`
- Purpose: standard identifiable `BRUCE-BLE-TEST` beacon and BLE API diagnostics.
- SHA-256: `4EA95FCD4F8598330BF9E26B6DDE8E2E1DD6415DF055543B5FC9625BB281FC77`
- This is a test build, not a stable release.

## Limitations

The Rugged A1 enclosure remains a prototype based partly on PHOTO_ESTIMATE values. Several peripherals and Bluetooth Spam reactions on current iOS remain unverified or compatibility-limited.
