From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 5/5] Input: mpr121 - switch to device tree probe
Date: Sun, 15 Jan 2017 22:15:44 +0900
Message-ID: <1484486144-27947-6-git-send-email-akinobu.mita@gmail.com>
References: <1484486144-27947-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484486144-27947-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This driver currently only supports legacy platform data probe.  This
change adds device tree support and gets rid of platform data probe code
since no one is actually using mpr121 platform data in the mainline.

The device tree property parsing code is based on the work of
atmel_captouch driver.

Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
* Newly added patch from v2

 .../devicetree/bindings/input/mpr121-touchkey.txt  |  30 ++++++
 drivers/input/keyboard/mpr121_touchkey.c           | 110 +++++++++++++++------
 include/linux/i2c/mpr121_touchkey.h                |  20 ----
 3 files changed, 110 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey.txt
 delete mode 100644 include/linux/i2c/mpr121_touchkey.h

diff --git a/Documentation/devicetree/bindings/input/mpr121-touchkey.txt b/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
new file mode 100644
index 0000000..b7c61ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
@@ -0,0 +1,30 @@
+* Freescale MPR121 Controllor
+
+Required Properties:
+- compatible:		Should be "fsl,mpr121-touchkey"
+- reg:			The I2C slave address of the device.
+- interrupts:		The interrupt number to the cpu.
+- vdd-supply:		Phandle to the Vdd power supply.
+- linux,keycodes:	Specifies an array of numeric keycode values to
+			be used for reporting button presses. The array can
+			contain up to 12 entries.
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
+		linux,keycodes = <KEY_0>, <KEY_1>, <KEY_2>, <KEY_3>,
+				<KEY_4> <KEY_5>, <KEY_6>, <KEY_7>,
+				<KEY_8>, <KEY_9>, <KEY_A>, <KEY_B>;
+	};
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index a0210ae..ebb401f 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -19,7 +19,7 @@
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
-#include <linux/i2c/mpr121_touchkey.h>
+#include <linux/regulator/consumer.h>
 
 /* Register definitions */
 #define ELE_TOUCH_STATUS_0_ADDR	0x0
@@ -61,7 +61,7 @@ struct mpr121_touchkey {
 	struct input_dev	*input_dev;
 	unsigned int		statusbits;
 	unsigned int		keycount;
-	u16			keycodes[MPR121_MAX_KEY_COUNT];
+	u32			keycodes[MPR121_MAX_KEY_COUNT];
 };
 
 struct mpr121_init_register {
@@ -81,6 +81,42 @@ static const struct mpr121_init_register init_reg_table[] = {
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
@@ -126,9 +162,8 @@ static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mpr121_phys_init(const struct mpr121_platform_data *pdata,
-				      struct mpr121_touchkey *mpr121,
-				      struct i2c_client *client)
+static int mpr121_phys_init(struct mpr121_touchkey *mpr121,
+			    struct i2c_client *client, int vdd_uv)
 {
 	const struct mpr121_init_register *reg;
 	unsigned char usl, lsl, tl, eleconf;
@@ -158,9 +193,9 @@ static int mpr121_phys_init(const struct mpr121_platform_data *pdata,
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
@@ -191,27 +226,19 @@ static int mpr121_phys_init(const struct mpr121_platform_data *pdata,
 static int mpr_touchkey_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
-	const struct mpr121_platform_data *pdata =
-			dev_get_platdata(&client->dev);
+	struct device *dev = &client->dev;
+	struct regulator *vdd_supply;
+	int vdd_uv;
 	struct mpr121_touchkey *mpr121;
 	struct input_dev *input_dev;
 	int error;
 	int i;
 
-	if (!pdata) {
-		dev_err(&client->dev, "no platform data defined\n");
-		return -EINVAL;
-	}
+	vdd_supply = mpr121_vdd_supply_init(dev);
+	if (IS_ERR(vdd_supply))
+		return PTR_ERR(vdd_supply);
 
-	if (!pdata->keymap || !pdata->keymap_size) {
-		dev_err(&client->dev, "missing keymap data\n");
-		return -EINVAL;
-	}
-
-	if (pdata->keymap_size > MPR121_MAX_KEY_COUNT) {
-		dev_err(&client->dev, "too many keys defined\n");
-		return -EINVAL;
-	}
+	vdd_uv = regulator_get_voltage(vdd_supply);
 
 	if (!client->irq) {
 		dev_err(&client->dev, "irq number should not be zero\n");
@@ -229,24 +256,37 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 
 	mpr121->client = client;
 	mpr121->input_dev = input_dev;
-	mpr121->keycount = pdata->keymap_size;
+	mpr121->keycount = device_property_read_u32_array(dev, "linux,keycodes",
+							NULL, 0);
+	if (mpr121->keycount > MPR121_MAX_KEY_COUNT) {
+		dev_err(dev, "too many keys defined\n");
+		return -EINVAL;
+	}
+
+	error = device_property_read_u32_array(dev, "linux,keycodes",
+						mpr121->keycodes,
+						mpr121->keycount);
+	if (error) {
+		dev_err(dev,
+			"failed to read linux,keycode property: %d\n", error);
+		return error;
+	}
 
 	input_dev->name = "Freescale MPR121 Touchkey";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+	if (device_property_present(dev, "autorepeat"))
+		__set_bit(EV_REP, input_dev->evbit);
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 
 	input_dev->keycode = mpr121->keycodes;
 	input_dev->keycodesize = sizeof(mpr121->keycodes[0]);
 	input_dev->keycodemax = mpr121->keycount;
 
-	for (i = 0; i < pdata->keymap_size; i++) {
-		input_set_capability(input_dev, EV_KEY, pdata->keymap[i]);
-		mpr121->keycodes[i] = pdata->keymap[i];
-	}
+	for (i = 0; i < mpr121->keycount; i++)
+		input_set_capability(input_dev, EV_KEY, mpr121->keycodes[i]);
 
-	error = mpr121_phys_init(pdata, mpr121, client);
+	error = mpr121_phys_init(mpr121, client, vdd_uv);
 	if (error) {
 		dev_err(&client->dev, "Failed to init register\n");
 		return error;
@@ -266,7 +306,8 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 		return error;
 
 	i2c_set_clientdata(client, mpr121);
-	device_init_wakeup(&client->dev, pdata->wakeup);
+	device_init_wakeup(dev,
+			device_property_read_bool(dev, "wakeup-source"));
 
 	return 0;
 }
@@ -305,10 +346,19 @@ static const struct i2c_device_id mpr121_id[] = {
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
diff --git a/include/linux/i2c/mpr121_touchkey.h b/include/linux/i2c/mpr121_touchkey.h
deleted file mode 100644
index f0bcc38..0000000
--- a/include/linux/i2c/mpr121_touchkey.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* Header file for Freescale MPR121 Capacitive Touch Sensor */
-
-#ifndef _MPR121_TOUCHKEY_H
-#define _MPR121_TOUCHKEY_H
-
-/**
- * struct mpr121_platform_data - platform data for mpr121 sensor
- * @keymap: pointer to array of KEY_* values representing keymap
- * @keymap_size: size of the keymap
- * @wakeup: configure the button as a wake-up source
- * @vdd_uv: VDD voltage in uV
- */
-struct mpr121_platform_data {
-	const unsigned short *keymap;
-	unsigned int keymap_size;
-	bool wakeup;
-	int vdd_uv;
-};
-
-#endif /* _MPR121_TOUCHKEY_H */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
