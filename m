From: Donggeun Kim <dg77.kim@samsung.com>
Subject: [PATCH] input: lis3dh: Add driver for lis3dh accelerometer
Date: Tue, 20 Sep 2011 18:52:12 +0900
Message-ID: <1316512332-8336-1-git-send-email-dg77.kim@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44840 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab1ITJxP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 05:53:15 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LRT00KUEFGDX1X0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Tue, 20 Sep 2011 18:53:14 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LRT001YEFGPOK50@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 20 Sep 2011 18:53:13 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, dg77.kim@samsung.com

This patch supports STMicroelectronics LIS3DH accelerometer.

Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/input/misc/Kconfig           |   10 +
 drivers/input/misc/Makefile          |    1 +
 drivers/input/misc/lis3dh.c          |  620 ++++++++++++++++++++++++++++++++++
 include/linux/platform_data/lis3dh.h |  297 ++++++++++++++++
 4 files changed, 928 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/lis3dh.c
 create mode 100644 include/linux/platform_data/lis3dh.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index c9104bb..0f25872 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -527,4 +527,14 @@ config INPUT_XEN_KBDDEV_FRONTEND
 	  To compile this driver as a module, choose M here: the
 	  module will be called xen-kbdfront.
 
+config INPUT_LIS3DH
+	tristate "STMicroelectronics LIS3DH accelerometer sensor"
+	depends on I2C
+	help
+	  Say Y here if you want to support for STMicroelectronics
+	  LIS3DH accelerometer sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called lis3dh.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 299ad5e..276c19a 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
 obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
+obj-$(CONFIG_INPUT_LIS3DH)		+= lis3dh.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
 obj-$(CONFIG_INPUT_MMA8450)		+= mma8450.o
