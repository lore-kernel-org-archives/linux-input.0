From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] Input: mpr121 - add device tree support
Date: Thu, 12 Jan 2017 02:42:29 +0900
Message-ID: <1484156549-26585-6-git-send-email-akinobu.mita@gmail.com>
References: <1484156549-26585-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484156549-26585-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This adds device tree support to mpr121 driver which currently only
supports legacy platform data probe.

Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/input/mpr121-touchkey.txt  | 44 +++++++++++
 drivers/input/keyboard/mpr121_touchkey.c           | 87 +++++++++++++++++++---
 2 files changed, 121 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey.txt

diff --git a/Documentation/devicetree/bindings/input/mpr121-touchkey.txt b/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
new file mode 100644
index 0000000..2c4a53c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
@@ -0,0 +1,44 @@
+* Freescale MPR121 Controllor
+
+Required Properties:
+- compatible:		Should be "fsl,mpr121-touchkey"
+- reg:			The I2C slave address of the device.
+- interrupts:		The interrupt number to the cpu.
+- vdd-supply:		Phandle to the Vdd power supply.
+- linux,keymap:		The keymap for keys as described in the binding document
+			devicetree/bindings/input/matrix-keymap.txt.
+- keypad,num-rows:	Must be 1
+- keypad,num-columns:	Number of lines connected to the keypad controller.
+
+Optional Properties:
+- wakeup-source:	Use any event on keypad as wakeup event.
+- autorepeat:		Enable autorepeat feature.
+
+Example:
+
+#include "dt-bindings/input/input.h"
+
+	touchkey: mpr121@5a {
+		compatible = "fsl,mpr121-touchkey";
+		reg = <0x5a>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <28 2>;
+		autorepeat;
+		vdd-supply = <&ldo4_reg>;
+		keypad,num-rows = <1>;
+		keypad,num-columns = <12>;
+		linux,keymap = <
+			MATRIX_KEY(0x00, 0x00, KEY_0)
+			MATRIX_KEY(0x00, 0x01, KEY_1)
+			MATRIX_KEY(0x00, 0x02, KEY_2)
+			MATRIX_KEY(0x00, 0x03, KEY_3)
+			MATRIX_KEY(0x00, 0x04, KEY_4)
+			MATRIX_KEY(0x00, 0x05, KEY_5)
+			MATRIX_KEY(0x00, 0x06, KEY_6)
+			MATRIX_KEY(0x00, 0x07, KEY_7)
+			MATRIX_KEY(0x00, 0x08, KEY_8)
+			MATRIX_KEY(0x00, 0x09, KEY_9)
+			MATRIX_KEY(0x00, 0x0a, KEY_A)
+			MATRIX_KEY(0x00, 0x0b, KEY_B)
+		>;
+	};
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 7e85512..2eb0900 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/i2c/mpr121_touchkey.h>
+#include <linux/regulator/consumer.h>
 #include <linux/input/matrix_keypad.h>
 
 /* Register definitions */
@@ -81,6 +82,42 @@ static const struct mpr121_init_register init_reg_table[] = {
 	{ AUTO_CONFIG_CTRL_ADDR, 0x0b },
 };
 
