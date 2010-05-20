From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] input: mcs5000 - Add MCS5000 touchkey support
Date: Thu, 20 May 2010 15:44:29 +0900
Message-ID: <4BF4DA4D.1090407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33462 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab0ETGoc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 02:44:32 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0L2P00KU8HE5C8@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 20 May 2010 15:44:29 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L2P00JJQHE574@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 20 May 2010 15:44:29 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: riverful.kim@samsung.com, kyungmin.park@samsung.com, linux-input@vger.kernel.org

The MELPAS MCS5000 can use to touchkey controller. This is patch to
support touchkey at original MCS5000 touchscreen driver.

Signed-off-by: HeungJun Kim <riverful.kim@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/input/touchscreen/Kconfig      |    6 +-
 drivers/input/touchscreen/mcs5000_ts.c |  245 ++++++++++++++++++++++++--------
 include/linux/i2c/mcs5000_ts.h         |   17 ++-
 3 files changed, 201 insertions(+), 67 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index cc47198..d569e87 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -202,11 +202,11 @@ config TOUCHSCREEN_WACOM_W8001
 	  module will be called wacom_w8001.
 
 config TOUCHSCREEN_MCS5000
-	tristate "MELFAS MCS-5000 touchscreen"
+	tristate "MELFAS MCS5000 touchscreen/touchkey"
 	depends on I2C
 	help
-	  Say Y here if you have the MELFAS MCS-5000 touchscreen controller
-	  chip in your system.
+	  Say Y here if you have the MELFAS MCS5000 touchscreen/touchkey
+	  controller chip in your system.
 
 	  If unsure, say N.
 
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index ce8ab02..87842e3 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -1,10 +1,9 @@
 /*
- * mcs5000_ts.c - Touchscreen driver for MELFAS MCS-5000 controller
+ * mcs5000_ts.c - Touchscreen/Touchkey driver for MELFAS MCS5000 controller
  *
- * Copyright (C) 2009 Samsung Electronics Co.Ltd
+ * Copyright (C) 2009 - 2010 Samsung Electronics Co.Ltd
  * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- * Based on wm97xx-core.c
+ * Author: HeungJun Kim <riverful.kim@samsung.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -22,7 +21,7 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 
-/* Registers */
+/* Touchscreen Registers */
 #define MCS5000_TS_STATUS		0x00
 #define STATUS_OFFSET			0
 #define STATUS_NO			(0 << STATUS_OFFSET)
@@ -92,6 +91,21 @@
 #define MCS5000_MAX_XC			0x3ff
 #define MCS5000_MAX_YC			0x3ff
 
