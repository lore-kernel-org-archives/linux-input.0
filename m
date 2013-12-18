From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 8/9] Input: pixcir_i2c_ts: Add support for TangoC family
Date: Wed, 18 Dec 2013 14:51:19 +0530
Message-ID: <1387358480-8313-9-git-send-email-rogerq@ti.com>
References: <1387358480-8313-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387358480-8313-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, jcbian@pixcir.com.cn, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-input@vger.kernel.org

Add support for Pixcir TangoC controller.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 .../devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt         | 2 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c                           | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
index c0b0b270..0ab9505 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
@@ -1,7 +1,7 @@
 * Pixcir I2C touchscreen controllers
 
 Required properties:
-- compatible: must be "pixcir,pixcir_ts"
+- compatible: must be "pixcir,pixcir_ts" or "pixcir,pixcir_tangoc"
 - reg: I2C address of the chip
 - interrupts: interrupt to which the chip is connected
 - attb-gpio: GPIO connected to the ATTB line of the chip
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 9e14415..3575eab 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -549,13 +549,19 @@ static int pixcir_i2c_ts_remove(struct i2c_client *client)
 
 static const struct i2c_device_id pixcir_i2c_ts_id[] = {
 	{ "pixcir_ts", 0 },
+	{ "pixcir_tangoc", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pixcir_i2c_ts_id);
 
 #if defined(CONFIG_OF)
+static const struct pixcir_i2c_chip_data tangoc_data = {
+	.num_report_ids = 5,
+};
+
 static const struct of_device_id pixcir_of_match[] = {
 	{ .compatible = "pixcir,pixcir_ts", },
+	{ .compatible = "pixcir,pixcir_tangoc", .data = &tangoc_data, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pixcir_of_match);
-- 
1.8.3.2
