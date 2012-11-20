From: Stefan Nilsson <stefan.nilsson@unixphere.com>
Subject: [PATCH 1/1] input: added driver support for the t5400 pressure sensor.
Date: Tue, 20 Nov 2012 22:02:34 +0100
Message-ID: <1353445355-2517-2-git-send-email-stefan.nilsson@unixphere.com>
References: <1353445355-2517-1-git-send-email-stefan.nilsson@unixphere.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:48609 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933Ab2KTVCj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Nov 2012 16:02:39 -0500
In-Reply-To: <1353445355-2517-1-git-send-email-stefan.nilsson@unixphere.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rob.herring@calxeda.com, arnd@arndb.de, matthias.schmidt@epcos.com, armin.schober@epcos.com, eric.andersson@unixphere.com

This patch will enable the kernel driver support for the TDK/EPCOS
barometric pressure sensor. The driver implements a common core file
together with two digital interface files, i2c and spi, which are
abstracted through regmap handling.

Tested-by: Matthias Schmidt <matthias.schmidt@epcos.com>
Reviewed-by: Eric Andersson <eric.andersson@unixphere.com>
Signed-off-by: Stefan Nilsson <stefan.nilsson@unixphere.com>
---
 .../devicetree/bindings/input/misc/t5400.txt       |   17 +
 drivers/input/misc/Kconfig                         |   23 +
 drivers/input/misc/Makefile                        |    2 +
 drivers/input/misc/t5400-core.c                    |  607 ++++++++++++++++++++
 drivers/input/misc/t5400-i2c.c                     |  130 +++++
 drivers/input/misc/t5400-spi.c                     |  128 ++++
 include/linux/t5400.h                              |   69 +++
 7 files changed, 976 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/misc/t5400.txt
 create mode 100644 drivers/input/misc/t5400-core.c
 create mode 100644 drivers/input/misc/t5400-i2c.c
 create mode 100644 drivers/input/misc/t5400-spi.c
 create mode 100644 include/linux/t5400.h

diff --git a/Documentation/devicetree/bindings/input/misc/t5400.txt b/Documentation/devicetree/bindings/input/misc/t5400.txt
new file mode 100644
index 0000000..4dd0eed
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/misc/t5400.txt
@@ -0,0 +1,17 @@
+T5400 digital pressure sensors
+
+Required properties:
+- compatible: tdk-epcos,t5400
+
+Optional properties:
+- gpio-irq: platform gpio pin connected to the t5400 irq pin
+- op-mode: operation modes to be set according to enum t5400_op_mode in t5400.h
+
+Example of having the t5400 on an i2c bus:
+
+pressure@77 {
+	compatible = "tdk-epcos,t5400";
+	reg = <0x77>;
+	gpio-irq = <18>;
+	op-mode = <1>;
+};
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7c0f1ec..acacfa5 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -600,4 +600,27 @@ config INPUT_XEN_KBDDEV_FRONTEND
 	  To compile this driver as a module, choose M here: the
 	  module will be called xen-kbdfront.
 
