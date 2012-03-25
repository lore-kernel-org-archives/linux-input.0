From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Wacom Stylus driver for I2C interface
Date: Sun, 25 Mar 2012 16:50:34 -0700
Message-ID: <20120325235034.GA1054@core.coreip.homeip.net>
References: <1332481207-6224-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35241 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387Ab2CYXuk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Mar 2012 19:50:40 -0400
Received: by pbcun15 with SMTP id un15so5218503pbc.19
        for <linux-input@vger.kernel.org>; Sun, 25 Mar 2012 16:50:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332481207-6224-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

Hi Tatsunosuke,

On Fri, Mar 23, 2012 at 02:40:07PM +0900, Tatsunosuke Tobita wrote:
> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> 
> This adds support for Wacom Stylus device with I2C interface.
> The modification from the previous update is replacing module_init and
> module_exit with module_i2c_driver.
> 
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> ---
>  drivers/input/touchscreen/wacom_i2c.c |  238 +++++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/wacom_i2c.h |   55 ++++++++
>  2 files changed, 293 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/wacom_i2c.c
>  create mode 100644 drivers/input/touchscreen/wacom_i2c.h
> 
> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
> new file mode 100644
> index 0000000..f5a3845
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.c
> @@ -0,0 +1,238 @@
> +/*
> + * Wacom Penabled Driver for I2C
> + *
> + * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
> + * <tobita.tatsunosuke@wacom.co.jp>
> + *
> + * This program is free software; you can redistribute it
> + * and/or modify it under the terms of the GNU General
> + * Public License as published by the Free Software
> + * Foundation; either version of 2 of the License,
> + * or (at your option) any later version.
> + */
> +
> +#include "wacom_i2c.h"
> +
> +static int wacom_send_query(struct wacom_i2c *wac_i2c)
> +{
> +	int ret;
> +	u8 cmd[4] = {CMD_QUERY0, CMD_QUERY1, CMD_QUERY2, CMD_QUERY3};
> +	u8 data[COM_COORD_NUM];
> +
> +	ret = i2c_master_send(wac_i2c->client, cmd, sizeof(cmd));
> +	if (ret < 0) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev,
> +			   "Sending 1st Query failed \n");
> +		return -1;

As Shubhrajyoti already mentioned you should not clobber errors returned
by i2c_master_send with a generic -1 (-EPERM).

> +	}
> +
> +	cmd[0] = CMD_THROW0; cmd[1] = CMD_THROW1;
> +	ret = i2c_master_send(wac_i2c->client, cmd, 2);
> +	if (ret < 0) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev,
> +			   "Sending 2nd Query failed \n");
> +		return -1;
> +	}
> +
> +	ret = i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
> +	if (ret < 0) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev,
> +			   "Receiving data failed 1\n");
> +		return -1;
> +	}

I wonder if all this could be converted into a single i2c_transfer().

