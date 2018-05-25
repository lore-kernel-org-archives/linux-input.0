From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] HID: steam: select CONFIG_POWER_SUPPLY
Date: Fri, 25 May 2018 17:30:51 +0200
Message-ID: <20180525153118.3015806-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Using the power supply APIs requires selecting the appropriate
Kconfig symbol, otherwise we get this build failure:

drivers/hid/hid-steam.o: In function `steam_unregister':
hid-steam.c:(.text+0x1cc): undefined reference to `power_supply_unregister'
drivers/hid/hid-steam.o: In function `steam_battery_get_property':
hid-steam.c:(.text+0x2d2): undefined reference to `power_supply_get_drvdata'
drivers/hid/hid-steam.o: In function `steam_raw_event':
hid-steam.c:(.text+0xcba): undefined reference to `power_supply_changed'
drivers/hid/hid-steam.o: In function `steam_register':
hid-steam.c:(.text+0x13e3): undefined reference to `power_supply_register'
hid-steam.c:(.text+0x13fe): undefined reference to `power_supply_powers'

Fixes: f82719790751 ("HID: steam: add battery device.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 8a865e3ccea6..a49a10437c40 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -848,6 +848,7 @@ config HID_SPEEDLINK
 config HID_STEAM
 	tristate "Steam Controller support"
 	depends on HID
+	select POWER_SUPPLY
 	---help---
 	Say Y here if you have a Steam Controller if you want to use it
 	without running the Steam Client. It supports both the wired and
-- 
2.9.0
