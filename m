From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 3/3] input: touchscreen: ad7879: add device tree support
Date: Tue,  2 Feb 2016 15:20:18 -0800
Message-ID: <1454455218-13004-3-git-send-email-stefan@agner.ch>
References: <1454455218-13004-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454455218-13004-1-git-send-email-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-input@vger.kernel.org

Add device tree support for the I2C and SPI variant of AD7879(-1).
This allows to specify the touchscreen controller as a I2C client
node or SPI slave device. Most of the options available in platform
data are also available as device tree properties, the only exception
being GPIO capabilities, which can not be activated through device
tree currently.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes since v2:
- do not free driver data and irq on remove (since we are using devm now)
Changes since v1:
- Move device tree parsing to main driver file ad7879.c
- Use common touchscreen_parse_properties for common properties
- Use device_property_* API
- Use struct ad7879 directly to store parsed values
- Support SPI variant through device tree too (untested)
- Add vendor prefix to vendor specific dt properties

 .../bindings/input/touchscreen/ad7879.txt          |  53 ++++++++
 drivers/input/touchscreen/ad7879-i2c.c             |  10 ++
 drivers/input/touchscreen/ad7879-spi.c             |  10 ++
 drivers/input/touchscreen/ad7879.c                 | 145 +++++++++++++--------
 4 files changed, 161 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ad7879.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt b/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
new file mode 100644
index 0000000..e3f22d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
@@ -0,0 +1,53 @@
+* Analog Devices AD7879(-1)/AD7889(-1) touchscreen interface (SPI/I2C)
+
+Required properties:
+- compatible			: for SPI slave, use "adi,ad7879"
+				  for I2C slave, use "adi,ad7879-1"
+- reg				: SPI chipselect/I2C slave address
+				  See spi-bus.txt for more SPI slave properties
+- interrupt-parent		: the phandle for the interrupt controller
+- interrupts			: touch controller interrupt
+- touchscreen-max-pressure	: maximum reported pressure
+- adi,resistance-plate-x	: total resistance of X-plate (for pressure
+				  calculation)
+Optional properties:
+- touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
+- adi,first-conversion-delay	: 0-12: In 128us steps (starting with 128us)
+				  13  : 2.560ms
+				  14  : 3.584ms
+				  15  : 4.096ms
+				  This property has to be a '/bits/ 8' value
+- adi,acquisition-time		: 0: 2us
+				  1: 4us
+				  2: 8us
+				  3: 16us
+				  This property has to be a '/bits/ 8' value
+- adi,median-filter-size	: 0: disabled
+				  1: 4 measurements
+				  2: 8 measurements
+				  3: 16 measurements
+				  This property has to be a '/bits/ 8' value
+- adi,averaging			: 0: 2 middle values (1 if median disabled)
+				  1: 4 middle values
+				  2: 8 middle values
+				  3: 16 values
+				  This property has to be a '/bits/ 8' value
+- adi,conversion-interval:	: 0    : convert one time only
+				  1-255: 515us + val * 35us (up to 9.440ms)
+				  This property has to be a '/bits/ 8' value
+
+Example:
+
+	ad7879@2c {
+		compatible = "adi,ad7879-1";
+		reg = <0x2c>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-max-pressure = <4096>;
+		adi,resistance-plate-x = <120>;
+		adi,first-conversion-delay = /bits/ 8 <3>;
+		adi,acquisition-time = /bits/ 8 <1>;
+		adi,median-filter-size = /bits/ 8 <2>;
+		adi,averaging = /bits/ 8 <1>;
+		adi,conversion-interval = /bits/ 8 <255>;
+	};
diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index d66962c..58f72e0 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 
 #include "ad7879.h"
