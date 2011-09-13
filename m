From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Tue, 13 Sep 2011 11:15:15 +0200
Message-ID: <20110913091515.GA5658@polaris.bitmath.org>
References: <20110812203003.GA8995@polaris.bitmath.org>
 <1315482029-13761-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:58172 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab1IMJLr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 05:11:47 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 93BD1EAB26
	for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 11:11:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315482029-13761-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: kzjeef@gmail.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi Zhang,

thanks for the changes, please some some comments inline.

> this patch adds EETI eGalax serial multi touch controller driver.

s/this/This/
s/adds/adds the/

> EETI eGalax serial touch screen controller is a I2C based multiple
> capacitive touch screen controller, it can supports 5 touch events maximum.

s/supports/support/

> diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
> new file mode 100644
> index 0000000..9f0a527
> --- /dev/null
> +++ b/drivers/input/touchscreen/egalax_ts.c
> @@ -0,0 +1,299 @@
> +/*
> + * Driver for EETI eGalax Multiple Touch Controller
> + *
> + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> + *
> + * based on max11801_ts.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/* EETI eGalax serial touch screen controller is a I2C based multiple
> + * touch screen controller, it can supports 5 pointer multiple touch. */
> +
> +/* TODO:
> +  - auto idle mode support
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/input/mt.h>
> +
> +/* Mouse Mode: some panel may configure the controller to mouse mode,
> + * which can only one point at a given time. */

s/only/only report/

> +#define REPORT_MODE_MOUSE		0x1
> +/* Vendor Mode: this mode is used to transfer some vendor specify
> + * messages, it was ignore in this driver. */
> +#define REPORT_MODE_VENDOR		0x3

Since this is ignored, it could be dropped entirely, or possibly be
mentioned in the comment.

> +/* Multiple Touch Mode */
> +#define REPORT_MODE_MTTOUCH		0x4
> +
> +#define MAX_SUPPORT_POINTS		5
> +
> +#define EVENT_VALID_OFFSET	7
> +#define EVENT_VAILD_MASK	(0x1 << EVENT_VALID_OFFSET)

s/VAILD/VALID/

