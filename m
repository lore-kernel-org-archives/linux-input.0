From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] input: touchscreen: silead: Add regulator support
Date: Wed, 16 Nov 2016 12:55:07 +0100
Message-ID: <20161116115507.24220-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbcKPLzL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Nov 2016 06:55:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

On some tablets the touchscreen controller is powered by separate
regulators, add support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
-Use devm_regulator_bulk_get() and friends
-Use devm_add_action_or_reset() to disable the regulator
---
 .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 ++
 drivers/input/touchscreen/silead.c                 | 29 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

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
index f502c84..404830a 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -29,6 +29,7 @@
 #include <linux/input/touchscreen.h>
 #include <linux/pm.h>
 #include <linux/irq.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/unaligned.h>
 
@@ -73,6 +74,7 @@ struct silead_ts_data {
 	struct i2c_client *client;
 	struct gpio_desc *gpio_power;
 	struct input_dev *input;
+	struct regulator_bulk_data regulators[2];
 	char fw_name[64];
 	struct touchscreen_properties prop;
 	u32 max_fingers;
@@ -433,6 +435,13 @@ static int silead_ts_set_default_fw_name(struct silead_ts_data *data,
 }
 #endif
 
+static void silead_disable_regulator(void *arg)
+{
+	struct silead_ts_data *data = arg;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+}
+
 static int silead_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -465,6 +474,26 @@ static int silead_ts_probe(struct i2c_client *client,
 	if (client->irq <= 0)
 		return -ENODEV;
 
+	data->regulators[0].supply = "vddio";
+	data->regulators[1].supply = "avdd";
+	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
+					data->regulators);
+	if (error)
+		return error;
+
+	/*
+	 * Enable regulators at probe and disable them at remove, we need
+	 * to keep the chip powered otherwise it forgets its firmware.
+	 */
+	error = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (error)
+		return error;
+
+	error = devm_add_action_or_reset(dev, silead_disable_regulator, data);
+	if (error)
+		return error;
+
 	/* Power GPIO pin */
 	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpio_power)) {
-- 
2.9.3