+static void mpr121_vdd_supply_disable(void *data)
+{
+	struct regulator *vdd_supply = data;
+
+	regulator_disable(vdd_supply);
+}
+
+static struct regulator *mpr121_vdd_supply_init(struct device *dev)
+{
+	struct regulator *vdd_supply;
+	int err;
+
+	vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(vdd_supply)) {
+		dev_err(dev, "failed to get vdd regulator: %ld\n",
+			PTR_ERR(vdd_supply));
+		return vdd_supply;
+	}
+
+	err = regulator_enable(vdd_supply);
+	if (err) {
+		dev_err(dev, "failed to enable vdd regulator: %d\n", err);
+		return ERR_PTR(err);
+	}
+
+	err = devm_add_action(dev, mpr121_vdd_supply_disable, vdd_supply);
+	if (err) {
+		regulator_disable(vdd_supply);
+		dev_err(dev, "failed to add disable regulator action: %d\n",
+			err);
+		return ERR_PTR(err);
+	}
+
+	return vdd_supply;
+}
+
 static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 {
 	struct mpr121_touchkey *mpr121 = dev_id;
@@ -130,9 +167,8 @@ static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mpr121_phys_init(const struct mpr121_platform_data *pdata,
-				      struct mpr121_touchkey *mpr121,
-				      struct i2c_client *client)
+static int mpr121_phys_init(int vdd_uv, struct mpr121_touchkey *mpr121,
+				struct i2c_client *client)
 {
 	const struct mpr121_init_register *reg;
 	unsigned char usl, lsl, tl, eleconf;
@@ -162,9 +198,9 @@ static int mpr121_phys_init(const struct mpr121_platform_data *pdata,
 	/*
 	 * Capacitance on sensing input varies and needs to be compensated.
 	 * The internal MPR121-auto-configuration can do this if it's
-	 * registers are set properly (based on pdata->vdd_uv).
+	 * registers are set properly (based on vdd_uv).
 	 */
-	vdd = pdata->vdd_uv / 1000;
+	vdd = vdd_uv / 1000;
 	usl = ((vdd - 700) * 256) / vdd;
 	lsl = (usl * 65) / 100;
 	tl = (usl * 90) / 100;
@@ -198,6 +234,9 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 	const struct mpr121_platform_data *pdata =
 			dev_get_platdata(&client->dev);
 	struct device *dev = &client->dev;
+	bool autorepeat;
+	bool wakeup;
+	int vdd_uv;
 	unsigned int keymap_size;
 	struct matrix_keymap_data *keymap_data;
 	struct mpr121_touchkey *mpr121;
@@ -218,6 +257,9 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 			return -EINVAL;
 		}
 
+		autorepeat = true;
+		wakeup = pdata->wakeup;
+		vdd_uv = pdata->vdd_uv;
 		keymap_size = pdata->keymap_size;
 
 		keymap = devm_kcalloc(dev, keymap_size,
@@ -236,8 +278,23 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 		keymap_data->keymap_size = keymap_size;
 		keymap_data->keymap = keymap;
 	} else {
-		dev_err(&client->dev, "no platform data defined\n");
-		return -EINVAL;
+		unsigned int rows;
+		struct regulator *vdd_supply;
+
+		error = matrix_keypad_parse_of_params(dev, &rows, &keymap_size);
+		if (rows != 1) {
+			dev_err(dev, "number of keypad rows must be 1\n");
+			return -EINVAL;
+		}
+
+		vdd_supply = mpr121_vdd_supply_init(dev);
+		if (IS_ERR(vdd_supply))
+			return PTR_ERR(vdd_supply);
+
+		vdd_uv = regulator_get_voltage(vdd_supply);
+		autorepeat = device_property_present(dev, "autorepeat");
+		wakeup = device_property_read_bool(dev, "wakeup-source");
+		keymap_data = NULL;
 	}
 
 	if (!client->irq) {
@@ -261,15 +318,16 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 	input_dev->name = "Freescale MPR121 Touchkey";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
-	input_dev->evbit[0] = BIT_MASK(EV_REP);
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+	if (autorepeat)
+		__set_bit(EV_REP, input_dev->evbit);
 
 	error = matrix_keypad_build_keymap(keymap_data, NULL, 1, keymap_size,
 						NULL, input_dev);
 	if (error)
 		return error;
 
-	error = mpr121_phys_init(pdata, mpr121, client);
+	error = mpr121_phys_init(vdd_uv, mpr121, client);
 	if (error) {
 		dev_err(&client->dev, "Failed to init register\n");
 		return error;
@@ -289,7 +347,7 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 		return error;
 
 	i2c_set_clientdata(client, mpr121);
-	device_init_wakeup(&client->dev, pdata->wakeup);
+	device_init_wakeup(dev, wakeup);
 
 	return 0;
 }
@@ -330,10 +388,19 @@ static const struct i2c_device_id mpr121_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mpr121_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id mpr121_touchkey_dt_match_table[] = {
+	{ .compatible = "fsl,mpr121-touchkey" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpr121_touchkey_dt_match_table);
+#endif
+
 static struct i2c_driver mpr_touchkey_driver = {
 	.driver = {
 		.name	= "mpr121",
 		.pm	= &mpr121_touchkey_pm_ops,
+		.of_match_table = of_match_ptr(mpr121_touchkey_dt_match_table),
 	},
 	.id_table	= mpr121_id,
 	.probe		= mpr_touchkey_probe,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
