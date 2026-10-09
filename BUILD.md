# Build and flash

Environment: `esp32-s3-n16r8-ili9341-touch`.

Required tools are PlatformIO Core and the Arduino ESP32 framework used by the project. On Windows, use the project Python environment and build from the repository root:

```powershell
pio run -e esp32-s3-n16r8-ili9341-touch
```

The merged image is generated as `Bruce-esp32-s3-n16r8-ili9341-touch.bin` and is intended for address `0x0`. Flash only after confirming the correct USB-Serial/JTAG port and the physical wiring. Runtime logs use 115200 baud. This project has used native USB COM18; the port number can change on another computer.

The build does not prove physical operation. Test LCD drawing, touch calibration, menu geometry and each optional peripheral separately.
