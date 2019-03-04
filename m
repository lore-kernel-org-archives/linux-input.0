From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] HID: hid-asus: select CONFIG_POWER_SUPPLY
Date: Mon,  4 Mar 2019 20:54:43 +0100
Message-ID: <20190304195536.1019650-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: NOGUCHI Hiroshi <drvlabo@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The newly added power supply code fails to link when the power supply core
code is disabled:

drivers/hid/hid-asus.o: In function `asus_battery_get_property':
hid-asus.c:(.text+0x11de): undefined reference to `power_supply_get_drvdata'
drivers/hid/hid-asus.o: In function `asus_probe':
hid-asus.c:(.text+0x170c): undefined reference to `devm_power_supply_register'
hid-asus.c:(.text+0x1734): undefined reference to `power_supply_powers'
drivers/hid/hid-asus.o: In function `asus_raw_event':
hid-asus.c:(.text+0x1914): undefined reference to `power_supply_changed'

Select the subsystem from Kconfig as we do for other hid drivers already.

Fixes: 6311d329e12a ("HID: hid-asus: Add BT keyboard dock battery monitoring support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6ca8d322b487..4ca0cdfa6b33 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -150,6 +150,7 @@ config HID_ASUS
 	tristate "Asus"
 	depends on LEDS_CLASS
 	depends on ASUS_WMI || ASUS_WMI=n
+	select POWER_SUPPLY
 	---help---
 	Support for Asus notebook built-in keyboard and touchpad via i2c, and
 	the Asus Republic of Gamers laptop keyboard special keys.
-- 
2.20.0
