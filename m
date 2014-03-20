From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCHv5 2/5] Input: edt-ft5x06: Add DT support
Date: Thu, 20 Mar 2014 14:44:32 +0100
Message-ID: <1395323075-12146-3-git-send-email-LW@KARO-electronics.de>
References: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de>
 <1395323075-12146-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395323075-12146-1-git-send-email-LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Budig <simon.budig-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Daniel Wagener <daniel.wagener-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
List-Id: linux-input@vger.kernel.org


Signed-off-by: Lothar Wa=C3=9Fmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
---
 .../bindings/input/touchscreen/edt-ft5x06.txt      |   55 ++++++++
 drivers/input/touchscreen/edt-ft5x06.c             |  143 ++++++++++++=
+++-----
 2 files changed, 167 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/edt-ft5x06.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft=
5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x=
06.txt
new file mode 100644
index 0000000..76db967
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.tx=
t
@@ -0,0 +1,55 @@
+FocalTech EDT-FT5x06 Polytouch driver
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+There are 3 variants of the chip for various touch panel sizes
+FT5206GE1  2.8" .. 3.8"
+FT5306DE4  4.3" .. 7"
+FT5406EE8  7"   .. 8.9"
+
+The software interface is identical for all those chips, so that
+currently there is no need for the driver to distinguish between the
+different chips. Nevertheless distinct compatible strings are used so
+that a distinction can be added if necessary without changing the DT
+bindings.
+
+
+Required properties:
+ - compatible:  "edt,edt-ft5206"
+           or:  "edt,edt-ft5306"
+           or:  "edt,edt-ft5406"
+
+ - reg:         I2C slave address of the chip (0x38)
+ - interrupt-parent: a phandle pointing to the interrupt controller
+                     serving the interrupt for this chip
+ - interrupts:       interrupt specification for the touchdetect
+                     interrupt
+
+Optional properties:
+ - reset-gpios: GPIO specification for the RESET input
+ - wake-gpios:  GPIO specification for the WAKE input
+
+ - pinctrl-names: should be "default"
+ - pinctrl-0:   a phandle pointing to the pin settings for the
+                control gpios
+
+ - threshold:   allows setting the "click"-threshold in the range
+                from 20 to 80.
+
+ - gain:        allows setting the sensitivity in the range from 0 to
+                31. Note that lower values indicate higher
+                sensitivity.
+
+ - offset:      allows setting the edge compensation in the range from
+                0 to 31.
+
+Example:
+	polytouch: edt-ft5x06@38 {
+		compatible =3D "edt,edt-ft5406", "edt,edt-ft5x06";
+		reg =3D <0x38>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&edt_ft5x06_pins>;
+		interrupt-parent =3D <&gpio2>;
+		interrupts =3D <5 0>;
+		reset-gpios =3D <&gpio2 6 1>;
+		wake-gpios =3D <&gpio4 9 0>;
+	};
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
index 155ab3b..03dab2f 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2012 Simon Budig, <simon.budig-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
+ * Lothar Wa=C3=9Fmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org> (DT support)
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, an=
d
@@ -33,6 +34,7 @@
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/input/mt.h>
 #include <linux/input/edt-ft5x06.h>
=20
@@ -65,6 +67,10 @@ struct edt_ft5x06_ts_data {
 	u16 num_x;
 	u16 num_y;
=20
+	int reset_pin;
+	int irq_pin;
+	int wake_pin;
+
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry *debug_dir;
 	u8 *raw_buffer;
@@ -614,24 +620,38 @@ edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_=
ts_data *tsdata)
 #endif /* CONFIG_DEBUGFS */