@@ -91,10 +92,19 @@ static const struct i2c_device_id ad7879_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad7879_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ad7879_i2c_dt_ids[] = {
+	{ .compatible = "adi,ad7879-1", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7879_i2c_dt_ids);
+#endif
+
 static struct i2c_driver ad7879_i2c_driver = {
 	.driver = {
 		.name	= "ad7879",
 		.pm	= &ad7879_pm_ops,
+		.of_match_table = of_match_ptr(ad7879_i2c_dt_ids),
 	},
 	.probe		= ad7879_i2c_probe,
 	.remove		= ad7879_i2c_remove,
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 48033c2..d42b6b9 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -10,6 +10,7 @@
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include "ad7879.h"
 
@@ -146,10 +147,19 @@ static int ad7879_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ad7879_spi_dt_ids[] = {
+	{ .compatible = "adi,ad7879", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7879_spi_dt_ids);
+#endif
+
 static struct spi_driver ad7879_spi_driver = {
 	.driver = {
 		.name	= "ad7879",
 		.pm	= &ad7879_pm_ops,
+		.of_match_table = of_match_ptr(ad7879_spi_dt_ids),
 	},
 	.probe		= ad7879_spi_probe,
 	.remove		= ad7879_spi_remove,
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index abd0220..093cb04 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -31,6 +31,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 
+#include <linux/input/touchscreen.h>
 #include <linux/platform_data/ad7879.h>
 #include <linux/module.h>
 #include "ad7879.h"
@@ -126,7 +127,6 @@ struct ad7879 {
 	u8			pen_down_acc_interval;
 	u8			median;
 	u16			x_plate_ohms;
-	u16			pressure_max;
 	u16			cmd_crtl1;
 	u16			cmd_crtl2;
 	u16			cmd_crtl3;
@@ -186,7 +186,7 @@ static int ad7879_report(struct ad7879 *ts)
 		 * Sample found inconsistent, pressure is beyond
 		 * the maximum. Don't report it to user space.
 		 */
-		if (Rt > ts->pressure_max)
+		if (Rt > input_abs_get_max(input_dev, ABS_PRESSURE))
 			return -EINVAL;
 
 		/*
@@ -469,7 +469,7 @@ static void ad7879_gpio_remove(struct ad7879 *ts)
 {
 	const struct ad7879_platform_data *pdata = dev_get_platdata(ts->dev);
 
-	if (pdata->gpio_export)
+	if (pdata && pdata->gpio_export)
 		gpiochip_remove(&ts->gc);
 
 }
@@ -485,6 +485,29 @@ static inline void ad7879_gpio_remove(struct ad7879 *ts)
 }
 #endif
 
+static int ad7879_parse_dt(struct device *dev, struct ad7879 *ts)
+{
+	int err;
+	u32 tmp;
+
+	err = device_property_read_u32(dev, "adi,resistance-plate-x", &tmp);
+	if (err) {
+		dev_err(dev, "failed to get resistance-plate-x property\n");
+		return err;
+	}
+	ts->x_plate_ohms = (u16)tmp;
+
+	device_property_read_u8(dev, "adi,first-conversion-delay", &ts->first_conversion_delay);
+	device_property_read_u8(dev, "adi,acquisition-time", &ts->acquisition_time);
+	device_property_read_u8(dev, "adi,median-filter-size", &ts->median);
+	device_property_read_u8(dev, "adi,averaging", &ts->averaging);
+	device_property_read_u8(dev, "adi,conversion-interval", &ts->pen_down_acc_interval);
+
+	ts->swap_xy = device_property_read_bool(dev, "touchscreen-swapped-x-y");
+
+	return 0;
+}
+
 struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 			    const struct ad7879_bus_ops *bops)
 {
@@ -495,22 +518,37 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	u16 revid;
 
 	if (!irq) {
-		dev_err(dev, "no IRQ?\n");
-		err = -EINVAL;
-		goto err_out;
+		dev_err(dev, "No IRQ specified\n");
+		return ERR_PTR(-EINVAL);
 	}
 
-	if (!pdata) {
-		dev_err(dev, "no platform data?\n");
-		err = -EINVAL;
-		goto err_out;
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return ERR_PTR(-ENOMEM);
+
+	if (pdata) {
+		/* Platform data use swapped axis (backward compatibility) */
+		ts->swap_xy = !pdata->swap_xy;
+
+		ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
+
+		ts->first_conversion_delay = pdata->first_conversion_delay;
+		ts->acquisition_time = pdata->acquisition_time;
+		ts->averaging = pdata->averaging;
+		ts->pen_down_acc_interval = pdata->pen_down_acc_interval;
+		ts->median = pdata->median;
+
+	} else if (dev->of_node) {
+		ad7879_parse_dt(dev, ts);
+	} else {
+		dev_err(dev, "No platform data\n");
+		return ERR_PTR(-EINVAL);
 	}
 
-	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!ts || !input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
+	input_dev = devm_input_allocate_device(dev);
+	if (!input_dev) {
+		dev_err(dev, "Failed to allocate input device\n");
+		return ERR_PTR(-ENOMEM);
 	}
 
 	ts->bops = bops;
@@ -518,20 +556,7 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	ts->input = input_dev;
 	ts->irq = irq;
 
-	/* Use swapped axis by default (backward compatibility) */
-	ts->swap_xy = !pdata->swap_xy;
-
 	setup_timer(&ts->timer, ad7879_timer, (unsigned long) ts);
-
-	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
-	ts->pressure_max = pdata->pressure_max ? : ~0;
-
-	ts->first_conversion_delay = pdata->first_conversion_delay;
-	ts->acquisition_time = pdata->acquisition_time;
-	ts->averaging = pdata->averaging;
-	ts->pen_down_acc_interval = pdata->pen_down_acc_interval;
-	ts->median = pdata->median;
-
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
 
 	input_dev->name = "AD7879 Touchscreen";
@@ -552,21 +577,33 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 
-	input_set_abs_params(input_dev, ABS_X,
-			pdata->x_min ? : 0,
-			pdata->x_max ? : MAX_12BIT,
-			0, 0);
-	input_set_abs_params(input_dev, ABS_Y,
-			pdata->y_min ? : 0,
-			pdata->y_max ? : MAX_12BIT,
-			0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			pdata->pressure_min, pdata->pressure_max, 0, 0);
+	if (pdata) {
+		input_set_abs_params(input_dev, ABS_X,
+				pdata->x_min ? : 0,
+				pdata->x_max ? : MAX_12BIT,
+				0, 0);
+		input_set_abs_params(input_dev, ABS_Y,
+				pdata->y_min ? : 0,
+				pdata->y_max ? : MAX_12BIT,
+				0, 0);
+		input_set_abs_params(input_dev, ABS_PRESSURE,
+				pdata->pressure_min,
+				pdata->pressure_max ? : ~0,
+				0, 0);
+	} else {
+		input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
+		input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
+		touchscreen_parse_properties(input_dev, false);
+		if (!input_abs_get_max(input_dev, ABS_PRESSURE)) {
+			dev_err(dev, "Touchscreen pressure is not specified\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
 
 	err = ad7879_write(ts, AD7879_REG_CTRL2, AD7879_RESET);
 	if (err < 0) {
 		dev_err(dev, "Failed to write %s\n", input_dev->name);
-		goto err_free_mem;
+		return ERR_PTR(err);
 	}
 
 	revid = ad7879_read(ts, AD7879_REG_REVID);
@@ -575,8 +612,7 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	if (input_dev->id.product != devid) {
 		dev_err(dev, "Failed to probe %s (%x vs %x)\n",
 			input_dev->name, devid, revid);
-		err = -ENODEV;
-		goto err_free_mem;
+		return ERR_PTR(-ENODEV);
 	}
 
 	ts->cmd_crtl3 = AD7879_YPLUS_BIT |
@@ -596,23 +632,25 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 			AD7879_ACQ(ts->acquisition_time) |
 			AD7879_TMR(ts->pen_down_acc_interval);
 
-	err = request_threaded_irq(ts->irq, NULL, ad7879_irq,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   dev_name(dev), ts);
+	err = devm_request_threaded_irq(dev, ts->irq, NULL, ad7879_irq,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					dev_name(dev), ts);
 	if (err) {
-		dev_err(dev, "irq %d busy?\n", ts->irq);
-		goto err_free_mem;
+		dev_err(dev, "Failed to request IRQ: %d\n", err);
+		return ERR_PTR(err);
 	}
 
 	__ad7879_disable(ts);
 
 	err = sysfs_create_group(&dev->kobj, &ad7879_attr_group);
 	if (err)
-		goto err_free_irq;
+		goto err_out;
 
-	err = ad7879_gpio_add(ts, pdata);
-	if (err)
-		goto err_remove_attr;
+	if (pdata) {
+		err = ad7879_gpio_add(ts, pdata);
+		if (err)
+			goto err_remove_attr;
+	}
 
 	err = input_register_device(input_dev);
 	if (err)
@@ -624,11 +662,6 @@ err_remove_gpio:
 	ad7879_gpio_remove(ts);
 err_remove_attr:
 	sysfs_remove_group(&dev->kobj, &ad7879_attr_group);
-err_free_irq:
-	free_irq(ts->irq, ts);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(ts);
 err_out:
 	return ERR_PTR(err);
 }
@@ -638,9 +671,7 @@ void ad7879_remove(struct ad7879 *ts)
 {
 	ad7879_gpio_remove(ts);
 	sysfs_remove_group(&ts->dev->kobj, &ad7879_attr_group);
-	free_irq(ts->irq, ts);
 	input_unregister_device(ts->input);
-	kfree(ts);
 }
 EXPORT_SYMBOL(ad7879_remove);
 
-- 
2.7.0
