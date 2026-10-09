#ifndef __FM_MENU_H__
#define __FM_MENU_H__

#include <MenuItemInterface.h>

class FMMenu : public MenuItemInterface {
public:
    FMMenu() : MenuItemInterface("BRUCE_FM") {}

    void optionsMenu(void);
    void drawIcon(float scale);
    bool hasTheme() { return bruceConfig.theme.BRUCE_FM; }
    String themePath() { return bruceConfig.theme.paths.BRUCE_FM; }
};

#endif

