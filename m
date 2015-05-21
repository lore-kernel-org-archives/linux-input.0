From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 2/2] input: adxl34x: Add OF match support
Date: Thu, 21 May 2015 13:42:26 +0200
Message-ID: <1432208546-18615-3-git-send-email-geert+renesas@glider.be>
References: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432208546-18615-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

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

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Reviewed-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - Add Reviewed-by.

 drivers/input/misc/adxl34x-i2c.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index 470bfd6f08304c67..bdb5d03b296ec6db 100644
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
@@ -135,11 +136,31 @@ static const struct i2c_device_id adxl34x_id[] = {
 
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
1.9.1