=20
 static int edt_ft5x06_ts_reset(struct i2c_client *client,
-					 int reset_pin)
+			struct edt_ft5x06_ts_data *tsdata)
 {
 	int error;
=20
-	if (gpio_is_valid(reset_pin)) {
+	if (gpio_is_valid(tsdata->wake_pin)) {
+		error =3D devm_gpio_request_one(&client->dev,
+					tsdata->wake_pin, GPIOF_OUT_INIT_LOW,
+					"edt-ft5x06 wake");
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to request GPIO %d as wake pin, error %d\n",
+				tsdata->wake_pin, error);
+			return error;
+		}
+
+		mdelay(5);
+		gpio_set_value(tsdata->wake_pin, 1);
+	}
+	if (gpio_is_valid(tsdata->reset_pin)) {
 		/* this pulls reset down, enabling the low active reset */
-		error =3D devm_gpio_request_one(&client->dev, reset_pin,
-					      GPIOF_OUT_INIT_LOW,
-					      "edt-ft5x06 reset");
+		error =3D devm_gpio_request_one(&client->dev,
+					tsdata->reset_pin, GPIOF_OUT_INIT_LOW,
+					"edt-ft5x06 reset");
 		if (error) {
 			dev_err(&client->dev,
 				"Failed to request GPIO %d as reset pin, error %d\n",
-				reset_pin, error);
+				tsdata->reset_pin, error);
 			return error;
 		}
=20
 		mdelay(50);
-		gpio_set_value(reset_pin, 1);
+		gpio_set_value(tsdata->reset_pin, 1);
 		mdelay(100);
 	}
=20
@@ -672,6 +692,20 @@ static int edt_ft5x06_ts_identify(struct i2c_clien=
t *client,
 	    pdata->name <=3D edt_ft5x06_attr_##name.limit_high)		\
 		edt_ft5x06_register_write(tsdata, reg, pdata->name)
=20
+#define EDT_GET_PROP(name, reg) {				\
+	u32 val;						\
+	if (of_property_read_u32(np, #name, val) =3D=3D 0)		\
+		edt_ft5x06_register_write(tsdata, reg, val);	\
+}
+
+static void edt_ft5x06_ts_get_dt_defaults(struct device_node *np,
+					struct edt_ft5x06_ts_data *tsdata)
+{
+	EDT_GET_PROP(threshold, WORK_REGISTER_THRESHOLD);
+	EDT_GET_PROP(gain, WORK_REGISTER_GAIN);
+	EDT_GET_PROP(offset, WORK_REGISTER_OFFSET);
+}
+
 static void
 edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
 			   const struct edt_ft5x06_platform_data *pdata)
@@ -699,6 +733,30 @@ edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_=
data *tsdata)
 	tsdata->num_y =3D edt_ft5x06_register_read(tsdata, WORK_REGISTER_NUM_=
Y);
 }
=20
+#ifdef CONFIG_OF
+static int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
+				struct edt_ft5x06_ts_data *tsdata)
+{
+	struct device_node *np =3D dev->of_node;
+
+	/*
+	 * irq_pin is not needed for DT setup.
+	 * irq is associated via 'interrupts' property in DT
+	 */
+	tsdata->irq_pin =3D -EINVAL;
+	tsdata->reset_pin =3D of_get_named_gpio(np, "reset-gpios", 0);
+	tsdata->wake_pin =3D of_get_named_gpio(np, "wake-gpios", 0);
+
+	return 0;
+}
+#else
+static inline int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
+					struct edt_ft5x06_i2c_ts_data *tsdata)
+{
+	return -ENODEV;
+}
+#endif
+
 static int edt_ft5x06_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
