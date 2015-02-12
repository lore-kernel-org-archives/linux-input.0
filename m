From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2] Input: sun4i-ts: add thermal driver dependency
Date: Thu, 12 Feb 2015 16:00:11 +0800
Message-ID: <1423728011-30272-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:35957 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbBLIAS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Feb 2015 03:00:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>

From: Arnd Bergmann <arnd@arndb.de>

The sun4i-ts driver has had a dependency on the thermal code
with the addition of the thermal zone sensor support, but this
is not currently enforced in Kconfig, so with TOUCHSCREEN_SUN4I=y,
THERMAL=m and THERMAL_OF=y we get

drivers/built-in.o: In function `sun4i_ts_remove':
:(.text+0x2376f4): undefined reference to `thermal_zone_of_sensor_unregister'
drivers/built-in.o: In function `sun4i_ts_probe':
:(.text+0x237a94): undefined reference to `thermal_zone_of_sensor_register'
:(.text+0x237c00): undefined reference to `thermal_zone_of_sensor_unregister'

We need the dependency on THERMAL in order to ensure that this
driver becomes a loadable module if the thermal support itself
is modular, while the dependency on THERMAL_OF is a runtime
dependency and the driver will still build if it is missing.
It is entirely possible to build sun4i-ts without THERMAL_OF
just to use the hwmon sensors and/or touchscreen.

Fixes: 223697107949 ("Input: sun4i-ts - add thermal zone sensor support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[wens@csie.org: Fix description and Kconfig dependencies]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

v2 updates the Kconfig dependencies as Dmitry pointed out, and makes
the description be more specific on the failing config and why a
dependency on THERMAL_OF is not required. The failing commit hash
is also updated.

---
 drivers/input/touchscreen/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 58917525126e..6261fd6d7c3c 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -943,6 +943,7 @@ config TOUCHSCREEN_SUN4I
 	tristate "Allwinner sun4i resistive touchscreen controller support"
 	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on HWMON
+	depends on THERMAL || !THERMAL_OF
 	help
 	  This selects support for the resistive touchscreen controller
 	  found on Allwinner sunxi SoCs.
-- 
2.1.4

