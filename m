From: chris.hudson.comp.eng@gmail.com
Subject: [PATCH v5] input: Initial support for Kionix KXTJ9 accelerometer
Date: Tue, 28 Jun 2011 15:12:28 -0400
Message-ID: <1309288348-30735-1-git-send-email-chris.hudson.comp.eng@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kionix.com ([66.152.113.154]:45375 "EHLO mail.kionix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab1F1TYI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jun 2011 15:24:08 -0400
Received: from mail1.kionix.com (localhost [127.0.0.1])
	by mail.kionix.com (Spam Firewall) with ESMTP id AA762279673
	for <linux-input@vger.kernel.org>; Tue, 28 Jun 2011 15:11:32 -0400 (EDT)
Received: from mail1.kionix.com ([10.0.0.125]) by mail.kionix.com with ESMTP id 8X0QhFl5zBaEEXyV for <linux-input@vger.kernel.org>; Tue, 28 Jun 2011 15:11:32 -0400 (EDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>

From: Chris Hudson <chudson@kionix.com>

- Added Dmitry's changes
- Now using input_polled_dev interface when in polling mode
- IRQ mode provides a separate sysfs node to change the hardware data rate

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 drivers/input/misc/Kconfig  |   17 ++
 drivers/input/misc/Makefile |    1 +
 drivers/input/misc/kxtj9.c  |  646 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/input/kxtj9.h |   76 +++++
 4 files changed, 740 insertions(+), 0 deletions(-)
 create mode 100755 drivers/input/misc/kxtj9.c
 create mode 100755 include/linux/input/kxtj9.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 45dc6aa..cd6a806 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -478,4 +478,21 @@ config INPUT_XEN_KBDDEV_FRONTEND
 	  To compile this driver as a module, choose M here: the
 	  module will be called xen-kbdfront.
 
+config INPUT_KXTJ9
+       tristate "Kionix KXTJ9 tri-axis digital accelerometer"
+       depends on I2C
+       help
+         If you say yes here you get support for the Kionix KXTJ9 digital
+         tri-axis accelerometer.
+
+         This driver can also be built as a module.  If so, the module
+         will be called kxtj9.
+
+config KXTJ9_POLLED_MODE
+       bool "Enable polling mode support"
+       depends on INPUT_KXTJ9
+       select INPUT_POLLDEV
+       help
+         Say Y here if you need accelerometer to work in polling mode.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 38efb2c..bfe1057 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
+obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
 obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 0000000..7faf155
--- /dev/null
+++ b/drivers/input/misc/kxtj9.c
@@ -0,0 +1,646 @@
+/*
+ * Copyright (C) 2011 Kionix, Inc.
+ * Written by Chris Hudson <chudson@kionix.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307, USA
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/input/kxtj9.h>
+#include <linux/input-polldev.h>
+
+#define NAME			"kxtj9"
+#define G_MAX			8000
+/* OUTPUT REGISTERS */
+#define XOUT_L			0x06
+#define WHO_AM_I		0x0F
+/* CONTROL REGISTERS */
+#define INT_REL			0x1A
+#define CTRL_REG1		0x1B
+#define INT_CTRL1		0x1E
+#define DATA_CTRL		0x21
+/* CONTROL REGISTER 1 BITS */
+#define PC1_OFF			0x7F
+#define PC1_ON			(1 << 7)
+/* Data ready funtion enable bit: set during probe if using irq mode */
+#define DRDYE			(1 << 5)
+/* INTERRUPT CONTROL REGISTER 1 BITS */
+/* Set these during probe if using irq mode */
+#define KXTJ9_IEL		(1 << 3)
+#define KXTJ9_IEA		(1 << 4)
+#define KXTJ9_IEN		(1 << 5)
+/* INPUT_ABS CONSTANTS */
+#define FUZZ			3
+#define FLAT			3
+/* RESUME STATE INDICES */
+#define RES_DATA_CTRL		0
+#define RES_CTRL_REG1		1
+#define RES_INT_CTRL1		2
+#define RESUME_ENTRIES		3
+
+/*
+ * The following table lists the maximum appropriate poll interval for each
+ * available output data rate.
+ */
+static const struct {
+	unsigned int cutoff;
+	u8 mask;
+} kxtj9_odr_table[] = {
+	{ 3,	ODR800F },
+	{ 5,	ODR400F },
+	{ 10,	ODR200F },
+	{ 20,	ODR100F },
+	{ 40,	ODR50F  },
+	{ 80,	ODR25F  },
+	{ 0,	ODR12_5F},
+};
+
+struct kxtj9_data {
+	struct i2c_client *client;
+	struct kxtj9_platform_data pdata;
+	struct input_dev *input_dev;
+#ifdef CONFIG_KXTJ9_POLLED_MODE
+	struct input_polled_dev *poll_dev;
+#else
+	struct mutex lock;
+#endif
+	unsigned int last_poll_interval;
+	u8 shift;
+	u8 ctrl_reg1;
+	u8 data_ctrl;
+	u8 int_ctrl;
+};
+
+static int kxtj9_i2c_read(struct kxtj9_data *tj9, u8 addr, u8 *data, int len)
+{
+	struct i2c_msg msgs[] = {
+		{
+			.addr = tj9->client->addr,
+			.flags = tj9->client->flags,
+			.len = 1,
+			.buf = &addr,
+		},
+		{
+			.addr = tj9->client->addr,
+			.flags = tj9->client->flags | I2C_M_RD,
+			.len = len,
+			.buf = data,
+		},
+	};
+
+	return i2c_transfer(tj9->client->adapter, msgs, 2);
+}
+
+static void kxtj9_report_acceleration_data(struct kxtj9_data *tj9)
+{
+	s16 acc_data[3]; /* Data bytes from hardware xL, xH, yL, yH, zL, zH */
+	s16 x, y, z;
+	int err;
+
+	err = kxtj9_i2c_read(tj9, XOUT_L, (u8 *)acc_data, 6);
+	if (err < 0)
+		dev_err(&tj9->client->dev, "accelerometer data read failed\n");
+
+	x = le16_to_cpu(acc_data[0]) >> tj9->shift;
+	y = le16_to_cpu(acc_data[1]) >> tj9->shift;
+	z = le16_to_cpu(acc_data[2]) >> tj9->shift;
+
+	input_report_abs(tj9->input_dev, ABS_X, tj9->pdata.negate_x ? -x : x);
+	input_report_abs(tj9->input_dev, ABS_Y, tj9->pdata.negate_y ? -y : y);
+	input_report_abs(tj9->input_dev, ABS_Z, tj9->pdata.negate_x ? -y : y);
+	input_sync(tj9->input_dev);
+}
+
+static int kxtj9_update_g_range(struct kxtj9_data *tj9, u8 new_g_range)
+{
+	switch (new_g_range) {
+	case KXTJ9_G_2G:
+		tj9->shift = SHIFT_ADJ_2G;
+		break;
+
+	case KXTJ9_G_4G:
+		tj9->shift = SHIFT_ADJ_4G;
+		break;
+
+	case KXTJ9_G_8G:
+		tj9->shift = SHIFT_ADJ_8G;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	tj9->ctrl_reg1 &= 0xe7;
+	tj9->ctrl_reg1 |= new_g_range;
+
+	return 0;
+}
+
+static int kxtj9_update_odr(struct kxtj9_data *tj9, int poll_interval)
+{
+	int err;
+	int i;
+
+	/* Use the lowest ODR that can support the requested poll interval */
+	for (i = 0; i < ARRAY_SIZE(kxtj9_odr_table); i++) {
+		tj9->data_ctrl = kxtj9_odr_table[i].mask;
+		if (poll_interval < kxtj9_odr_table[i].cutoff)
+			break;
+	}
+
+	err = i2c_smbus_write_byte_data(tj9->client, CTRL_REG1, 0);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_write_byte_data(tj9->client, DATA_CTRL, tj9->data_ctrl);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_write_byte_data(tj9->client, CTRL_REG1, tj9->ctrl_reg1);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int kxtj9_device_power_on(struct kxtj9_data *tj9)
+{
+	int err;
+
+	if (tj9->pdata.power_on) {
+		err = tj9->pdata.power_on();
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static void kxtj9_device_power_off(struct kxtj9_data *tj9)
+{
+	int err;
+
+	tj9->ctrl_reg1 &= PC1_OFF;
+	err = i2c_smbus_write_byte_data(tj9->client, CTRL_REG1, tj9->ctrl_reg1);
+	if (err < 0)
+		dev_err(&tj9->client->dev, "soft power off failed\n");
+
+	if (tj9->pdata.power_off)
+		tj9->pdata.power_off();
+}
+
+static int kxtj9_enable(struct kxtj9_data *tj9)
+{
+	int err;
+
+	err = kxtj9_device_power_on(tj9);
+	if (err < 0)
+		return err;
+
+	/* ensure that PC1 is cleared before updating control registers */
+	err = i2c_smbus_write_byte_data(tj9->client, CTRL_REG1, 0);
+	if (err < 0)
+		return err;
+
+	/* only write INT_CTRL_REG1 if in irq mode */
+	if (tj9->client->irq) {
+		err = i2c_smbus_write_byte_data(tj9->client,
+						INT_CTRL1, tj9->int_ctrl);
+		if (err < 0)
+			return err;
+	}
+
+	err = kxtj9_update_g_range(tj9, tj9->pdata.g_range);
+	if (err < 0)
+		return err;
+
+	/* turn on outputs */
+	tj9->ctrl_reg1 |= PC1_ON;
+	err = i2c_smbus_write_byte_data(tj9->client, CTRL_REG1, tj9->ctrl_reg1);
+	if (err < 0)
+		return err;
+
+	err = kxtj9_update_odr(tj9, tj9->last_poll_interval);
+	if (err < 0)
+		return err;
+
+	/* clear initial interrupt if in irq mode */
+	if (tj9->client->irq) {
+		err = i2c_smbus_read_byte_data(tj9->client, INT_REL);
+		if (err < 0) {
+			dev_err(&tj9->client->dev,
+					"error clearing interrupt: %d\n", err);
+			goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	kxtj9_device_power_off(tj9);
+	return err;
+}
+
+static void __devinit kxtj9_init_input_device(struct kxtj9_data *tj9,
+						struct input_dev *input_dev)
+{
+	__set_bit(EV_ABS, input_dev->evbit);
+	input_set_abs_params(input_dev, ABS_X, -G_MAX, G_MAX, FUZZ, FLAT);
+	input_set_abs_params(input_dev, ABS_Y, -G_MAX, G_MAX, FUZZ, FLAT);
+	input_set_abs_params(input_dev, ABS_Z, -G_MAX, G_MAX, FUZZ, FLAT);
+
+	input_dev->name = "kxtj9_accel";
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->dev.parent = &tj9->client->dev;
+}
+
+#ifdef CONFIG_KXTJ9_POLLED_MODE
+static void kxtj9_poll(struct input_polled_dev *dev)
+{
+	struct kxtj9_data *tj9 = dev->private;
+	unsigned int poll_interval = dev->poll_interval;
+
+	kxtj9_report_acceleration_data(tj9);
+
+	if (poll_interval != tj9->last_poll_interval) {
+		kxtj9_update_odr(tj9, poll_interval);
+		tj9->last_poll_interval = poll_interval;
+	}
+}
+
+static void kxtj9_polled_input_open(struct input_polled_dev *dev)
+{
+	struct kxtj9_data *tj9 = dev->private;
+
+	kxtj9_enable(tj9);
+}
+
+static void kxtj9_polled_input_close(struct input_polled_dev *dev)
+{
+	struct kxtj9_data *tj9 = dev->private;
+
+	kxtj9_device_power_off(tj9);
+}
+
+static int __devinit kxtj9_setup_polled_device(struct kxtj9_data *tj9)
+{
+	int err;
+	struct input_polled_dev *poll_dev;
+	poll_dev = input_allocate_polled_device();
+
+	if (!poll_dev) {
+		dev_err(&tj9->client->dev,
+			"Failed to allocate polled device\n");
+		return -ENOMEM;
+	}
+
+	tj9->poll_dev = poll_dev;
+	tj9->input_dev = poll_dev->input;
+
+	poll_dev->private = tj9;
+	poll_dev->poll = kxtj9_poll;
+	poll_dev->open = kxtj9_polled_input_open;
+	poll_dev->close = kxtj9_polled_input_close;
+
+	kxtj9_init_input_device(tj9, poll_dev->input);
+
+	err = input_register_polled_device(poll_dev);
+	if (err) {
+		dev_err(&tj9->client->dev,
+			"Unable to register polled device, err=%d\n", err);
+		input_free_polled_device(poll_dev);
+		return 0;
+	}
+
+	return 0;
+}
+
+static void kxtj9_teardown_polled_device(struct kxtj9_data *tj9)
+{
+	input_unregister_polled_device(tj9->poll_dev);
+	input_free_polled_device(tj9->poll_dev);
+}
+
+#else	/* IRQ Mode is enabled */
+static int kxtj9_input_open(struct input_dev *input)
+{
+	struct kxtj9_data *tj9 = input_get_drvdata(input);
+
+	return kxtj9_enable(tj9);
+}
+
+static void kxtj9_input_close(struct input_dev *dev)
+{
+	struct kxtj9_data *tj9 = input_get_drvdata(dev);
+
+	kxtj9_device_power_off(tj9);
+}
+
+static int __devinit kxtj9_setup_input_device(struct kxtj9_data *tj9)
+{
+	struct input_dev *input_dev;
+	int err;
+
+	input_dev = input_allocate_device();
+	if (!tj9->input_dev) {
+		dev_err(&tj9->client->dev, "input device allocate failed\n");
+		return -ENOMEM;
+	}
+
+	tj9->input_dev = input_dev;
+
+	input_dev->open = kxtj9_input_open;
+	input_dev->close = kxtj9_input_close;
+	input_set_drvdata(input_dev, tj9);
+
+	kxtj9_init_input_device(tj9, input_dev);
+
+	err = input_register_device(tj9->input_dev);
+	if (err) {
+		dev_err(&tj9->client->dev,
+			"unable to register input polled device %s: %d\n",
+			tj9->input_dev->name, err);
+		input_free_device(tj9->input_dev);
+	}
+
+	return 0;
+}
+
+static irqreturn_t kxtj9_isr(int irq, void *dev)
+{
+	struct kxtj9_data *tj9 = dev;
+	int err;
+
+	/* data ready is the only possible interrupt type */
+	kxtj9_report_acceleration_data(tj9);
+
+	err = i2c_smbus_read_byte_data(tj9->client, INT_REL);
+	if (err < 0)
+		dev_err(&tj9->client->dev,
+				"error clearing interrupt status: %d\n", err);
+
+	return IRQ_HANDLED;
+}
+
+static inline int kxtj9_setup_polled_device(struct kxtj9_data *tj9)
+{
+	return -ENOSYS;
+}
+
+static inline void kxtj9_teardown_polled_device(struct kxtj9_data *tj9)
+{
+}
+
+/* kxtj9_get_poll: returns the currently selected poll interval (in ms) */
+static ssize_t kxtj9_get_poll(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct kxtj9_data *tj9 = i2c_get_clientdata(to_i2c_client(dev));
+	return sprintf(buf, "%d\n", tj9->last_poll_interval);
+}
+
+/* kxtj9_set_poll: allows the user to select a new poll interval (in ms) */
+static ssize_t kxtj9_set_poll(struct device *dev, struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct kxtj9_data *tj9 = i2c_get_clientdata(to_i2c_client(dev));
+
+	unsigned long interval;
+	int ret = kstrtoul(buf, 10, &interval);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&tj9->lock);
+	/* set current interval to the greater of the minimum interval or
+	the requested interval */
+	tj9->last_poll_interval = max((int)interval, tj9->pdata.min_interval);
+	mutex_unlock(&tj9->lock);
+
+	kxtj9_update_odr(tj9, tj9->last_poll_interval);
+
+	return count;
+}
+/* When IRQ mode is selected, we need to provide an interface to allow the user
+ * to change the output data rate of the part.  For consistency, we are using
+ * the set_poll method, which accepts a poll interval in milliseconds, and then
+ * calls update_odr() while passing this value as an argument.  In IRQ mode, the
+ * data outputs will not be read AT the requested poll interval, rather, the
+ * lowest ODR that can support the requested interval.  The client application
+ * will be responsible for retrieving data from the input node at the desired
+ * interval.
+ */
+static DEVICE_ATTR(poll, S_IRUGO|S_IWUSR, kxtj9_get_poll, kxtj9_set_poll);
+
+static struct attribute *kxtj9_attributes[] = {
+	&dev_attr_poll.attr,
+	NULL
+};
+
+static struct attribute_group kxtj9_attribute_group = {
+	.attrs = kxtj9_attributes
+};
+#endif
+
+static int __devinit kxtj9_verify(struct kxtj9_data *tj9)
+{
+	int retval;
+	retval = kxtj9_device_power_on(tj9);
+	if (retval < 0)
+		return retval;
+	retval = i2c_smbus_read_byte_data(tj9->client, WHO_AM_I);
+	if (retval < 0) {
+		dev_err(&tj9->client->dev, "read err int source\n");
+		goto out;
+	}
+	retval = retval != 0x06 ? -EIO : 0;
+
+out:
+	kxtj9_device_power_off(tj9);
+	return retval;
+}
+
+static int __devinit kxtj9_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	const struct kxtj9_platform_data *pdata = client->dev.platform_data;
+	struct kxtj9_data *tj9;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter,
+				I2C_FUNC_I2C | I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_err(&client->dev, "client is not i2c capable\n");
+		return -ENXIO;
+	}
+	if (!pdata) {
+		dev_err(&client->dev, "platform data is NULL; exiting\n");
+		return -EINVAL;
+	}
+	tj9 = kzalloc(sizeof(*tj9), GFP_KERNEL);
+	if (!tj9) {
+		dev_err(&client->dev,
+			"failed to allocate memory for module data\n");
+		return -ENOMEM;
+	}
+
+	tj9->client = client;
+	tj9->pdata = *pdata;
+
+	if (pdata->init) {
+		err = pdata->init();
+		if (err < 0)
+			goto err_free_mem;
+	}
+
+	err = kxtj9_verify(tj9);
+	if (err < 0) {
+		dev_err(&client->dev, "device not recognized\n");
+		goto err_pdata_exit;
+	}
+
+	tj9->ctrl_reg1 = tj9->pdata.res_12bit | tj9->pdata.g_range;
+	tj9->data_ctrl = tj9->pdata.data_odr_init;
+
+#ifdef CONFIG_KXTJ9_POLLED_MODE
+	err = kxtj9_setup_polled_device(tj9);
+	if (err)
+		goto err_pdata_exit;
+#else
+	/* If in irq mode, populate INT_CTRL_REG1 and enable DRDY. */
+	tj9->int_ctrl |= KXTJ9_IEN | KXTJ9_IEA | KXTJ9_IEL;
+	tj9->ctrl_reg1 |= DRDYE;
+
+	err = kxtj9_setup_input_device(tj9);
+	if (err)
+		goto err_pdata_exit;
+
+	err = request_threaded_irq(client->irq, NULL, kxtj9_isr,
+				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				"kxtj9-irq", tj9);
+	if (err) {
+		dev_err(&client->dev, "request irq failed: %d\n", err);
+		goto err_destroy_input;
+	}
+	err = sysfs_create_group(&client->dev.kobj, &kxtj9_attribute_group);
+	if (err) {
+		dev_err(&client->dev, "sysfs create failed: %d\n", err);
+		goto err_destroy_input;
+	}
+#endif
+	i2c_set_clientdata(client, tj9);
+	return 0;
+
+#ifndef CONFIG_KXTJ9_POLLED_MODE
+err_destroy_input:
+	input_unregister_device(tj9->input_dev);
+#endif
+err_pdata_exit:
+	if (tj9->pdata.exit)
+		tj9->pdata.exit();
+err_free_mem:
+	kfree(tj9);
+	return err;
+}
+
+static int __devexit kxtj9_remove(struct i2c_client *client)
+{
+	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
+
+#ifdef CONFIG_KXTJ9_POLLED_MODE
+	kxtj9_teardown_polled_device(tj9);
+#else
+	sysfs_remove_group(&client->dev.kobj, &kxtj9_attribute_group);
+	free_irq(client->irq, tj9);
+	input_unregister_device(tj9->input_dev);
+#endif
+	if (tj9->pdata.exit)
+		tj9->pdata.exit();
+
+	kfree(tj9);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int kxtj9_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
+	struct input_dev *input_dev = tj9->input_dev;
+
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users)
+		kxtj9_device_power_off(tj9);
+
+	mutex_unlock(&input_dev->mutex);
+	return 0;
+}
+
+static int kxtj9_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
+	struct input_dev *input_dev = tj9->input_dev;
+	int retval = 0;
+
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users)
+		kxtj9_enable(tj9);
+
+	mutex_unlock(&input_dev->mutex);
+	return retval;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(kxtj9_pm_ops, kxtj9_suspend, kxtj9_resume);
+
+static const struct i2c_device_id kxtj9_id[] = {
+	{ NAME, 0 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(i2c, kxtj9_id);
+
+static struct i2c_driver kxtj9_driver = {
+	.driver = {
+		  .name = NAME,
+		  .owner = THIS_MODULE,
+		  .pm = &kxtj9_pm_ops,
+	},
+	.probe = kxtj9_probe,
+	.remove = __devexit_p(kxtj9_remove),
+	.id_table = kxtj9_id,
+};
+
+static int __init kxtj9_init(void)
+{
+	return i2c_add_driver(&kxtj9_driver);
+}
+module_init(kxtj9_init);
+
+static void __exit kxtj9_exit(void)
+{
+	i2c_del_driver(&kxtj9_driver);
+}
+module_exit(kxtj9_exit);
+
+MODULE_DESCRIPTION("KXTJ9 accelerometer driver");
+MODULE_AUTHOR("Chris Hudson <chudson@kionix.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/input/kxtj9.h b/include/linux/input/kxtj9.h
index 0000000..cc5928b
--- /dev/null
+++ b/include/linux/input/kxtj9.h
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2011 Kionix, Inc.
+ * Written by Chris Hudson <chudson@kionix.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307, USA
+ */
+
+#ifndef __KXTJ9_H__
+#define __KXTJ9_H__
+
+#define KXTJ9_I2C_ADDR		0x0F
+
+/* These shift values are used to provide consistent output data */
+#define SHIFT_ADJ_2G		4
+#define SHIFT_ADJ_4G		3
+#define SHIFT_ADJ_8G		2
+
+#ifdef __KERNEL__
+struct kxtj9_platform_data {
+	int poll_interval;	/* current poll interval (in milli-seconds) */
+	int min_interval;	/* minimum poll interval (in milli-seconds) */
+
+	/* by default, x is axis 0, y is axis 1, z is axis 2; these can be
+	changed to account for sensor orientation within the host device */
+	u8 axis_map_x;
+	u8 axis_map_y;
+	u8 axis_map_z;
+
+	/* each axis can be negated to account for sensor orientation within
+	the host device; 1 = negate this axis; 0 = do not negate this axis */
+	bool negate_x;
+	bool negate_y;
+	bool negate_z;
+
+	/* CTRL_REG1: set resolution, g-range, data ready enable */
+	/* Output resolution: 8-bit valid or 12-bit valid */
+	#define RES_8BIT		0
+	#define RES_12BIT		(1 << 6)
+	u8 res_12bit;
+	/* Output g-range: +/-2g, 4g, or 8g */
+	#define KXTJ9_G_2G		0
+	#define KXTJ9_G_4G		(1 << 3)
+	#define KXTJ9_G_8G		(1 << 4)
+	u8 g_range;
+
+	/* DATA_CTRL_REG: controls the output data rate of the part */
+	#define ODR12_5F		0
+	#define ODR25F			1
+	#define ODR50F			2
+	#define ODR100F			3
+	#define ODR200F			4
+	#define ODR400F			5
+	#define ODR800F			6
+	u8 data_odr_init;
+
+	int (*init)(void);
+	void (*exit)(void);
+	int (*power_on)(void);
+	int (*power_off)(void);
+};
+#endif /* __KERNEL__ */
+
+#endif  /* __KXTJ9_H__ */
+
-- 
1.5.4.3

