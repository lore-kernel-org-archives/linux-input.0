From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/6] Input: pixcir_i2c_ts - move platform data
Date: Mon,  6 Jul 2015 17:30:06 -0700
Message-ID: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35242 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544AbbGGAaU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 20:30:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Roger Quadros <rogerq@ti.com>
Cc: Jianchun Bian <jcbian@pixcir.com.cn>, linux-kernel@vger.kernel.org

Let's move driver's platform data definitions from include/linux/input/
into include/linux/platform_data/ so that it stays with the rest of
platform data definitions.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c   |  2 +-
 include/linux/input/pixcir_ts.h             | 64 -----------------------------
 include/linux/platform_data/pixcir_i2c_ts.h | 64 +++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 65 deletions(-)
 delete mode 100644 include/linux/input/pixcir_ts.h
 create mode 100644 include/linux/platform_data/pixcir_i2c_ts.h

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 8f3e243..ccafa75 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -24,11 +24,11 @@
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
-#include <linux/input/pixcir_ts.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/platform_data/pixcir_i2c_ts.h>
 
 #define PIXCIR_MAX_SLOTS       5 /* Max fingers supported by driver */
 
diff --git a/include/linux/input/pixcir_ts.h b/include/linux/input/pixcir_ts.h
deleted file mode 100644
index 7bae83b..0000000
--- a/include/linux/input/pixcir_ts.h
+++ /dev/null
@@ -1,64 +0,0 @@
-#ifndef	_PIXCIR_I2C_TS_H
-#define	_PIXCIR_I2C_TS_H
-
-/*
- * Register map
- */
-#define PIXCIR_REG_POWER_MODE	51
-#define PIXCIR_REG_INT_MODE	52
-
-/*
- * Power modes:
- * active: max scan speed
- * idle: lower scan speed with automatic transition to active on touch
- * halt: datasheet says sleep but this is more like halt as the chip
- *       clocks are cut and it can only be brought out of this mode
- *	 using the RESET pin.
- */
-enum pixcir_power_mode {
-	PIXCIR_POWER_ACTIVE,
-	PIXCIR_POWER_IDLE,
-	PIXCIR_POWER_HALT,
-};
-
-#define PIXCIR_POWER_MODE_MASK	0x03
-#define PIXCIR_POWER_ALLOW_IDLE (1UL << 2)
-
-/*
- * Interrupt modes:
- * periodical: interrupt is asserted periodicaly
- * diff coordinates: interrupt is asserted when coordinates change
- * level on touch: interrupt level asserted during touch
- * pulse on touch: interrupt pulse asserted druing touch
- *
- */
-enum pixcir_int_mode {
-	PIXCIR_INT_PERIODICAL,
-	PIXCIR_INT_DIFF_COORD,
-	PIXCIR_INT_LEVEL_TOUCH,
-	PIXCIR_INT_PULSE_TOUCH,
-};
-
-#define PIXCIR_INT_MODE_MASK	0x03
-#define PIXCIR_INT_ENABLE	(1UL << 3)
-#define PIXCIR_INT_POL_HIGH	(1UL << 2)
-
-/**
- * struct pixcir_irc_chip_data - chip related data
- * @max_fingers:	Max number of fingers reported simultaneously by h/w
- * @has_hw_ids:		Hardware supports finger tracking IDs
- *
- */
-struct pixcir_i2c_chip_data {
-	u8 max_fingers;
-	bool has_hw_ids;
-};
-
-struct pixcir_ts_platform_data {
-	int x_max;
-	int y_max;
-	int gpio_attb;		/* GPIO connected to ATTB line */
-	struct pixcir_i2c_chip_data chip;
-};
-
-#endif
diff --git a/include/linux/platform_data/pixcir_i2c_ts.h b/include/linux/platform_data/pixcir_i2c_ts.h
new file mode 100644
index 0000000..7bae83b
--- /dev/null
+++ b/include/linux/platform_data/pixcir_i2c_ts.h
@@ -0,0 +1,64 @@
+#ifndef	_PIXCIR_I2C_TS_H
+#define	_PIXCIR_I2C_TS_H
+
+/*
+ * Register map
+ */
+#define PIXCIR_REG_POWER_MODE	51
+#define PIXCIR_REG_INT_MODE	52
+
+/*
+ * Power modes:
+ * active: max scan speed
+ * idle: lower scan speed with automatic transition to active on touch
+ * halt: datasheet says sleep but this is more like halt as the chip
+ *       clocks are cut and it can only be brought out of this mode
+ *	 using the RESET pin.
+ */
+enum pixcir_power_mode {
+	PIXCIR_POWER_ACTIVE,
+	PIXCIR_POWER_IDLE,
+	PIXCIR_POWER_HALT,
+};
+
+#define PIXCIR_POWER_MODE_MASK	0x03
+#define PIXCIR_POWER_ALLOW_IDLE (1UL << 2)
+
+/*
+ * Interrupt modes:
+ * periodical: interrupt is asserted periodicaly
+ * diff coordinates: interrupt is asserted when coordinates change
+ * level on touch: interrupt level asserted during touch
+ * pulse on touch: interrupt pulse asserted druing touch
+ *
+ */
+enum pixcir_int_mode {
+	PIXCIR_INT_PERIODICAL,
+	PIXCIR_INT_DIFF_COORD,
+	PIXCIR_INT_LEVEL_TOUCH,
+	PIXCIR_INT_PULSE_TOUCH,
+};
+
+#define PIXCIR_INT_MODE_MASK	0x03
+#define PIXCIR_INT_ENABLE	(1UL << 3)
+#define PIXCIR_INT_POL_HIGH	(1UL << 2)
+
+/**
+ * struct pixcir_irc_chip_data - chip related data
+ * @max_fingers:	Max number of fingers reported simultaneously by h/w
+ * @has_hw_ids:		Hardware supports finger tracking IDs
+ *
+ */
+struct pixcir_i2c_chip_data {
+	u8 max_fingers;
+	bool has_hw_ids;
+};
+
+struct pixcir_ts_platform_data {
+	int x_max;
+	int y_max;
+	int gpio_attb;		/* GPIO connected to ATTB line */
+	struct pixcir_i2c_chip_data chip;
+};
+
+#endif
-- 
2.4.3.573.g4eafbef

