#ifndef __THEME_H
#define __THEME_H
#include "sd_functions.h"
#include <ArduinoJson.h>

// Terminal Green palette, converted from RGB888 to RGB565.
// #39FF14, #B7FF9A, #050805, #123018
#define TERMINAL_GREEN_PRI 0x3FE2
#define TERMINAL_GREEN_SEC 0xB7F3
#define TERMINAL_GREEN_BG  0x0841
#define TERMINAL_GREEN_DIM 0x2183

#define DEFAULT_PRICOLOR TERMINAL_GREEN_PRI
#define DEFAULT_SECCOLOR TERMINAL_GREEN_SEC

struct themeFiles {
    String wifi = "";
    String ble = "";
    String ethernet = "";
    String rf = "";
    String rfid = "";
    String BRUCE_FM = "";
    String ir = "";
    String files = "";
    String gps = "";
    String nrf = "";
    String interpreter = "";
    String others = "";
    String clock = "";
    String connect = "";
    String config = "";
    String boot_img = "";
    String boot_sound = "";
    String lora = "";
};

struct themeInfo {
    // Default storage (speed up loading)
    uint8_t fs = 0;
    // control booleans to not try to read unnecessary files, defined on validateTheme
    bool border = true;
    bool label = true;
    bool wifi = false;
    bool ble = false;
    bool ethernet = false;
    bool rf = false;
    bool rfid = false;
    bool BRUCE_FM = false;
    bool ir = false;
    bool files = false;
    bool gps = false;
    bool nrf = false;
    bool interpreter = false;
    bool others = false;
    bool clock = false;
    bool connect = false;
    bool config = false;
    bool boot_img = false;
    bool boot_sound = false;
    bool lora = false;
    int gifDuration = 0;

    // Theme file paths, colors and border
    themeFiles paths;
};

class BruceTheme {
public:
    themeInfo theme;
    String themePath = "";

    // Theme colors in RGB565 format
    uint16_t priColor = DEFAULT_PRICOLOR;
    uint16_t secColor = DEFAULT_PRICOLOR - 0x2000;
    uint16_t bgColor = TERMINAL_GREEN_BG;

    // UI Color
    void _setUiColor(uint16_t primary, uint16_t *secondary = nullptr, uint16_t *background = nullptr);

    bool openThemeFile(FS *fs, String filepath, bool overwriteConfigSettings);
    bool validateImgFile(FS *fs, String filepath);
    String getThemeItemImg(String item) {
        return themePath.substring(0, themePath.lastIndexOf('/')) + "/" + item;
    };
    void removeTheme(void);
    FS *themeFS(void);
};

#endif

