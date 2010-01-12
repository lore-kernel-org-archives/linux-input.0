From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH v2] Input: ad7879: support auxiliary GPIOs via gpiolib
Date: Tue, 12 Jan 2010 16:04:57 -0500
Message-ID: <1263330297-1387-1-git-send-email-vapier@gentoo.org>
References: <20100107073114.GC2314@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:56791 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926Ab0ALVE7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2010 16:04:59 -0500
In-Reply-To: <20100107073114.GC2314@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Drop the simple fancy sysfs hooks for the aux GPIOs and expose these via
the gpiolib interface so that other drivers can use them.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
v2
	- call gpiochip_remove as pointed out by Dmitry

 drivers/input/touchscreen/ad7879.c |  158 +++++++++++++++++++++++-------------
 include/linux/spi/ad7879.h         |   12 ++-
 2 files changed, 111 insertions(+), 59 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index c21e6d3..d319d2c 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -47,6 +47,7 @@
 #include <linux/workqueue.h>
 #include <linux/spi/spi.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>
 
 #include <linux/spi/ad7879.h>
 
@@ -132,7 +133,9 @@ struct ad7879 {
 	struct input_dev	*input;
 	struct work_struct	work;
 	struct timer_list	timer;
-
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip 	gc;
+#endif
 	struct mutex		mutex;
 	unsigned		disabled:1;	/* P: mutex */
 
@@ -150,11 +153,9 @@ struct ad7879 {
 	u8			median;
 	u16			x_plate_ohms;
 	u16			pressure_max;
-	u16			gpio_init;
 	u16			cmd_crtl1;
 	u16			cmd_crtl2;
 	u16			cmd_crtl3;
-	unsigned		gpio:1;
 };
 
 static int ad7879_read(bus_device *, u8);
@@ -237,24 +238,6 @@ static irqreturn_t ad7879_irq(int irq, void *handle)
 
 static void ad7879_setup(struct ad7879 *ts)
 {
-	ts->cmd_crtl3 = AD7879_YPLUS_BIT |
-			AD7879_XPLUS_BIT |
-			AD7879_Z2_BIT |
-			AD7879_Z1_BIT |
-			AD7879_TEMPMASK_BIT |
-			AD7879_AUXVBATMASK_BIT |
-			AD7879_GPIOALERTMASK_BIT;
-
-	ts->cmd_crtl2 = AD7879_PM(AD7879_PM_DYN) | AD7879_DFR |
-			AD7879_AVG(ts->averaging) |
-			AD7879_MFS(ts->median) |
-			AD7879_FCD(ts->first_conversion_delay) |
-			ts->gpio_init;
-
-	ts->cmd_crtl1 = AD7879_MODE_INT | AD7879_MODE_SEQ1 |
-			AD7879_ACQ(ts->acquisition_time) |
-			AD7879_TMR(ts->pen_down_acc_interval);
-
 	ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
 	ad7879_write(ts->bus, AD7879_REG_CTRL3, ts->cmd_crtl3);
 	ad7879_write(ts->bus, AD7879_REG_CTRL1, ts->cmd_crtl1);
@@ -324,48 +307,74 @@ static ssize_t ad7879_disable_store(struct device *dev,
 
 static DEVICE_ATTR(disable, 0664, ad7879_disable_show, ad7879_disable_store);
 
-static ssize_t ad7879_gpio_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
+static struct attribute *ad7879_attributes[] = {
+	&dev_attr_disable.attr,
+	NULL
+};
+
+static const struct attribute_group ad7879_attr_group = {
+	.attrs = ad7879_attributes,
+};
+
+#ifdef CONFIG_GPIOLIB
+int ad7879_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
-	struct ad7879 *ts = dev_get_drvdata(dev);
+	struct ad7879 *ts = container_of(chip, struct ad7879, gc);
+	int err;
+
+	mutex_lock(&ts->mutex);
+	ts->cmd_crtl2 |= AD7879_GPIO_EN | AD7879_GPIODIR | AD7879_GPIOPOL;
+	err = ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
+	mutex_unlock(&ts->mutex);
 
-	return sprintf(buf, "%u\n", ts->gpio);
+	return err;
 }
 
-static ssize_t ad7879_gpio_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
+int ad7879_gpio_direction_output(struct gpio_chip *chip, unsigned gpio, int level)
 {
-	struct ad7879 *ts = dev_get_drvdata(dev);
-	unsigned long val;
-	int error;
+	struct ad7879 *ts = container_of(chip, struct ad7879, gc);
+	int err;
 
-	error = strict_strtoul(buf, 10, &val);
-	if (error)
-		return error;
+	mutex_lock(&ts->mutex);
+	ts->cmd_crtl2 &= ~AD7879_GPIODIR;
+	ts->cmd_crtl2 |= AD7879_GPIO_EN | AD7879_GPIOPOL;
+	if (level)
+		ts->cmd_crtl2 |= AD7879_GPIO_DATA;
+	else
+		ts->cmd_crtl2 &= ~AD7879_GPIO_DATA;
+
+	err = ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
+	mutex_unlock(&ts->mutex);
+
+	return err;
+}
+
+int ad7879_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
+{
+	struct ad7879 *ts = container_of(chip, struct ad7879, gc);
+	u16 val;
 
 	mutex_lock(&ts->mutex);
-	ts->gpio = !!val;
-	error = ad7879_write(ts->bus, AD7879_REG_CTRL2,
-			   ts->gpio ?
-				ts->cmd_crtl2 & ~AD7879_GPIO_DATA :
-				ts->cmd_crtl2 | AD7879_GPIO_DATA);
+	val = ad7879_read(ts->bus, AD7879_REG_CTRL2);
 	mutex_unlock(&ts->mutex);
 
-	return error ? : count;
+	return !!(val & AD7879_GPIO_DATA);
 }
 
-static DEVICE_ATTR(gpio, 0664, ad7879_gpio_show, ad7879_gpio_store);
+void ad7879_gpio_set_value(struct gpio_chip *chip, unsigned gpio, int value)
+{
+	struct ad7879 *ts = container_of(chip, struct ad7879, gc);
 
-static struct attribute *ad7879_attributes[] = {
-	&dev_attr_disable.attr,
-	&dev_attr_gpio.attr,
-	NULL
-};
+	mutex_lock(&ts->mutex);
+	if (value)
+		ts->cmd_crtl2 |= AD7879_GPIO_DATA;
+	else
+		ts->cmd_crtl2 &= ~AD7879_GPIO_DATA;
 
-static const struct attribute_group ad7879_attr_group = {
-	.attrs = ad7879_attributes,
-};
+	ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
+	mutex_unlock(&ts->mutex);
+}
+#endif
 
 static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 {
@@ -403,12 +412,6 @@ static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 	ts->pen_down_acc_interval = pdata->pen_down_acc_interval;
 	ts->median = pdata->median;
 
-	if (pdata->gpio_output)
-		ts->gpio_init = AD7879_GPIO_EN |
-				(pdata->gpio_default ? 0 : AD7879_GPIO_DATA);
-	else
-		ts->gpio_init = AD7879_GPIO_EN | AD7879_GPIODIR;
-
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&bus->dev));
 
 	input_dev->name = "AD7879 Touchscreen";
@@ -446,6 +449,23 @@ static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 		goto err_free_mem;
 	}
 
