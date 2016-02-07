From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] Input: Allow compile test of Goodix and Colibri VF50 if !GPIOLIB
Date: Sun,  7 Feb 2016 15:18:07 +0100
Message-ID: <1454854687-21114-2-git-send-email-geert@linux-m68k.org>
References: <1454854687-21114-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1454854687-21114-1-git-send-email-geert@linux-m68k.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

If COMPILE_TEST is enabled, relax the dependency on GPIOLIB for the
recently introduced or relaxed symbols TOUCHSCREEN_GOODIX and
TOUCHSCREEN_COLIBRI_VF50.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/touchscreen/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 66c62641b59a31cf..fba4d5665857221b 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -334,7 +334,7 @@ config TOUCHSCREEN_FUJITSU
 config TOUCHSCREEN_GOODIX
 	tristate "Goodix I2C touchscreen"
 	depends on I2C
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here if you have the Goodix touchscreen (such as one
 	  installed in Onda v975w tablets) connected to your
@@ -1112,7 +1112,8 @@ config TOUCHSCREEN_ZFORCE
 
 config TOUCHSCREEN_COLIBRI_VF50
 	tristate "Toradex Colibri on board touchscreen driver"
-	depends on GPIOLIB && IIO && VF610_ADC
+	depends on IIO && VF610_ADC
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here if you have a Colibri VF50 and plan to use
 	  the on-board provided 4-wire touchscreen driver.
-- 
1.9.1