> +
> +	wac_i2c->wac_feature.x_max = get_unaligned_le16(&data[3]);
> +	wac_i2c->wac_feature.y_max = get_unaligned_le16(&data[5]);
> +	wac_i2c->wac_feature.pressure_max = get_unaligned_le16(&data[11]);
> +	wac_i2c->wac_feature.fw_version = get_unaligned_le16(&data[13]);
> +
> +	dev_dbg(&wac_i2c->client->dev,
> +		   "x_max:%d, y_max:%d, pressure:%d, fw:%d\n",
> +		   wac_i2c->wac_feature.x_max, wac_i2c->wac_feature.y_max,
> +		   wac_i2c->wac_feature.pressure_max, wac_i2c->wac_feature.fw_version);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t wacom_i2c_irq(int irqno, void *param)
> +{
> +	struct wacom_i2c *wac_i2c = param;
> +       int ret;
> +	unsigned int x, y, pressure;
> +	unsigned char tsw, f1, f2, ers;
> +	u8 data[COM_COORD_NUM];
> +
> +	do {
> +		ret = i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
> +	} while (gpio_get_value(irq_to_gpio(wac_i2c->client->irq)) == 0);

irq_to_gpio() may fail. Also it does not make sense to do the conversion
in interrupt handler if it can be done once, at probe() time.

> +
> +	if (ret > 0) {
> +		tsw = data[3]&0x01;
> +		ers = data[3]&0x04;
> +		f1 = data[3]&0x02;
> +		f2 = data[3]&0x10;
> +		x = le16_to_cpup((__le16 *)&data[4]);
> +		y = le16_to_cpup((__le16 *)&data[6]);
> +		pressure = le16_to_cpup((__le16 *)&data[8]);
> +
> +		input_report_abs(wac_i2c->input, ABS_X, x);
> +		input_report_abs(wac_i2c->input, ABS_Y, y);
> +		input_report_key(wac_i2c->input, BTN_TOOL_PEN, tsw);
> +		input_report_key(wac_i2c->input, BTN_TOOL_RUBBER, ers);
> +		input_report_abs(wac_i2c->input, ABS_PRESSURE, pressure);
> +		input_report_key(wac_i2c->input, BTN_TOUCH, (tsw || ers));
> +		input_report_key(wac_i2c->input, BTN_STYLUS, f1);
> +		input_report_key(wac_i2c->input, BTN_STYLUS2, f2);
> +
> +		input_sync(wac_i2c->input);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int wacom_i2c_input_open(struct input_dev *dev)
> +{
> +	struct wacom_i2c *wac_i2c = input_get_drvdata(dev);
> +	int ret;
> +	ret = wacom_send_query(wac_i2c);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	wac_i2c->input->id.version = wac_i2c->wac_feature.fw_version;
> +	input_set_abs_params(wac_i2c->input, ABS_X, 0,
> +			     wac_i2c->wac_feature.x_max, 0, 0);
> +	input_set_abs_params(wac_i2c->input, ABS_Y, 0,
> +			     wac_i2c->wac_feature.y_max, 0, 0);
> +	input_set_abs_params(wac_i2c->input, ABS_PRESSURE, 0,
> +			     wac_i2c->wac_feature.pressure_max, 0, 0);

This should be done when registering input device.

> +
> +	return 0;
> +}
> +
> +static void wacom_i2c_input_close(struct input_dev *dev)
> +{
> +}

Empty methods are not needed.

> +
> +static int __devinit wacom_i2c_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	struct wacom_i2c *wac_i2c;
> +	int err;
> +	u8 data[COM_COORD_NUM];
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		err = -EIO;
> +		goto fail1;
> +	}
> +
> +	wac_i2c = kzalloc(sizeof(*wac_i2c), GFP_KERNEL);
> +	if (wac_i2c == NULL) {
> +		err = -ENOMEM;
> +		goto fail2;
> +	}
> +
> +	wac_i2c->input = input_allocate_device();
> +	if (wac_i2c->input == NULL) {
> +		err = -ENOMEM;
> +		goto fail2;
> +	}
> +
> +	wac_i2c->client = client;
> +	i2c_set_clientdata(client, wac_i2c);
> +	mutex_init(&wac_i2c->lock);

What is this lock used for?

> +
> +	__set_bit(BTN_TOOL_PEN, wac_i2c->input->keybit);
> +	__set_bit(BTN_TOOL_RUBBER, wac_i2c->input->keybit);
> +	__set_bit(BTN_STYLUS, wac_i2c->input->keybit);
> +	__set_bit(BTN_STYLUS2, wac_i2c->input->keybit);
> +	__set_bit(BTN_TOUCH, wac_i2c->input->keybit);
> +
> +	wac_i2c->input->name = "Wacom I2C Digitizer";
> +	wac_i2c->input->id.bustype = BUS_I2C;
> +	wac_i2c->input->id.vendor = 0x56a;
> +	wac_i2c->input->dev.parent = &client->dev;
> +	wac_i2c->input->open = wacom_i2c_input_open;
> +	wac_i2c->input->close = wacom_i2c_input_close;
> +	wac_i2c->input->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	input_set_drvdata(wac_i2c->input, wac_i2c);
> +
> +	if (input_register_device(wac_i2c->input)) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev, "Failed to register input device \n");

dev_err() and dev_info() throughout.

> +		err = -ENODEV;

The proper error is ENOMEM.

> +		goto fail3;
> +	}
> +
> +
> +	err = request_threaded_irq(wac_i2c->client->irq, NULL,
> +				   wacom_i2c_irq, IRQF_TRIGGER_FALLING, "WACOM_I2C_IRQ", wac_i2c);
> +	if (err) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev, "Failed to enable IRQ for EMR \n");
> +		goto fail3;
> +	}
> +
> +	/*Clear the buffer in the firmware*/
> +	do {
> +		i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
> +	} while (gpio_get_value(irq_to_gpio(wac_i2c->client->irq)) == 0);

This should be done at open() time.

