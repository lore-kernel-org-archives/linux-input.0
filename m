From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v4 1/3] Input: egalax_ts: get gpio from devicetree node
Date: Thu, 16 Aug 2012 18:47:29 +0800
Message-ID: <1345114051-3052-2-git-send-email-jason77.wang@gmail.com>
References: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:61016 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab2HPKsX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Aug 2012 06:48:23 -0400
In-Reply-To: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, shawn.guo@linaro.org
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
and don't support this API anymore.

The i.MX6q sabrelite platform equips an egalax touchscreen controller,
and this platform already transfered to GENERIC_GPIO framework, to
support this driver, we use a more generic way to get gpio.

Add a return value checking for waking up the controller in the probe
function, this guarantee only a workable device can pass init.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 drivers/input/touchscreen/egalax_ts.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 70524dd..8516a4e 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/input/mt.h>
+#include <linux/of_gpio.h>
 
 /*
  * Mouse Mode: some panel may configure the controller to mouse mode,
@@ -122,8 +123,15 @@ static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
 /* wake up controller by an falling edge of interrupt gpio.  */
 static int egalax_wake_up_device(struct i2c_client *client)
 {
-	int gpio = irq_to_gpio(client->irq);
-	int ret;
+	struct device_node *np = client->dev.of_node;
+	int gpio, ret;
+
+	if (!np)
+		return -ENODEV;
+
+	gpio = of_get_named_gpio(np, "wakeup-gpios", 0);
+	if (!gpio_is_valid(gpio))
+		return -ENODEV;
 
 	ret = gpio_request(gpio, "egalax_irq");
 	if (ret < 0) {
@@ -181,7 +189,12 @@ static int __devinit egalax_ts_probe(struct i2c_client *client,
 	ts->input_dev = input_dev;
 
 	/* controller may be in sleep, wake it up. */
-	egalax_wake_up_device(client);
+	ret = egalax_wake_up_device(client);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to wake up the controller\n");
+		error = ret;
+		goto err_free_dev;
+	}
 
 	ret = egalax_firmware_version(client);
 	if (ret < 0) {
@@ -274,11 +287,17 @@ static int egalax_ts_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(egalax_ts_pm_ops, egalax_ts_suspend, egalax_ts_resume);
 
+static struct of_device_id egalax_ts_dt_ids[] = {
+	{ .compatible = "eeti,egalax_ts" },
+	{ /* sentinel */ }
+};
+
 static struct i2c_driver egalax_ts_driver = {
 	.driver = {
 		.name	= "egalax_ts",
 		.owner	= THIS_MODULE,
 		.pm	= &egalax_ts_pm_ops,
+		.of_match_table	= egalax_ts_dt_ids,
 	},
 	.id_table	= egalax_ts_id,
 	.probe		= egalax_ts_probe,
-- 
1.7.6

