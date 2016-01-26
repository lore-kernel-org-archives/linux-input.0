From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: [PATCH 1/3] input: touchscreen: ad7879: move header to input subdirectory
Date: Mon, 25 Jan 2016 19:04:35 -0800
Message-ID: <1453777477-29706-1-git-send-email-stefan@agner.ch>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The header file is used by the SPI and I2C variant of the driver.
Therefore, move it to a more generic place under input.

Signed-off-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
---
 arch/blackfin/mach-bf527/boards/ezbrd.c    |  2 +-
 arch/blackfin/mach-bf527/boards/ezkit.c    |  2 +-
 arch/blackfin/mach-bf527/boards/tll6527m.c |  2 +-
 arch/blackfin/mach-bf537/boards/stamp.c    |  2 +-
 arch/blackfin/mach-bf538/boards/ezkit.c    |  2 +-
 drivers/input/touchscreen/ad7879.c         |  4 +--
 include/linux/input/ad7879.h               | 41 ++++++++++++++++++++++++++++++
 include/linux/spi/ad7879.h                 | 41 ------------------------------
 8 files changed, 48 insertions(+), 48 deletions(-)
 create mode 100644 include/linux/input/ad7879.h
 delete mode 100644 include/linux/spi/ad7879.h

diff --git a/arch/blackfin/mach-bf527/boards/ezbrd.c b/arch/blackfin/mach-bf527/boards/ezbrd.c
index a3a5723..b5a74e5 100644
--- a/arch/blackfin/mach-bf527/boards/ezbrd.c
+++ b/arch/blackfin/mach-bf527/boards/ezbrd.c
@@ -279,7 +279,7 @@ static const struct ad7877_platform_data bfin_ad7877_ts_info = {
 #endif
 
 #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
-#include <linux/spi/ad7879.h>
+#include <linux/input/ad7879.h>
 static const struct ad7879_platform_data bfin_ad7879_ts_info = {
 	.model			= 7879,	/* Model = AD7879 */
 	.x_plate_ohms		= 620,	/* 620 Ohm from the touch datasheet */
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index d4219e8..276270c 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -477,7 +477,7 @@ static const struct ad7877_platform_data bfin_ad7877_ts_info = {
 #endif
 
 #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
-#include <linux/spi/ad7879.h>
+#include <linux/input/ad7879.h>
 static const struct ad7879_platform_data bfin_ad7879_ts_info = {
 	.model			= 7879,	/* Model = AD7879 */
 	.x_plate_ohms		= 620,	/* 620 Ohm from the touch datasheet */
diff --git a/arch/blackfin/mach-bf527/boards/tll6527m.c b/arch/blackfin/mach-bf527/boards/tll6527m.c
index a0f5856..ff67ddc 100644
--- a/arch/blackfin/mach-bf527/boards/tll6527m.c
+++ b/arch/blackfin/mach-bf527/boards/tll6527m.c
@@ -29,7 +29,7 @@
 #include <asm/dpmc.h>
 
 #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
-#include <linux/spi/ad7879.h>
+#include <linux/input/ad7879.h>
 #define LCD_BACKLIGHT_GPIO 0x40
 /* TLL6527M uses TLL7UIQ35 / ADI LCD EZ Extender. AD7879 AUX GPIO is used for
  * LCD Backlight Enable
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index c181543..cf063be 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -776,7 +776,7 @@ static const struct ad7877_platform_data bfin_ad7877_ts_info = {
 #endif
 
 #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
-#include <linux/spi/ad7879.h>
+#include <linux/input/ad7879.h>
 static const struct ad7879_platform_data bfin_ad7879_ts_info = {
 	.model			= 7879,	/* Model = AD7879 */
 	.x_plate_ohms		= 620,	/* 620 Ohm from the touch datasheet */
diff --git a/arch/blackfin/mach-bf538/boards/ezkit.c b/arch/blackfin/mach-bf538/boards/ezkit.c
index ae2fcbb..849587c 100644
--- a/arch/blackfin/mach-bf538/boards/ezkit.c
+++ b/arch/blackfin/mach-bf538/boards/ezkit.c
@@ -521,7 +521,7 @@ static struct bfin5xx_spi_chip spi_flash_chip_info = {
 #endif	/* CONFIG_SPI_BFIN5XX */
 
 #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
-#include <linux/spi/ad7879.h>
+#include <linux/input/ad7879.h>
 static const struct ad7879_platform_data bfin_ad7879_ts_info = {
 	.model			= 7879,	/* Model = AD7879 */
 	.x_plate_ohms		= 620,	/* 620 Ohm from the touch datasheet */
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 16b5cc2..a73934b 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -31,7 +31,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 
-#include <linux/spi/ad7879.h>
+#include <linux/input/ad7879.h>
 #include <linux/module.h>
 #include "ad7879.h"
 
@@ -170,7 +170,7 @@ static int ad7879_report(struct ad7879 *ts)
 	 * filter.  The combination of these two techniques provides a robust
 	 * solution, discarding the spurious noise in the signal and keeping
 	 * only the data of interest.  The size of both filters is
-	 * programmable. (dev.platform_data, see linux/spi/ad7879.h) Other
+	 * programmable. (dev.platform_data, see linux/input/ad7879.h) Other
 	 * user-programmable conversion controls include variable acquisition
 	 * time, and first conversion delay. Up to 16 averages can be taken
 	 * per conversion.
diff --git a/include/linux/input/ad7879.h b/include/linux/input/ad7879.h
new file mode 100644
index 0000000..98fc270
--- /dev/null
+++ b/include/linux/input/ad7879.h
@@ -0,0 +1,41 @@
+/* linux/input/ad7879.h */
+
+/* Touchscreen characteristics vary between boards and models.  The
+ * platform_data for the device's "struct device" holds this information.
+ *
+ * It's OK if the min/max values are zero.
+ */
+struct ad7879_platform_data {
+	u16	model;			/* 7879 */
+	u16	x_plate_ohms;
+	u16	x_min, x_max;
+	u16	y_min, y_max;
+	u16	pressure_min, pressure_max;
+
+	bool	swap_xy;		/* swap x and y axes */
+
+	/* [0..255] 0=OFF Starts at 1=550us and goes
+	 * all the way to 9.440ms in steps of 35us.
+	 */
+	u8	pen_down_acc_interval;
+	/* [0..15] Starts at 0=128us and goes all the
+	 * way to 4.096ms in steps of 128us.
+	 */
+	u8	first_conversion_delay;
+	/* [0..3] 0 = 2us, 1 = 4us, 2 = 8us, 3 = 16us */
+	u8	acquisition_time;
+	/* [0..3] Average X middle samples 0 = 2, 1 = 4, 2 = 8, 3 = 16 */
+	u8	averaging;
+	/* [0..3] Perform X measurements 0 = OFF,
+	 * 1 = 4, 2 = 8, 3 = 16 (median > averaging)
+	 */
+	u8	median;
+	/* 1 = AUX/VBAT/GPIO export GPIO to gpiolib
+	 * requires CONFIG_GPIOLIB
+	 */
+	bool	gpio_export;
+	/* identifies the first GPIO number handled by this chip;
+	 * or, if negative, requests dynamic ID allocation.
+	 */
+	s32	gpio_base;
+};
diff --git a/include/linux/spi/ad7879.h b/include/linux/spi/ad7879.h
deleted file mode 100644
index 58368be..0000000
--- a/include/linux/spi/ad7879.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* linux/spi/ad7879.h */
-
-/* Touchscreen characteristics vary between boards and models.  The
- * platform_data for the device's "struct device" holds this information.
- *
- * It's OK if the min/max values are zero.
- */
-struct ad7879_platform_data {
-	u16	model;			/* 7879 */
-	u16	x_plate_ohms;
-	u16	x_min, x_max;
-	u16	y_min, y_max;
-	u16	pressure_min, pressure_max;
-
-	bool	swap_xy;		/* swap x and y axes */
-
-	/* [0..255] 0=OFF Starts at 1=550us and goes
-	 * all the way to 9.440ms in steps of 35us.
-	 */
-	u8	pen_down_acc_interval;
-	/* [0..15] Starts at 0=128us and goes all the
-	 * way to 4.096ms in steps of 128us.
-	 */
-	u8	first_conversion_delay;
-	/* [0..3] 0 = 2us, 1 = 4us, 2 = 8us, 3 = 16us */
-	u8	acquisition_time;
-	/* [0..3] Average X middle samples 0 = 2, 1 = 4, 2 = 8, 3 = 16 */
-	u8	averaging;
-	/* [0..3] Perform X measurements 0 = OFF,
-	 * 1 = 4, 2 = 8, 3 = 16 (median > averaging)
-	 */
-	u8	median;
-	/* 1 = AUX/VBAT/GPIO export GPIO to gpiolib
-	 * requires CONFIG_GPIOLIB
-	 */
-	bool	gpio_export;
-	/* identifies the first GPIO number handled by this chip;
-	 * or, if negative, requests dynamic ID allocation.
-	 */
-	s32	gpio_base;
-};
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
