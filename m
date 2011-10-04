From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: [PATCH] input:Adding support for Wacom Stylus with I2c interface
Date: Tue,  4 Oct 2011 16:44:23 +0900
Message-ID: <1317714263-9851-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50536 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab1JDHob (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2011 03:44:31 -0400
Received: by pzk1 with SMTP id 1so652057pzk.1
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 00:44:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

This driver has the same pen input process logic as wacom_w8001.c does.
Also some modifications for structures were applied.

Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
---
 drivers/input/touchscreen/wacom_i2c.c      |  216 ++++++++++++++++++++++++++++
 drivers/input/touchscreen/wacom_i2c.h      |   66 +++++++++
 drivers/input/touchscreen/wacom_i2c_func.c |   96 ++++++++++++
 drivers/input/touchscreen/wacom_i2c_func.h |    8 +
 4 files changed, 386 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/wacom_i2c.c
 create mode 100644 drivers/input/touchscreen/wacom_i2c.h
 create mode 100644 drivers/input/touchscreen/wacom_i2c_func.c
 create mode 100644 drivers/input/touchscreen/wacom_i2c_func.h

diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
new file mode 100644
index 0000000..88a232b
--- /dev/null
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -0,0 +1,216 @@
+/*
+ * Wacom Penabled Driver for I2C
+ *
+ * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
+ * <tobita.tatsunosuke@wacom.co.jp>
+ *
+ * This program is free software; you can redistribute it
+ * and/or modify it under the terms of the GNU General
+ * Public License as published by the Free Software
+ * Foundation; either version of 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Note: Wacom Penabled Driver for I2C obtains data by polling.
+ * If you use irq, you must use the edge based rising
+ * interruption with low level pin.
+ */
+
+#include <linux/device.h>
+#include "wacom_i2c_func.h"
+
+const unsigned short addr[2];
+
+static void wacom_i2c_workqueue(struct work_struct *workq)
+{
+	struct wacom_i2c *wac_i2c = container_of(workq, struct wacom_i2c, workq);
+	wacom_set_coordination(wac_i2c);
+}
+
+static enum hrtimer_restart wacom_i2c_timer(struct hrtimer *timer)
+{
+	struct wacom_i2c *wac_i2c = container_of(timer, struct wacom_i2c, timer);
+
+	queue_work(wacom_i2c_wq, &wac_i2c->workq);
+	hrtimer_start(&wac_i2c->timer, ktime_set(0, POLL_RATE), HRTIMER_MODE_REL);
+
+	return HRTIMER_NORESTART;
+}
+
+static int wacom_i2c_input_open(struct input_dev *dev)
+{
+	struct wacom_i2c *wac_i2c = input_get_drvdata(dev);
+
+	mutex_lock(&wac_i2c->lock);
+	wac_i2c->dev->open = true;
+	mutex_unlock(&wac_i2c->lock);
+
+	return 0;
+}
+
+static void wacom_i2c_input_close(struct input_dev *dev)
+{
+	struct wacom_i2c *wac_i2c = input_get_drvdata(dev);
+
+	mutex_lock(&wac_i2c->lock);
+	wac_i2c->dev->open = false;
+	mutex_unlock(&wac_i2c->lock);
+}
+
+static void wacom_i2c_set_input_values(struct i2c_client *client,
+				       struct wacom_i2c *wac_i2c, struct input_dev *dev)
+{
+	dev->name = "WACOM_I2C_DIGITIZER";
+	dev->id.bustype = BUS_I2C;
+	dev->id.vendor = 0x56a;
+	dev->dev.parent = &client->dev;
+	dev->open = wacom_i2c_input_open;
+	dev->close = wacom_i2c_input_close;
+	dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+
+	__set_bit(ABS_X, dev->absbit);
+	__set_bit(ABS_Y, dev->absbit);
+	__set_bit(ABS_PRESSURE, dev->absbit);
+	__set_bit(BTN_TOOL_PEN, dev->keybit);
+	__set_bit(BTN_TOOL_RUBBER, dev->keybit);
+	__set_bit(BTN_STYLUS, dev->keybit);
+	__set_bit(BTN_STYLUS2, dev->keybit);
+	__set_bit(BTN_TOUCH, dev->keybit);
+}
+
+static int wacom_i2c_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	struct wacom_i2c *wac_i2c;
+	int i, ret;
+	i = ret = 0;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		goto err2;
+
+	wac_i2c = kzalloc(sizeof(struct wacom_i2c), GFP_KERNEL);
+	wac_i2c->wac_feature = wacom_feature_EMR;
+
+	mutex_init(&wac_i2c->lock);
+
+	wac_i2c->dev = input_allocate_device();
+	if (wac_i2c == NULL || wac_i2c->dev == NULL)
+		goto fail;
+	wacom_i2c_set_input_values(client, wac_i2c, wac_i2c->dev);
+
+	wac_i2c->client = client;
+
+	INIT_WORK(&wac_i2c->workq, wacom_i2c_workqueue);
+
+	ret = wacom_send_query(wac_i2c);
+	if (ret < 0)
+		goto err1;
+
+	wac_i2c->dev->id.version = wac_i2c->wac_feature.fw_version;
+	input_set_abs_params(wac_i2c->dev, ABS_X, 0,
+			     wac_i2c->wac_feature.x_max, 0, 0);
+	input_set_abs_params(wac_i2c->dev, ABS_Y, 0,
+			     wac_i2c->wac_feature.y_max, 0, 0);
+	input_set_abs_params(wac_i2c->dev, ABS_PRESSURE, 0,
+			     wac_i2c->wac_feature.pressure_max, 0, 0);
+	input_set_drvdata(wac_i2c->dev, wac_i2c);
+
+	i2c_set_clientdata(client, wac_i2c);
+	if (input_register_device(wac_i2c->dev))
+		goto err1;
+
+	hrtimer_init(&wac_i2c->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	wac_i2c->timer.function = wacom_i2c_timer;
+	hrtimer_start(&wac_i2c->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
+	printk(KERN_INFO "WACOM_I2C_DIGITIZER: initialized and started \n");
+
+	return 0;
+
+ err2:
+	printk(KERN_ERR "wacom_i2c:No I2C functionality found\n");
+	return -ENODEV;
+
+ err1:
+	printk(KERN_ERR "wacom_i2c:err1 occured(num:%d)\n", ret);
+	input_free_device(wac_i2c->dev);
+	wac_i2c->dev = NULL;
+	return -EIO;
+
+ fail:
+	printk(KERN_ERR "wacom_i2c:fail occured\n");
+	return -ENOMEM;
+}
+
+static int wacom_i2c_remove(struct i2c_client *client)
+{
+	struct wacom_i2c *wac_i2c = i2c_get_clientdata(client);
+
+	input_unregister_device(wac_i2c->dev);
+	hrtimer_cancel(&wac_i2c->timer);
+	kfree(wac_i2c);
+
+	return 0;
+}
+
+static int wacom_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	int ret;
+	struct wacom_i2c *wac_i2c = i2c_get_clientdata(client);
+
+	hrtimer_cancel(&wac_i2c->timer);
+	cancel_work_sync(&wac_i2c->workq);
+	ret = wac_i2c->power(0);
+
+	return 0;
+}
+
+static int wacom_i2c_resume(struct i2c_client *client)
+{
+	struct wacom_i2c *wac_i2c = i2c_get_clientdata(client);
+
+	hrtimer_start(&wac_i2c->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+static const struct i2c_device_id wacom_i2c_id[] = {
+	{WACNAME, 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
+
+static struct i2c_driver wacom_i2c_driver = {
+	.driver = {
+		.name = "wacom_i2c",
+	},
+
+	.probe = wacom_i2c_probe,
+	.remove = wacom_i2c_remove,
+	.suspend = wacom_i2c_suspend,
+	.resume = wacom_i2c_resume,
+	.id_table = wacom_i2c_id,
+};
+
+static int __init wacom_i2c_init()
+{
+
+	wacom_i2c_wq = create_singlethread_workqueue("wacom_i2c_wq");
+	if (!wacom_i2c_wq)
+		return -ENOMEM;
+
+	return i2c_add_driver(&wacom_i2c_driver);
+}
+
+static void __exit wacom_i2c_exit()
+{
+	if (wacom_i2c_wq)
+		destroy_workqueue(wacom_i2c_wq);
+
+	i2c_del_driver(&wacom_i2c_driver);
+}
+
+module_init(wacom_i2c_init);
+module_exit(wacom_i2c_exit);
+
+MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>");
+MODULE_DESCRIPTION("WACOM EMR I2C Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/wacom_i2c.h b/drivers/input/touchscreen/wacom_i2c.h
new file mode 100644
index 0000000..390b765
--- /dev/null
+++ b/drivers/input/touchscreen/wacom_i2c.h
@@ -0,0 +1,66 @@
+#ifndef WACOM_I2C_H
+#define WAOCM_I2C_H
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/hrtimer.h>
+#include <linux/delay.h>
+#include <linux/uaccess.h>
+#include <asm/unaligned.h>
+
+#define NAMEBUF 12
+#define WACNAME "WAC_I2C_EMR"
+
+/*Wacom Command*/
+#define COM_COORD_NUM      256
+#define COM_SAMPLERATE_40  0x33
+#define COM_SAMPLERATE_80  0x32
+#define COM_SAMPLERATE_133 0x31
+#define CMD_QUERY0         0x04
+#define CMD_QUERY1         0x00
+#define CMD_QUERY2         0x33
+#define CMD_QUERY3         0x02
+#define CMD_THROW0         0x05
+#define CMD_THROW1         0x00
+#define QUERY_SIZE           19
+
+/*I2C address for digitizer*/
+#define WACOM_I2C_ADDR   0x09
+
+/*Polling Rate*/
+#define POLL_RATE 7500000
+
+static struct workqueue_struct *wacom_i2c_wq;
+
+/*Parameters for wacom own features*/
+struct wacom_features {
+	int x_max;
+	int y_max;
+	int pressure_max;
+	char fw_version;
+};
+
+static struct wacom_features wacom_feature_EMR = {
+	16128,
+	8448,
+	256,
+	0x10,
+};
+
+/*Parameters for i2c driver*/
+struct wacom_i2c {
+	struct i2c_client *client;
+	struct input_dev *dev;
+	struct mutex lock;
+	struct work_struct workq;
+	struct hrtimer timer;
+	struct wacom_features wac_feature;
+	int (*power)(int on);
+	int type;
+	const char name[NAMEBUF];
+};
+#endif
diff --git a/drivers/input/touchscreen/wacom_i2c_func.c b/drivers/input/touchscreen/wacom_i2c_func.c
new file mode 100644
index 0000000..97f086c
--- /dev/null
+++ b/drivers/input/touchscreen/wacom_i2c_func.c
@@ -0,0 +1,96 @@
+#include "wacom_i2c_func.h"
+
+int wacom_send_query(struct wacom_i2c *wac_i2c)
+{
+	int ret;
+	u8 cmd[4] = {CMD_QUERY0, CMD_QUERY1, CMD_QUERY2, CMD_QUERY3};
+	u8 data[COM_COORD_NUM];
+
+	ret = i2c_master_send(wac_i2c->client, cmd, sizeof(cmd));
+	if (ret < 0) {
+		printk(KERN_ERR "wacom_i2c: Sending Query failed \n");
+		return -1;
+	}
+
+	cmd[0] = CMD_THROW0; cmd[1] = CMD_THROW1;
+	ret = i2c_master_send(wac_i2c->client, cmd, 2);
+	if (ret < 0) {
+		printk(KERN_ERR "wacom_i2c: Sending Query failed \n");
+		return -1;
+	}
+
+	ret = i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
+	if (ret < 0) {
+		printk(KERN_ERR "wacom_i2c: Receiving Query failed\n");
+		return -1;
+	}
+
+	wac_i2c->wac_feature.x_max = get_unaligned_le16(&data[3]);
+	wac_i2c->wac_feature.y_max = get_unaligned_le16(&data[5]);
+	wac_i2c->wac_feature.pressure_max = get_unaligned_le16(&data[11]);
+	wac_i2c->wac_feature.fw_version = get_unaligned_le16(&data[13]);
+
+	printk(KERN_INFO "wacom_i2c: x_max:%d, y_max:%d, pressure:%d, fw:%d\n",
+	       wac_i2c->wac_feature.x_max, wac_i2c->wac_feature.y_max,
+	       wac_i2c->wac_feature.pressure_max, wac_i2c->wac_feature.fw_version);
+
+	return 0;
+}
+
+int wacom_set_coordination(struct wacom_i2c *wac_i2c)
+{
+	int ret = 0;
+	unsigned int x, y, pressure;
+	unsigned char rdy, tsw, f1, f2, ers;
+	u8 data[COM_COORD_NUM];
+
+	ret = i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
+	if (ret >= 0) {
+		tsw = data[3]&0x01;
+		ers = data[3]&0x04;
+		f1 = data[3]&0x02;
+		f2 = data[3]&0x10;
+		rdy = data[3]&0x20;
+		x = le16_to_cpup((__le16 *)&data[4]);
+		y = le16_to_cpup((__le16 *)&data[6]);
+		pressure = le16_to_cpup((__le16 *)&data[8]);
+
+		switch (wac_i2c->type) {
+		case BTN_TOOL_RUBBER:
+			if (!f2) {
+				input_report_abs(wac_i2c->dev, ABS_PRESSURE, 0);
+				input_report_key(wac_i2c->dev, BTN_TOUCH, 0);
+				input_report_key(wac_i2c->dev, BTN_STYLUS, 0);
+				input_report_key(wac_i2c->dev, BTN_STYLUS2, 0);
+				input_report_key(wac_i2c->dev, BTN_TOOL_RUBBER, 0);
+				input_sync(wac_i2c->dev);
+				wac_i2c->type = BTN_TOOL_PEN;
+			}
+			break;
+
+		case KEY_RESERVED:
+			wac_i2c->type = f2 ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
+			break;
+
+		default:
+			input_report_key(wac_i2c->dev, BTN_STYLUS2, f2);
+			break;
+		}
+
+		input_report_abs(wac_i2c->dev, ABS_X, x);
+		input_report_abs(wac_i2c->dev, ABS_Y, y);
+		input_report_abs(wac_i2c->dev, ABS_PRESSURE, pressure);
+		input_report_key(wac_i2c->dev, BTN_TOUCH, (tsw || ers));
+		input_report_key(wac_i2c->dev, BTN_STYLUS, f1);
+
+		input_sync(wac_i2c->dev);
+
+		if (!rdy)
+			wac_i2c->type = KEY_RESERVED;
+
+	} else {
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/drivers/input/touchscreen/wacom_i2c_func.h b/drivers/input/touchscreen/wacom_i2c_func.h
new file mode 100644
index 0000000..cce35c4
--- /dev/null
+++ b/drivers/input/touchscreen/wacom_i2c_func.h
@@ -0,0 +1,8 @@
+#ifndef WACOM_I2C_FUNC_H
+#define WACOM_I2C_FUNC_H
+
+#include "wacom_i2c.h"
+
+int wacom_set_coordination(struct wacom_i2c *wac_i2c);
+int wacom_send_query(struct wacom_i2c *wac_i2c);
+#endif
-- 
1.7.1

