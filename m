From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 08/27] input: Allow compile test of GPIO consumers if !GPIOLIB
Date: Tue,  5 May 2015 18:32:24 +0200
Message-ID: <1430843563-18615-8-git-send-email-geert@linux-m68k.org>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:46220 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761330AbbEEQcz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 12:32:55 -0400
In-Reply-To: <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
appropriate.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/keyboard/Kconfig    |  4 ++--
 drivers/input/misc/Kconfig        | 11 ++++++-----
 drivers/input/mouse/Kconfig       |  2 +-
 drivers/input/touchscreen/Kconfig |  8 ++++----
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 106fbac7f8c5b024..353598ad519893f9 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -187,7 +187,7 @@ config KEYBOARD_EP93XX
 
 config KEYBOARD_GPIO
 	tristate "GPIO Buttons"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  This driver implements support for buttons connected
 	  to GPIO pins of various CPUs (and some other chips).
@@ -253,7 +253,7 @@ config KEYBOARD_TCA8418
 
 config KEYBOARD_MATRIX
 	tristate "GPIO driven matrix keypad support"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	select INPUT_MATRIXKMAP
 	help
 	  Enable support for GPIO driven matrix keypad.
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 4436ab1b9735d608..c38a356d5a478af5 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -259,7 +259,7 @@ config INPUT_APANEL
 config INPUT_GP2A
 	tristate "Sharp GP2AP002A00F I2C Proximity/Opto sensor driver"
 	depends on I2C
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here if you have a Sharp GP2AP002A00F proximity/als combo-chip
 	  hooked to an I2C bus.
@@ -269,7 +269,7 @@ config INPUT_GP2A
 
 config INPUT_GPIO_BEEPER
 	tristate "Generic GPIO Beeper support"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here if you have a beeper connected to a GPIO pin.
 
@@ -278,7 +278,7 @@ config INPUT_GPIO_BEEPER
 
 config INPUT_GPIO_TILT_POLLED
 	tristate "Polled GPIO tilt switch"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	select INPUT_POLLDEV
 	help
 	  This driver implements support for tilt switches connected
@@ -569,7 +569,7 @@ config INPUT_PWM_BEEPER
 
 config INPUT_GPIO_ROTARY_ENCODER
 	tristate "Rotary encoders connected to GPIO pins"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here to add support for rotary encoders connected to GPIO lines.
 	  Check file:Documentation/input/rotary-encoder.txt for more
@@ -766,7 +766,8 @@ config INPUT_SOC_BUTTON_ARRAY
 
 config INPUT_DRV260X_HAPTICS
 	tristate "TI DRV260X haptics support"
-	depends on INPUT && I2C && GPIOLIB
+	depends on INPUT && I2C
+	depends on GPIOLIB || COMPILE_TEST
 	select INPUT_FF_MEMLESS
 	select REGMAP_I2C
 	help
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 7462d2fc8cfed8d4..1d1f8e9b19054d00 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -341,7 +341,7 @@ config MOUSE_VSXXXAA
 
 config MOUSE_GPIO
 	tristate "GPIO mouse"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	select INPUT_POLLDEV
 	help
 	  This driver simulates a mouse on GPIO lines of various CPUs (and some
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 05e4c6ffbe363690..b60079468a3e0780 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -118,7 +118,7 @@ config TOUCHSCREEN_ATMEL_MXT
 config TOUCHSCREEN_AUO_PIXCIR
 	tristate "AUO in-cell touchscreen using Pixcir ICs"
 	depends on I2C
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here if you have a AUO display with in-cell touchscreen
 	  using Pixcir ICs.
@@ -142,7 +142,7 @@ config TOUCHSCREEN_BU21013
 
 config TOUCHSCREEN_CHIPONE_ICN8318
 	tristate "chipone icn8318 touchscreen controller"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	depends on I2C
 	depends on OF
 	help
@@ -156,7 +156,7 @@ config TOUCHSCREEN_CHIPONE_ICN8318
 config TOUCHSCREEN_CY8CTMG110
 	tristate "cy8ctmg110 touchscreen"
 	depends on I2C
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here if you have a cy8ctmg110 capacitive touchscreen on
 	  an AAVA device.
@@ -1016,7 +1016,7 @@ config TOUCHSCREEN_TPS6507X
 config TOUCHSCREEN_ZFORCE
 	tristate "Neonode zForce infrared touchscreens"
 	depends on I2C
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here if you have a touchscreen using the zforce
 	  infraread technology from Neonode.
-- 
1.9.1

