From: chinyeow.sim.xt@renesas.com
Subject: [PATCH v4] Input: add ST1232 touchscreen controller driver.
Date: Thu, 16 Dec 2010 09:45:25 +0900
Message-ID: <1292460325-4438-1-git-send-email-chinyeow.sim.xt@renesas.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54416 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0LPApd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Dec 2010 19:45:33 -0500
Received: by vws16 with SMTP id 16so1181720vws.19
        for <linux-input@vger.kernel.org>; Wed, 15 Dec 2010 16:45:33 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: tsoni@codeaurora.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-input@vger.kernel.org
Cc: chinyeow.sim.xt@renesas.com

From: Tony SIM <chinyeow.sim.xt@renesas.com>

This patch set introduces for Sitronix ST1232 touchscreen controller
driver. This is an integrated capacitive touchscreen with LCD module
which can detect two fingers's touch X/Y coordinate.

Signed-off-by: Tony SIM <chinyeow.sim.xt@renesas.com>
---

Thanks for review!

Changes since v3:
- Removed unused variable.
- Changed touch counting flag.

 drivers/input/touchscreen/Kconfig  |   11 ++
 drivers/input/touchscreen/Makefile |    1 +
 drivers/input/touchscreen/st1232.c |  273 ++++++++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/st1232.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 06ea8da..3ca7700 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -681,4 +681,15 @@ config TOUCHSCREEN_STMPE
 	  To compile this driver as a module, choose M here: the
 	  module will be called stmpe-ts.
 
+config TOUCHSCREEN_ST1232
+	tristate "Sitronix ST1232 touchscreen controllers"
+	depends on I2C
+	help
+	  Say Y here if you want to support Sitronix ST1232
+	  touchscreen controller.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called st1232_ts.
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 7cc1b4f..718bcc8 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
 obj-$(CONFIG_TOUCHSCREEN_QT602240)	+= qt602240_ts.o
 obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
+obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
 obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
 obj-$(CONFIG_TOUCHSCREEN_TNETV107X)	+= tnetv107x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
