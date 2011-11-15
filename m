From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:Add Wacom Stylus support for I2C
Date: Mon, 14 Nov 2011 17:06:12 -0800
Message-ID: <20111115010612.GA12910@core.coreip.homeip.net>
References: <1319006175-8630-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34690 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab1KOBGT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 20:06:19 -0500
Received: by iage36 with SMTP id e36so7854650iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 17:06:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1319006175-8630-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

On Wed, Oct 19, 2011 at 03:36:15PM +0900, Tatsunosuke Tobita wrote:
> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> 
> Adding support for Wacom Stylus with I2C interface.
> 
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> ---
>  drivers/input/touchscreen/wacom_i2c.c |  261 +++++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/wacom_i2c.h |   72 +++++++++
>  2 files changed, 333 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/wacom_i2c.c
>  create mode 100644 drivers/input/touchscreen/wacom_i2c.h
> 
> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
> new file mode 100644
> index 0000000..3f16f93
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.c
> @@ -0,0 +1,260 @@
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

		dev_err(&wac_i2c->client->dev,
			"Sending query 1 failed, error: %d",
			ret);

> +		return -1;

		return ret;

> +	}
> +
> +	cmd[0] = CMD_THROW0; cmd[1] = CMD_THROW1;
> +	ret = i2c_master_send(wac_i2c->client, cmd, 2);
> +	if (ret < 0) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev,
> +			   "Sending 2nd Query failed \n");
> +		return -1;
> +	}

Does it have to be 2 separate transactions? Can we combine everything
into a single i2c_transfer()?

> +
> +	ret = i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
> +	if (ret < 0) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev,
> +			   "Receiving data failed 1\n");
> +		return -1;
> +	}
> +
> +	wac_i2c->wac_feature.x_max = get_unaligned_le16(&data[3]);
> +	wac_i2c->wac_feature.y_max = get_unaligned_le16(&data[5]);
> +	wac_i2c->wac_feature.pressure_max = get_unaligned_le16(&data[11]);
> +	wac_i2c->wac_feature.fw_version = get_unaligned_le16(&data[13]);
> +
> +	dev_printk(KERN_INFO, &wac_i2c->client->dev,
> +		   "x_max:%d, y_max:%d, pressure:%d, fw:%d\n",
> +		   wac_i2c->wac_feature.x_max, wac_i2c->wac_feature.y_max,
> +		   wac_i2c->wac_feature.pressure_max, wac_i2c->wac_feature.fw_version);

Looks like a good dev_dbg() candidate.

> +
> +	return 0;
> +}
> +
> +static void wacom_set_coordination(struct wacom_i2c *wac_i2c)

wacom_report_coordinates; but I would fold it into wacom_i2c_irq.

> +{
> +	int ret;
> +	unsigned int x, y, pressure;
> +	unsigned char tsw, f1, f2, ers;
> +	u8 data[COM_COORD_NUM];
> +
> +	do {
> +		ret = i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
> +	} while (gpio_get_value(GPIO) <= 0);

Why do we need to spin and check GPIO here?

> +
> +	if (ret >= 0) {
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
> +}
> +
> +static irqreturn_t wacom_i2c_irq(int irqno, void *param)
> +{
> +	struct wacom_i2c *wac_i2c = param;
> +
> +	wacom_set_coordination(wac_i2c);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static int wacom_i2c_input_open(struct input_dev *dev)
> +{
> +	struct wacom_i2c *wac_i2c = input_get_drvdata(dev);
> +	int ret;
> +
> +	__set_bit(ABS_X, wac_i2c->input->absbit);
> +	__set_bit(ABS_Y, wac_i2c->input->absbit);
> +	__set_bit(ABS_PRESSURE, wac_i2c->input->absbit);

These 3 are not needed, input_set_abs_params will take care of setting
them.

> +	__set_bit(BTN_TOOL_PEN, wac_i2c->input->keybit);
> +	__set_bit(BTN_TOOL_RUBBER, wac_i2c->input->keybit);
> +	__set_bit(BTN_STYLUS, wac_i2c->input->keybit);
> +	__set_bit(BTN_STYLUS2, wac_i2c->input->keybit);
> +	__set_bit(BTN_TOUCH, wac_i2c->input->keybit);

This is too late; input device capabilities should be set before the
device is registered. Please move it all up and including request_irq
into your probe function.

> +
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
> +
> +	if (request_threaded_irq(EMR_IRQ, NULL,

Use client->irq instead.

> +				 wacom_i2c_irq, IRQF_TRIGGER_FALLING, "WACOM_I2C_IRQ", wac_i2c)) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev, "Failed to enable IRQ for EMR \n");
> +		return -EIO;

Please report error code that request_threaded_irq returned, no need to
mangle it with your own. Besides -EIO does not fit here at all, -EBUSY
would fit better.

> +	}
> +
> +	/*Clear the buffer in the firmware*/
> +	wacom_set_coordination(wac_i2c);

Why is this needed?

> +
> +	return 0;
> +}
> +
> +static void wacom_i2c_input_close(struct input_dev *dev)
> +{
> +	disable_irq(EMR_IRQ);

This is not balanced; if you open/close device several times you'll end
up with IRQ disabled.

> +}
> +
> +static int wacom_i2c_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)