> +#define EVENT_ID_OFFSET		2
> +#define EVENT_ID_MASK		(0xf << EVENT_ID_OFFSET)
> +#define EVENT_IN_RANGE		(0x1 << 1)
> +#define EVENT_DOWN_UP		(0X1 << 0)
> +
> +#define MAX_I2C_DATA_LEN	10
> +
> +#define EGALAX_MAX_X	32760
> +#define EGALAX_MAX_Y	32760
> +
> +struct egalax_ts {
> +	struct i2c_client		*client;
> +	struct input_dev		*input_dev;
> +};
> +
> +static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
> +{
> +	struct egalax_ts *data = dev_id;
> +	struct input_dev *input_dev = data->input_dev;
> +	struct i2c_client *client = data->client;
> +	u8 buf[MAX_I2C_DATA_LEN];
> +	int id, ret, x, y, z;
> +	bool down, valid;
> +	u8 state;
> +
> +retry:
> +	ret = i2c_master_recv(client, buf, MAX_I2C_DATA_LEN);
> +	if (ret == -EAGAIN)
> +		goto retry;
> +
> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	if (buf[0] != REPORT_MODE_VENDOR
> +	    && buf[0] != REPORT_MODE_MOUSE
> +	    && buf[0] != REPORT_MODE_MTTOUCH) {
> +		/* invalid point */
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (buf[0] == REPORT_MODE_VENDOR) {
> +		dev_dbg(&client->dev, "vendor message, ignore...\n");
> +		return IRQ_HANDLED;
> +	}

Why not merge the vendor mode with the rest of the stuff you ignore? Something like

if (buf[0] != REPORT_MODE_MOUSE && buf[0] != REPORT_MODE_MTTOUCH)
	return IRQ_HANDLED;

> +
> +	state = buf[1];
> +	x = (buf[3] << 8) | buf[2];
> +	y = (buf[5] << 8) | buf[4];
> +	z = (buf[7] << 8) | buf[6]; /* only valid in multitouch mode. */
> +
> +	if (buf[0] == REPORT_MODE_MOUSE) {
> +		input_report_abs(input_dev, ABS_X, x);
> +		input_report_abs(input_dev, ABS_Y, y);
> +		input_report_key(input_dev, BTN_TOUCH, !!state);
> +		input_sync(input_dev);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* deal with multiple touch  */
> +	valid = state & EVENT_VAILD_MASK;
> +	id = (state & EVENT_ID_MASK) >> EVENT_ID_OFFSET;
> +	down = state & EVENT_DOWN_UP;
> +
> +	if (!valid || id > MAX_SUPPORT_POINTS) {
> +		dev_dbg(&client->dev, "point invalid\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	input_mt_slot(input_dev, id);
> +	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, down);
> +
> +	dev_dbg(&client->dev, "%s id:%d x:%d y:%d z:%d",
> +		(down ? "down" : "up"), id, x, y, z);
> +
> +	if (down) {
> +		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
> +		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
> +		input_report_abs(input_dev, ABS_MT_PRESSURE, z);
> +	}
> +
> +	input_mt_report_pointer_emulation(input_dev, true);
> +	input_sync(input_dev);
> +	return IRQ_HANDLED;
> +}
> +
> +/* wake up controller by an falling edge of interrupt gpio.  */
> +static int egalax_wake_up_device(struct i2c_client *client)
> +{
> +	int gpio = irq_to_gpio(client->irq);
> +	int ret;
> +
> +	ret = gpio_request(gpio, "egalax_irq");
> +	if (ret < 0) {
> +		dev_err(&client->dev, "request gpio failed,"
> +			"cannot wake up controller:%d\n", ret);
> +		return ret;
> +	}
> +	/* wake up controller via an falling edge on IRQ gpio. */
> +	gpio_direction_output(gpio, 0);
> +	gpio_set_value(gpio, 1);
> +	/* controller should be waken up, return irq.  */
> +	gpio_direction_input(gpio);
> +	gpio_free(gpio);
> +	return 0;
> +}
> +
> +static int egalax_firmware_version(struct i2c_client *client)
> +{
> +	static const u8 cmd[MAX_I2C_DATA_LEN] = { 0x03, 0x03, 0xa, 0x01, 0x41 };
> +	int ret;
> +	ret = i2c_master_send(client, cmd, MAX_I2C_DATA_LEN);
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}
> +
> +static int __devinit egalax_ts_probe(struct i2c_client *client,
> +				       const struct i2c_device_id *id)
> +{
> +	struct egalax_ts *data;
> +	struct input_dev *input_dev;
> +	int ret;
> +
> +	data = kzalloc(sizeof(struct egalax_ts), GFP_KERNEL);
> +	if (!data) {
> +		dev_err(&client->dev, "Failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	input_dev = input_allocate_device();
> +	if (!input_dev) {
> +		dev_err(&client->dev, "Failed to allocate memory\n");
> +		ret = -ENOMEM;
> +		goto err_free_data;
> +	}
> +
> +	data->client = client;
> +	data->input_dev = input_dev;
> +	/* controller may be in sleep, wake it up. */
> +	egalax_wake_up_device(client);
> +	ret = egalax_firmware_version(client);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"egalax_ts: failed to read firmware version\n");
> +		ret = -EIO;
> +		goto err_free_dev;
> +	}
> +
> +	input_dev->name = "EETI eGalax Touch Screen";
> +	input_dev->phys = "I2C",
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = &client->dev;
> +
> +	__set_bit(EV_ABS, input_dev->evbit);
> +	__set_bit(EV_KEY, input_dev->evbit);
> +	__set_bit(BTN_TOUCH, input_dev->keybit);
> +	__set_bit(ABS_X, input_dev->absbit);
> +	__set_bit(ABS_Y, input_dev->absbit);
> +	input_set_abs_params(input_dev, ABS_X, 0, EGALAX_MAX_X, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, EGALAX_MAX_Y, 0, 0);
> +	input_set_abs_params(input_dev,
> +			     ABS_MT_POSITION_X, 0, EGALAX_MAX_X, 0, 0);
> +	input_set_abs_params(input_dev,
> +			     ABS_MT_POSITION_X, 0, EGALAX_MAX_Y, 0, 0);
> +	input_mt_init_slots(input_dev, MAX_SUPPORT_POINTS);

How do you know when the device is in MOUSE mode here? The MT
parameters should only be set up for multitouch.

> +
> +	input_set_drvdata(input_dev, data);
> +
> +	ret = request_threaded_irq(client->irq, NULL, egalax_ts_interrupt,
> +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +				   "egalax_ts", data);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to register interrupt\n");
> +		goto err_free_dev;
> +	}
> +
> +	ret = input_register_device(data->input_dev);
> +	if (ret < 0)
> +		goto err_free_irq;
> +	i2c_set_clientdata(client, data);
> +	return 0;
> +
> +err_free_irq:
> +	free_irq(client->irq, data);
> +err_free_dev:
> +	input_free_device(input_dev);
> +err_free_data:
> +	kfree(data);
> +
> +	return ret;
> +}

Thanks,
Henrik
