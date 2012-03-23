From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] Input: Wacom Stylus driver for I2C interface
Date: Fri, 23 Mar 2012 23:32:14 +0530
Message-ID: <4F6CBAA6.9010308@ti.com>
References: <1332481207-6224-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35165 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755952Ab2CWSC0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Mar 2012 14:02:26 -0400
Received: by mail-yx0-f182.google.com with SMTP id l9so3695951yen.41
        for <linux-input@vger.kernel.org>; Fri, 23 Mar 2012 11:02:24 -0700 (PDT)
In-Reply-To: <1332481207-6224-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

Hi ,
Some comments / doubts.

On Friday 23 March 2012 11:10 AM, Tatsunosuke Tobita wrote:
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
May be use dev_err . Feel free to ignore if you feel so. Just a suggestion
> +		return -1;

Why mask the error?
> +	}
> +
> +	cmd[0] = CMD_THROW0; cmd[1] = CMD_THROW1;
> +	ret = i2c_master_send(wac_i2c->client, cmd, 2);
> +	if (ret < 0) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev,
> +			   "Sending 2nd Query failed \n");
> +		return -1;
same
> +	}
> +
> +	ret = i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
> +	if (ret < 0) {
> +		dev_printk(KERN_ERR, &wac_i2c->client->dev,
> +			   "Receiving data failed 1\n");
> +		return -1;
same
> +	}
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
> +
> +	return 0;
> +}
> +
> +static void wacom_i2c_input_close(struct input_dev *dev)
> +{
> +}
May be this could be cleaned up?
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
We are leaking wac_i2c here ?
> +	}
> +
> +	wac_i2c->client = client;
> +	i2c_set_clientdata(client, wac_i2c);
> +	mutex_init(&wac_i2c->lock);
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
> +		err = -ENODEV;
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
Why is this disable needed?
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
> + 
nit : 2012?
