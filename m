From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/9] Input: pixcir_i2c_ts: Add register definitions
Date: Wed, 18 Dec 2013 14:51:13 +0530
Message-ID: <1387358480-8313-3-git-send-email-rogerq@ti.com>
References: <1387358480-8313-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387358480-8313-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, jcbian@pixcir.com.cn, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-input@vger.kernel.org

Add power and interrupt register definitions.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 include/linux/input/pixcir_ts.h | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/input/pixcir_ts.h b/include/linux/input/pixcir_ts.h
index b34ff7e..f17c192 100644
--- a/include/linux/input/pixcir_ts.h
+++ b/include/linux/input/pixcir_ts.h
@@ -1,6 +1,48 @@
 #ifndef	_PIXCIR_I2C_TS_H
 #define	_PIXCIR_I2C_TS_H
 
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
 struct pixcir_ts_platform_data {
 	int (*attb_read_val)(void);
 	unsigned int x_size;	/* X axis resolution */
-- 
1.8.3.2
