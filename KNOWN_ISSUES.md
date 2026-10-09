# Known issues

## Resolved

- ESP32-S3 TFT_eSPI crash caused by the old `SPI_PORT=FSPI` register index; the local S3 configuration now uses `SPI_PORT=2`.
- Saved `colorInverted=1` caused a blank white panel after TFT initialization; the recovery path stores inversion off for the ILI9341 target.
- XPT2046 coordinates were rotated twice in the CYD-derived input path; the extra transform was removed for `USE_TFT_eSPI_TOUCH`.
- The touch footer reserved 20 px although it is 43 px high; the geometry reserve is now 45 px.

## Under investigation

- Some icons, labels and frames may still be clipped or partially refreshed.
- WiFi, Config and other submenu contents remain invisible despite valid navigation; a one-shot three-method renderer probe is flashed and requires physical observation/log capture.
- The `SMOOTH_FONT` override and initial geometry fix are now built and flashed; physical confirmation of submenu geometry is still required.
- SD is not physically verified and has reported mount failures in runtime logs.
- RFID, Sub-GHz, NFC, IR, CC1101, NRF24 and other optional modules are not claimed as physically tested in this DIY build.
