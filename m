From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 2/2] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 16:54:15 +0200
Message-ID: <1421333655-31029-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@glider.be>
List-Id: linux-input@vger.kernel.org

The I2C subsystem can match devices without explicit OF support based on
the part of their compatible property after the comma. However, this
mechanism uses the first compatible value only. For adxl34x OF device
nodes the compatible property will contain the more specific
"adi,adxl345" or "adi,adxl346" value first. This prevents the device
node from being matched with the adxl34x driver.

Fix this by adding an OF match table with an "adi,adxl345" compatible
entry. There's no need to add the "adi,adxl346" entry as the ADXL346 is
backward-compatible with the ADXL345 with differences handled by runtime
detection of the device model.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/input/misc/adxl34x-i2c.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index 416f47ddcc90..1e028f1f221c 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -10,6 +10,7 @@
 #include <linux/input.h>	/* BUS_I2C */
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/types.h>
 #include <linux/pm.h>
 #include "adxl34x.h"
@@ -137,11 +138,31 @@ static const struct i2c_device_id adxl34x_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, adxl34x_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id adxl34x_of_id[] = {
+	/*
+	 * The ADXL346 is backward-compatible with the ADXL345. Differences are
+	 * handled by runtime detection of the device model, there's thus no
+	 * need for listing the "adi,adxl346" compatible value explicitly.
+	 */
+	{ .compatible = "adi,adxl345", },
+	/*
+	 * Deprecated, DT nodes should use one or more of the device-specific
+	 * compatible values "adi,adxl345" and "adi,adxl346".
+	 */
+	{ .compatible = "adi,adxl34x", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, adxl34x_of_id);
+#endif
+
 static struct i2c_driver adxl34x_driver = {
 	.driver = {
 		.name = "adxl34x",
 		.owner = THIS_MODULE,
 		.pm = &adxl34x_i2c_pm,
+		.of_match_table = of_match_ptr(adxl34x_of_id),
 	},
 	.probe    = adxl34x_i2c_probe,
 	.remove   = adxl34x_i2c_remove,
-- 
2.0.5

