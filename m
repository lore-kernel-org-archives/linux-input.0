From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] HID: logitech-hidpp: select CONFIG_POWER_SUPPLY
Date: Mon, 11 Jul 2016 23:49:20 +0200
Message-ID: <20160711214954.2668262-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60654 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcGKVq3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 17:46:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Yusuke Fujimaki <usk.fujimaki@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

A recent commit added barry support to this driver, but that causes
a link failure when CONFIG_POWER_SUPPLY is not set:

drivers/hid/built-in.o: In function `hidpp_battery_get_property':
:(.text+0x1a834): undefined reference to `power_supply_get_drvdata'
drivers/hid/built-in.o: In function `hidpp_raw_event':
:(.text+0x1b10c): undefined reference to `power_supply_changed'
drivers/hid/built-in.o: In function `hidpp_connect_event':
:(.text+0x1bd88): undefined reference to `devm_power_supply_register'
:(.text+0x1be30): undefined reference to `power_supply_powers'

This adds a dependency, identically to the other HID drivers that need this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 5a2b190cddb9 ("HID: logitech-hidpp: add battery support for HID++ 2.0 devices")
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 78ac4811bd3c..4c6b59c9fa15 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -440,6 +440,7 @@ config HID_LOGITECH_DJ
 config HID_LOGITECH_HIDPP
 	tristate "Logitech HID++ devices support"
 	depends on HID_LOGITECH
+	select POWER_SUPPLY
 	---help---
 	Support for Logitech devices relyingon the HID++ Logitech specification
 
-- 
2.9.0

