From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v4] Input: add touchscreen driver for MELFAS MCS-5000 controller
Date: Wed, 16 Sep 2009 14:45:02 +0900
Message-ID: <4AB07B5E.7040501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:64553 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbZIPFpA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 01:45:00 -0400
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KQ1005TQUN2JG@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Sep 2009 14:45:02 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KQ1009MDUN2ES@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Sep 2009 14:45:02 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.fujak@samsung.com

The MELPAS MCS-5000 is the touchscreen controller. The overview of this
controller can see at the following website:

http://www.melfas.com/product/product01.asp?k_r=eng_

This driver is tested on s3c6410 NCP board and supports only the i2c
interface.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
Hi, Dmitry.

This patch v4 adds threaded IRQ support from the patch you send before.

The Kconfig and Makefile of driver/input/touchscreen/ are not ordered, 
so i add the contents at the last.

Change log:
v2: updated as per feedback for v1
v3: add platform_data checking before call set_pin() on probe function
    change #ifdef CONFIG_PM position
v4: support threaded irq from the patch of Dmitry.


 drivers/input/touchscreen/Kconfig      |   12 ++
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/mcs5000_ts.c |  327 ++++++++++++++++++++++++++++++++
 include/linux/i2c/mcs5000_ts.h         |   11 +
 4 files changed, 351 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/mcs5000_ts.c
 create mode 100644 include/linux/i2c/mcs5000_ts.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 87a1ae6..b394662 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -510,4 +510,16 @@ config TOUCHSCREEN_W90X900
 	  To compile this driver as a module, choose M here: the
 	  module will be called w90p910_ts.
 