__devinit.

> +{
> +	struct wacom_i2c *wac_i2c;
> +	int err;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		err = -EIO;
> +		goto fail1;
> +	}
> +
> +	wac_i2c = kzalloc(sizeof(struct wacom_i2c), GFP_KERNEL);
> +	wac_i2c->input = input_allocate_device();
> +	if (wac_i2c == NULL || wac_i2c->input == NULL) {
> +		err = -ENOMEM;
> +		goto fail2;
> +	}
> +
> +	wac_i2c->client = client;
> +	i2c_set_clientdata(client, wac_i2c);
> +
> +	mutex_init(&wac_i2c->lock);

What is it used for?

> +
> +	wac_i2c->input->name = "WACOM_I2C_DIGITIZER";

Maybe "Wacom I2C Digitizer"?

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
> +		err = -ENODEV;
> +		goto fail3;
> +	}
> +
> +	return 0;
> +
> + fail3:
> +	input_free_device(wac_i2c->input);
> + fail2:
> +	kfree(wac_i2c);
> +	dev_printk(KERN_ERR, &wac_i2c->client->dev, "Freeing device \n");
> + fail1:
> +	printk(KERN_ERR "wacom_i2c: No I2C functionality found \n");

dev_err(). And this reporting is misleading as it will trigger even when
let's say device registration failed.

> +	return err;
> +}
> +
> +static int wacom_i2c_remove(struct i2c_client *client)

__devexit.

> +{
> +	struct wacom_i2c *wac_i2c = i2c_get_clientdata(client);
> +
> +	free_irq(EMR_IRQ, wac_i2c);
> +	input_unregister_device(wac_i2c->input);
> +	kfree(wac_i2c);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int wacom_i2c_suspend(struct device *dev)
> +{
> +	disable_irq(EMR_IRQ);
> +
> +	return 0;
> +}
> +
> +static int wacom_i2c_resume(struct device *dev)
> +{
> +	enable_irq(EMR_IRQ);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops wacom_i2c_pm = {
> +	.suspend = wacom_i2c_suspend,
> +	.resume = wacom_i2c_resume,
> +};

Lose this definition in favor of below.

> +#endif

static SIMPLE_DEV_OP_OPS(wacom_i2c_pm, wacom_i2c_suspend, wacom_i2c_resume);

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
> +#ifdef CONFIG_PM
> +		.pm = &wacom_i2c_pm,
> +#endif

Lose this ifdef.

> +	},
> +
> +	.probe = wacom_i2c_probe,
> +	.remove = wacom_i2c_remove,

__devexit_p()

> +	.id_table = wacom_i2c_id,
> +};
> +
> +static int __init wacom_i2c_init(void)
> +{
> +	return i2c_add_driver(&wacom_i2c_driver);
> +}
> +
> +static void __exit wacom_i2c_exit(void)
> +{
> +	i2c_del_driver(&wacom_i2c_driver);
> +}
> +
> +module_init(wacom_i2c_init);
> +module_exit(wacom_i2c_exit);
> +
> +MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>");
> +MODULE_DESCRIPTION("WACOM EMR I2C Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/input/touchscreen/wacom_i2c.h b/drivers/input/touchscreen/wacom_i2c.h
> new file mode 100644
> index 0000000..13d86f9
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.h
> @@ -0,0 +1,72 @@
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
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/uaccess.h>
> +#include <linux/device.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <asm/unaligned.h>
> +#include <asm/system.h>

You need _all_ these headers?

> +
> +#define NAMEBUF 12
> +#define WACNAME "WAC_I2C_EMR"
> +
> +/*Wacom Command*/
> +#define COM_COORD_NUM      256
> +#define COM_SAMPLERATE_40  0x33
> +#define COM_SAMPLERATE_80  0x32
> +#define COM_SAMPLERATE_133 0x31
> +#define CMD_QUERY0         0x04
> +#define CMD_QUERY1         0x00
> +#define CMD_QUERY2         0x33
> +#define CMD_QUERY3         0x02
> +#define CMD_THROW0         0x05
> +#define CMD_THROW1         0x00
> +#define QUERY_SIZE           19
> +
> +/*I2C address for digitizer*/
> +#define WACOM_I2C_ADDR   0x09
> +
> +/*Set a specific pin number on GPI for IRQ*/
> +#define GPIO 1

No, please don't.

> +#define EMR_IRQ gpio_to_irq(GPIO)
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
> +	struct wacom_features wac_feature;
> +	int type;
> +	const char name[NAMEBUF];

If this is const how do you set it?

> +};
> +#endif
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