@@ -711,32 +769,40 @@ static int edt_ft5x06_ts_probe(struct i2c_client =
*client,
=20
 	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
=20
+	tsdata =3D devm_kzalloc(&client->dev, sizeof(*tsdata), GFP_KERNEL);
+	if (!tsdata) {
+		dev_err(&client->dev, "failed to allocate driver data.\n");
+		return -ENOMEM;
+	}
+
 	if (!pdata) {
-		dev_err(&client->dev, "no platform data?\n");
-		return -EINVAL;
+		error =3D edt_ft5x06_i2c_ts_probe_dt(&client->dev, tsdata);
+		if (error) {
+			dev_err(&client->dev,
+				"DT probe failed and no platform data present\n");
+			return error;
+		}
+	} else {
+		tsdata->reset_pin =3D pdata->reset_pin;
+		tsdata->irq_pin =3D pdata->irq_pin;
+		tsdata->wake_pin =3D -EINVAL;
 	}
=20
-	error =3D edt_ft5x06_ts_reset(client, pdata->reset_pin);
+	error =3D edt_ft5x06_ts_reset(client, tsdata);
 	if (error)
 		return error;
=20
-	if (gpio_is_valid(pdata->irq_pin)) {
-		error =3D devm_gpio_request_one(&client->dev, pdata->irq_pin,
-					      GPIOF_IN, "edt-ft5x06 irq");
+	if (gpio_is_valid(tsdata->irq_pin)) {
+		error =3D devm_gpio_request_one(&client->dev, tsdata->irq_pin,
+					GPIOF_IN, "edt-ft5x06 irq");
 		if (error) {
 			dev_err(&client->dev,
 				"Failed to request GPIO %d, error %d\n",
-				pdata->irq_pin, error);
+				tsdata->irq_pin, error);
 			return error;
 		}
 	}
=20
-	tsdata =3D devm_kzalloc(&client->dev, sizeof(*tsdata), GFP_KERNEL);
-	if (!tsdata) {
-		dev_err(&client->dev, "failed to allocate driver data.\n");
-		return -ENOMEM;
-	}
-
 	input =3D devm_input_allocate_device(&client->dev);
 	if (!input) {
 		dev_err(&client->dev, "failed to allocate input device.\n");
@@ -754,7 +820,11 @@ static int edt_ft5x06_ts_probe(struct i2c_client *=
client,
 		return error;
 	}
=20
-	edt_ft5x06_ts_get_defaults(tsdata, pdata);
+	if (!pdata)
+		edt_ft5x06_ts_get_dt_defaults(client->dev.of_node, tsdata);
+	else
+		edt_ft5x06_ts_get_defaults(tsdata, pdata);
+
 	edt_ft5x06_ts_get_parameters(tsdata);
=20
 	dev_dbg(&client->dev,
@@ -784,10 +854,10 @@ static int edt_ft5x06_ts_probe(struct i2c_client =
*client,
 	input_set_drvdata(input, tsdata);
 	i2c_set_clientdata(client, tsdata);
=20
-	error =3D devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, edt_ft5x06_ts_isr,
-					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					  client->name, tsdata);
+	error =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					edt_ft5x06_ts_isr,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					client->name, tsdata);
 	if (error) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
 		return error;
@@ -798,19 +868,21 @@ static int edt_ft5x06_ts_probe(struct i2c_client =
*client,
 		return error;
=20
 	error =3D input_register_device(input);
-	if (error) {
-		sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
-		return error;
-	}
+	if (error)
+		goto err_remove_attrs;
=20
 	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev)=
);
 	device_init_wakeup(&client->dev, 1);
=20
 	dev_dbg(&client->dev,
-		"EDT FT5x06 initialized: IRQ pin %d, Reset pin %d.\n",
-		pdata->irq_pin, pdata->reset_pin);
+		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
+		client->irq, tsdata->wake_pin, tsdata->reset_pin);
=20
 	return 0;
+
+err_remove_attrs:
+	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
+	return error;
 }
=20
 static int edt_ft5x06_ts_remove(struct i2c_client *client)
@@ -854,10 +926,19 @@ static const struct i2c_device_id edt_ft5x06_ts_i=
d[] =3D {
 };
 MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
=20
+static const struct of_device_id edt_ft5x06_of_match[] =3D {
+	{ .compatible =3D "edt,edt-ft5206", },
+	{ .compatible =3D "edt,edt-ft5306", },
+	{ .compatible =3D "edt,edt-ft5406", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, edt_ft5x06_of_match);
+
 static struct i2c_driver edt_ft5x06_ts_driver =3D {
 	.driver =3D {
 		.owner =3D THIS_MODULE,
 		.name =3D "edt_ft5x06",
+		.of_match_table =3D edt_ft5x06_of_match,
 		.pm =3D &edt_ft5x06_ts_pm_ops,
 	},
 	.id_table =3D edt_ft5x06_ts_id,
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
