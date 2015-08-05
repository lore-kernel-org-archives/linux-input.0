From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v3 3/3] touchscreen: colibri-vf50-ts: Add touchscreen support for Colibri VF50
Date: Wed,  5 Aug 2015 14:25:51 +0530
Message-ID: <bb234514d6921c3d184930d78e7822381c481b79.1438763030.git.maitysanchayan@gmail.com>
References: <cover.1438763030.git.maitysanchayan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438763030.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1438763030.git.maitysanchayan@gmail.com>
References: <cover.1438763030.git.maitysanchayan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.org, kernel@pengutronix.de, stefan@agner.ch, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sanchayan Maity <maitysanchayan@gmail.com>
List-Id: linux-input@vger.kernel.org

The Colibri Vybrid VF50 module supports 4-wire touchscreens using
FETs and ADC inputs. This driver uses the IIO consumer interface
and relies on the vf610_adc driver based on the IIO framework.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/input/touchscreen/Kconfig           |  12 +
 drivers/input/touchscreen/Makefile          |   1 +
 drivers/input/touchscreen/colibri-vf50-ts.c | 404 ++++++++++++++++++++++++++++
 3 files changed, 417 insertions(+)
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
index 0000000..d7bc91a
--- /dev/null
+++ b/drivers/input/touchscreen/colibri-vf50-ts.c
@@ -0,0 +1,404 @@
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
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/types.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
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
+	struct iio_channel	*channels;
+	struct gpio_desc *gpio_xp;
+	struct gpio_desc *gpio_xm;
+	struct gpio_desc *gpio_yp;
+	struct gpio_desc *gpio_ym;
+	struct gpio_desc *gpio_pen_detect;
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
+		if (ret < 0) {
+			value = ret;
+			goto error_iio_read;
+		}
+
+		value += val;
+	}
+
+	value /= 5;
+
+error_iio_read:
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
+ * ADC touch screen sampling bottom half irq handler
+ */
+static irqreturn_t vf50_ts_irq_bh(int irq, void *private)
+{
+	struct vf50_touch_device *vf50_ts = (struct vf50_touch_device *)private;
+	struct device *dev = &vf50_ts->pdev->dev;
+	int val_x, val_y, val_z1, val_z2, val_p = 0;
+	bool discard_val_on_start = true;
+
+	/* Disable the touch detection plates */
+	gpiod_set_value(vf50_ts->gpio_ym, 0);
+
+	/* Let the platform mux to default state in order to mux as ADC */
+	pinctrl_pm_select_default_state(dev);
+
+	while (!vf50_ts->stop_touchscreen) {
+		/* X-Direction */
+		val_x = adc_ts_measure(&vf50_ts->channels[0],
+				vf50_ts->gpio_xp, vf50_ts->gpio_xm);
+		if (val_x < 0)
+			break;
+
+		/* Y-Direction */
+		val_y = adc_ts_measure(&vf50_ts->channels[1],
+				vf50_ts->gpio_yp, vf50_ts->gpio_ym);
+		if (val_y < 0)
+			break;
+
+		/*
+		 * Touch pressure
+		 * Measure on XP/YM
+		 */
+		val_z1 = adc_ts_measure(&vf50_ts->channels[2],
+				vf50_ts->gpio_yp, vf50_ts->gpio_xm);
+		if (val_z1 < 0)
+			break;
+		val_z2 = adc_ts_measure(&vf50_ts->channels[3],
+				vf50_ts->gpio_yp, vf50_ts->gpio_xm);
+		if (val_z2 < 0)
+			break;
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
+	/* Mux detection before request IRQ, wait for pull-up to settle */
+	vf50_ts_enable_touch_detection(touchdev);
+	msleep(10);
+
+	return 0;
+}
+
+static void vf50_ts_close(struct input_dev *dev_input)
+{
+	struct vf50_touch_device *touchdev = input_get_drvdata(dev_input);
+	struct device *dev = &touchdev->pdev->dev;
+
+	touchdev->stop_touchscreen = true;
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
+	struct input_dev *input;
+	struct iio_channel *channels;
+	struct device *dev = &pdev->dev;
+	struct vf50_touch_device *touchdev;
+	int ret;
+
+	channels = iio_channel_get_all(dev);
+	if (IS_ERR(channels))
+		return PTR_ERR(channels);
+
+	touchdev = devm_kzalloc(dev, sizeof(*touchdev), GFP_KERNEL);
+	if (touchdev == NULL) {
+		ret = -ENOMEM;
+		goto error_release_channels;
+	}
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(dev, "Failed to allocate TS input device\n");
+		ret = -ENOMEM;
+		goto error_release_channels;
+	}
+
+	platform_set_drvdata(pdev, touchdev);
+
+	touchdev->pdev = pdev;
+	touchdev->channels = channels;
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
+		goto error_release_channels;
+	}
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_xp, "xp");
+	if (ret)
+		goto error_release_channels;
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_xm, "xm");
+	if (ret)
+		goto error_release_channels;
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_yp, "yp");
+	if (ret)
+		goto error_release_channels;
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_ym, "ym");
+	if (ret)
+		goto error_release_channels;
+
+	ret = vf50_ts_get_gpiod(dev, &touchdev->gpio_pen_detect,
+				"pen-detect");
+	if (ret)
+		goto error_release_channels;
+
+	touchdev->pen_irq = gpiod_to_irq(touchdev->gpio_pen_detect);
+	if (touchdev->pen_irq < 0) {
+		ret = touchdev->pen_irq;
+		dev_err(dev, "Unable to get IRQ for GPIO\n");
+		goto error_release_channels;
+	}
+
+	ret = devm_request_threaded_irq(dev, touchdev->pen_irq, NULL,
+			vf50_ts_irq_bh, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+			"vf50 touch", touchdev);
+	if (ret < 0) {
+		dev_err(dev, "Unable to request IRQ %d\n", touchdev->pen_irq);
+		goto error_release_channels;
+	}
+
+	return 0;
+
+error_release_channels:
+	iio_channel_release_all(channels);
+	return ret;
+}
+
+static int vf50_ts_remove(struct platform_device *pdev)
+{
+	struct vf50_touch_device *touchdev = platform_get_drvdata(pdev);
+
+	iio_channel_release_all(touchdev->channels);
+
+	return 0;
+}
+
+static const struct of_device_id vf50_touch_of_match[] = {
+	{ .compatible = "toradex,vf50-touchscreen", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, vf50_touch_of_match);
+
+static struct platform_driver vf50_touch_driver = {
+	.driver = {
+		.name = "toradex,vf50_touchctrl",
+		.of_match_table = vf50_touch_of_match,
+	},
+	.probe = vf50_ts_probe,
+	.remove = vf50_ts_remove,
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
2.5.0