diff --git a/drivers/input/misc/lis3dh.c b/drivers/input/misc/lis3dh.c
new file mode 100644
index 0000000..ca0e851
--- /dev/null
+++ b/drivers/input/misc/lis3dh.c
@@ -0,0 +1,620 @@
+/*
+ *  lis3dh.c - STMicroelectronics three-axes accelerometer
+ *  Datasheet available at:
+ *	http://www.st.com/internet/com/TECHNICAL_RESOURCES/
+ *	     TECHNICAL_LITERATURE/DATASHEET/CD00274221.pdf
+ *
+ *  Copyright (C) 2010 Samsung Electronics
+ *  Donggeun Kim <dg77.kim@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_data/lis3dh.h>
+
+#define LIS3DH_STATUS_REG_AUX	0x07
+#define LIS3DH_OUT_ADC1_L	0x08
+#define LIS3DH_OUT_ADC1_H	0x09
+#define LIS3DH_OUT_ADC2_L	0x0a
+#define LIS3DH_OUT_ADC2_H	0x0b
+#define LIS3DH_OUT_ADC3_L	0x0c
+#define LIS3DH_OUT_ADC3_H	0x0d
+#define LIS3DH_INT_COUNTER_REG	0x0e
+#define LIS3DH_WHO_AM_I		0x0f
+#define LIS3DH_TEMP_CFG_REG	0x1f
+#define LIS3DH_CTRL_REG1	0x20
+#define LIS3DH_CTRL_REG2	0x21
+#define LIS3DH_CTRL_REG3	0x22
+#define LIS3DH_CTRL_REG4	0x23
+#define LIS3DH_CTRL_REG5	0x24
+#define LIS3DH_CTRL_REG6	0x25
+#define LIS3DH_REFERENCE	0x26
+#define LIS3DH_STATUS_REG2	0x27
+#define LIS3DH_OUT_X_L		0x28
+#define LIS3DH_OUT_X_H		0x29
+#define LIS3DH_OUT_Y_L		0x2a
+#define LIS3DH_OUT_Y_H		0x2b
+#define LIS3DH_OUT_Z_L		0x2c
+#define LIS3DH_OUT_Z_H		0x2d
+#define LIS3DH_FIFO_CTRL_REG	0x2e
+#define LIS3DH_FIFO_SRC_REG	0x2f
+#define LIS3DH_INT1_CFG		0x30
+#define LIS3DH_INT1_SRC		0x31
+#define LIS3DH_INT1_THS		0x32
+#define LIS3DH_INT1_DURATION	0x33
+#define LIS3DH_CLICK_CFG	0x38
+#define LIS3DH_CLICK_SRC	0x39
+#define LIS3DH_CLICK_THS	0x3a
+#define LIS3DH_TIME_LIMIT	0x3b
+#define LIS3DH_TIME_LATENCY	0x3c
+#define LIS3DH_TIME_WINDOW	0x3d
+
+#define LIS3DH_FIFO_WTM_MASK	0x80
+#define LIS3DH_FIFO_OVRN_MASK	0x40
+
+#define LIS3DH_MULTI_OUT_X_L	0xa8
+
+#define LIS3DH_DEV_ID		0x33
+
+#define LIS3DH_OUT_MIN_VALUE	(-32768)
+#define LIS3DH_OUT_MAX_VALUE	(32767)
+
+struct lis3dh_chip {
+	struct i2c_client		*client;
+	struct device			*dev;
+	struct input_dev		*idev;
+	struct work_struct		irq_work;
+	struct mutex			lock;
+	struct lis3dh_platform_data	*pdata;
+
+	s16 x;
+	s16 y;
+	s16 z;
+	u8 resume_data_rate;
+	int disabled_irq;
+};
+
+static int lis3dh_set_data_rate(struct lis3dh_chip *chip, u8 val)
+{
+	u8 value;
+	int ret;
+
+	mutex_lock(&chip->lock);
+
+	ret = i2c_smbus_read_byte_data(chip->client, LIS3DH_CTRL_REG1);
+	if (ret < 0)
+		goto out;
+
+	value = ret | val;
+	chip->pdata->data_rate = val;
+	ret = i2c_smbus_write_byte_data(chip->client, LIS3DH_CTRL_REG1, value);
+out:
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static u8 lis3dh_get_data_rate(struct lis3dh_chip *chip)
+{
+	return chip->pdata->data_rate;
+}
+
+static int lis3dh_get_xyz(struct lis3dh_chip *chip)
+{
+	u8 xyz_values[6];
+	s16 temp;
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(chip->client,
+		LIS3DH_MULTI_OUT_X_L, 6, xyz_values);
+	if (ret < 0)
+		goto out;
+
+	temp = (xyz_values[1] << BITS_PER_BYTE) | xyz_values[0];
+	chip->x = temp >> 4;
+	temp = (xyz_values[3] << BITS_PER_BYTE) | xyz_values[2];
+	chip->y = temp >> 4;
+	temp = (xyz_values[5] << BITS_PER_BYTE) | xyz_values[4];
+	chip->z = temp >> 4;
+out:
+	return ret;
+}
+
+static void lis3dh_irq_work(struct work_struct *work)
+{
+	struct lis3dh_chip *chip = container_of(work,
+			struct lis3dh_chip, irq_work);
+	u8 int_src, fifo_src, click_src;
+	int ret;
+
+	mutex_lock(&chip->lock);
+
+	ret = int_src = i2c_smbus_read_byte_data(chip->client, LIS3DH_INT1_SRC);
+	if (ret < 0)
+		goto out;
+
+	ret = fifo_src = i2c_smbus_read_byte_data(chip->client,
+					LIS3DH_FIFO_SRC_REG);
+	if (ret < 0)
+		goto out;
+
+	ret = click_src = i2c_smbus_read_byte_data(chip->client,
+					LIS3DH_CLICK_SRC);
+	if (ret < 0)
+		goto out;
+
+	ret = lis3dh_get_xyz(chip);
+	if (ret < 0)
+		goto out;
+
+	/* Each interrupt source has different value for reporting */
+	if (int_src) {
+		input_report_abs(chip->idev, ABS_MISC, 1);
+		input_report_abs(chip->idev, ABS_MISC, int_src);
+	} else if (fifo_src & (LIS3DH_FIFO_WTM_MASK | LIS3DH_FIFO_OVRN_MASK)) {
+		input_report_abs(chip->idev, ABS_MISC, 2);
+		input_report_abs(chip->idev, ABS_MISC, fifo_src);
+	} else {
+		input_report_abs(chip->idev, ABS_MISC, 3);
+		input_report_abs(chip->idev, ABS_MISC, click_src);
+	}
+
+	input_report_abs(chip->idev, ABS_X, chip->x);
+	input_report_abs(chip->idev, ABS_Y, chip->y);
+	input_report_abs(chip->idev, ABS_Z, chip->z);
+	input_sync(chip->idev);
+
+out:
+	mutex_unlock(&chip->lock);
+	enable_irq(chip->disabled_irq);
+}
+
+static irqreturn_t lis3dh_irq(int irq, void *data)
+{
+	struct lis3dh_chip *chip = data;
+
+	disable_irq_nosync(irq);
+	chip->disabled_irq = irq;
+	schedule_work(&chip->irq_work);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t lis3dh_show_xyz(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct lis3dh_chip *chip = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = lis3dh_get_xyz(chip);
+	mutex_unlock(&chip->lock);
+
+	if (ret < 0)
+		return ret;
+	return sprintf(buf, "%d %d %d\n", chip->x, chip->y, chip->z);
+}
+static DEVICE_ATTR(xyz, S_IRUGO, lis3dh_show_xyz, NULL);
+
+#define LIS3DH_INPUT(name)						\
+static ssize_t lis3dh_store_##name(struct device *dev,			\
+	struct device_attribute *attr, const char *buf, size_t count)	\
+{									\
+	struct lis3dh_chip *chip = dev_get_drvdata(dev);		\
+	unsigned long val;						\
+	int ret;							\
+									\
+	if (!count)							\
+		return -EINVAL;						\
+	ret = strict_strtoul(buf, 10, &val);				\
+	if (ret) {							\
+		dev_err(dev, "fail: conversion %s to number\n", buf);	\
+		return count;						\
+	}								\
+	lis3dh_set_##name(chip, (u8) val);				\
+	return count;							\
+}									\
+static ssize_t lis3dh_show_##name(struct device *dev,			\
+		struct device_attribute *attr, char *buf)		\
+{									\
+	struct lis3dh_chip *chip = dev_get_drvdata(dev);		\
+	int ret = lis3dh_get_##name(chip);				\
+	if (ret < 0)							\
+		return ret;						\
+	return sprintf(buf, "%d\n", ret);				\
+}									\
+static DEVICE_ATTR(name, S_IRUGO | S_IWUSR,				\
+		lis3dh_show_##name, lis3dh_store_##name);
+
+LIS3DH_INPUT(data_rate);
+
+static struct attribute *lis3dh_attributes[] = {
+	&dev_attr_data_rate.attr,
+	&dev_attr_xyz.attr,
+	NULL
+};
+
+static const struct attribute_group lis3dh_group = {
+	.attrs = lis3dh_attributes,
+};
+
+static void lis3dh_unregister_input_device(struct lis3dh_chip *chip)
+{
+	struct i2c_client *client = chip->client;
+
+	if (client->irq > 0)
+		free_irq(client->irq, chip);
+	if (chip->pdata->irq2 > 0)
+		free_irq(chip->pdata->irq2, chip);
+
+	input_unregister_device(chip->idev);
+	chip->idev = NULL;
+}
+
+static int lis3dh_register_input_device(struct lis3dh_chip *chip)
+{
+	struct i2c_client *client = chip->client;
+	struct input_dev *idev;
+	int ret;
+
+	idev = chip->idev = input_allocate_device();
+	if (!idev) {
+		dev_err(&client->dev, "allocating input device failed\n");
+		ret = -ENOMEM;
+		goto error_alloc;
+	}
+
+	idev->name = "LIS3DH accelerometer";
+	idev->id.bustype = BUS_I2C;
+	idev->dev.parent = &client->dev;
+	idev->evbit[0] = BIT_MASK(EV_ABS);
+
+	input_set_abs_params(idev, ABS_MISC, 0,	255, 0, 0);
+	input_set_abs_params(idev, ABS_X, LIS3DH_OUT_MIN_VALUE,
+			     LIS3DH_OUT_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Y, LIS3DH_OUT_MIN_VALUE,
+			     LIS3DH_OUT_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Z, LIS3DH_OUT_MIN_VALUE,
+			     LIS3DH_OUT_MAX_VALUE, 0, 0);
+
+	input_set_drvdata(idev, chip);
+
+	ret = input_register_device(idev);
+	if (ret) {
+		dev_err(&client->dev, "registering input device failed\n");
+		goto error_reg;
+	}
+
+	if (client->irq > 0) {
+		ret = request_threaded_irq(client->irq, NULL, lis3dh_irq,
+			IRQF_TRIGGER_RISING, "LIS3DH accelerometer int1", chip);
+		if (ret) {
+			dev_err(&client->dev, "can't get IRQ %d, ret %d\n",
+					client->irq, ret);
+			goto error_irq1;
+		}
+	}
+
+	if (chip->pdata->irq2 > 0) {
+		ret = request_threaded_irq(chip->pdata->irq2, NULL, lis3dh_irq,
+			IRQF_TRIGGER_RISING, "LIS3DH accelerometer int2", chip);
+		if (ret) {
+			dev_err(&client->dev, "can't get IRQ %d, ret %d\n",
+					chip->pdata->irq2, ret);
+			goto error_irq2;
+		}
+	}
+
+	return 0;
+
+error_irq2:
+	if (client->irq > 0)
+		free_irq(client->irq, chip);
+error_irq1:
+	input_unregister_device(idev);
+error_reg:
+	input_free_device(idev);
+error_alloc:
+	return ret;
+}
+
+static int lis3dh_initialize_chip(struct lis3dh_chip *chip)
+{
+	struct lis3dh_platform_data *pdata = chip->pdata;
+	struct i2c_client *client = chip->client;
+	u8 value;
+	int ret;
+
+	/* TEMP_CFG_REG */
+	value = pdata->adc_enable | pdata->temp_enable | 0;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_TEMP_CFG_REG, value);
+	if (ret < 0)
+		goto out;
+
+	/* CTRL_REG2 */
+	value = pdata->hpmode | pdata->hpcf | pdata->fds |
+		pdata->hpclick | pdata->hpis2 | pdata->hpis1;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_CTRL_REG2, value);
+	if (ret < 0)
+		goto out;
+
+	/* CTRL_REG3 */
+	value = pdata->int1_click_enable | pdata->int1_aoi_enable |
+		pdata->int2_aoi_enable | pdata->int1_drdy_enable |
+		pdata->int2_drdy_enable | pdata->int_wtm_enable |
+		pdata->int_overrun_enable;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_CTRL_REG3, value);
+	if (ret < 0)
+		goto out;
+
+	/* CTRL_REG4 */
+	value = pdata->bdu | pdata->endian | pdata->fullscale |
+		pdata->high_resolution_enable | pdata->selftest |
+		pdata->spi_mode;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_CTRL_REG4, value);
+	if (ret < 0)
+		goto out;
+
+	/* CTRL_REG5 */
+	value = pdata->reboot | pdata->fifo_enable | pdata->int_latch |
+		pdata->int_4d_enable;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_CTRL_REG5, value);
+	if (ret < 0)
+		goto out;
+
+	/* CTRL_REG6 */
+	value = pdata->int2_click_enable | pdata->int_enable |
+		pdata->boot_int1_enable | pdata->high_low_active;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_CTRL_REG6, value);
+	if (ret < 0)
+		goto out;
+
+	/* REFERENCE */
+	value = pdata->reference;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_REFERENCE, value);
+	if (ret < 0)
+		goto out;
+
+	/* FIFO_CTRL_REG */
+	value = pdata->fifo_mode | pdata->trigger_selection |
+		pdata->fifo_trigger_threshold;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_FIFO_CTRL_REG, value);
+	if (ret < 0)
+		goto out;
+
+	/* INT1_CFG */
+	value = pdata->interrupt_mode | pdata->int_z_high_enable |
+		pdata->int_z_low_enable | pdata->int_y_high_enable |
+		pdata->int_y_low_enable | pdata->int_x_high_enable |
+		pdata->int_x_low_enable;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_INT1_CFG, value);
+	if (ret < 0)
+		goto out;
+
+	/* INT1_THS */
+	value = pdata->int_threshold;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_INT1_THS, value);
+	if (ret < 0)
+		goto out;
+
+	/* INT1_DURATION */
+	value = pdata->int_duration;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_INT1_DURATION, value);
+	if (ret < 0)
+		goto out;
+
+	/* CLICK_CFG */
+	value = pdata->z_double_click_enable | pdata->z_single_click_enable |
+		pdata->y_double_click_enable | pdata->y_single_click_enable |
+		pdata->x_double_click_enable | pdata->x_single_click_enable;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_CLICK_CFG, value);
+	if (ret < 0)
+		goto out;
+
+	/* CLICK_THS */
+	value = pdata->click_threshold;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_CLICK_THS, value);
+	if (ret < 0)
+		goto out;
+
+	/* TIME_LIMIT */
+	value = pdata->click_time_limit;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_TIME_LIMIT, value);
+	if (ret < 0)
+		goto out;
+
+	/* TIME_LATENCY */
+	value = pdata->click_time_latency;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_TIME_LATENCY, value);
+	if (ret < 0)
+		goto out;
+
+	/* TIME_WINDOW */
+	value = pdata->click_time_window;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_TIME_WINDOW, value);
+	if (ret < 0)
+		goto out;
+
+	/* CTRL_REG1 */
+	value = pdata->data_rate | pdata->low_power_mode_enable |
+		pdata->zen | pdata->yen | pdata->xen;
+	ret = i2c_smbus_write_byte_data(client, LIS3DH_CTRL_REG1, value);
+out:
+	return ret;
+}
+
+static int __devinit lis3dh_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct lis3dh_chip *chip;
+	struct lis3dh_platform_data *pdata = client->dev.platform_data;
+	int ret = 0;
+
+	if (!pdata) {
+		dev_err(&client->dev, "No platform init data supplied\n");
+		return -ENODEV;
+	}
+
+	chip = kzalloc(sizeof(struct lis3dh_chip), GFP_KERNEL);
+	if (!chip) {
+		dev_err(&client->dev, "Failed to allocate structure\n");
+		return -ENOMEM;
+	}
+	chip->pdata = pdata;
+
+	/* Detect device id */
+	ret = i2c_smbus_read_byte_data(client, LIS3DH_WHO_AM_I);
+	if (ret != LIS3DH_DEV_ID) {
+		dev_err(&client->dev, "Failed to detect device id\n");
+		goto error_devid_detect;
+	}
+
+	chip->client = client;
+
+	i2c_set_clientdata(client, chip);
+	INIT_WORK(&chip->irq_work, lis3dh_irq_work);
+	mutex_init(&chip->lock);
+
+	ret = sysfs_create_group(&client->dev.kobj, &lis3dh_group);
+	if (ret) {
+		dev_err(&client->dev,
+				"Failed to create attribute group\n");
+		goto error_sysfs;
+	}
+
+	ret = lis3dh_register_input_device(chip);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register input device\n");
+		goto error_input;
+	}
+
+	ret = lis3dh_initialize_chip(chip);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to initialize device\n");
+		goto error_init;
+	}
+
+	pm_runtime_set_active(&client->dev);
+
+	dev_info(&client->dev, "%s registered\n", id->name);
+
+	return 0;
+
+error_init:
+	lis3dh_unregister_input_device(chip);
+error_input:
+	sysfs_remove_group(&client->dev.kobj, &lis3dh_group);
+error_devid_detect:
+error_sysfs:
+	kfree(chip);
+
+	return ret;
+}
+
+static int __devexit lis3dh_remove(struct i2c_client *client)
+{
+	struct lis3dh_chip *chip = i2c_get_clientdata(client);
+
+	disable_irq_nosync(client->irq);
+	disable_irq_nosync(chip->pdata->irq2);
+	cancel_work_sync(&chip->irq_work);
+
+	lis3dh_set_data_rate(chip, 0);
+
+	lis3dh_unregister_input_device(chip);
+	sysfs_remove_group(&client->dev.kobj, &lis3dh_group);
+	kfree(chip);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int lis3dh_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lis3dh_chip *chip = i2c_get_clientdata(client);
+
+	if (client->irq)
+		disable_irq_nosync(client->irq);
+	if (chip->pdata->irq2)
+		disable_irq_nosync(chip->pdata->irq2);
+	cancel_work_sync(&chip->irq_work);
+
+	chip->resume_data_rate = chip->pdata->data_rate;
+	lis3dh_set_data_rate(chip, 0);
+
+	return 0;
+}
+
+static int lis3dh_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lis3dh_chip *chip = i2c_get_clientdata(client);
+
+	chip->pdata->data_rate = chip->resume_data_rate;
+	lis3dh_initialize_chip(chip);
+
+	if (client->irq)
+		enable_irq(client->irq);
+	if (chip->pdata->irq2)
+		enable_irq(chip->pdata->irq2);
+
+	return 0;
+}
+
+static const struct dev_pm_ops lis3dh_dev_pm_ops = {
+	.suspend		= lis3dh_suspend,
+	.resume			= lis3dh_resume,
+};
+
+#define LIS3DH_DEV_PM_OPS	(&lis3dh_dev_pm_ops)
+#else
+#define LIS3DH_DEV_PM_OPS	NULL
+#endif
+
+static const struct i2c_device_id lis3dh_id[] = {
+	{ "LIS3DH", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lis3dh_id);
+
+static struct i2c_driver lis3dh_i2c_driver = {
+	.driver = {
+		.name	= "LIS3DH",
+		.pm	= LIS3DH_DEV_PM_OPS,
+	},
+	.probe		= lis3dh_probe,
+	.remove		= __exit_p(lis3dh_remove),
+	.id_table	= lis3dh_id,
+};
+
+static int __init lis3dh_init(void)
+{
+	return i2c_add_driver(&lis3dh_i2c_driver);
+}
+module_init(lis3dh_init);
+
+static void __exit lis3dh_exit(void)
+{
+	i2c_del_driver(&lis3dh_i2c_driver);
+}
+module_exit(lis3dh_exit);
+
+MODULE_AUTHOR("Donggeun Kim <dg77.kim@samsung.com>");
+MODULE_DESCRIPTION("LIS3DH accelerometer driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/lis3dh.h b/include/linux/platform_data/lis3dh.h
new file mode 100644
index 0000000..954318f
--- /dev/null
+++ b/include/linux/platform_data/lis3dh.h
@@ -0,0 +1,297 @@
+/*
+ *  lis3dh.h - STMicroelectronics three-axes accelerometer
+ *  Datasheet available at:
+ *	http://www.st.com/internet/com/TECHNICAL_RESOURCES/
+ *	     TECHNICAL_LITERATURE/DATASHEET/CD00274221.pdf
+ *
+ *  Copyright (C) 2010 Samsung Electronics
+ *  Donggeun Kim <dg77.kim@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LIS3DH_H_
+#define _LIS3DH_H_
+
+enum lis3dh_ouput_data_rate {
+	LIS3DH_ODR_POWER_DOWN = 0x00,
+	LIS3DH_ODR_1HZ = 0x10,
+	LIS3DH_ODR_10HZ = 0x20,
+	LIS3DH_ODR_25HZ = 0x30,
+	LIS3DH_ODR_50HZ = 0x40,
+	LIS3DH_ODR_100HZ = 0x50,
+	LIS3DH_ODR_200HZ = 0x60,
+	LIS3DH_ODR_400HZ = 0x70,
+	LIS3DH_ODR_1620HZ = 0x80,
+	LIS3DH_ODR_5376HZ = 0x90,
+};
+
+enum lis3dh_high_pass_filter_mode {
+	LIS3DH_REFERENCE_SIGNAL = 0x40,
+	LIS3DH_NORMAL_MODE = 0x80,
+	LIS3DH_AUTORESET_ON_INTERRUPT = 0xc0,
+};
+
+enum lis3dh_scale_range {
+	LIS3DH_RANGE_2G = 0x00,
+	LIS3DH_RANGE_4G = 0x10,
+	LIS3DH_RANGE_8G = 0x20,
+	LIS3DH_RANGE_16G = 0x30,
+};
+
+enum lis3dh_self_test {
+	LIS3DH_NORMAL = 0x00,
+	LIS3DH_SELF_TEST0 = 0x02,
+	LIS3DH_SELF_TEST1 = 0x04,
+};
+
+enum lis3dh_fifo_mode {
+	LIS3DH_BYPASS_MODE = 0x00,
+	LIS3DH_FIFO_MODE = 0x40,
+	LIS3DH_STREAM_MODE = 0x80,
+	LIS3DH_TRIGGER_MODE = 0xc0,
+};
+
+enum lis3dh_interrupt_mode {
+	LIS3DH_OR_COMBINATION = 0x00,
+	LIS3DH_6D_MOVEMENT = 0x40,
+	LIS3DH_AND_COMBINATION = 0x80,
+	LIS3DH_6D_POSITION = 0xc0,
+};
+
+/**
+ * struct lis3dh_platform_data
+ * @irq2: GPIO for second interrupt line
+ * @adc_enable: enable ADC
+ *	0: ADC disabled
+ *	0x80: ADC enabled
+ * @temp_enable: enable temperature sensor
+ *	0: disabled
+ *	0x40: enabled
+ * @data_rate: data rate selection
+ *	select one from 'enum lis3dh_ouput_data_rate'
+ * @low_power_mode_enable: low power mode enable
+ *	0: normal mode
+ *	0x8: low power mode
+ * @zen: Z-axis enable
+ *	0: Z-axis disabled
+ *	0x4: Z-axis enabled
+ * @yen: Y-axis enable
+ *	0: Y-axis disabled
+ *	0x2: Y-axis enabled
+ * @xen: X-axis enable
+ *	0: X-axis disabled
+ *	0x1: X-axis enabled
+ * @hpmode: high pass filter mode selection
+ *	select one from 'enum lis3dh_high_pass_filter_mode'
+ * @hpcf: high pass filter cut off frequency selection
+ *	select one from [0, 0x10, 0x20, 0x30]
+ * @fds: filtered data selection
+ *	0: internal filter bypassed
+ *	0x8: data from internal filter sent to output register and FIFO
+ * @hpclick: high pass filter enabled for CLICK function
+ *	0: filter bypassed
+ *	0x4: filter enabled
+ * @hpis2: high pass filter enabled for AOI function on interrupt 2
+ *	0: filter bypassed
+ *	0x2: filter enabled
+ * @hpis1: high pass filter enabled for AOI function on interrupt 1
+ *	0: filter bypassed
+ *	0x1: filter enabled
+ * @int1_click_enable: CLICK interrupt on INT1
+ *	0: disable
+ *	0x80: enable
+ * @int1_aoi_enable: AOI interrupt on INT1
+ *	0: disable
+ *	0x40: enable
+ * @int2_aoi_enable: AOI interrupt on INT2
+ *	0: disable
+ *	0x20: enable
+ * @int1_drdy_enable: DRDY interrupt on INT1
+ *	0: disable
+ *	0x10: enable
+ * @int2_drdy_enable: DRDY interrupt on INT2
+ *	0: disable
+ *	0x8: enable
+ * @int_wtm_enable: FIFO watermark interrupt
+ *	0: disable
+ *	0x4: enable
+ * @int_overrun_enable: FIFO overrun interrupt
+ *	0: disable
+ *	0x2: enable
+ * @bdu: block data update
+ *	0: continuous update
+ *	0x80: output registers not updated until MSB and LSB reading
+ * @endian: big/little endian data selection
+ *	0: data LSB at lower address
+ *	0x40: data MSB at lower address
+ * @fullscale: Full scale selection
+ *	select one from 'enum lis3dh_scale_range'
+ * @high_resolution_enable: high resolution output mode
+ *	0: high resolution disable
+ *	0x8: high resolution enable
+ * @selftest: self test enable
+ *	select one from 'enum lis3dh_self_test'
+ * @spi_mode: SPI serial interface mode selection
+ *	0: four-wire interface
+ *	1: three-wire interface
+ * @reboot: reboot memory content
+ *	0: normal mode
+ *	0x80: reboot memory content
+ * @fifo_enable: FIFO enable
+ *	0: FIFO disable
+ *	0x40: FIFO enable
+ * @int_latch: latch interrupt request
+ *	0: interrupt request not latched
+ *	0x8: interrupt request latched
+ * @int_4d_enable: 4D enable
+ *	0: disable
+ *	0x4: enable when 6D bit on INT1_CFG is set to 1
+ * @int2_click_enable: CLICK interrupt on INT2
+ *	0: disable
+ *	0x80: enable
+ * @int_enable: interrupt enable
+ *	0: disable
+ *	0x40: enable
+ * @boot_int1_enable: boot status available on INT1
+ *	0: disable
+ *	0x10: enable
+ * @high_low_active: interrupt active configuration on INT
+ *	0: high
+ *	0x2: low
+ * @reference: reference value for interrupt generation
+ *	[0, 0xff]
+ * @fifo_mode: FIFO mode selection
+ *	select one from 'enum lis3dh_fifo_mode'
+ * @trigger_selection: trigger selection
+ *	0: trigger signal on INT1
+ *	0x20: trigger signal on INT2
+ * @fifo_trigger_threshold: FIFO trigger threshold
+ *	[0, 0x1f]
+ * @interrupt_mode: interrupt mode
+ *	select one from 'enum lis3dh_interrupt_mode'
+ * @int_z_high_enable: enable interrupt generation on Z high event
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @int_z_low_enable: enable interrupt generation on Z low event
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @int_y_high_enable: enable interrupt generation on Y high event
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @int_y_low_enable: enable interrupt generation on Y low event
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @int_x_high_enable: enable interrupt generation on X high event
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @int_x_low_enable: enable interrupt generation on X low event
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @int_threshold: interrupt threshold
+ *	[0, 0x7f]
+ * @int_duration: the minimum duration of the interrupt event to be recognized
+ *	[0, 0x7f]
+ * @z_double_click_enable: enable interrupt double CLICK on Z-axis
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @z_single_click_enable: enable interrupt single CLICK on Z-axis
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @y_double_click_enable: enable interrupt double CLICK on Y-axis
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @y_single_click_enable: enable interrupt single CLICK on Y-axis
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @x_double_click_enable: enable interrupt double CLICK on X-axis
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @x_single_click_enable: enable interrupt single CLICK on X-axis
+ *	0: disable interrupt request
+ *	1: enable interrupt request
+ * @click_threshold: CLICK interrupt threshold
+ *	[0, 0x7f]
+ * @click_time_limit: CLICK interrupt time limit
+ *	[0, 0x7f]
+ * @click_time_latency: CLICK interrupt time latency
+ *	[0, 0xff]
+ * @click_time_window: CLICK interrupt time window
+ *	[0, 0xff]
+ */
+struct lis3dh_platform_data {
+	int irq2;
+
+	u8 adc_enable;
+	u8 temp_enable;
+
+	u8 data_rate;
+	u8 low_power_mode_enable;
+	u8 zen;
+	u8 yen;
+	u8 xen;
+
+	u8 hpmode;
+	u8 hpcf;
+	u8 fds;
+	u8 hpclick;
+	u8 hpis2;
+	u8 hpis1;
+
+	u8 int1_click_enable;
+	u8 int1_aoi_enable;
+	u8 int2_aoi_enable;
+	u8 int1_drdy_enable;
+	u8 int2_drdy_enable;
+	u8 int_wtm_enable;
+	u8 int_overrun_enable;
+
+	u8 bdu;
+	u8 endian;
+	u8 fullscale;
+	u8 high_resolution_enable;
+	u8 selftest;
+	u8 spi_mode;
+
+	u8 reboot;
+	u8 fifo_enable;
+	u8 int_latch;
+	u8 int_4d_enable;
+
+	u8 int2_click_enable;
+	u8 int_enable;
+	u8 boot_int1_enable;
+	u8 high_low_active;
+
+	u8 reference;
+
+	u8 fifo_mode;
+	u8 trigger_selection;
+	u8 fifo_trigger_threshold;
+
+	u8 interrupt_mode;
+	u8 int_z_high_enable;
+	u8 int_z_low_enable;
+	u8 int_y_high_enable;
+	u8 int_y_low_enable;
+	u8 int_x_high_enable;
+	u8 int_x_low_enable;
+	u8 int_threshold;
+	u8 int_duration;
+
+	u8 z_double_click_enable;
+	u8 z_single_click_enable;
+	u8 y_double_click_enable;
+	u8 y_single_click_enable;
+	u8 x_double_click_enable;
+	u8 x_single_click_enable;
+
+	u8 click_threshold;
+	u8 click_time_limit;
+	u8 click_time_latency;
+	u8 click_time_window;
+};
+
+#endif
-- 
1.7.4.1

