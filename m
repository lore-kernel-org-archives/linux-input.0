From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 13/14] input: touchscreen: sama5d2_rts: SAMA5D2 Resistive touchscreen driver
Date: Fri, 22 Dec 2017 17:07:20 +0200
Message-ID: <1513955241-10985-14-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

This is the implementation of the Microchip SAMA5D2 SOC resistive
touchscreen driver.
The driver registers an input device and connects to the give IIO device
from devicetree. It requires an IIO trigger (acting as a consumer) and
three IIO channels : one for X position, one for Y position and one
for pressure.
It the reports the values to the input subsystem.

Some parts of this driver are based on the initial original work by
Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/input/touchscreen/Kconfig       |  13 ++
 drivers/input/touchscreen/Makefile      |   1 +
 drivers/input/touchscreen/sama5d2_rts.c | 287 ++++++++++++++++++++++++++++++++
 3 files changed, 301 insertions(+)
 create mode 100644 drivers/input/touchscreen/sama5d2_rts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 64b30fe..db8f541 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -126,6 +126,19 @@ config TOUCHSCREEN_ATMEL_MXT_T37
 	  Say Y here if you want support to output data from the T37
 	  Diagnostic Data object using a V4L device.
 
+config TOUCHSCREEN_SAMA5D2
+	tristate "Microchip SAMA5D2 resistive touchscreen support"
+	depends on ARCH_AT91
+	depends on AT91_SAMA5D2_ADC
+	help
+	  Say Y here if you have 4-wire touchscreen connected
+          to ADC Controller on your SAMA5D2 Microchip SoC.
+
+          If unsure, say N.
+
+          To compile this driver as a module, choose M here: the
+          module will be called sama5d2_rts.
+
 config TOUCHSCREEN_AUO_PIXCIR
 	tristate "AUO in-cell touchscreen using Pixcir ICs"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 850c156..9a2772e 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
+obj-$(CONFIG_TOUCHSCREEN_SAMA5D2)	+= sama5d2_rts.o
 obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+= auo-pixcir-ts.o
 obj-$(CONFIG_TOUCHSCREEN_BU21013)	+= bu21013_ts.o
 obj-$(CONFIG_TOUCHSCREEN_CHIPONE_ICN8318)	+= chipone_icn8318.o