> +
> +	return 0;
> +
> + fail3:
> +	input_free_device(wac_i2c->input);
> + fail2:
> +	dev_err(&wac_i2c->client->dev, "Freeing device \n");
> + fail1:
> +	return err;
> +}
> +
> +static int __devexit wacom_i2c_remove(struct i2c_client *client)
> +{
> +	struct wacom_i2c *wac_i2c = i2c_get_clientdata(client);
> +
> +	free_irq(wac_i2c->client->irq, wac_i2c);
> +	input_unregister_device(wac_i2c->input);
> +	kfree(wac_i2c);
> +
> +	return 0;
> +}
> +
> +static int wacom_i2c_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	disable_irq(client->irq);

I guess disabling IRQ is OK for now, but don't you want to use it as a
wakeup source?

> +
> +	return 0;
> +}
> +
> +static int wacom_i2c_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	enable_irq(client->irq);
> +
> +	return 0;
> +}

Suspend and resume should be guarded by #ifdef CONFIG_PM_SLEEP

> +
> +static SIMPLE_DEV_PM_OPS(wacom_i2c_pm, wacom_i2c_suspend, wacom_i2c_resume);
> +
> +static const struct i2c_device_id wacom_i2c_id[] = {
> +	{WACNAME, 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
> +
> +static struct i2c_driver wacom_i2c_driver = {
> +	.driver = {
> +		.name = "wacom_i2c",
> +		.owner = THIS_MODULE,
> +		.pm = &wacom_i2c_pm,
> +	},
> +
> +	.probe = wacom_i2c_probe,
> +	.remove = __devexit_p(wacom_i2c_remove),
> +	.id_table = wacom_i2c_id,
> +};
> +module_i2c_driver(wacom_i2c_driver);
> +
> +MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>");
> +MODULE_DESCRIPTION("WACOM EMR I2C Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/input/touchscreen/wacom_i2c.h b/drivers/input/touchscreen/wacom_i2c.h
> new file mode 100644
> index 0000000..b5c2d07
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.h
> @@ -0,0 +1,55 @@
> +/*
> + * Wacom Penabled Driver for I2C
> + *
> + * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
> + * <tobita.tatsunosuke@wacom.co.jp>
> + *
> + * This program is free software; you can redistribute it
> + * and/or modify it under the terms of the GNU General
> + * Public License as published by the Free Software
> + * Foundation; either version of 2 of the License,
> + * or (at your option) any later version.
> + */
> +
> +#ifndef WACOM_I2C_H
> +#define WACOM_I2C_H
> +
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <asm/unaligned.h>
> +
> +#define NAMEBUF 12

Not used.

> +#define WACNAME "WAC_I2C_EMR"
> +
> +/*Wacom Command*/
> +#define COM_COORD_NUM      128
> +#define CMD_QUERY0         0x04
> +#define CMD_QUERY1         0x00
> +#define CMD_QUERY2         0x33
> +#define CMD_QUERY3         0x02
> +#define CMD_THROW0         0x05
> +#define CMD_THROW1         0x00
> +#define QUERY_SIZE           19
> +
> +/*Parameters for wacom own features*/
> +struct wacom_features {
> +	int x_max;
> +	int y_max;
> +	int pressure_max;
> +	char fw_version;
> +};
> +
> +/*Parameters for i2c driver*/
> +struct wacom_i2c {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct mutex lock;

Not used.

> +	struct wacom_features wac_feature;

No need to carry this around, you only use it once.

> +	int type;

Not needed.

> +};
> +#endif

I also do not see why you need a separate header file and why you split
this into 2 patches - one with driver and another with Kconfig/Makefile
adjustments.

Could you please try the version below and let me know if it works for
you. Thanks!

-- 
Dmitry


Input: add support for Wacom Stylus device with I2C interface

From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

This adds support for Wacom Stylus device with I2C interface.

Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/Kconfig     |   12 +
 drivers/input/touchscreen/Makefile    |    1 
 drivers/input/touchscreen/wacom_i2c.c |  338 +++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/wacom_i2c.c


diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 3594591..1773001 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -323,6 +323,18 @@ config TOUCHSCREEN_WACOM_W8001
 	  To compile this driver as a module, choose M here: the
 	  module will be called wacom_w8001.
 
+config TOUCHSCREEN_WACOM_I2C
+	tristate "Wacom Tablet support (I2C)"
+	depends on I2C
+	help
+	  Say Y here if you want to use the I2C version of the Wacom
+	  Pen Tablet.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called wacom_i2c.
+
 config TOUCHSCREEN_LPC32XX
 	tristate "LPC32XX touchscreen controller"
 	depends on ARCH_LPC32XX
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index b6c746e0..eb8bfe1 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
 obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+= wacom_w8001.o
+obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C)	+= wacom_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_WM831X)	+= wm831x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+= wm97xx-ts.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9705)	+= wm9705.o
diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
new file mode 100644
index 0000000..88e0800
--- /dev/null
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -0,0 +1,338 @@
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
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <asm/unaligned.h>
+
+#define WACOM_CMD_QUERY0	0x04
+#define WACOM_CMD_QUERY1	0x00
+#define WACOM_CMD_QUERY2	0x33
+#define WACOM_CMD_QUERY3	0x02
+#define WACOM_CMD_THROW0	0x05
+#define WACOM_CMD_THROW1	0x00
+#define WACOM_QUERY_SIZE	19
+#define WACOM_RETRY_CNT		100
+
+struct wacom_features {
+	int x_max;
+	int y_max;
+	int pressure_max;
+	char fw_version;
+};
+
+struct wacom_i2c {
+	struct i2c_client *client;
+	struct input_dev *input;
+	unsigned int gpio;
+	u8 data[WACOM_QUERY_SIZE];
+};
+
+static int wacom_query_device(struct i2c_client *client,
+			      struct wacom_features *features)
+{
+	int ret;
+	u8 cmd1[] = { WACOM_CMD_QUERY0, WACOM_CMD_QUERY1,
+			WACOM_CMD_QUERY2, WACOM_CMD_QUERY3 };
+	u8 cmd2[] = { WACOM_CMD_THROW0, WACOM_CMD_THROW1 };
+	u8 data[WACOM_QUERY_SIZE];
+#if 1
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = sizeof(cmd1),
+			.buf = cmd1,
+		},
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = sizeof(cmd2),
+			.buf = cmd2,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(data),
+			.buf = data,
+		},
+	};
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+#else
+	ret = i2c_master_send(client, cmd1, sizeof(cmd1));
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Sending 1st Query failed, error: %d\n", ret);
+		return ret;
+	}
+
+	ret = i2c_master_send(client, cmd2, sizeof(cmd2));
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Sending 2nd Query failed, error: %d\n", ret);
+		return ret;
+	}
+
+	ret = i2c_master_recv(client, data, sizeof(data));
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Receiving data failed, error: %d\n", ret);
+		return ret;
+	}
+#endif
+
+	features->x_max = get_unaligned_le16(&data[3]);
+	features->y_max = get_unaligned_le16(&data[5]);
+	features->pressure_max = get_unaligned_le16(&data[11]);
+	features->fw_version = get_unaligned_le16(&data[13]);
+
+	dev_dbg(&client->dev,
+		"x_max:%d, y_max:%d, pressure:%d, fw:%d\n",
+		features->x_max, features->y_max,
+		features->pressure_max, features->fw_version);
+
+	return 0;
+}
+
+static int wacom_i2c_fetch_data(struct wacom_i2c *wac_i2c)
+{
+	int retries = 0;
+	int ret;
+
+	do {
+		ret = i2c_master_recv(wac_i2c->client,
+				      wac_i2c->data, sizeof(wac_i2c->data));
+	} while (gpio_get_value(wac_i2c->gpio) == 0 &&
+		 retries++ < WACOM_RETRY_CNT);
+
+	if (retries >= WACOM_RETRY_CNT)
+		ret = -EIO;
+
+	return ret < 0 ? ret : 0;
+}
+
+static irqreturn_t wacom_i2c_irq(int irq, void *dev_id)
+{
+	struct wacom_i2c *wac_i2c = dev_id;
+	struct input_dev *input = wac_i2c->input;
+	u8 *data = wac_i2c->data;
+	unsigned int x, y, pressure;
+	unsigned char tsw, f1, f2, ers;
+	int error;
+
+	error = wacom_i2c_fetch_data(wac_i2c);
+	if (error)
+		goto out;
+
+	tsw = data[3] & 0x01;
+	ers = data[3] & 0x04;
+	f1 = data[3] & 0x02;
+	f2 = data[3] & 0x10;
+	x = le16_to_cpup((__le16 *)&data[4]);
+	y = le16_to_cpup((__le16 *)&data[6]);
+	pressure = le16_to_cpup((__le16 *)&data[8]);
+
+	input_report_key(input, BTN_TOUCH, tsw || ers);
+	input_report_key(input, BTN_TOOL_PEN, tsw);
+	input_report_key(input, BTN_TOOL_RUBBER, ers);
+	input_report_key(input, BTN_STYLUS, f1);
+	input_report_key(input, BTN_STYLUS2, f2);
+	input_report_abs(input, ABS_X, x);
+	input_report_abs(input, ABS_Y, y);
+	input_report_abs(input, ABS_PRESSURE, pressure);
+
+	input_sync(wac_i2c->input);
+out:
+	return IRQ_HANDLED;
+}
+
+static int wacom_i2c_open(struct input_dev *dev)
+{
+	struct wacom_i2c *wac_i2c = input_get_drvdata(dev);
+	struct i2c_client *client = wac_i2c->client;
+	int error;
+
+	/* Clear the device buffer */
+	error = wacom_i2c_fetch_data(wac_i2c);
+	if (error)
+		return error;
+
+	enable_irq(client->irq);
+
+	return 0;
+}
+
+static void wacom_i2c_close(struct input_dev *dev)
+{
+	struct wacom_i2c *wac_i2c = input_get_drvdata(dev);
+	struct i2c_client *client = wac_i2c->client;
+
+	disable_irq(client->irq);
+}
+
+static int __devinit wacom_i2c_probe(struct i2c_client *client,
+				     const struct i2c_device_id *id)
+{
+	struct wacom_i2c *wac_i2c;
+	struct input_dev *input;
+	struct wacom_features features;
+	int gpio;
+	int error;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "i2c_check_functionality error\n");
+		return -EIO;
+	}
+
+	gpio = irq_to_gpio(client->irq);
+	if (gpio < 0) {
+		error = gpio;
+		dev_err(&client->dev,
+			"irq_to_gpio() failed, error: %d\n", error);
+		return error;
+	}
+
+	error = wacom_query_device(client, &features);
+	if (error)
+		return error;
+
+	wac_i2c = kzalloc(sizeof(*wac_i2c), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!wac_i2c || !input) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	wac_i2c->client = client;
+	wac_i2c->input = input;
+	wac_i2c->gpio = gpio;
+
+	input->name = "Wacom I2C Digitizer";
+	input->id.bustype = BUS_I2C;
+	input->id.vendor = 0x56a;
+	input->id.version = features.fw_version;
+	input->dev.parent = &client->dev;
+	input->open = wacom_i2c_open;
+	input->close = wacom_i2c_close;
+
+	input->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+
+	__set_bit(BTN_TOOL_PEN, input->keybit);
+	__set_bit(BTN_TOOL_RUBBER, input->keybit);
+	__set_bit(BTN_STYLUS, input->keybit);
+	__set_bit(BTN_STYLUS2, input->keybit);
+	__set_bit(BTN_TOUCH, input->keybit);
+
+	input_set_abs_params(input, ABS_X, 0, features.x_max, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, features.y_max, 0, 0);
+	input_set_abs_params(input, ABS_PRESSURE,
+			     0, features.pressure_max, 0, 0);
+
+	input_set_drvdata(input, wac_i2c);
+
+	error = request_threaded_irq(client->irq, NULL, wacom_i2c_irq,
+				     IRQF_TRIGGER_FALLING,
+				     "wacom_i2c", wac_i2c);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to enable IRQ, error: %d\n", error);
+		goto err_free_mem;
+	}
+
+	/* Disable the IRQ, we'll enable it in wac_i2c_open() */
+	disable_irq(client->irq);
+
+	error = input_register_device(wac_i2c->input);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to register input device, error: %d\n", error);
+		goto err_free_irq;
+	}
+
+	i2c_set_clientdata(client, wac_i2c);
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, wac_i2c);
+err_free_mem:
+	input_free_device(wac_i2c->input);
+	kfree(wac_i2c);
+
+	return error;
+}
+
+static int __devexit wacom_i2c_remove(struct i2c_client *client)
+{
+	struct wacom_i2c *wac_i2c = i2c_get_clientdata(client);
+
+	free_irq(client->irq, wac_i2c);
+	input_unregister_device(wac_i2c->input);
+	kfree(wac_i2c);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int wacom_i2c_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	disable_irq(client->irq);
+
+	return 0;
+}
+
+static int wacom_i2c_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	enable_irq(client->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(wacom_i2c_pm, wacom_i2c_suspend, wacom_i2c_resume);
+
+static const struct i2c_device_id wacom_i2c_id[] = {
+	{ "WAC_I2C_EMR", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
+
+static struct i2c_driver wacom_i2c_driver = {
+	.driver	= {
+		.name	= "wacom_i2c",
+		.owner	= THIS_MODULE,
+		.pm	= &wacom_i2c_pm,
+	},
+
+	.probe		= wacom_i2c_probe,
+	.remove		= __devexit_p(wacom_i2c_remove),
+	.id_table	= wacom_i2c_id,
+};
+module_i2c_driver(wacom_i2c_driver);
+
+MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>");
+MODULE_DESCRIPTION("WACOM EMR I2C Driver");
+MODULE_LICENSE("GPL");
