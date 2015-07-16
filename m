From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v2 3/4] touchscreen: colibri-vf50-ts: Add touchscreen support for Colibri VF50
Date: Thu, 16 Jul 2015 20:43:21 +0530
Message-ID: <26748bd9a7bde7c2304b6b971f1150bb575e4938.1437058481.git.maitysanchayan@gmail.com>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437058481.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1437058481.git.maitysanchayan@gmail.com>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.org, kernel@pengutronix.de, stefan@agner.ch, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sanchayan Maity <maitysanchayan@gmail.com>
List-Id: linux-input@vger.kernel.org

The Colibri Vybrid VF50 module supports 4-wire touchscreens using
FETs and ADC inputs. This driver uses the IIO consumer interface
and relies on the vf610_adc driver based on the IIO framework.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/input/touchscreen/Kconfig           |  12 +
 drivers/input/touchscreen/Makefile          |   1 +
 drivers/input/touchscreen/colibri-vf50-ts.c | 451 ++++++++++++++++++++++++++++
 3 files changed, 464 insertions(+)
 create mode 100644 drivers/input/touchscreen/colibri-vf50-ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 80f6386..28948ca 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1027,4 +1027,16 @@ config TOUCHSCREEN_ZFORCE
 	  To compile this driver as a module, choose M here: the
 	  module will be called zforce_ts.
 