new file mode 100644
index 0000000..f94a718
--- /dev/null
+++ b/drivers/input/touchscreen/st1232.c
@@ -0,0 +1,273 @@
+/*
+ * ST1232 Touchscreen Controller Driver
+ *
+ * Copyright (C) 2010 Renesas Solutions Corp.
+ *	Tony SIM <chinyeow.sim.xt@renesas.com>
+ *
+ * Using code from:
+ *  - android.git.kernel.org: projects/kernel/common.git: synaptics_i2c_rmi.c
+ *	Copyright (C) 2007 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#define ST1232_TS_NAME	"st1232-ts"
+
+#define MIN_X	0x00
+#define MIN_Y	0x00
+#define MAX_X	0x31f	/* (800 - 1) */
+#define MAX_Y	0x1df	/* (480 - 1) */
+#define MAX_AREA	0xff
+#define MAX_FINGERS	2
+
+struct st1232_ts_finger {
+	uint8_t is_valid;
+	uint16_t x;
+	uint16_t y;
+	uint8_t t;
+};
+
+struct st1232_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	struct st1232_ts_finger finger[MAX_FINGERS];
+};
+
+static int st1232_ts_read_data(struct st1232_ts_data *ts)
+{
+	int ret;
+	struct i2c_msg msg[2];
+	uint8_t start_reg;
+	uint8_t buf[10];
+	struct st1232_ts_finger *finger = ts->finger;
+
+	/* read touchscreen data from ST1232 */
+	msg[0].addr = ts->client->addr;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = &start_reg;
+	start_reg = 0x10;
+
+	msg[1].addr = ts->client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = sizeof(buf);
+	msg[1].buf = buf;
+
+	ret = i2c_transfer(ts->client->adapter, msg, 2);
+	if (ret < 0)
+		return ret;
+
+	/* get valid bit */
+	finger[0].is_valid = buf[2] >> 7;
+	finger[1].is_valid = buf[5] >> 7;
+
+	/* get xy coordinate */
+	if (finger[0].is_valid) {
+		finger[0].x = ((buf[2] & 0x0070) << 4) | buf[3];
+		finger[0].y = ((buf[2] & 0x0007) << 8) | buf[4];
+		finger[0].t = buf[8];
+	}
+
+	if (finger[1].is_valid) {
+		finger[1].x = ((buf[5] & 0x0070) << 4) | buf[6];
+		finger[1].y = ((buf[5] & 0x0007) << 8) | buf[7];
+		finger[1].t = buf[9];
+	}
+
+	return 0;
+}
+
+static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
+{
+	int i, ret;
+	int count = 0;
+	struct st1232_ts_data *ts = dev_id;
+	struct st1232_ts_finger *finger = ts->finger;
+
+	ret = st1232_ts_read_data(ts);
+	if (ret < 0)
+		goto end;
+
+	/* multi touch protocol */
+	for (i = 0; i < MAX_FINGERS; i++) {
+		if (!finger[i].is_valid)
+			continue;
+
+		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
+					finger[i].t);
+		input_report_abs(ts->input_dev, ABS_MT_POSITION_X, finger[i].x);
+		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, finger[i].y);
+		input_mt_sync(ts->input_dev);
+		count++;
+	}
+
+	/* SYN_MT_REPORT only if no contact */
+	if (!count)
+		input_mt_sync(ts->input_dev);
+
+	/* SYN_REPORT */
+	input_sync(ts->input_dev);
+
+end:
+	return IRQ_HANDLED;
+}
+
+static int __devinit st1232_ts_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	struct st1232_ts_data *ts;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "need I2C_FUNC_I2C\n");
+		return -EIO;
+	}
+
+	ts = kzalloc(sizeof(struct st1232_ts_data), GFP_KERNEL);
+	if (!ts) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ts->client = client;
+	i2c_set_clientdata(client, ts);
+
+	ts->input_dev = input_allocate_device();
+	if (!ts->input_dev) {
+		ret = -ENOMEM;
+		dev_err(&client->dev, "Failed to allocate input device\n");
+		goto err_free_mem;
+	}
+	ts->input_dev->name = "st1232-touchscreen";
+
+	__set_bit(EV_SYN, ts->input_dev->evbit);
+	__set_bit(EV_KEY, ts->input_dev->evbit);
+	__set_bit(EV_ABS, ts->input_dev->evbit);
+
+	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
+				0, MAX_AREA, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
+				MIN_X, MAX_X, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
+				MIN_Y, MAX_Y, 0, 0);
+
+	ret = input_register_device(ts->input_dev);
+	if (ret) {
+		dev_err(&client->dev, "Unable to register %s input device\n",
+			ts->input_dev->name);
+		goto err_free_input_device;
+	}
+
+	ret = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
+					IRQF_ONESHOT, client->name, ts);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register interrupt\n");
+		goto err_free_input_device;
+	}
+
+	device_init_wakeup(&client->dev, 1);
+
+	return 0;
+
+err_free_input_device:
+	input_free_device(ts->input_dev);
+err_free_mem:
+	kfree(ts);
+err:
+	return ret;
+}
+
+static int __devexit st1232_ts_remove(struct i2c_client *client)
+{
+	struct st1232_ts_data *ts = i2c_get_clientdata(client);
+
+	device_init_wakeup(&client->dev, 0);
+	free_irq(client->irq, ts);
+	input_unregister_device(ts->input_dev);
+	kfree(ts);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int st1232_ts_suspend(struct device *dev)
+{
+	struct st1232_ts_data *ts = dev_get_drvdata(dev);
+	struct i2c_client *client = ts->client;
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(client->irq);
+	else
+		disable_irq(client->irq);
+
+	return 0;
+}
+
+static int st1232_ts_resume(struct device *dev)
+{
+	struct st1232_ts_data *ts = dev_get_drvdata(dev);
+	struct i2c_client *client = ts->client;
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(client->irq);
+	else
+		enable_irq(client->irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops st1232_ts_pm_ops = {
+	.suspend	= st1232_ts_suspend,
+	.resume		= st1232_ts_resume,
+};
+#endif
+
+static const struct i2c_device_id st1232_ts_id[] = {
+	{ ST1232_TS_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
+
+static struct i2c_driver st1232_ts_driver = {
+	.probe		= st1232_ts_probe,
+	.remove		= __devexit_p(st1232_ts_remove),
+	.id_table	= st1232_ts_id,
+	.driver = {
+		.name	= ST1232_TS_NAME,
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &st1232_ts_pm_ops,
+#endif
+	},
+};
+
+static int __init st1232_ts_init(void)
+{
+	return i2c_add_driver(&st1232_ts_driver);
+}
+module_init(st1232_ts_init);
+
+static void __exit st1232_ts_exit(void)
+{
+	i2c_del_driver(&st1232_ts_driver);
+}
+module_exit(st1232_ts_exit);
+
+MODULE_AUTHOR("Tony SIM <chinyeow.sim.xt@renesas.com>");
+MODULE_DESCRIPTION("SITRONIX ST1232 Touchscreen Controller Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.2.3

