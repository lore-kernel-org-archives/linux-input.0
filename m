From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: add driver for pixcir i2c touchscreens
Date: Mon, 4 Jul 2011 09:50:00 -0700
Message-ID: <20110704165000.GD8144@core.coreip.homeip.net>
References: <4DDB2516.6050302@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49040 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab1GEEgh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 00:36:37 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so4900484iwn.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 21:36:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DDB2516.6050302@pixcir.com.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jcbian <jcbian@pixcir.com.cn>
Cc: linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

Hi Jianchun,

On Tue, May 24, 2011 at 11:25:10AM +0800, jcbian wrote:
> +
> +static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
> +{
> +	struct pixcir_i2c_ts_data *tsdata = dev_id;
> +
> +	do {
> +		pixcir_ts_poscheck(tsdata);
> +		tsdata->attb_pin = tsdata->chip->attb_read_val();
> +		if (tsdata->attb_pin == ATTB_PIN_LOW)
> +			wait_event_timeout(tsdata->wait, TRUE,
> +					msecs_to_jiffies(20));

This doews not mak sense, you do not do any waiting here since your
condition is 'TRUE' and this the thread never sleeps but spins
constantly.

You also ignored my other comments...

Does the patch below still work for you?

Thanks.

-- 
Dmitry


Input: add driver for pixcir i2c touchscreens

From: Jianchun Bian <jcbian@pixcir.com.cn>

This patch adds a driver for PIXCIR's I2C connected touchscreens.

Signed-off-by: Jianchun <jcbian@pixcir.com.cn>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/Kconfig         |   12 +
 drivers/input/touchscreen/Makefile        |    1 
 drivers/input/touchscreen/pixcir_i2c_ts.c |  235 +++++++++++++++++++++++++++++
 include/linux/input/pixcir_ts.h           |   10 +
 4 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/pixcir_i2c_ts.c
 create mode 100644 include/linux/input/pixcir_ts.h


diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index a369c94..358be1f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -464,6 +464,18 @@ config TOUCHSCREEN_UCB1400
 	  To compile this driver as a module, choose M here: the
 	  module will be called ucb1400_ts.
 
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
 config TOUCHSCREEN_WM831X
 	tristate "Support for WM831x touchscreen controllers"
 	depends on MFD_WM831X
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 141ee3e..c0727a4 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+= htcpen.o
 obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
 obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
+obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+= pixcir_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
 obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
new file mode 100644
index 0000000..0c1ae91
--- /dev/null
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -0,0 +1,235 @@
+/*
+ * Driver for Pixcir I2C touchscreen controllers.
+ *
+ * Copyright (C) 2010-2011 Pixcir, Inc.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/pixcir_ts.h>
+
+struct pixcir_i2c_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	const struct pixcir_ts_platform_data *chip;
+	bool exiting;
+};
+
+static void pixcir_ts_poscheck(struct pixcir_i2c_ts_data *data)
+{
+	struct pixcir_i2c_ts_data *tsdata = data;
+
+	u8 touching;
+	u16 posx1, posy1, posx2, posy2;
+	u8 rdbuf[10], wrbuf[1] = { 0 };
+	int ret;
+
+	ret = i2c_master_send(tsdata->client, wrbuf, sizeof(wrbuf));
+	if (ret != sizeof(wrbuf)) {
+		dev_err(&tsdata->client->dev,
+			"%s: i2c_master_send failed(), ret=%d\n",
+			__func__, ret);
+		return;
+	}
+
+	ret = i2c_master_recv(tsdata->client, rdbuf, sizeof(rdbuf));
+	if (ret != sizeof(rdbuf)) {
+		dev_err(&tsdata->client->dev,
+			"%s: i2c_master_recv failed(), ret=%d\n",
+			__func__, ret);
+		return;
+	}
+
+	touching = rdbuf[0];
+	posx1 = (rdbuf[3] << 8) | rdbuf[2];
+	posy1 = (rdbuf[5] << 8) | rdbuf[4];
+	posx2 = (rdbuf[7] << 8) | rdbuf[6];
+	posy2 = (rdbuf[9] << 8) | rdbuf[8];
+
+	input_report_key(tsdata->input, BTN_TOUCH, touching);
+	input_report_abs(tsdata->input, ABS_X, posx1);
+	input_report_abs(tsdata->input, ABS_Y, posy1);
+
+	input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx1);
+	input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy1);
+	input_mt_sync(tsdata->input);
+
+	if (touching == 2) {
+		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx2);
+		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy2);
+		input_mt_sync(tsdata->input);
+	}
+
+	input_sync(tsdata->input);
+}
+
+static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
+{
+	struct pixcir_i2c_ts_data *tsdata = dev_id;
+
+	while (!tsdata->exiting) {
+		pixcir_ts_poscheck(tsdata);
+
+		if (tsdata->chip->attb_read_val())
+			break;
+
+		msleep(20);
+	}
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int pixcir_i2c_ts_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int pixcir_i2c_ts_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(client->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pixcir_dev_pm_ops,
+			 pixcir_i2c_ts_suspend, pixcir_i2c_ts_resume);
+
+static int __devinit pixcir_i2c_ts_probe(struct i2c_client *client,
+					 const struct i2c_device_id *id)
+{
+	const struct pixcir_ts_platform_data *pdata = client->dev.platform_data;
+	struct pixcir_i2c_ts_data *tsdata;
+	struct input_dev *input;
+	int error;
+
+	if (!pdata) {
+		dev_err(&client->dev, "platform data not defined\n");
+		return -EINVAL;
+	}
+
+	tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!tsdata || !input) {
+		dev_err(&client->dev, "Failed to allocate driver data!\n");
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	tsdata->client = client;
+	tsdata->input = input;
+	tsdata->chip = pdata;
+
+	input->name = client->name;
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &client->dev;
+
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_ABS, input->evbit);
+	__set_bit(BTN_TOUCH, input->keybit);
+	input_set_abs_params(input, ABS_X, 0, pdata->x_max, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, pdata->y_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, pdata->x_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, pdata->y_max, 0, 0);
+
+	input_set_drvdata(input, tsdata);
+
+	error = request_threaded_irq(client->irq, NULL, pixcir_ts_isr,
+				     IRQF_TRIGGER_FALLING,
+				     client->name, tsdata);
+	if (error) {
+		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
+		goto err_free_mem;
+	}
+
+	error = input_register_device(input);
+	if (error)
+		goto err_free_irq;
+
+	i2c_set_clientdata(client, tsdata);
+	device_init_wakeup(&client->dev, 1);
+
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, tsdata);
+err_free_mem:
+	input_free_device(input);
+	kfree(tsdata);
+	return error;
+}
+
+static int __devexit pixcir_i2c_ts_remove(struct i2c_client *client)
+{
+	struct pixcir_i2c_ts_data *tsdata = i2c_get_clientdata(client);
+
+	device_init_wakeup(&client->dev, 0);
+
+	tsdata->exiting = true;
+	mb();
+	free_irq(client->irq, tsdata);
+
+	input_unregister_device(tsdata->input);
+	kfree(tsdata);
+
+	return 0;
+}
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
+		.pm	= &pixcir_dev_pm_ops,
+	},
+	.probe		= pixcir_i2c_ts_probe,
+	.remove		= __devexit_p(pixcir_i2c_ts_remove),
+	.id_table	= pixcir_i2c_ts_id,
+};
+
+static int __init pixcir_i2c_ts_init(void)
+{
+	return i2c_add_driver(&pixcir_i2c_ts_driver);
+}
+module_init(pixcir_i2c_ts_init);
+
+static void __exit pixcir_i2c_ts_exit(void)
+{
+	i2c_del_driver(&pixcir_i2c_ts_driver);
+}
+module_exit(pixcir_i2c_ts_exit);
+
+MODULE_AUTHOR("Jianchun Bian <jcbian@pixcir.com.cn>, Dequan Meng <dqmeng@pixcir.com.cn>");
+MODULE_DESCRIPTION("Pixcir I2C Touchscreen Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/input/pixcir_ts.h b/include/linux/input/pixcir_ts.h
new file mode 100644
index 0000000..7163d91
--- /dev/null
+++ b/include/linux/input/pixcir_ts.h
@@ -0,0 +1,10 @@
+#ifndef	_PIXCIR_I2C_TS_H
+#define	_PIXCIR_I2C_TS_H
+
+struct pixcir_ts_platform_data {
+	int (*attb_read_val)(void);
+	int x_max;
+	int y_max;
+};
+
+#endif