+config TOUCHSCREEN_COLIBRI_VF50
+	tristate "Toradex Colibri on board touchscreen driver"
+	depends on GPIOLIB && IIO && VF610_ADC
+	help
+	  Say Y here if you have a Colibri VF50 and plan to use
+	  the on-board provided 4-wire touchscreen driver.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called colibri_vf50_ts.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 44deea7..93746a0 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_SX8654)	+= sx8654.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
+obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/input/touchscreen/colibri-vf50-ts.c
new file mode 100644
index 0000000..eb16bdc
--- /dev/null
+++ b/drivers/input/touchscreen/colibri-vf50-ts.c
@@ -0,0 +1,451 @@
+/* Copyright 2015 Toradex AG
+ *
+ * Toradex Colibri VF50 Touchscreen driver
+ *
+ * Originally authored by Stefan Agner for 3.0 kernel
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/types.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define DRIVER_NAME "colibri-vf50-ts"
+#define DRV_VERSION "1.0"
+
+#define VF_ADC_MAX ((1 << 12) - 1)
+
+#define COLI_TOUCH_MIN_DELAY_US 1000
+#define COLI_TOUCH_MAX_DELAY_US 2000
+
+static int min_pressure = 200;
+
+struct vf50_touch_device {
+	struct platform_device	*pdev;
+	struct input_dev	*ts_input;
+	struct workqueue_struct *ts_workqueue;
+	struct work_struct	ts_work;
+	struct iio_channel	*channels;
+	struct gpio_desc *gpio_xp;
+	struct gpio_desc *gpio_xm;
+	struct gpio_desc *gpio_yp;
+	struct gpio_desc *gpio_ym;
+	struct gpio_desc *gpio_pen_detect;
+	struct gpio_desc *gpio_pen_detect_pullup;
+	int pen_irq;
+	bool stop_touchscreen;
+};
+
+/*
+ * Enables given plates and measures touch parameters using ADC
+ */
+static int adc_ts_measure(struct iio_channel *channel,
+		  struct gpio_desc *plate_p, struct gpio_desc *plate_m)
+{
+	int i, value = 0, val = 0;
+	int ret;
+
+	gpiod_set_value(plate_p, 1);
+	gpiod_set_value(plate_m, 1);
+
+	usleep_range(COLI_TOUCH_MIN_DELAY_US, COLI_TOUCH_MAX_DELAY_US);
+
+	for (i = 0; i < 5; i++) {
+		ret = iio_read_channel_raw(channel, &val);
+		if (ret < 0)
+			return -EINVAL;
+
+		value += val;
+	}
+
+	value /= 5;
+
+	gpiod_set_value(plate_p, 0);
+	gpiod_set_value(plate_m, 0);
+
+	return value;
+}
+
+/*
+ * Enable touch detection using falling edge detection on XM
+ */
+static void vf50_ts_enable_touch_detection(struct vf50_touch_device *vf50_ts)
+{
+	/* Enable plate YM (needs to be strong GND, high active) */
+	gpiod_set_value(vf50_ts->gpio_ym, 1);
+
+	/*
+	 * Let the platform mux to idle state in order to enable
+	 * Pull-Up on GPIO
+	 */
+	pinctrl_pm_select_idle_state(&vf50_ts->pdev->dev);
+}
+
+/*
+ * ADC touch screen sampling worker function
+ */
+static void vf50_ts_work(struct work_struct *ts_work)
+{
+	struct vf50_touch_device *vf50_ts = container_of(ts_work,
+				struct vf50_touch_device, ts_work);
+	struct device *dev = &vf50_ts->pdev->dev;
+	int val_x, val_y, val_z1, val_z2, val_p = 0;
+	bool discard_val_on_start = true;
+
+	while (!vf50_ts->stop_touchscreen) {
+		/* X-Direction */
+		val_x = adc_ts_measure(&vf50_ts->channels[0],
+				vf50_ts->gpio_xp, vf50_ts->gpio_xm);
+		if (val_x < 0)
+			continue;
+
+		/* Y-Direction */
+		val_y = adc_ts_measure(&vf50_ts->channels[1],
+				vf50_ts->gpio_yp, vf50_ts->gpio_ym);
+		if (val_y < 0)
+			continue;
+
+		/*
+		 * Touch pressure
+		 * Measure on XP/YM
+		 */
+		val_z1 = adc_ts_measure(&vf50_ts->channels[2],
+				vf50_ts->gpio_yp, vf50_ts->gpio_xm);
+		if (val_z1 < 0)
+			continue;
+		val_z2 = adc_ts_measure(&vf50_ts->channels[3],
+				vf50_ts->gpio_yp, vf50_ts->gpio_xm);
+		if (val_z2 < 0)
+			continue;
+
+		/* Validate signal (avoid calculation using noise) */
+		if (val_z1 > 64 && val_x > 64) {
+			/*
+			 * Calculate resistance between the plates
+			 * lower resistance means higher pressure
+			 */
+			int r_x = (1000 * val_x) / VF_ADC_MAX;
+
+			val_p = (r_x * val_z2) / val_z1 - r_x;
+
+		} else {
+			val_p = 2000;
+		}
+
+		val_p = 2000 - val_p;
+		dev_dbg(dev, "Measured values: x: %d, y: %d, z1: %d, z2: %d, "
+			"p: %d\n", val_x, val_y, val_z1, val_z2, val_p);
+
+		/*
+		 * If touch pressure is too low, stop measuring and reenable
+		 * touch detection
+		 */
+		if (val_p < min_pressure || val_p > 2000)
+			break;
+
+		/*
+		 * The pressure may not be enough for the first x and the
+		 * second y measurement, but, the pressure is ok when the
+		 * driver is doing the third and fourth measurement. To
+		 * take care of this, we drop the first measurement always.
+		 */
+		if (discard_val_on_start) {
+			discard_val_on_start = false;
+		} else {
+			/*
+			 * Report touch position and sleep for
+			 * next measurement
+			 */
+			input_report_abs(vf50_ts->ts_input,
+					ABS_X, VF_ADC_MAX - val_x);
+			input_report_abs(vf50_ts->ts_input,
+					ABS_Y, VF_ADC_MAX - val_y);
+			input_report_abs(vf50_ts->ts_input,
+					ABS_PRESSURE, val_p);
+			input_report_key(vf50_ts->ts_input, BTN_TOUCH, 1);
+			input_sync(vf50_ts->ts_input);
+		}
+
+		msleep(10);
+	}
+
+	/* Report no more touch, reenable touch detection */
+	input_report_abs(vf50_ts->ts_input, ABS_PRESSURE, 0);
+	input_report_key(vf50_ts->ts_input, BTN_TOUCH, 0);
+	input_sync(vf50_ts->ts_input);
+
+	vf50_ts_enable_touch_detection(vf50_ts);
+
+	/* Wait for the pull-up to be stable on high */
+	msleep(10);
+
+	/* Reenable IRQ to detect touch */
+	enable_irq(vf50_ts->pen_irq);
+
+	dev_dbg(dev, "Reenabled touch detection interrupt\n");
+}
+
+static irqreturn_t vf50_ts_touched(int irq, void *dev_id)
+{
+	struct vf50_touch_device *vf50_ts = (struct vf50_touch_device *)dev_id;
+	struct device *dev = &vf50_ts->pdev->dev;
+
+	dev_dbg(dev, "Touch detected, start worker thread\n");
+
+	disable_irq_nosync(irq);
+
+	/* Disable the touch detection plates */
+	gpiod_set_value(vf50_ts->gpio_ym, 0);
+
+	/* Let the platform mux to default state in order to mux as ADC */
+	pinctrl_pm_select_default_state(dev);
+
+	queue_work(vf50_ts->ts_workqueue, &vf50_ts->ts_work);
+
+	return IRQ_HANDLED;
+}
+
+static int vf50_ts_open(struct input_dev *dev_input)
+{
+	int ret;
+	struct vf50_touch_device *touchdev = input_get_drvdata(dev_input);
+	struct device *dev = &touchdev->pdev->dev;
+
+	dev_dbg(dev, "Input device %s opened, starting touch detection\n",
+			dev_input->name);
+
+	touchdev->stop_touchscreen = false;
+
+	ret = gpiod_direction_output(touchdev->gpio_xp, 0);
+	if (ret) {
+		dev_err(dev, "Could not set gpio xp as output %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiod_direction_output(touchdev->gpio_xm, 0);
+	if (ret) {
+		dev_err(dev, "Could not set gpio xm as output %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiod_direction_output(touchdev->gpio_yp, 0);
+	if (ret) {
+		dev_err(dev, "Could not set gpio yp as output %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiod_direction_output(touchdev->gpio_ym, 0);
+	if (ret) {
+		dev_err(dev, "Could not set gpio ym as output %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiod_direction_input(touchdev->gpio_pen_detect);
+	if (ret) {
+		dev_err(dev,
+			"Could not set gpio pen detect as input %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiod_direction_input(touchdev->gpio_pen_detect_pullup);
+	if (ret) {
+		dev_err(dev,
+			"Could not set pen detect pullup as input %d\n", ret);
+		return ret;
+	}
+
+	/* Mux detection before request IRQ, wait for pull-up to settle */
+	vf50_ts_enable_touch_detection(touchdev);
+	msleep(10);
+
+	touchdev->pen_irq = gpiod_to_irq(touchdev->gpio_pen_detect);
+	if (touchdev->pen_irq < 0) {
+		dev_err(dev, "Unable to get IRQ for GPIO\n");
+		return touchdev->pen_irq;
+	}
+
+	ret = request_irq(touchdev->pen_irq, vf50_ts_touched,
+			IRQF_TRIGGER_FALLING, "touch detected", touchdev);
+	if (ret < 0) {
+		dev_err(dev, "Unable to request IRQ %d\n", touchdev->pen_irq);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vf50_ts_close(struct input_dev *dev_input)
+{
+	struct vf50_touch_device *touchdev = input_get_drvdata(dev_input);
+	struct device *dev = &touchdev->pdev->dev;
+
+	free_irq(touchdev->pen_irq, touchdev);
+
+	touchdev->stop_touchscreen = true;
+
+	/* Wait until touchscreen thread finishes any possible remnants. */
+	cancel_work_sync(&touchdev->ts_work);
+
+	dev_dbg(dev, "Input device %s closed, disable touch detection\n",
+		dev_input->name);
+}
+
+static inline int vf50_ts_get_gpiod(struct device *dev,
+			struct gpio_desc **gpio_d, const char *con_id)
+{
+	int ret;
+
+	*gpio_d = devm_gpiod_get(dev, con_id);
+	if (IS_ERR(*gpio_d)) {
+		ret = PTR_ERR(*gpio_d);
+		dev_err(dev, "Could not get gpio_%s %d\n", con_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int vf50_ts_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct vf50_touch_device *touchdev;
+	struct input_dev *input;
+	int ret = 0;
+
+	if (!node) {
+		dev_err(dev, "Device does not have associated DT data\n");
+		return -EINVAL;
+	}
+
+	touchdev = devm_kzalloc(dev, sizeof(*touchdev), GFP_KERNEL);
+	if (touchdev == NULL)
+		return -ENOMEM;
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(dev, "Failed to allocate TS input device\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, touchdev);
+
+	touchdev->pdev = pdev;
+
+	input->name = DRIVER_NAME;
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = dev;
+	input->open = vf50_ts_open;
+	input->close = vf50_ts_close;
+
+	_set_bit(EV_ABS, input->evbit);
+	_set_bit(EV_KEY, input->evbit);
+	_set_bit(BTN_TOUCH, input->keybit);
+	input_set_abs_params(input, ABS_X, 0, VF_ADC_MAX, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, VF_ADC_MAX, 0, 0);
+	input_set_abs_params(input, ABS_PRESSURE, 0, VF_ADC_MAX, 0, 0);
+
+	touchdev->ts_input = input;
+	input_set_drvdata(input, touchdev);
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(dev, "Failed to register input device\n");
+		return ret;
+	}
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_xp, "xp");
+	if (ret)
+		return ret;
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_xm, "xm");
+	if (ret)
+		return ret;
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_yp, "yp");
+	if (ret)
+		return ret;
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_ym, "ym");
+	if (ret)
+		return ret;
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_pen_detect,
+				"pen-detect");
+	if (ret)
+		return ret;
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_pen_detect_pullup,
+				"pen-pullup");
+	if (ret)
+		return ret;
+
+	INIT_WORK(&touchdev->ts_work, vf50_ts_work);
+	touchdev->ts_workqueue = create_singlethread_workqueue("vf50-ts-touch");
+
+	if (!touchdev->ts_workqueue) {
+		ret = PTR_ERR(touchdev->ts_workqueue);
+		dev_err(dev,
+			"Failed creating vf50-ts-touch workqueue %d\n", ret);
+		return ret;
+	}
+
+	touchdev->channels = iio_channel_get_all(dev);
+	if (IS_ERR(touchdev->channels))
+		return PTR_ERR(touchdev->channels);
+
+	dev_info(dev, "Attached colibri-vf50-ts driver successfully\n");
+
+	return 0;
+}
+
+static int vf50_ts_remove(struct platform_device *pdev)
+{
+	struct vf50_touch_device *touchdev = platform_get_drvdata(pdev);
+
+	destroy_workqueue(touchdev->ts_workqueue);
+	iio_channel_release_all(touchdev->channels);
+
+	return 0;
+}
+
+static const struct of_device_id vf50_touch_of_match[] = {
+	{ .compatible = "toradex,vf50-touchctrl", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, vf50_touch_of_match);
+
+static struct platform_driver __refdata vf50_touch_driver = {
+	.driver = {
+		.name = "toradex,vf50_touchctrl",
+		.of_match_table = vf50_touch_of_match,
+	},
+	.probe = vf50_ts_probe,
+	.remove = vf50_ts_remove,
+	.prevent_deferred_probe = false,
+};
+
+module_platform_driver(vf50_touch_driver);
+
+module_param(min_pressure, int, 0600);
+MODULE_PARM_DESC(min_pressure, "Minimum pressure for touch detection");
+MODULE_AUTHOR("Sanchayan Maity");
+MODULE_DESCRIPTION("Colibri VF50 Touchscreen driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
-- 
2.4.6