+config TOUCHSCREEN_MCS5000
+	tristate "MELFAS MCS-5000 touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have the MELFAS MCS-5000 touchscreen controller
+	  chip in your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mcs5000_ts.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 3e1c5e0..91e820f 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -40,3 +40,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ATMEL)	+= atmel-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
+obj-$(CONFIG_TOUCHSCREEN_MCS5000)	+= mcs5000_ts.o
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
new file mode 100644
index 0000000..9773128
--- /dev/null
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -0,0 +1,327 @@
+/*
+ * mcs5000_ts.c - Touchscreen driver for MELFAS MCS-5000 controller
+ *
+ * Copyright (C) 2009 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ * Based on wm97xx-core.c
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c/mcs5000_ts.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/irq.h>
+
+/* Registers */
+#define MCS5000_TS_STATUS		0x00
+#define STATUS_OFFSET			0
+#define STATUS_NO			(0 << STATUS_OFFSET)
+#define STATUS_INIT			(1 << STATUS_OFFSET)
+#define STATUS_SENSING			(2 << STATUS_OFFSET)
+#define STATUS_COORD			(3 << STATUS_OFFSET)
+#define STATUS_GESTURE			(4 << STATUS_OFFSET)
+#define ERROR_OFFSET			4
+#define ERROR_NO			(0 << ERROR_OFFSET)
+#define ERROR_POWER_ON_RESET		(1 << ERROR_OFFSET)
+#define ERROR_INT_RESET			(2 << ERROR_OFFSET)
+#define ERROR_EXT_RESET			(3 << ERROR_OFFSET)
+#define ERROR_INVALID_REG_ADDRESS	(8 << ERROR_OFFSET)
+#define ERROR_INVALID_REG_VALUE		(9 << ERROR_OFFSET)
+
+#define MCS5000_TS_OP_MODE		0x01
+#define RESET_OFFSET			0
+#define RESET_NO			(0 << RESET_OFFSET)
+#define RESET_EXT_SOFT			(1 << RESET_OFFSET)
+#define OP_MODE_OFFSET			1
+#define OP_MODE_SLEEP			(0 << OP_MODE_OFFSET)
+#define OP_MODE_ACTIVE			(1 << OP_MODE_OFFSET)
+#define GESTURE_OFFSET			4
+#define GESTURE_DISABLE			(0 << GESTURE_OFFSET)
+#define GESTURE_ENABLE			(1 << GESTURE_OFFSET)
+#define PROXIMITY_OFFSET		5
+#define PROXIMITY_DISABLE		(0 << PROXIMITY_OFFSET)
+#define PROXIMITY_ENABLE		(1 << PROXIMITY_OFFSET)
+#define SCAN_MODE_OFFSET		6
+#define SCAN_MODE_INTERRUPT		(0 << SCAN_MODE_OFFSET)
+#define SCAN_MODE_POLLING		(1 << SCAN_MODE_OFFSET)
+#define REPORT_RATE_OFFSET		7
+#define REPORT_RATE_40			(0 << REPORT_RATE_OFFSET)
+#define REPORT_RATE_80			(1 << REPORT_RATE_OFFSET)
+
+#define MCS5000_TS_SENS_CTL		0x02
+#define MCS5000_TS_FILTER_CTL		0x03
+#define PRI_FILTER_OFFSET		0
+#define SEC_FILTER_OFFSET		4
+
+#define MCS5000_TS_X_SIZE_UPPER		0x08
+#define MCS5000_TS_X_SIZE_LOWER		0x09
+#define MCS5000_TS_Y_SIZE_UPPER		0x0A
+#define MCS5000_TS_Y_SIZE_LOWER		0x0B
+
+#define MCS5000_TS_INPUT_INFO		0x10
+#define INPUT_TYPE_OFFSET		0
+#define INPUT_TYPE_NONTOUCH		(0 << INPUT_TYPE_OFFSET)
+#define INPUT_TYPE_SINGLE		(1 << INPUT_TYPE_OFFSET)
+#define INPUT_TYPE_DUAL			(2 << INPUT_TYPE_OFFSET)
+#define INPUT_TYPE_PALM			(3 << INPUT_TYPE_OFFSET)
+#define INPUT_TYPE_PROXIMITY		(7 << INPUT_TYPE_OFFSET)
+#define GESTURE_CODE_OFFSET		3
+#define GESTURE_CODE_NO			(0 << GESTURE_CODE_OFFSET)
+
+#define MCS5000_TS_X_POS_UPPER		0x11
+#define MCS5000_TS_X_POS_LOWER		0x12
+#define MCS5000_TS_Y_POS_UPPER		0x13
+#define MCS5000_TS_Y_POS_LOWER		0x14
+#define MCS5000_TS_Z_POS		0x15
+#define MCS5000_TS_WIDTH		0x16
+#define MCS5000_TS_GESTURE_VAL		0x17
+#define MCS5000_TS_MODULE_REV		0x20
+#define MCS5000_TS_FIRMWARE_VER		0x21
+
+/* Touchscreen absolute values */
+#define MCS5000_MAX_XC			0x3ff
+#define MCS5000_MAX_YC			0x3ff
+
+enum mcs5000_ts_read_offset {
+	READ_INPUT_INFO,
+	READ_X_POS_UPPER,
+	READ_X_POS_LOWER,
+	READ_Y_POS_UPPER,
+	READ_Y_POS_LOWER,
+	READ_BLOCK_SIZE,
+};
+
+/* Each client has this additional data */
+struct mcs5000_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	const struct mcs5000_ts_platform_data *platform_data;
+};
+
+static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
+{
+	struct mcs5000_ts_data *data = dev_id;
+	struct i2c_client *client = data->client;
+	u8 buffer[READ_BLOCK_SIZE];
+	int err;
+	int x;
+	int y;
+
+	disable_irq_nosync(irq);
+
+	err = i2c_smbus_read_i2c_block_data(client, MCS5000_TS_INPUT_INFO,
+			READ_BLOCK_SIZE, buffer);
+	if (err < 0) {
+		dev_err(&client->dev, "%s, err[%d]\n", __func__, err);
+		goto out;
+	}
+
+	switch (buffer[READ_INPUT_INFO]) {
+	case INPUT_TYPE_NONTOUCH:
+		input_report_key(data->input_dev, BTN_TOUCH, 0);
+		input_sync(data->input_dev);
+		break;
+
+	case INPUT_TYPE_SINGLE:
+		x = (buffer[READ_X_POS_UPPER] << 8) | buffer[READ_X_POS_LOWER];
+		y = (buffer[READ_Y_POS_UPPER] << 8) | buffer[READ_Y_POS_LOWER];
+
+		input_report_key(data->input_dev, BTN_TOUCH, 1);
+		input_report_abs(data->input_dev, ABS_X, x);
+		input_report_abs(data->input_dev, ABS_Y, y);
+		input_sync(data->input_dev);
+		break;
+
+	case INPUT_TYPE_DUAL:
+		/* TODO */
+		break;
+
+	case INPUT_TYPE_PALM:
+		/* TODO */
+		break;
+
+	case INPUT_TYPE_PROXIMITY:
+		/* TODO */
+		break;
+
+	default:
+		dev_err(&client->dev, "Unknown ts input type %d\n",
+				buffer[READ_INPUT_INFO]);
+		break;
+	}
+
+ out:
+	enable_irq(irq);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mcs5000_ts_hardirq(int irq, void *dev_id)
+{
+	return IRQ_WAKE_THREAD;
+}
+
+static void mcs5000_ts_phys_init(struct mcs5000_ts_data *data)
+{
+	const struct mcs5000_ts_platform_data *platform_data =
+		data->platform_data;
+	struct i2c_client *client = data->client;
+
+	/* Touch reset & sleep mode */
+	i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE,
+			RESET_EXT_SOFT | OP_MODE_SLEEP);
+
+	/* Touch size */
+	i2c_smbus_write_byte_data(client, MCS5000_TS_X_SIZE_UPPER,
+			platform_data->x_size >> 8);
+	i2c_smbus_write_byte_data(client, MCS5000_TS_X_SIZE_LOWER,
+			platform_data->x_size & 0xff);
+	i2c_smbus_write_byte_data(client, MCS5000_TS_Y_SIZE_UPPER,
+			platform_data->y_size >> 8);
+	i2c_smbus_write_byte_data(client, MCS5000_TS_Y_SIZE_LOWER,
+			platform_data->y_size & 0xff);
+
+	/* Touch active mode & 80 report rate */
+	i2c_smbus_write_byte_data(data->client, MCS5000_TS_OP_MODE,
+			OP_MODE_ACTIVE | REPORT_RATE_80);
+}
+
+static int __devinit mcs5000_ts_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct mcs5000_ts_data *data;
+	struct input_dev *input_dev;
+	int ret;
+
+	if (!client->dev.platform_data)
+		return -EINVAL;
+
+	data = kzalloc(sizeof(struct mcs5000_ts_data), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!data || !input_dev) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		ret = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	data->client = client;
+	data->input_dev = input_dev;
+	data->platform_data = client->dev.platform_data;
+
+	input_dev->name = "MELPAS MCS-5000 Touchscreen";
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->dev.parent = &client->dev;
+
+	__set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+	input_set_abs_params(input_dev, ABS_X, 0, MCS5000_MAX_XC, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, MCS5000_MAX_YC, 0, 0);
+
+	input_set_drvdata(input_dev, data);
+
+	if (data->platform_data->cfg_pin)
+		data->platform_data->cfg_pin();
+
+	ret = request_threaded_irq(client->irq, mcs5000_ts_hardirq,
+			mcs5000_ts_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+			"mcs5000_ts", data);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to register interrupt\n");
+		goto err_free_mem;
+	}
+
+	ret = input_register_device(data->input_dev);
+	if (ret < 0)
+		goto err_free_irq;
+
+	mcs5000_ts_phys_init(data);
+	i2c_set_clientdata(client, data);
+
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, data);
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(data);
+	return ret;
+}
+
+static int __devexit mcs5000_ts_remove(struct i2c_client *client)
+{
+	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
+
+	free_irq(client->irq, data);
+	input_unregister_device(data->input_dev);
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mcs5000_ts_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	/* Touch sleep mode */
+	i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE, OP_MODE_SLEEP);
+
+	return 0;
+}
+
+static int mcs5000_ts_resume(struct i2c_client *client)
+{
+	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
+
+	mcs5000_ts_phys_init(data);
+
+	return 0;
+}
+#else
+#define mcs5000_ts_suspend	NULL
+#define mcs5000_ts_resume	NULL
+#endif
+
+static const struct i2c_device_id mcs5000_ts_id[] = {
+	{ "mcs5000_ts", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcs5000_ts_id);
+
+static struct i2c_driver mcs5000_ts_driver = {
+	.probe		= mcs5000_ts_probe,
+	.remove		= __devexit_p(mcs5000_ts_remove),
+	.suspend	= mcs5000_ts_suspend,
+	.resume		= mcs5000_ts_resume,
+	.driver = {
+		.name = "mcs5000_ts",
+	},
+	.id_table	= mcs5000_ts_id,
+};
+
+static int __init mcs5000_ts_init(void)
+{
+	return i2c_add_driver(&mcs5000_ts_driver);
+}
+
+static void __exit mcs5000_ts_exit(void)
+{
+	i2c_del_driver(&mcs5000_ts_driver);
+}
+
+module_init(mcs5000_ts_init);
+module_exit(mcs5000_ts_exit);
+
+/* Module information */
+MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
+MODULE_DESCRIPTION("Touchscreen driver for MELFAS MCS-5000 controller");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/mcs5000_ts.h b/include/linux/i2c/mcs5000_ts.h
new file mode 100644
index 0000000..865be11
--- /dev/null
+++ b/include/linux/i2c/mcs5000_ts.h
@@ -0,0 +1,11 @@
+#ifndef __LINUX_MCS5000_TS_H
+#define __LINUX_MCS5000_TS_H
+
+/* platform data for the MELFAS MCS-5000 touchscreen driver */
+struct mcs5000_ts_platform_data {
+	void (*cfg_pin)(void);
+	int x_size;
+	int y_size;
+};
+
+#endif	/* __LINUX_MCS5000_TS_H */
-- 
1.6.0.4
