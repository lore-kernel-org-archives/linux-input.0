From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 3/4] Input: edt-ft5x06 - Add support for FT5506
Date: Fri, 16 Oct 2015 09:14:28 -0500
Message-ID: <1445004869-31986-4-git-send-email-fcooper@ti.com>
References: <1445004869-31986-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445004869-31986-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com, LW@KARO-electronics.de, jg1.han@samsung.com, asaf.vertz@tandemg.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-input@vger.kernel.org

FT5506 is essentially the same as other FT5x06 devices other than
supporting 10 support points.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Changes since RFC:
Increase rdbuf to accomodate extra 2 bytes being read.

 Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt | 2 ++
 drivers/input/touchscreen/edt-ft5x06.c                             | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
index bedd7dd..f99528d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
@@ -5,6 +5,7 @@ There are 3 variants of the chip for various touch panel sizes
 FT5206GE1  2.8" .. 3.8"
 FT5306DE4  4.3" .. 7"
 FT5406EE8  7"   .. 8.9"
+FT5506EEG  7"   .. 8.9"
 
 The software interface is identical for all those chips, so that
 currently there is no need for the driver to distinguish between the
@@ -17,6 +18,7 @@ Required properties:
  - compatible:  "edt,edt-ft5206"
            or:  "edt,edt-ft5306"
            or:  "edt,edt-ft5406"
+           or:  "edt,edt-ft5506"
 
  - reg:         I2C slave address of the chip (0x38)
  - interrupt-parent: a phandle pointing to the interrupt controller
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 34a353b..e095838 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -172,7 +172,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	struct edt_ft5x06_ts_data *tsdata = dev_id;
 	struct device *dev = &tsdata->client->dev;
 	u8 cmd;
-	u8 rdbuf[31];
+	u8 rdbuf[61];
 	int i, type, x, y, id;
 	int offset, tplen, datalen, crclen;
 	int error;
@@ -1076,6 +1076,10 @@ MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
 
 #ifdef CONFIG_OF
 
+static const struct edt_i2c_chip_data edt_ft5506_data = {
+	.max_support_points = 10,
+};
+
 static const struct edt_i2c_chip_data edt_ft5x06_data = {
 	.max_support_points = 5,
 };
@@ -1084,6 +1088,7 @@ static const struct of_device_id edt_ft5x06_of_match[] = {
 	{ .compatible = "edt,edt-ft5206", .data = &edt_ft5x06_data},
 	{ .compatible = "edt,edt-ft5306", .data = &edt_ft5x06_data},
 	{ .compatible = "edt,edt-ft5406", .data = &edt_ft5x06_data},
+	{ .compatible = "edt,edt-ft5506", .data = &edt_ft5506_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, edt_ft5x06_of_match);
-- 
2.6.1