diff --git a/drivers/input/touchscreen/sama5d2_rts.c b/drivers/input/touchscreen/sama5d2_rts.c
new file mode 100644
index 0000000..e2ae413
--- /dev/null
+++ b/drivers/input/touchscreen/sama5d2_rts.c
@@ -0,0 +1,287 @@
+/*
+ * Microchip resistive touchscreen (RTS) driver for SAMA5D2.
+ *
+ * Copyright (C) 2017 Microchip Technology,
+ * Author: Eugen Hristev <eugen.hristev@microchip.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+#include <linux/input.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define DRIVER_NAME					"sama5d2_rts"
+#define MAX_POS_MASK					GENMASK(11, 0)
+#define AT91_RTS_DEFAULT_PRESSURE_THRESHOLD		10000
+
+/**
+ * at91_rts - at91 resistive touchscreen information struct
+ * @input:		the input device structure that we register
+ * @chan_x:		X channel to IIO device to get position on X axis
+ * @chan_y:		Y channel to IIO device to get position on Y axis
+ * @chan_pressure:	pressure channel to IIO device to get pressure
+ * @trig:		trigger to IIO device to register to for polling
+ * @rts_pf:		pollfunc for the trigger to be called by IIO dev
+ * @pressure_threshold:	number representing the threshold for the pressure
+ * @adc_connected:	to know if adc device is connected
+ * @workq:		to defer computations to this work queue for reporting
+ */
+struct at91_rts {
+	struct input_dev	*input;
+	struct iio_channel	*chan_x, *chan_y, *chan_pressure;
+	struct iio_trigger	*trig;
+	struct iio_poll_func	*rts_pf;
+	u32                     pressure_threshold;
+	bool			adc_connected;
+	struct work_struct	workq;
+};
+
+static irqreturn_t at91_rts_trigger_handler(int irq, void *p)
+{
+	struct at91_rts *st = ((struct iio_poll_func *)p)->p;
+
+	schedule_work(&st->workq);
+
+	return IRQ_HANDLED;
+}
+
+static void at91_rts_workq_handler(struct work_struct *workq)
+{
+	struct at91_rts *st = container_of(workq, struct at91_rts, workq);
+	unsigned int x, y, press;
+	int ret;
+
+	/* read the channels, if all good, report touch */
+	ret = iio_read_channel_raw(st->chan_x, &x);
+	if (ret < 0)
+		goto at91_rts_workq_handler_end_touch;
+
+	ret = iio_read_channel_raw(st->chan_y, &y);
+	if (ret < 0)
+		goto at91_rts_workq_handler_end_touch;
+
+	ret = iio_read_channel_raw(st->chan_pressure, &press);
+	if (ret < 0)
+		goto at91_rts_workq_handler_end_touch;
+
+	/* if pressure too low, don't report */
+	if (press > st->pressure_threshold)
+		goto at91_rts_workq_handler_exit;
+
+	input_report_abs(st->input, ABS_X, x);
+	input_report_abs(st->input, ABS_Y, y);
+	input_report_abs(st->input, ABS_PRESSURE, press);
+	input_report_key(st->input, BTN_TOUCH, 1);
+	input_sync(st->input);
+
+	iio_trigger_notify_done(st->trig);
+	return;
+
+at91_rts_workq_handler_end_touch:
+	/* report end of touch */
+	input_report_key(st->input, BTN_TOUCH, 0);
+	input_sync(st->input);
+at91_rts_workq_handler_exit:
+	iio_trigger_notify_done(st->trig);
+}
+
+static int at91_rts_open(struct input_dev *dev)
+{
+	int ret;
+	struct at91_rts *st = input_get_drvdata(dev);
+
+	/* avoid multiple initialization in case touchscreen is opened again */
+	if (st->adc_connected)
+		return 0;
+
+	/*
+	 * First, look for the channels. It is possible that the ADC device
+	 * did not probe yet, but we already probed, so we returning probe defer
+	 * doesn't make much sense.
+	 */
+	st->chan_x = iio_channel_get(dev->dev.parent, "x");
+	if (IS_ERR_OR_NULL(st->chan_x)) {
+		dev_err(dev->dev.parent, "cannot get X channel from ADC");
+		ret = PTR_ERR(st->chan_x);
+		goto at91_rts_open_free_chan;
+	}
+
+	st->chan_y = iio_channel_get(dev->dev.parent, "y");
+	if (IS_ERR_OR_NULL(st->chan_y)) {
+		dev_err(dev->dev.parent, "cannot get Y channel from ADC");
+		ret = PTR_ERR(st->chan_y);
+		goto at91_rts_open_free_chan;
+	}
+
+	st->chan_pressure = iio_channel_get(dev->dev.parent, "pressure");
+	if (IS_ERR_OR_NULL(st->chan_pressure)) {
+		dev_err(dev->dev.parent, "cannot get pressure channel from ADC");
+		ret = PTR_ERR(st->chan_pressure);
+		goto at91_rts_open_free_chan;
+	}
+
+	/* look for the trigger in device tree */
+	st->trig = iio_trigger_find(dev->dev.parent, NULL);
+	if (IS_ERR_OR_NULL(st->trig)) {
+		dev_err(dev->dev.parent, "cannot get trigger from ADC");
+		ret = PTR_ERR(st->trig);
+		goto at91_rts_open_free_chan;
+	}
+
+	/* allocate a pollfunc for the trigger */
+	st->rts_pf = iio_alloc_pollfunc(at91_rts_trigger_handler, NULL,
+					IRQF_ONESHOT, NULL,
+					dev->dev.parent->of_node->name);
+	if (!st->rts_pf) {
+		ret = -ENOMEM;
+		dev_err(dev->dev.parent, "cannot allocate trigger pollfunc");
+		goto at91_rts_open_free_chan;
+	}
+
+	iio_pollfunc_set_private_data(st->rts_pf, st);
+
+	/*
+	 * Attach the pollfunc to the trigger. This will also call the
+	 * configure function to enable the trigger
+	 */
+	ret = iio_trigger_attach_poll_func(st->trig, st->rts_pf);
+	if (ret)
+		goto at91_rts_open_dealloc_pf;
+
+	dev_dbg(dev->dev.parent, "channels found, attached to trigger");
+
+	st->adc_connected = true;
+	return 0;
+
+at91_rts_open_dealloc_pf:
+	iio_dealloc_pollfunc(st->rts_pf);
+at91_rts_open_free_chan:
+	if (!IS_ERR_OR_NULL(st->chan_x))
+		iio_channel_release(st->chan_x);
+	if (!IS_ERR_OR_NULL(st->chan_y))
+		iio_channel_release(st->chan_y);
+	if (!IS_ERR_OR_NULL(st->chan_pressure))
+		iio_channel_release(st->chan_pressure);
+	/*
+	 * Avoid keeping old values in channel pointers. in case some channel
+	 * failed and we reopen them, and now fail, we will have invalid values
+	 * to release. So write them as NULL now.
+	 */
+	st->chan_x = NULL;
+	st->chan_y = NULL;
+	st->chan_pressure = NULL;
+	return ret;
+}
+
+static void at91_rts_close(struct input_dev *dev)
+{
+	struct at91_rts *st = input_get_drvdata(dev);
+
+	if (!st->adc_connected)
+		return;
+
+	iio_trigger_detach_poll_func(st->trig, st->rts_pf);
+	iio_dealloc_pollfunc(st->rts_pf);
+
+	if (!IS_ERR_OR_NULL(st->chan_x))
+		iio_channel_release(st->chan_x);
+	if (!IS_ERR_OR_NULL(st->chan_y))
+		iio_channel_release(st->chan_y);
+	if (!IS_ERR_OR_NULL(st->chan_pressure))
+		iio_channel_release(st->chan_pressure);
+
+	st->adc_connected = false;
+}
+
+static int at91_rts_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct at91_rts *st;
+	struct input_dev *input;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	st = devm_kzalloc(dev, sizeof(struct at91_rts), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+	st->adc_connected = false;
+
+	INIT_WORK(&st->workq, at91_rts_workq_handler);
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(dev, "failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	ret = of_property_read_u32(node, "microchip,pressure-threshold",
+				   &st->pressure_threshold);
+	if (ret < 0) {
+		dev_dbg(dev, "can't get touchscreen pressure threshold property.\n");
+		st->pressure_threshold = AT91_RTS_DEFAULT_PRESSURE_THRESHOLD;
+	}
+
+	input->name = DRIVER_NAME;
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &pdev->dev;
+	input->open = at91_rts_open;
+	input->close = at91_rts_close;
+
+	input_set_abs_params(input, ABS_X, 0, MAX_POS_MASK - 1, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, MAX_POS_MASK, 0, 0);
+	input_set_abs_params(input, ABS_PRESSURE, 0, 0xffffff, 0, 0);
+
+	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	st->input = input;
+	input_set_drvdata(input, st);
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(dev, "failed to register input device: %d", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, st);
+
+	dev_info(dev, "probed successfully\n");
+	return 0;
+}
+
+static int at91_rts_remove(struct platform_device *pdev)
+{
+	struct at91_rts *st = platform_get_drvdata(pdev);
+
+	input_unregister_device(st->input);
+
+	return 0;
+}
+
+static const struct of_device_id at91_rts_of_match[] = {
+	{
+		.compatible = "microchip,sama5d2-resistive-touch",
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, at91_rts_of_match);
+
+static struct platform_driver atmel_rts_driver = {
+	.probe = at91_rts_probe,
+	.remove = at91_rts_remove,
+	.driver = {
+		   .name = DRIVER_NAME,
+		   .of_match_table = of_match_ptr(at91_rts_of_match),
+	},
+};
+
+module_platform_driver(atmel_rts_driver);
+
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
+MODULE_DESCRIPTION("Microchip SAMA5D2 Resistive Touch Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
