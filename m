From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 18 Dec 2014 04:15:23 +0200
Message-ID: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:50362 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbaLRCP0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 21:15:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>, Wolfram Sang <wsa@the-dreams.de>

The I2C subsystem can match devices without explicit OF support based on
the part of their compatible property after the comma. However, this
mechanism uses the first compatible value only. For adxl34x OF device
nodes the compatible property should list the more specific
"adi,adxl345" or "adi,adxl346" value first and the "adi,adxl34x"
fallback value second. This prevents the device node from being matched
with the adxl34x driver.

Fix this by adding an OF match table with an "adi,adxl34x" compatible
entry.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/input/misc/adxl34x-i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

Another option would have been to add "adxl325" and "adxl326" entries to the
adxl34x_id I2C match table, but it would have had the drawback of requiring a
driver update for every new device.

diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index 416f47ddcc90..22687b738811 100644
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
@@ -137,11 +138,21 @@ static const struct i2c_device_id adxl34x_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, adxl34x_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id adxl34x_of_id[] = {
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
Regards,

Laurent Pinchart