+config INPUT_T5400_I2C
+	tristate "T5400 digital pressure sensor on I2C"
+	select REGMAP_I2C
+	select INPUT_POLLDEV
+	depends on I2C
+	help
+	  Say Y here if you want to support TDK/EPCOS's T5400 digital pressure
+	  sensor hooked to an I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called t5400-i2c.
+
+config INPUT_T5400_SPI
+	tristate "T5400 digital pressure sensor on SPI"
+	select REGMAP_SPI
+	select INPUT_POLLDEV
+	depends on SPI_MASTER
+	help
+	  Say Y here if you want to support TDK/EPCOS's T5400 digital pressure
+	  sensor hooked to an SPI bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called t5400-spi.
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 83fe6f5..4e22be1 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -56,3 +56,5 @@ obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
+obj-$(CONFIG_INPUT_T5400_I2C)		+= t5400-core.o t5400-i2c.o
+obj-$(CONFIG_INPUT_T5400_SPI)		+= t5400-core.o t5400-spi.o
diff --git a/drivers/input/misc/t5400-core.c b/drivers/input/misc/t5400-core.c
new file mode 100644
index 0000000..1cfe0eb
--- /dev/null
+++ b/drivers/input/misc/t5400-core.c
@@ -0,0 +1,607 @@
+/**
+ * Copyright (c) 2012 Epcos/TDK
+ * Copyright (c) 2012 Unixphere
+ *
+ * This driver supports the Epcos/TDK T5400 digital barometric pressure
+ * and temperature sensor
+ *
+ * The datasheet for the T5400 chip can be found here:
+ * http://www.epcos.com/datasheets/C953.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/input-polldev.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/of.h>
+#include <linux/t5400.h>
+
+/* Max/Min barometric pressure values as stated in spec, unit = hPa */
+#define T5400_ABS_MAX_PRES	1100
+#define T5400_ABS_MIN_PRES	300
+
+/* Max/Min ambient temperature values as stated in spec, unit = Celsius */
+#define T5400_ABS_MAX_TEMP	80
+#define T5400_ABS_MIN_TEMP	-30
+
+/* Chip id register */
+#define T5400_CHIP_ID_REG	0x88
+#define T5400_CHIP_ID_MSK	0x7F
+#define T5400_CHIP_ID		0x77
+
+/**
+ * Calibration coefficients registers
+ *
+ * The coefficients comes in a consecutive register serie, from C1 to C8, where
+ * C1-C4 are unsigned 16-bit integer values and C5-C8 are signed 16-bit values.
+ */
+#define T5400_C1_LSB_REG	0x8E
+#define T5400_C8_MSB_REG	0x9D
+#define T5400_CALIB_REGS_SIZE	16
+
+/* Software reset  */
+#define T5400_CTRL_RES_REG	0xF0
+#define T5400_RESET_CMD		0x73
+
+/**
+ * Temperature/Pressure measurement control register
+ *
+ * This register defines the control bit used for measurement requests as listed
+ * below.
+ * b0: sco, set to 1 for conversion start
+ * b1-b2: pt, set 00 for pressure meas and 01 for temperature meas
+ * b3-b4: mode, set values according to enum t5400_op_mode
+ * b5: zero, set to 0 for applying the command correctly
+ * b6-b7: don't care
+ */
+#define T5400_CTRL_MEAS_REG	0xF1
+#define T5400_CONV_PRES_CMD	0x01
+#define T5400_CONV_TEMP_CMD	0x03
+#define T5400_MEAS_MODE_POS	3
+
+/* Temperature/Pressure Data registers */
+#define T5400_DATA_LSB_REG	0xF5
+#define T5400_DATA_MSB_REG	0xF6
+#define T5400_DATA_SIZE		2
+
+/* Input poll-intervals (milliseconds) */
+#define T5400_POLL_INTERVAL	50
+#define T5400_POLL_MIN		5
+#define T5400_POLL_MAX		200
+
+/* Power-on/Reset start-up time (milliseconds) */
+#define T5400_START_UP_TIME	12
+
+/* Idle mode wake-up time (milliseconds) */
+#define T5400_WAKE_UP_TIME	2
+
+/* Temperature conversion time (milliseconds) */
+#define T5400_TEMP_CONV_TIME	(T5400_WAKE_UP_TIME + 4)
+
+/* Pressure measurement conversion time (milliseconds), used in non-irq mode */
+static const u8 pres_conv_time[T5400_OP_MODE_LAST] = {
+	(T5400_WAKE_UP_TIME + 2),
+	(T5400_WAKE_UP_TIME + 8),
+	(T5400_WAKE_UP_TIME + 16),
+	(T5400_WAKE_UP_TIME + 64)
+};
+
+enum t5400_conv_type {
+	T5400_CONV_PRES,
+	T5400_CONV_TEMP
+};
+
+struct t5400_calib_coef {
+	u16 c1, c2, c3, c4;
+	s16 c5, c6, c7, c8;
+};
+
+struct t5400_data {
+	struct t5400_calib_coef coef;
+	u16 raw_pres;
+	s16 raw_temp;
+};
+
+struct t5400 {
+	struct regmap *regmap;
+	struct device *dev;
+	struct input_polled_dev *input_polled;
+	struct input_dev *input;
+	struct work_struct work;
+	struct mutex mutex;
+	struct t5400_data data;
+	enum t5400_op_mode op-mode;
+	int gpio-irq;
+	int (*setup_hw)(bool activate);
+};
+
+static int t5400_start_conv(struct regmap *regmap, enum t5400_conv_type type,
+					enum t5400_op_mode op-mode)
+{
+	if (type == T5400_CONV_PRES)
+		return regmap_write(regmap, T5400_CTRL_MEAS_REG,
+					T5400_CONV_PRES_CMD |
+					(u8)(op-mode << T5400_MEAS_MODE_POS));
+	else
+		return regmap_write(regmap, T5400_CTRL_MEAS_REG,
+					T5400_CONV_TEMP_CMD);
+}
+
+static s32 __devinit t5400_get_calibration_parameters(struct regmap *regmap,
+					struct t5400_calib_coef *coef)
+{
+	u16 data[T5400_CALIB_REGS_SIZE >> 1];
+	int error;
+
+	error = regmap_bulk_read(regmap, T5400_C1_LSB_REG, (char *)data,
+						T5400_CALIB_REGS_SIZE);
+	if (error < 0)
+		return error;
+
+	coef->c1 = le16_to_cpu(data[0]);
+	coef->c2 = le16_to_cpu(data[1]);
+	coef->c3 = le16_to_cpu(data[2]);
+	coef->c4 = le16_to_cpu(data[3]);
+	coef->c5 = le16_to_cpu(data[4]);
+	coef->c6 = le16_to_cpu(data[5]);
+	coef->c7 = le16_to_cpu(data[6]);
+	coef->c8 = le16_to_cpu(data[7]);
+
+	return 0;
+}
+
+static int t5400_soft_reset(struct regmap *regmap)
+{
+	int error;
+
+	error = regmap_write(regmap, T5400_CTRL_RES_REG, T5400_RESET_CMD);
+	if (error < 0)
+		return error;
+
+	msleep(T5400_START_UP_TIME);
+	return 0;
+}
+
+static void t5400_worker(struct work_struct *work)
+{
+	struct t5400 *t5400 = container_of(work, struct t5400, work);
+	u16 raw_pres;
+	s16 raw_temp;
+	int error;
+
+	error = t5400_start_conv(t5400->regmap, T5400_CONV_PRES,
+					t5400->op-mode);
+	if (error < 0)
+		goto error_exit;
+
+	msleep(pres_conv_time[t5400->op-mode]);
+	error = regmap_bulk_read(t5400->regmap, T5400_DATA_LSB_REG,
+					(char *)&raw_pres, T5400_DATA_SIZE);
+	if (error < 0)
+		goto error_exit;
+
+	error = t5400_start_conv(t5400->regmap, T5400_CONV_TEMP, 0);
+	if (error < 0)
+		goto error_exit;
+
+	msleep(T5400_TEMP_CONV_TIME);
+	error = regmap_bulk_read(t5400->regmap, T5400_DATA_LSB_REG,
+					(char *)&raw_temp, T5400_DATA_SIZE);
+	if (error < 0)
+		goto error_exit;
+
+	/**
+	 * Store the new values upon successful consecutive readings of
+	 * both pressure and temperature, else stick to the previous values.
+	 */
+	mutex_lock(&t5400->mutex);
+	t5400->data.raw_temp = le16_to_cpu(raw_temp);
+	t5400->data.raw_pres = le16_to_cpu(raw_pres);
+	mutex_unlock(&t5400->mutex);
+
+error_exit:
+	schedule_work(&t5400->work);
+}
+
+static irqreturn_t t5400_irq_thread(int irq, void *data)
+{
+	struct t5400 *t5400 = (struct t5400 *)data;
+	u16 raw_pres;
+	s16 raw_temp;
+	int error;
+
+	error = regmap_bulk_read(t5400->regmap, T5400_DATA_LSB_REG,
+					(char *)&raw_pres, T5400_DATA_SIZE);
+	if (error < 0)
+		goto error_exit;
+
+	error = t5400_start_conv(t5400->regmap, T5400_CONV_TEMP, 0);
+	if (error < 0)
+		goto error_exit;
+
+	msleep(T5400_TEMP_CONV_TIME);
+	error = regmap_bulk_read(t5400->regmap, T5400_DATA_LSB_REG,
+					(char *)&raw_temp, T5400_DATA_SIZE);
+	if (error < 0)
+		goto error_exit;
+
+	/* Same as for the worker above */
+	mutex_lock(&t5400->mutex);
+	t5400->data.raw_temp = le16_to_cpu(raw_temp);
+	t5400->data.raw_pres = le16_to_cpu(raw_pres);
+	mutex_unlock(&t5400->mutex);
+
+error_exit:
+	error = t5400_start_conv(t5400->regmap, T5400_CONV_PRES,
+					t5400->op-mode);
+	if (error < 0)
+		dev_err(t5400->dev, "%s: start conv. req. failed, %d\n",
+					__func__, error);
+	return IRQ_HANDLED;
+}
+
+/**
+ * This function converts the raw temperature to centi-celsius with optimization
+ * for integer fixed-point arithmetics with two fractions embedded in the
+ * integer (i.e. 27.30 will be reported as 2730 and so on).
+ *
+ * Formula from T5400 Application Note, rev. 1.0.A1:
+ * Ta = ((c1 * Tr) / 2^24) + (c2 / 2^10)
+ */
+static inline int t5400_get_temperature(struct t5400_calib_coef *coef,
+						s16 raw_temp)
+{
+	s64 temp, val;
+
+	val = ((s64)(coef->c1 * raw_temp) * 100);
+	temp = (val >> 24);
+	val = ((s64)coef->c2 * 100);
+	temp += (val >> 10);
+	return (int)temp;
+}
+
+/**
+ * This function converts the raw pressure to Pascal, i.e. without fractions.
+ *
+ * Formula from T5400 Application Note, rev. 1.0.A1:
+ * Sensitivity = (c3 + ((c4 * Tr) / 2^17) + ((c5 * Tr^2) / 2^34))
+ * Offset = (c6 * 2^14) + ((c7 * Tr) / 2^3) + ((c8 * Tr^2) / 2^19)
+ * Pa = (Sensitivity * Pr + Offset) / 2^14
+ */
+static inline int t5400_get_pressure(struct t5400_calib_coef *coef,
+						s16 raw_temp, u16 raw_pres)
+{
+	s64 s, o, pres, val;
+
+	s = (s64)coef->c3 ;
+	val = (s64)(coef->c4 * raw_temp);
+	s += (val >> 17);
+	val = (s64)(coef->c5 * raw_temp * raw_temp);
+	s += (val >> 34);
+
+	o = (s64)coef->c6 << 14;
+	val = (s64)(coef->c7 * raw_temp);
+	o += (val >> 3);
+	val = (s64)(coef->c8 * raw_temp * raw_temp);
+	o += (val >> 19);
+
+	pres = ((s64)(s * raw_pres) + o) >> 14;
+
+	return (int)pres;
+}
+
+static void t5400_poll(struct input_polled_dev *dev)
+{
+	struct t5400 *t5400 = dev->private;
+	u16 raw_pres;
+	s16 raw_temp;
+	int temperature;
+	int pressure;
+
+	/**
+	 * Locked in order to ensure that both raw temp. & pres. values
+	 * comes from the same consecutive readings.
+	 */
+	mutex_lock(&t5400->mutex);
+	raw_pres = t5400->data.raw_pres;
+	raw_temp = t5400->data.raw_temp;
+	mutex_unlock(&t5400->mutex);
+
+	temperature = t5400_get_temperature(&t5400->data.coef, raw_temp);
+	pressure = t5400_get_pressure(&t5400->data.coef, raw_temp, raw_pres);
+
+	input_report_abs(t5400->input, ABS_PRESSURE, pressure);
+	input_report_abs(t5400->input, ABS_MISC, temperature);
+	input_sync(t5400->input);
+}
+
+static int t5400_activate(struct t5400 *t5400)
+{
+	int error;
+
+	if (t5400->gpio-irq > 0) {
+		enable_irq(t5400->gpio-irq);
+		error = t5400_start_conv(t5400->regmap, T5400_CONV_PRES,
+						t5400->op-mode);
+		if (error < 0)
+			dev_err(t5400->dev, "%s: start conv. req. failed, %d\n",
+						__func__, error);
+		return error;
+	} else {
+		schedule_work(&t5400->work);
+		return 0;
+	}
+}
+
+static int t5400_deactivate(struct t5400 *t5400)
+{
+	int error;
+
+	if (t5400->gpio-irq > 0) {
+		disable_irq(t5400->gpio-irq);
+		error = t5400_soft_reset(t5400->regmap);
+		if (error < 0)
+			dev_err(t5400->dev, "%s: soft reset failed, %d\n",
+						__func__, error);
+		return error;
+	} else {
+		cancel_work_sync(&t5400->work);
+		return 0;
+	}
+}
+
+static void t5400_open(struct input_polled_dev *dev)
+{
+	struct t5400 *t5400 = dev->private;
+	int error;
+
+	error = t5400_activate(t5400);
+	if (error < 0)
+		dev_err(t5400->dev, "%s: failed, %d\n", __func__, error);
+}
+
+static void t5400_close(struct input_polled_dev *dev)
+{
+	struct t5400 *t5400 = dev->private;
+	int error;
+
+	error = t5400_deactivate(t5400);
+	if (error < 0)
+		dev_err(t5400->dev, "%s: failed, %d\n", __func__, error);
+}
+
+static int __devinit t5400_register_polled_device(struct t5400 *t5400)
+{
+	struct input_polled_dev *ipoll_dev;
+	struct input_dev *idev;
+	int error;
+
+	ipoll_dev = input_allocate_polled_device();
+	if (!ipoll_dev)
+		return -ENOMEM;
+
+	ipoll_dev->private = t5400;
+	ipoll_dev->poll = t5400_poll;
+	ipoll_dev->open = t5400_open;
+	ipoll_dev->close = t5400_close;
+	ipoll_dev->poll_interval = T5400_POLL_INTERVAL;
+	ipoll_dev->poll_interval_min = T5400_POLL_MIN;
+	ipoll_dev->poll_interval_max = T5400_POLL_MAX;
+
+	idev = ipoll_dev->input;
+	idev->name = T5400_DRIVER;
+	idev->phys = T5400_DRIVER "/input0";
+	idev->dev.parent = t5400->dev;
+
+	idev->evbit[0] = BIT_MASK(EV_ABS);
+	input_set_abs_params(idev, ABS_PRESSURE, T5400_ABS_MIN_PRES,
+					T5400_ABS_MAX_PRES, 0, 0);
+	input_set_abs_params(idev, ABS_MISC, T5400_ABS_MIN_TEMP,
+					T5400_ABS_MAX_TEMP, 0, 0);
+
+	error = input_register_polled_device(ipoll_dev);
+	if (error < 0) {
+		input_free_polled_device(ipoll_dev);
+		return error;
+	}
+
+	t5400->input = ipoll_dev->input;
+	t5400->input_polled = ipoll_dev;
+
+	if (t5400->gpio-irq > 0) {
+		error = request_threaded_irq(t5400->gpio-irq, NULL,
+			t5400_irq_thread, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			T5400_DRIVER, t5400);
+		if (error < 0) {
+			dev_err(t5400->dev, "%s: irq req. failed %d, %d\n",
+					__func__, t5400->gpio-irq, error);
+			goto error_irq;
+		}
+		disable_irq(t5400->gpio-irq);
+	} else {
+		INIT_WORK(&t5400->work, t5400_worker);
+	}
+
+	return 0;
+
+error_irq:
+	input_unregister_polled_device(t5400->input_polled);
+	return error;
+}
+
+static void __init t5400_get_of_properties(struct t5400 *data)
+{
+#ifdef CONFIG_OF
+	struct device_node *np = data->dev->of_node;
+	u32 prop;
+
+	if (!np)
+		return;
+
+	if (!of_property_read_u32(np, "gpio-irq", &prop))
+		data->gpio-irq = prop & 0xff;
+
+	if (!of_property_read_u32(np, "op-mode", &prop))
+		data->op-mode = (prop & 0xff) > T5400_OP_MODE_U_HIGH ?
+				T5400_OP_MODE_STANDARD : (prop & 0xff);
+#endif
+}
+
+struct regmap_config t5400_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8
+};
+EXPORT_SYMBOL_GPL(t5400_regmap_config);
+
+int t5400_detect(struct device *dev)
+{
+	struct t5400 *t5400 = dev_get_drvdata(dev);
+	int chip_id;
+	int ret;
+
+	ret = regmap_read(t5400->regmap, T5400_CHIP_ID_REG, &chip_id);
+	if (ret < 0)
+		return ret;
+
+	if ((T5400_CHIP_ID_MSK & chip_id) != T5400_CHIP_ID)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(t5400_detect);
+
+int __devinit t5400_probe(struct device *dev, struct regmap *regmap)
+{
+	struct t5400 *t5400;
+	struct t5400_platform_data *pdata = dev->platform_data;
+	int error;
+
+	t5400 = kzalloc(sizeof(struct t5400), GFP_KERNEL);
+	if (!t5400)
+		return -ENOMEM;
+	dev_set_drvdata(dev, t5400);
+	t5400->dev = dev;
+	t5400->regmap = regmap;
+	t5400->op-mode = T5400_OP_MODE_STANDARD;
+
+	if (pdata) {
+		if (pdata->setup_hw) {
+			error = pdata->setup_hw(1);
+			if (error < 0) {
+				dev_err(dev, "%s: setup hw failed, %d\n",
+						__func__, error);
+				goto err_free_mem;
+			}
+		}
+		t5400->op-mode = pdata->op-mode;
+		t5400->gpio-irq = pdata->gpio-irq;
+		t5400->setup_hw = pdata->setup_hw;
+	} else {
+		t5400_get_of_properties(t5400);
+	}
+
+	error = t5400_soft_reset(regmap);
+	if (error < 0) {
+		dev_err(dev, "%s: soft reset failed, %d\n", __func__, error);
+		goto err_free_mem;
+	}
+
+	error = t5400_detect(dev);
+	if (error < 0) {
+		dev_err(dev, "%s: hw detection failed, %d\n", __func__, error);
+		goto err_free_mem;
+	}
+
+	error = t5400_get_calibration_parameters(regmap, &t5400->data.coef);
+	if (error < 0) {
+		dev_err(dev, "%s: failed to get calib. params, %d\n",
+				__func__, error);
+		goto err_free_mem;
+	}
+
+	error = t5400_register_polled_device(t5400);
+	if (error < 0)
+		goto err_free_mem;
+
+	mutex_init(&t5400->mutex);
+
+	return 0;
+
+err_free_mem:
+	kfree(t5400);
+	return error;
+}
+EXPORT_SYMBOL(t5400_probe);
+
+int __devexit t5400_remove(struct device *dev)
+{
+	struct t5400 *t5400 = dev_get_drvdata(dev);
+
+	if (t5400->gpio-irq > 0)
+		free_irq(t5400->gpio-irq, t5400);
+	input_unregister_polled_device(t5400->input_polled);
+	input_free_polled_device(t5400->input_polled);
+	kfree(t5400);
+
+	return 0;
+}
+EXPORT_SYMBOL(t5400_remove);
+
+#if defined(CONFIG_PM)
+int t5400_disable(struct device *dev)
+{
+	struct t5400 *t5400 = dev_get_drvdata(dev);
+	int error;
+
+	error = t5400_deactivate(t5400);
+	if (error < 0) {
+		dev_err(dev, "%s: deactivation failed, %d\n", __func__, error);
+		return error;
+	}
+
+	if (t5400->setup_hw)
+		return t5400->setup_hw(0);
+
+	return 0;
+}
+EXPORT_SYMBOL(t5400_disable);
+
+int t5400_enable(struct device *dev)
+{
+	struct t5400 *t5400 = dev_get_drvdata(dev);
+	int error;
+
+	if (t5400->setup_hw) {
+		error = t5400->setup_hw(1);
+		if (error < 0) {
+			dev_err(dev, "%s: setup hw failed, %d\n",
+					__func__, error);
+			return error;
+		}
+	}
+	return t5400_activate(t5400);
+}
+EXPORT_SYMBOL(t5400_enable);
+#endif
+
+MODULE_AUTHOR("Stefan Nilsson <stefan.nilsson@unixphere.com>");
+MODULE_DESCRIPTION("T5400 driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/t5400-i2c.c b/drivers/input/misc/t5400-i2c.c
new file mode 100644
index 0000000..bb388e0
--- /dev/null
+++ b/drivers/input/misc/t5400-i2c.c
@@ -0,0 +1,130 @@
+/**
+ * Copyright (c) 2012 Epcos/TDK
+ * Copyright (c) 2012 Unixphere
+ *
+ * This driver supports the Epcos/TDK T5400 digital barometric pressure
+ * and temperature sensor
+ *
+ * The datasheet for the T5400 chip can be found here:
+ * http://www.epcos.com/datasheets/C953.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/t5400.h>
+
+#define T5400_I2C_ADDRESS     0x77
+
+static const unsigned short normal_i2c[] = { T5400_I2C_ADDRESS,
+						I2C_CLIENT_END };
+
+static int t5400_i2c_detect(struct i2c_client *client,
+			struct i2c_board_info *info)
+{
+	if (client->addr != T5400_I2C_ADDRESS)
+		return -ENODEV;
+
+	return t5400_detect(&client->dev);
+}
+
+static int __devinit t5400_i2c_probe(struct i2c_client *client,
+				      const struct i2c_device_id *id)
+{
+	int err;
+	struct regmap *regmap = devm_regmap_init_i2c(client,
+					&t5400_regmap_config);
+	if (IS_ERR(regmap)) {
+		err = PTR_ERR(regmap);
+		dev_err(&client->dev, "Failed to init regmap: %d\n", err);
+		return err;
+	}
+
+	return t5400_probe(&client->dev, regmap);
+}
+
+static void t5400_i2c_shutdown(struct i2c_client *client)
+{
+	t5400_disable(&client->dev);
+}
+
+static int __devexit t5400_i2c_remove(struct i2c_client *client)
+{
+	return t5400_remove(&client->dev);
+}
+
+#if defined(CONFIG_PM)
+static int t5400_i2c_suspend(struct device *dev)
+{
+	return t5400_disable(dev);
+}
+
+static int t5400_i2c_resume(struct device *dev)
+{
+	return t5400_enable(dev);
+}
+#endif
+
+static UNIVERSAL_DEV_PM_OPS(t5400_i2c_pm, t5400_i2c_suspend,
+					t5400_i2c_resume, NULL);
+
+static const struct of_device_id t5400_of_match[] = {
+	{ .compatible = "tdk-epcos,t5400", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, t5400_of_match);
+
+static const struct i2c_device_id t5400_id[] = {
+	{ T5400_DRIVER, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, t5400_id);
+
+static struct i2c_driver t5400_i2c_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= T5400_DRIVER,
+		.pm	= &t5400_i2c_pm,
+		.of_match_table = t5400_of_match
+	},
+	.id_table	= t5400_id,
+	.probe		= t5400_i2c_probe,
+	.shutdown	= t5400_i2c_shutdown,
+	.remove		= __devexit_p(t5400_i2c_remove),
+
+	.detect         = t5400_i2c_detect,
+	.address_list   = normal_i2c
+};
+
+static int __init t5400_i2c_init(void)
+{
+	return i2c_add_driver(&t5400_i2c_driver);
+}
+
+static void __exit t5400_i2c_exit(void)
+{
+	i2c_del_driver(&t5400_i2c_driver);
+}
+
+
+MODULE_AUTHOR("Stefan Nilsson <stefan.nilsson@unixphere.com>");
+MODULE_DESCRIPTION("T5400 I2C bus driver");
+MODULE_LICENSE("GPL");
+
+module_init(t5400_i2c_init);
+module_exit(t5400_i2c_exit);
diff --git a/drivers/input/misc/t5400-spi.c b/drivers/input/misc/t5400-spi.c
new file mode 100644
index 0000000..c3daf56
--- /dev/null
+++ b/drivers/input/misc/t5400-spi.c
@@ -0,0 +1,128 @@
+/**
+ * Copyright (c) 2012 Epcos/TDK
+ * Copyright (c) 2012 Unixphere
+ *
+ * This driver supports the Epcos/TDK T5400 digital barometric pressure
+ * and temperature sensor
+ *
+ * The datasheet for the T5400 chip can be found here:
+ * http://www.epcos.com/datasheets/C953.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/pm.h>
+#include <linux/t5400.h>
+
+static int __devinit t5400_spi_probe(struct spi_device *client)
+{
+	int error;
+	struct regmap *regmap;
+
+	client->bits_per_word = 8;
+	error = spi_setup(client);
+	if (error < 0) {
+		dev_err(&client->dev, "%s: spi_setup failed!\n", __func__);
+		return error;
+	}
+
+	regmap = devm_regmap_init_spi(client, &t5400_regmap_config);
+	if (IS_ERR(regmap)) {
+		error = PTR_ERR(regmap);
+		dev_err(&client->dev, "%s: failed to init regmap: %d\n",
+					__func__, error);
+		return error;
+	}
+
+	return t5400_probe(&client->dev, regmap);
+}
+
+static void t5400_spi_shutdown(struct spi_device *client)
+{
+	t5400_disable(&client->dev);
+}
+
+static int __devexit t5400_spi_remove(struct spi_device *client)
+{
+	struct t5400_bus *t5400_spi = spi_get_drvdata(client);
+	int error;
+
+	error = t5400_remove(&client->dev);
+	if (error < 0)
+		return error;
+
+	kfree(t5400_spi);
+	return 0;
+}
+
+#if defined(CONFIG_PM)
+static int t5400_spi_suspend(struct device *dev)
+{
+	return t5400_disable(dev);
+}
+
+static int t5400_spi_resume(struct device *dev)
+{
+	return t5400_enable(dev);
+}
+#endif
+
+static UNIVERSAL_DEV_PM_OPS(t5400_spi_pm, t5400_spi_suspend,
+					t5400_spi_resume, NULL);
+
+static const struct of_device_id t5400_of_match[] = {
+	{ .compatible = "tdk-epcos,t5400", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, t5400_of_match);
+
+static const struct spi_device_id t5400_id[] = {
+	{ T5400_DRIVER, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, t5400_id);
+
+static struct spi_driver t5400_spi_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= T5400_DRIVER,
+		.pm	= &t5400_spi_pm,
+		.of_match_table = t5400_of_match
+	},
+	.id_table	= t5400_id,
+	.probe		= t5400_spi_probe,
+	.shutdown	= t5400_spi_shutdown,
+	.remove		= __devexit_p(t5400_spi_remove)
+};
+
+static int __init t5400_spi_init(void)
+{
+	return spi_register_driver(&t5400_spi_driver);
+}
+
+static void __exit t5400_spi_exit(void)
+{
+	spi_unregister_driver(&t5400_spi_driver);
+}
+
+
+MODULE_AUTHOR("Stefan Nilsson <stefan.nilsson@unixphere.com>");
+MODULE_DESCRIPTION("T5400 SPI bus driver");
+MODULE_LICENSE("GPL");
+
+module_init(t5400_spi_init);
+module_exit(t5400_spi_exit);
diff --git a/include/linux/t5400.h b/include/linux/t5400.h
new file mode 100644
index 0000000..aac6520
--- /dev/null
+++ b/include/linux/t5400.h
@@ -0,0 +1,69 @@
+#ifndef _T5400_H
+#define _T5400_H
+/**
+ * Copyright (c) 2012 Epcos/TDK
+ * Copyright (c) 2012 Unixphere
+ *
+ * This driver supports the Epcos/TDK T5400 digital barometric pressure
+ * and temperature sensor
+ *
+ * The datasheet for the T5400 chip can be found here:
+ * http://www.epcos.com/datasheets/C953.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/input.h>
+#include <linux/regmap.h>
+
+#define T5400_DRIVER	"t5400"
+
+/**
+ * enum t5400_op_mode - defines the different operation modes.
+ *
+ * The T5400 supports different operation modes which provides different
+ * accuracy levels (and accompanied conversion time) in terms of RMS noise
+ * performance.
+ */
+enum t5400_op_mode {
+	T5400_OP_MODE_LOW = 0,	/* ~8.8Pa RMS Noise, 2ms conv. time */
+	T5400_OP_MODE_STANDARD,	/* ~6.4Pa RMS Noise, 8ms conv. time */
+	T5400_OP_MODE_HIGH,	/* ~5.0Pa RMS Noise, 16ms conv. time */
+	T5400_OP_MODE_U_HIGH,	/* ~4.4Pa RMS Noise, 64ms conv. time */
+	T5400_OP_MODE_LAST
+};
+
+/**
+ * struct t5400_platform_data - represents platform data for the t5400 driver
+ * @op-mode: operation modes to be set according to enum t5400_op_mode
+ * @gpio-irq: platform gpio pin connected to the t5400 irq pin
+ * @setup_hw: callback for platform-specific t5400 hw initialization,
+ *	where 'activate = 1' initializes and 'activate = 0' de-initializes
+ */
+struct t5400_platform_data {
+	enum t5400_op_mode op-mode;
+	int gpio-irq;
+	int (*setup_hw)(bool activate);
+};
+
+extern struct regmap_config t5400_regmap_config;
+
+int t5400_probe(struct device *dev, struct regmap *regmap);
+int t5400_detect(struct device *dev);
+int t5400_remove(struct device *dev);
+#if defined(CONFIG_PM)
+int t5400_enable(struct device *dev);
+int t5400_disable(struct device *dev);
+#endif
+#endif
-- 
1.7.7.2

