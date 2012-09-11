From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v3] input: qt1070: Add device tree support
Date: Tue, 11 Sep 2012 18:14:19 +0800
Message-ID: <1347358459-11598-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:17891 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758464Ab2IKKUH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Sep 2012 06:20:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: shubhrajyoti@ti.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, jm.lin@atmel.com, Bo Shen <voice.shen@atmel.com>

Add qt1070 device tree support
Using device node to parse irq

Test this on at91sam9x5ek board

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
change since v2
  Using device node to parse irq,
  Remove gpio relative stuff

change since v1
  Add gpio relative stuff, gpio_is_valid, gpio_request
---
 .../devicetree/bindings/input/atmel-qt1070.txt     |   16 ++++++++++++++++
 drivers/input/keyboard/qt1070.c                    |    9 +++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/atmel-qt1070.txt

diff --git a/Documentation/devicetree/bindings/input/atmel-qt1070.txt b/Documentation/devicetree/bindings/input/atmel-qt1070.txt
new file mode 100644
index 0000000..e1fc09e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/atmel-qt1070.txt
@@ -0,0 +1,16 @@
+Atmel qt1070 keyboard interface
+
+Required Properties:
+- compatible: Should be "atmel,qt1070"
+- reg: I2C slave address
+- interrupt-parent: Depends on SoC
+- interrupts: The interrupt pin number to the cpu, and trigger mode.
+
+Example:
+
+	qt1070@1b {
+		compatible = "atmel,qt1070";
+		reg = <0x1b>;
+		interrupt-parent = <&pioA>;
+		interrupts = <7 0x0>;
+	};
diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index ca68f29..60457dc 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -249,10 +249,19 @@ static const struct i2c_device_id qt1070_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, qt1070_id);
 
+#ifdef CONFIG_OF
+static struct of_device_id atmel_qt1070_of_match[] = {
+	{ .compatible = "atmel,qt1070" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, atmel_qt1070_of_match);
+#endif
+
 static struct i2c_driver qt1070_driver = {
 	.driver	= {
 		.name	= "qt1070",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(atmel_qt1070_of_match),
 	},
 	.id_table	= qt1070_id,
 	.probe		= qt1070_probe,
-- 
1.7.9.5