+	ts->cmd_crtl3 = AD7879_YPLUS_BIT |
+			AD7879_XPLUS_BIT |
+			AD7879_Z2_BIT |
+			AD7879_Z1_BIT |
+			AD7879_TEMPMASK_BIT |
+			AD7879_AUXVBATMASK_BIT |
+			AD7879_GPIOALERTMASK_BIT;
+
+	ts->cmd_crtl2 = AD7879_PM(AD7879_PM_DYN) | AD7879_DFR |
+			AD7879_AVG(ts->averaging) |
+			AD7879_MFS(ts->median) |
+			AD7879_FCD(ts->first_conversion_delay);
+
+	ts->cmd_crtl1 = AD7879_MODE_INT | AD7879_MODE_SEQ1 |
+			AD7879_ACQ(ts->acquisition_time) |
+			AD7879_TMR(ts->pen_down_acc_interval);
+
 	ad7879_setup(ts);
 
 	err = request_irq(bus->irq, ad7879_irq,
@@ -467,6 +487,25 @@ static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 	dev_info(&bus->dev, "Rev.%d touchscreen, irq %d\n",
 		 revid >> 8, bus->irq);
 
+#ifdef CONFIG_GPIOLIB
+	if (pdata->gpio_export) {
+		ts->gc.direction_input = ad7879_gpio_direction_input;
+		ts->gc.direction_output = ad7879_gpio_direction_output;
+		ts->gc.get = ad7879_gpio_get_value;
+		ts->gc.set = ad7879_gpio_set_value;
+		ts->gc.can_sleep = 1;
+		ts->gc.base = pdata->gpio_base;
+		ts->gc.ngpio = 1;
+		ts->gc.label = "AD7879-GPIO";
+		ts->gc.owner = THIS_MODULE;
+
+		err = gpiochip_add(&ts->gc);
+		if (err)
+			dev_err(&bus->dev, "failed to register gpio %d\n",
+				ts->gc.base);
+	}
+#endif
+
 	return 0;
 
 err_remove_attr:
@@ -481,6 +520,15 @@ err_free_mem:
 
 static int __devexit ad7879_destroy(bus_device *bus, struct ad7879 *ts)
 {
+#ifdef CONFIG_GPIOLIB
+	struct ad7879_platform_data *pdata = bus->dev.platform_data;
+	if (pdata->gpio_export) {
+		if (gpiochip_remove(&ts->gc))
+			dev_err(&bus->dev, "failed to remove gpio %d\n",
+				ts->gc.base);
+	}
+#endif
+
 	ad7879_disable(ts);
 	sysfs_remove_group(&ts->bus->dev.kobj, &ad7879_attr_group);
 	free_irq(ts->bus->irq, ts);
diff --git a/include/linux/spi/ad7879.h b/include/linux/spi/ad7879.h
index 4231104..7231eab 100644
--- a/include/linux/spi/ad7879.h
+++ b/include/linux/spi/ad7879.h
@@ -28,8 +28,12 @@ struct ad7879_platform_data {
 	 * 1 = 4, 2 = 8, 3 = 16 (median > averaging)
 	 */
 	u8	median;
-	/* 1 = AUX/VBAT/GPIO set to GPIO Output */
-	u8	gpio_output;
-	/* Initial GPIO pin state (valid if gpio_output = 1) */
-	u8	gpio_default;
+	/* 1 = AUX/VBAT/GPIO export GPIO to gpiolib
+	 * requires CONFIG_GPIOLIB
+	 */
+	u8	gpio_export;
+	/* identifies the first GPIO number handled by this chip;
+	 * or, if negative, requests dynamic ID allocation.
+	 */
+	s32	gpio_base;
 };
-- 
1.6.6