+/* Touchkey Registers */
+#define MCS5000_TK_LED_ONOFF		0x01
+#define MCS5000_TK_LED_DIMMING		0x02
+#define MCS5000_TK_RESERVED1		0x03
+#define MCS5000_TK_VALUE_STATUS		0x04
+#define MCS5000_TK_RESERVED2		0x05
+#define MCS5000_TK_HW_VERSION		0x06
+#define MCS5000_TK_FW_VERSION		0x0A
+#define MCS5000_TK_MI_VERSION		0x0B
+
+enum mcs5000_type {
+	MCS5000_TOUCHSCREEN,
+	MCS5000_TOUCHKEY,
+};
+
 enum mcs5000_ts_read_offset {
 	READ_INPUT_INFO,
 	READ_X_POS_UPPER,
@@ -102,15 +116,59 @@ enum mcs5000_ts_read_offset {
 };
 
 /* Each client has this additional data */
-struct mcs5000_ts_data {
+struct mcs5000_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
-	const struct mcs5000_ts_platform_data *platform_data;
+	const struct mcs5000_platform_data *pdata;
+	unsigned int type;
+	unsigned int key_code;
 };
 
-static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
+static unsigned int mcs5000_get_type(struct mcs5000_data *data)
+{
+	return data->type;
+}
+
+static void mcs5000_tk_interrupt(struct mcs5000_data *data)
+{
+	const struct mcs5000_platform_data *pdata = data->pdata;
+	struct i2c_client *client = data->client;
+	struct input_dev *input = data->input_dev;
+	unsigned int key_val;
+	unsigned int key_code;
+	unsigned int pressed;
+	int val;
+	int i;
+
+	val = i2c_smbus_read_byte_data(client, MCS5000_TK_VALUE_STATUS);
+	if (val < 0) {
+		dev_err(&client->dev, "%s, err[%d]\n", __func__, val);
+		return;
+	}
+
+	key_val = val & 0x7f;
+	pressed = val >> 7;
+
+	if (pressed) {
+		for (i = 0; i < pdata->keymap_size; i++) {
+			if (MCS5000_KEY_VAL(pdata->keymap[i]) == key_val) {
+				key_code = MCS5000_KEY_CODE(pdata->keymap[i]);
+				data->key_code = key_code;
+				break;
+			}
+		}
+	} else
+		key_code = data->key_code;
+
+	input_report_key(input, key_code, pressed ? 1 : 0);
+	input_sync(input);
+
+	dev_dbg(&client->dev, "key %d %d %s\n", key_val, key_code,
+			pressed ? "pressed" : "released");
+}
+
+static void mcs5000_ts_interrupt(struct mcs5000_data *data)
 {
-	struct mcs5000_ts_data *data = dev_id;
 	struct i2c_client *client = data->client;
 	u8 buffer[READ_BLOCK_SIZE];
 	int err;
@@ -121,7 +179,7 @@ static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
 			READ_BLOCK_SIZE, buffer);
 	if (err < 0) {
 		dev_err(&client->dev, "%s, err[%d]\n", __func__, err);
-		goto out;
+		return;
 	}
 
 	switch (buffer[READ_INPUT_INFO]) {
@@ -157,15 +215,29 @@ static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
 				buffer[READ_INPUT_INFO]);
 		break;
 	}
+}
+
+static irqreturn_t mcs5000_interrupt(int irq, void *dev_id)
+{
+	struct mcs5000_data *data = dev_id;
+
+	switch (mcs5000_get_type(data)) {
+	case MCS5000_TOUCHSCREEN:
+		mcs5000_ts_interrupt(data);
+		break;
+	case MCS5000_TOUCHKEY:
+		mcs5000_tk_interrupt(data);
+		break;
+	default:
+		break;
+	}
 
- out:
 	return IRQ_HANDLED;
 }
 
-static void mcs5000_ts_phys_init(struct mcs5000_ts_data *data)
+static void mcs5000_ts_init(struct mcs5000_data *data)
 {
-	const struct mcs5000_ts_platform_data *platform_data =
-		data->platform_data;
+	const struct mcs5000_platform_data *pdata = data->pdata;
 	struct i2c_client *client = data->client;
 
 	/* Touch reset & sleep mode */
@@ -174,30 +246,32 @@ static void mcs5000_ts_phys_init(struct mcs5000_ts_data *data)
 
 	/* Touch size */
 	i2c_smbus_write_byte_data(client, MCS5000_TS_X_SIZE_UPPER,
-			platform_data->x_size >> 8);
+			pdata->x_size >> 8);
 	i2c_smbus_write_byte_data(client, MCS5000_TS_X_SIZE_LOWER,
-			platform_data->x_size & 0xff);
+			pdata->x_size & 0xff);
 	i2c_smbus_write_byte_data(client, MCS5000_TS_Y_SIZE_UPPER,
-			platform_data->y_size >> 8);
+			pdata->y_size >> 8);
 	i2c_smbus_write_byte_data(client, MCS5000_TS_Y_SIZE_LOWER,
-			platform_data->y_size & 0xff);
+			pdata->y_size & 0xff);
 
 	/* Touch active mode & 80 report rate */
 	i2c_smbus_write_byte_data(data->client, MCS5000_TS_OP_MODE,
 			OP_MODE_ACTIVE | REPORT_RATE_80);
 }
 
