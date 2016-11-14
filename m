From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend] input: touchscreen: silead: Add regulator support
Date: Mon, 14 Nov 2016 15:45:02 +0100
Message-ID: <20161114144502.10595-2-hdegoede@redhat.com>
References: <20161114144502.10595-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752597AbcKNOpH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Nov 2016 09:45:07 -0500
In-Reply-To: <20161114144502.10595-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

On some tablets the touchscreen controller is powered by seperate
regulators, add support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 +
 drivers/input/touchscreen/silead.c                 | 51 ++++++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
index e844c3f..b726823 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
@@ -22,6 +22,8 @@ Optional properties:
 - touchscreen-inverted-y  : See touchscreen.txt
 - touchscreen-swapped-x-y : See touchscreen.txt
 - silead,max-fingers	  : maximum number of fingers the touchscreen can detect
+- vddio-supply		  : regulator phandle for controller VDDIO
+- avdd-supply		  : regulator phandle for controller AVDD
 
 Example:
 
diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index f502c84..c6a1ae9 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -29,6 +29,7 @@
 #include <linux/input/touchscreen.h>
 #include <linux/pm.h>
 #include <linux/irq.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/unaligned.h>
 
@@ -72,6 +73,8 @@ enum silead_ts_power {
 struct silead_ts_data {
 	struct i2c_client *client;
 	struct gpio_desc *gpio_power;
+	struct regulator *vddio;
+	struct regulator *avdd;
 	struct input_dev *input;
 	char fw_name[64];
 	struct touchscreen_properties prop;
@@ -465,21 +468,52 @@ static int silead_ts_probe(struct i2c_client *client,
 	if (client->irq <= 0)
 		return -ENODEV;
 
+	data->vddio = devm_regulator_get_optional(dev, "vddio");
+	if (IS_ERR(data->vddio)) {
+		if (PTR_ERR(data->vddio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		data->vddio = NULL;
+	}
+
+	data->avdd = devm_regulator_get_optional(dev, "avdd");
+	if (IS_ERR(data->avdd)) {
+		if (PTR_ERR(data->avdd) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		data->avdd = NULL;
+	}
+
+	/*
+	 * Enable regulators at probe and disable them at remove, we need
+	 * to keep the chip powered otherwise it forgets its firmware.
+	 */
+	if (data->vddio) {
+		error = regulator_enable(data->vddio);
+		if (error)
+			return error;
+	}
+
+	if (data->avdd) {
+		error = regulator_enable(data->avdd);
+		if (error)
+			goto disable_vddio;
+	}
+
 	/* Power GPIO pin */
 	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpio_power)) {
 		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
 			dev_err(dev, "Shutdown GPIO request failed\n");
-		return PTR_ERR(data->gpio_power);
+		error = PTR_ERR(data->gpio_power);
+		goto disable_avdd;
 	}
 
 	error = silead_ts_setup(client);
 	if (error)
-		return error;
+		goto disable_avdd;
 
 	error = silead_ts_request_input_dev(data);
 	if (error)
-		return error;
+		goto disable_avdd;
 
 	error = devm_request_threaded_irq(dev, client->irq,
 					  NULL, silead_ts_threaded_irq_handler,
@@ -487,10 +521,19 @@ static int silead_ts_probe(struct i2c_client *client,
 	if (error) {
 		if (error != -EPROBE_DEFER)
 			dev_err(dev, "IRQ request failed %d\n", error);
-		return error;
+		goto disable_avdd;
 	}
 
 	return 0;
+
+disable_avdd:
+	if (data->avdd)
+		regulator_disable(data->avdd);
+disable_vddio:
+	if (data->vddio)
+		regulator_disable(data->vddio);
+
+	return error;
 }
 
 static int __maybe_unused silead_ts_suspend(struct device *dev)
-- 
2.9.3

