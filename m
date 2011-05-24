From: jcbian <jcbian@pixcir.com.cn>
Subject: [PATCH v3] input: add driver for pixcir i2c touchscreens
Date: Tue, 24 May 2011 11:25:10 +0800
Message-ID: <4DDB2516.6050302@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail23.corpease.net ([61.145.121.43]:63096 "EHLO corpease.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756602Ab1EXDkP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2011 23:40:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

Hi all,

This patch adds a driver for PIXCIR's I2C connected touchscreens.
Request the IRQ by doing request_threaded_irq() as v3.

Signed-off-by: Jianchun <jcbian@pixcir.com.cn>
---
 drivers/input/touchscreen/Kconfig         |   12 ++
 drivers/input/touchscreen/Makefile        |    1 +
 drivers/input/touchscreen/pixcir_i2c_ts.c |  269
+++++++++++++++++++++++++++++
 drivers/input/touchscreen/pixcir_i2c_ts.h |   13 ++
 4 files changed, 295 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/pixcir_i2c_ts.c
 create mode 100644 drivers/input/touchscreen/pixcir_i2c_ts.h

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index 434fd80..e91f40f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -714,4 +714,16 @@ config TOUCHSCREEN_TPS6507X
 	  To compile this driver as a module, choose M here: the
 	  module will be called tps6507x_ts.

+config TOUCHSCREEN_PIXCIR
+	tristate "PIXCIR I2C touchscreens"
+	depends on I2C
+	help
+	  Say Y here if you have a pixcir i2c touchscreen
+	  controller.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pixcir_i2c_ts.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index ca94098..585c0f0 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+= htcpen.o
 obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
 obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
+obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+= pixcir_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
 obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c
b/drivers/input/touchscreen/pixcir_i2c_ts.c
new file mode 100644
index 0000000..b734813
--- /dev/null
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -0,0 +1,269 @@
+/* drivers/input/touchscreen/pixcir_i2c_ts.c
+ *
+ * Copyright (C) 2010-2011 Pixcir, Inc.
+ * V1.0
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
+ * You should have received a copy of the GNU General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
 USA
+ */
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/i2c.h>
+#include "pixcir_i2c_ts.h"
+
+struct pixcir_i2c_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	wait_queue_head_t wait;
+	const struct pixcir_i2c_ts_platform *chip;
+	unsigned int attb_pin;
+	int irq;
+};
+
+static int pixcir_ts_poscheck(struct pixcir_i2c_ts_data *data)
+{
+	struct pixcir_i2c_ts_data *tsdata = data;
+
+	u8 touching, oldtouching;
+	u16 posx1, posy1, posx2, posy2;
+	u8 rdbuf[10], wrbuf[1];
+	int ret;
+
+	memset(wrbuf, 0, sizeof(wrbuf));
+	memset(rdbuf, 0, sizeof(rdbuf));
+
+	wrbuf[0] = 0;
+	ret = i2c_master_send(tsdata->client, wrbuf, 1);
+	if (ret != 1) {
+		dev_err(&tsdata->client->dev, "Unable to write to i2c touchscreen!\n");
+		goto out;
+	}
+
+	ret = i2c_master_recv(tsdata->client, rdbuf, sizeof(rdbuf));
+	if (ret != sizeof(rdbuf)) {
+		dev_err(&tsdata->client->dev, "Unable to read i2c page!\n");
+		goto out;
+	}
+
+	touching = rdbuf[0];
+	oldtouching = rdbuf[1];
+	posx1 = ((rdbuf[3] << 8) | rdbuf[2]);
+	posy1 = ((rdbuf[5] << 8) | rdbuf[4]);
+	posx2 = ((rdbuf[7] << 8) | rdbuf[6]);
+	posy2 = ((rdbuf[9] << 8) | rdbuf[8]);
+
+	input_report_key(tsdata->input, BTN_TOUCH, touching);
+
+	if (touching == 1) {
+		input_report_abs(tsdata->input, ABS_X, posx1);
+		input_report_abs(tsdata->input, ABS_Y, posy1);
+	}
+
+	if (touching == 2) {
+		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx1);
+		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy1);
+		input_mt_sync(tsdata->input);
+
+		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx2);
+		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy2);
+		input_mt_sync(tsdata->input);
+	} else
+		input_mt_sync(tsdata->input);
+	input_sync(tsdata->input);
+
+	return 0;
+
+out:
+	return -EINVAL;
+}
+
+static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
+{
+	struct pixcir_i2c_ts_data *tsdata = dev_id;
+
+	do {
+		pixcir_ts_poscheck(tsdata);
+		tsdata->attb_pin = tsdata->chip->attb_read_val();
+		if (tsdata->attb_pin == ATTB_PIN_LOW)
+			wait_event_timeout(tsdata->wait, TRUE,
+					msecs_to_jiffies(20));
+	} while (!tsdata->attb_pin);
+
+	return IRQ_HANDLED;
+}
+
+static void pixcir_ts_close(struct input_dev *dev)
+{
+
+}
+
+static int pixcir_i2c_ts_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct pixcir_i2c_ts_data *tsdata;
+	struct input_dev *input;
+	const struct pixcir_i2c_ts_platform *pdata =
+					client->dev.platform_data;
+	int error;
+
+	if (!pdata) {
+		dev_err(&client->dev, "platform data not defined\n");
+		return -EINVAL;
+	}
+
+	tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
+	if (!tsdata) {
+		dev_err(&client->dev, "Failed to allocate driver data!\n");
+		error = -ENOMEM;
+		dev_set_drvdata(&client->dev, NULL);
+		return error;
+	}
+
+	dev_set_drvdata(&client->dev, tsdata);
+
+	input = input_allocate_device();
+	if (!input) {
+		dev_err(&client->dev, "Failed to allocate input device!\n");
+		error = -ENOMEM;
+		input_free_device(input);
+		kfree(tsdata);
+	}
+
+	init_waitqueue_head(&tsdata->wait);
+
+	input->name = client->name;
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &client->dev;
+
+	input->close = pixcir_ts_close;
+
+	input_set_drvdata(input, tsdata);
+
+	tsdata->client = client;
+	tsdata->input = input;
+	tsdata->chip = pdata;
+	tsdata->irq = client->irq;
+
+	set_bit(EV_SYN, input->evbit);
+	set_bit(EV_KEY, input->evbit);
+	set_bit(EV_ABS, input->evbit);
+	set_bit(BTN_TOUCH, input->keybit);
+	input_set_abs_params(input, ABS_X, 0, pdata->ts_x_max, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, pdata->ts_y_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, pdata->ts_x_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, pdata->ts_y_max, 0, 0);
+
+	if (input_register_device(input)) {
+		input_free_device(input);
+		kfree(tsdata);
+	}
+
+	if (request_threaded_irq(tsdata->irq, NULL, pixcir_ts_isr,
+			IRQF_TRIGGER_FALLING, client->name, tsdata)) {
+		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
+		input_unregister_device(input);
+		input = NULL;
+	}
+
+	device_init_wakeup(&client->dev, 1);
+
+	return 0;
+}
+
+static int pixcir_i2c_ts_remove(struct i2c_client *client)
+{
+	struct pixcir_i2c_ts_data *tsdata;
+
+	tsdata = i2c_get_clientdata(client);
+	wake_up(&tsdata->wait);
+	free_irq(tsdata->irq, tsdata);
+	input_unregister_device(tsdata->input);
+	kfree(tsdata);
+	dev_set_drvdata(&client->dev, NULL);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int pixcir_i2c_ts_suspend(struct i2c_client *client,
pm_message_t mesg)
+{
+	struct pixcir_i2c_ts_data *tsdata = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(tsdata->irq);
+
+	return 0;
+}
+
+static int pixcir_i2c_ts_resume(struct i2c_client *client)
+{
+	struct pixcir_i2c_ts_data *tsdata = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(tsdata->irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops pixcir_dev_pm_ops = {
+	.suspend	= pixcir_i2c_ts_suspend,
+	.resume		= pixcir_i2c_ts_resume,
+};
+
+#else
+#define	pixcir_i2c_ts_suspend	NULL
+#define	pixcir_i2c_ts_resume	NULL
+#endif
+
+static const struct i2c_device_id pixcir_i2c_ts_id[] = {
+	{ "pixcir_ts", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pixcir_i2c_ts_id);
+
+static struct i2c_driver pixcir_i2c_ts_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "pixcir_ts",
+#ifdef PM_CONFIG
+		.pm	= &pixcir_dev_pm_ops,
+#endif
+	},
+	.probe		= pixcir_i2c_ts_probe,
+	.remove		= pixcir_i2c_ts_remove,
+	.id_table	= pixcir_i2c_ts_id,
+};
+
+static int __init pixcir_i2c_ts_init(void)
+{
+	/*pixcir_wq = create_singlethread_workqueue("pixcir_wq");
+	if (!pixcir_wq)
+		return -ENOMEM;*/
+	return i2c_add_driver(&pixcir_i2c_ts_driver);
+}
+
+static void __exit pixcir_i2c_ts_exit(void)
+{
+	i2c_del_driver(&pixcir_i2c_ts_driver);
+	/*if (pixcir_wq)
+		destroy_workqueue(pixcir_wq);*/
+}
+
+MODULE_AUTHOR("Jianchun Bian<jcbian@pixcir.com.cn>,Dequan
Meng<dqmeng@pixcir.com.cn>");
+MODULE_DESCRIPTION("Pixcir I2C Touchscreen Driver");
+MODULE_LICENSE("GPL");
+
+module_init(pixcir_i2c_ts_init);
+module_exit(pixcir_i2c_ts_exit);
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.h
b/drivers/input/touchscreen/pixcir_i2c_ts.h
new file mode 100644
index 0000000..b037c27
--- /dev/null
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.h
@@ -0,0 +1,13 @@
+#ifndef	_PIXCIR_I2C_TS_H
+#define	_PIXCIR_I2C_TS_H
+
+#define	TRUE		1
+#define	ATTB_PIN_LOW	0
+
+struct pixcir_i2c_ts_platform {
+	int (*attb_read_val) (void);
+	int ts_x_max;
+	int ts_y_max;
+};
+
+#endif
-- 
1.7.0.4


-- 
Best Regards
Bee/Pixcir