-static int __devinit mcs5000_ts_probe(struct i2c_client *client,
+static int __devinit mcs5000_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	struct mcs5000_ts_data *data;
+	struct mcs5000_data *data;
 	struct input_dev *input_dev;
+	unsigned long irq_flags = 0;
 	int ret;
+	int i;
 
 	if (!client->dev.platform_data)
 		return -EINVAL;
 
-	data = kzalloc(sizeof(struct mcs5000_ts_data), GFP_KERNEL);
+	data = kzalloc(sizeof(struct mcs5000_data), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!data || !input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
@@ -207,25 +281,44 @@ static int __devinit mcs5000_ts_probe(struct i2c_client *client,
 
 	data->client = client;
 	data->input_dev = input_dev;
-	data->platform_data = client->dev.platform_data;
+	data->pdata = client->dev.platform_data;
+	data->type = id->driver_data;
+
+	switch (mcs5000_get_type(data)) {
+	case MCS5000_TOUCHSCREEN:
+		input_dev->name = "MELPAS MCS5000 Touchscreen";
+		input_dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
+		input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+		input_set_abs_params(input_dev, ABS_X, 0, MCS5000_MAX_XC, 0, 0);
+		input_set_abs_params(input_dev, ABS_Y, 0, MCS5000_MAX_YC, 0, 0);
+
+		irq_flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT;
+		break;
+	case MCS5000_TOUCHKEY:
+		input_dev->name = "MELPAS MCS5000 Touchkey";
+		input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);;
+
+		for (i = 0; i < data->pdata->keymap_size; i++)
+			__set_bit(MCS5000_KEY_CODE(data->pdata->keymap[i]),
+					input_dev->keybit);
+
+		irq_flags = IRQF_TRIGGER_FALLING;
+		break;
+	default:
+		break;
+	}
 
-	input_dev->name = "MELPAS MCS-5000 Touchscreen";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 
-	__set_bit(EV_ABS, input_dev->evbit);
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
-	input_set_abs_params(input_dev, ABS_X, 0, MCS5000_MAX_XC, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, MCS5000_MAX_YC, 0, 0);
-
 	input_set_drvdata(input_dev, data);
 
-	if (data->platform_data->cfg_pin)
-		data->platform_data->cfg_pin();
+	if (data->pdata->cfg_pin)
+		data->pdata->cfg_pin();
 
-	ret = request_threaded_irq(client->irq, NULL, mcs5000_ts_interrupt,
-			IRQF_TRIGGER_LOW | IRQF_ONESHOT, "mcs5000_ts", data);
+	ret = request_threaded_irq(client->irq, NULL, mcs5000_interrupt,
+			irq_flags, client->dev.driver->name, data);
 
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
@@ -236,7 +329,16 @@ static int __devinit mcs5000_ts_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto err_free_irq;
 
-	mcs5000_ts_phys_init(data);
+	switch (mcs5000_get_type(data)) {
+	case MCS5000_TOUCHSCREEN:
+		mcs5000_ts_init(data);
+		break;
+	case MCS5000_TOUCHKEY:
+		break;
+	default:
+		break;
+	}
+
 	i2c_set_clientdata(client, data);
 
 	return 0;
@@ -249,9 +351,9 @@ err_free_mem:
 	return ret;
 }
 
-static int __devexit mcs5000_ts_remove(struct i2c_client *client)
+static int __devexit mcs5000_remove(struct i2c_client *client)
 {
-	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
+	struct mcs5000_data *data = i2c_get_clientdata(client);
 
 	free_irq(client->irq, data);
 	input_unregister_device(data->input_dev);
@@ -262,58 +364,79 @@ static int __devexit mcs5000_ts_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM
-static int mcs5000_ts_suspend(struct i2c_client *client, pm_message_t mesg)
+static int mcs5000_suspend(struct i2c_client *client, pm_message_t mesg)
 {
-	/* Touch sleep mode */
-	i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE, OP_MODE_SLEEP);
+	struct mcs5000_data *data = i2c_get_clientdata(client);
+
+	switch (mcs5000_get_type(data)) {
+	case MCS5000_TOUCHSCREEN:
+		/* Touch sleep mode */
+		i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE,
+				OP_MODE_SLEEP);
+		break;
+	case MCS5000_TOUCHKEY:
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
 
-static int mcs5000_ts_resume(struct i2c_client *client)
+static int mcs5000_resume(struct i2c_client *client)
 {
-	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
+	struct mcs5000_data *data = i2c_get_clientdata(client);
 
-	mcs5000_ts_phys_init(data);
+	switch (mcs5000_get_type(data)) {
+	case MCS5000_TOUCHSCREEN:
+		mcs5000_ts_init(data);
+		break;
+	case MCS5000_TOUCHKEY:
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
 #else
-#define mcs5000_ts_suspend	NULL
-#define mcs5000_ts_resume	NULL
+#define mcs5000_suspend		NULL
+#define mcs5000_resume		NULL
 #endif
 
-static const struct i2c_device_id mcs5000_ts_id[] = {
-	{ "mcs5000_ts", 0 },
+static const struct i2c_device_id mcs5000_id[] = {
+	{ "mcs5000_ts",	MCS5000_TOUCHSCREEN },
+	{ "mcs5000_tk",	MCS5000_TOUCHKEY },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, mcs5000_ts_id);
+MODULE_DEVICE_TABLE(i2c, mcs5000_id);
 
-static struct i2c_driver mcs5000_ts_driver = {
-	.probe		= mcs5000_ts_probe,
-	.remove		= __devexit_p(mcs5000_ts_remove),
-	.suspend	= mcs5000_ts_suspend,
-	.resume		= mcs5000_ts_resume,
+static struct i2c_driver mcs5000_driver = {
+	.probe		= mcs5000_probe,
+	.remove		= __devexit_p(mcs5000_remove),
+	.suspend	= mcs5000_suspend,
+	.resume		= mcs5000_resume,
 	.driver = {
-		.name = "mcs5000_ts",
+		.name = "mcs5000",
 	},
-	.id_table	= mcs5000_ts_id,
+	.id_table	= mcs5000_id,
 };
 
-static int __init mcs5000_ts_init(void)
+static int __init mcs5000_init(void)
 {
-	return i2c_add_driver(&mcs5000_ts_driver);
+	return i2c_add_driver(&mcs5000_driver);
 }
 
-static void __exit mcs5000_ts_exit(void)
+static void __exit mcs5000_exit(void)
 {
-	i2c_del_driver(&mcs5000_ts_driver);
+	i2c_del_driver(&mcs5000_driver);
 }
 
-module_init(mcs5000_ts_init);
-module_exit(mcs5000_ts_exit);
+module_init(mcs5000_init);
+module_exit(mcs5000_exit);
 
 /* Module information */
 MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
-MODULE_DESCRIPTION("Touchscreen driver for MELFAS MCS-5000 controller");
+MODULE_AUTHOR("HeungJun Kim <riverful.kim@samsung.com>");
+MODULE_DESCRIPTION("Touchscreen/Touchkey driver for MELFAS MCS5000 controller");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/mcs5000_ts.h b/include/linux/i2c/mcs5000_ts.h
index 5a117b5..578e3e5 100644
--- a/include/linux/i2c/mcs5000_ts.h
+++ b/include/linux/i2c/mcs5000_ts.h
@@ -1,8 +1,9 @@
 /*
  * mcs5000_ts.h
  *
- * Copyright (C) 2009 Samsung Electronics Co.Ltd
+ * Copyright (C) 2009 - 2010 Samsung Electronics Co.Ltd
  * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ * Author: HeungJun Kim <riverful.kim@samsung.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -14,11 +15,21 @@
 #ifndef __LINUX_MCS5000_TS_H
 #define __LINUX_MCS5000_TS_H
 
-/* platform data for the MELFAS MCS-5000 touchscreen driver */
-struct mcs5000_ts_platform_data {
+#define MCS5000_KEY_MAP(v, c)		((((v) & 0xff) << 16) | ((c) & 0xffff))
+#define MCS5000_KEY_VAL(v)		(((v) >> 16) & 0xff)
+#define MCS5000_KEY_CODE(v)		((v) & 0xffff)
+
+/* platform data for the MELFAS MCS5000 touchscreen/touchkey driver */
+struct mcs5000_platform_data {
 	void (*cfg_pin)(void);
+
+	/* touchscreen */
 	int x_size;
 	int y_size;
+
+	/* touchkey */
+	const uint32_t *keymap;
+	unsigned int keymap_size;
 };
 
 #endif	/* __LINUX_MCS5000_TS_H */
-- 
1.7.0.4
