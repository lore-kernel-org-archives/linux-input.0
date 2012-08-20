From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v2] input: dts: qt1070: add device tree support
Date: Mon, 20 Aug 2012 11:41:10 +0800
Message-ID: <1345434070-6539-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:41648 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab2HTDlS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Aug 2012 23:41:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: shubhrajyoti@ti.com, nicolas.ferre@atmel.com, jm.lin@atmel.com, linux-input@vger.kernel.org, Bo Shen <voice.shen@atmel.com>

This patch enable the qt1070 device tree support

If using device tree, the node of qt1070 looks like
i2c@0 {					     // this is an example
 	status = "okay";		     // Enable i2c master
 	qt1070@1b {
 		compatible = "atmel,qt1070"; // FDT device id
 		reg = <0x1b>;		     // qt1070 i2c address
 		change-gpio = <&pioA 7 1>;   // gpio used as interrupt
 	};
};

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
change since v1
  Add gpio relative stuff, gpio_is_valid, gpio_request

---
 drivers/input/keyboard/qt1070.c |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index ca68f29..2717bb4 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -33,6 +33,8 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 /* Address for each register */
 #define CHIP_ID            0x00
@@ -155,11 +157,25 @@ static int __devinit qt1070_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	if (!client->irq) {
+	if (client->dev.of_node)
+		client->irq = of_get_named_gpio(client->dev.of_node,
+				"change-gpio", 0);
+
+	if (!client->irq || client->irq < 0) {
 		dev_err(&client->dev, "please assign the irq to this device\n");
 		return -EINVAL;
 	}
 
+	if (gpio_is_valid(client->irq)) {
+		if (gpio_request(client->irq, "qt1070-change")) {
+			dev_err(&client->dev, "request gpio failed\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_err(&client->dev, "gpio is not valid\n");
+		return -EINVAL;
+	}
+
 	/* Identify the qt1070 chip */
 	if (!qt1070_identify(client))
 		return -ENODEV;
@@ -200,9 +216,9 @@ static int __devinit qt1070_probe(struct i2c_client *client,
 	qt1070_write(client, RESET, 1);
 	msleep(QT1070_RESET_TIME);
 
-	err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
-				   IRQF_TRIGGER_NONE | IRQF_ONESHOT,
-				   client->dev.driver->name, data);
+	err = request_threaded_irq(gpio_to_irq(client->irq), NULL,
+			qt1070_interrupt, IRQF_TRIGGER_NONE | IRQF_ONESHOT,
+			"qt1070-change", data);
 	if (err) {
 		dev_err(&client->dev, "fail to request irq\n");
 		goto err_free_mem;
@@ -243,6 +259,12 @@ static int __devexit qt1070_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id atmel_qt1070_of_match[] = {
+	{ .compatible = "atmel,qt1070", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, atmel_qt1070_of_match);
+
 static const struct i2c_device_id qt1070_id[] = {
 	{ "qt1070", 0 },
 	{ },
@@ -253,6 +275,7 @@ static struct i2c_driver qt1070_driver = {
 	.driver	= {
 		.name	= "qt1070",
 		.owner	= THIS_MODULE,
+		.of_match_table = atmel_qt1070_of_match,
 	},
 	.id_table	= qt1070_id,
 	.probe		= qt1070_probe,
-- 
1.7.10

