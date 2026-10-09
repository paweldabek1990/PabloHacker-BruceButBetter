# Bruce App compatibility analysis

## Official capability

The official Bruce companion-app documentation describes firmware flashing, serial commands and live device-screen mirroring: [Bruce Wiki — Companion Apps](https://wiki.bruce.computer/companion-apps/). The application repository similarly describes a cross-platform companion app with flashing, serial commands and live mirroring: [BruceDevices/App](https://github.com/BruceDevices/App).

## This fork

The target enables native USB CDC (`ARDUINO_USB_CDC_ON_BOOT=1`) and uses the ESP32-S3 USB identity `VID 0x303A / PID 0x1001`; runtime serial output was previously observed at 115200 on the native-USB COM port. This makes serial transport plausible, but it does not by itself prove compatibility with the app's command or mirroring protocol.

The fork has not been verified against the official app's live mirroring/WebUI workflow. No exact mirror endpoint or frame protocol is asserted here. A future compatibility test must compare the app's serial/WebUI requests with the firmware's implemented command handlers and verify that the app can open this fork without changing firmware.

“MSI” is not a confirmed interface name in the project; it is treated as a possible reference to USB/serial mirroring and remains unverified.

## Safe next test

Use the official app only after selecting the confirmed ESP32-S3 COM port. First test device identification and read-only serial communication; do not flash or erase from the app until its target detection is confirmed. Record whether the app shows the device, whether serial commands receive responses, and whether the live mirror displays the TFT.
