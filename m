From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: driver for the Goodix touchpanel
Date: Tue, 23 Sep 2014 17:45:10 -0700
Message-ID: <20140924004510.GC16747@core.coreip.homeip.net>
References: <1411511293.29315.16.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38451 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaIXApQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 20:45:16 -0400
Received: by mail-pd0-f172.google.com with SMTP id y10so7550004pdj.31
        for <linux-input@vger.kernel.org>; Tue, 23 Sep 2014 17:45:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411511293.29315.16.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi Bastien,

On Wed, Sep 24, 2014 at 12:28:13AM +0200, Bastien Nocera wrote:
> Add a driver for the Goodix touchscreen panel found in Onda v975w
> tablets. The driver is based off the Android driver gt9xx.c found
> in some Android code dumps, but now bears no resemblance to the original
> driver.
> 
> The driver was tested on the aforementioned tablet.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> Tested-by: Bastien Nocera <hadess@hadess.net>
> ---
>  MAINTAINERS                        |   6 +
>  drivers/input/touchscreen/Kconfig  |  13 ++
>  drivers/input/touchscreen/Makefile |   1 +
>  drivers/input/touchscreen/goodix.c | 452 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 472 insertions(+)
>  create mode 100644 drivers/input/touchscreen/goodix.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 670b3dc..7a37464 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4057,6 +4057,12 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/usb/go7007/
>  
> +GOODIX TOUCHSCREEN
> +M:	Bastien Nocera <hadess@hadess.net>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/input/touchscreen/goodix.c
> +
>  GPIO SUBSYSTEM
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  M:	Alexandre Courbot <gnurou@gmail.com>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 6bb9a7d..c328df3 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -283,6 +283,19 @@ config TOUCHSCREEN_FUJITSU
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called fujitsu-ts.
>  
> +config TOUCHSCREEN_GOODIX
> +	tristate "Goodix I2C touchscreen"
> +	depends on I2C && ACPI
> +	help
> +	  Say Y here if you have the Goodix touchscreen (such as one
> +	  installed in Onda v975w tablets) connected to your
> +	  system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called goodix.
> +
>  config TOUCHSCREEN_ILI210X
>  	tristate "Ilitek ILI210X based touchscreen"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 4be94fc..55af212 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
>  obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
>  obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
>  obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+= intel-mid-touch.o
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> new file mode 100644
> index 0000000..bda6482
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -0,0 +1,452 @@
> +/*
> + *  driver for Goodix Touchscreens
> + *
> + *  Copyright (c) 2014 Red Hat Inc.
> + *
> + *  This code is based on gt9xx.c authored by andrew@goodix.com:
> + *
> + *  2010 - 2012 Goodix Technology.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <asm/unaligned.h>
> +
> +struct goodix_ts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	int abs_x_max;
> +	int abs_y_max;
> +	unsigned int max_touch_num;
> +	unsigned int int_trigger_type;
> +};
> +
> +#define GOODIX_MAX_HEIGHT		4096
> +#define GOODIX_MAX_WIDTH		4096
> +#define GOODIX_INT_TRIGGER		1
> +#define GOODIX_MAX_TOUCH		10
> +
> +#define GOODIX_CONFIG_MAX_LENGTH	240
> +
> +/* Register defineS */
> +#define GOODIX_READ_COOR_ADDR		0x814E
> +#define GOODIX_REG_CONFIG_DATA		0x8047
> +#define GOODIX_REG_VERSION		0x8140
> +
> +#define RESOLUTION_LOC		1
> +#define TRIGGER_LOC		6
> +
> +#define GOODIX_INFO(fmt, arg...)       pr_info("<<-GTP-INFO->> "fmt"\n", ##arg)
> +#define GOODIX_ERROR(fmt, arg...)      pr_err("<<-GTP-ERROR->> "fmt"\n", ##arg)

Let's use standard dev_xxx()

> +
> +static const char *goodix_ts_name = "Goodix Capacitive TouchScreen";
> +static const unsigned long goodix_irq_flags[] = {
> +	IRQ_TYPE_EDGE_RISING  | IRQF_ONESHOT,
> +	IRQ_TYPE_EDGE_FALLING | IRQF_ONESHOT,
> +	IRQ_TYPE_LEVEL_LOW    | IRQF_ONESHOT,
> +	IRQ_TYPE_LEVEL_HIGH   | IRQF_ONESHOT
> +};

I'd rather you pulled out IRQF_ONESHOT and specified it explicitly in
request_threaded_irq().

> +
> +/**
> + * goodix_i2c_read - read data from a register of the i2c slave device.
> + *
> + * @client: i2c device.
> + * @reg: the register to read from.
> + * @buf: raw write data buffer.
> + * @len: length of the buffer to write
> + */
> +static int goodix_i2c_read(struct i2c_client *client,
> +				u16 reg, u8 *buf, int len)
> +{
> +	struct i2c_msg msgs[2];
> +	u8 wbuf[2] = { reg >> 8, reg & 0xff };

cpu_to_be16()?

> +
> +	msgs[0].flags = !I2C_M_RD;

I2C_M_RD is not a boolean, do not negate it.

> +	msgs[0].addr  = client->addr;
> +	msgs[0].len   = 2;
> +	msgs[0].buf   = wbuf;
> +
> +	msgs[1].flags = I2C_M_RD;
> +	msgs[1].addr  = client->addr;
> +	msgs[1].len   = len;
> +	msgs[1].buf   = buf;
> +
> +	return i2c_transfer(client->adapter, msgs, 2);

	return ret < 0 ? ret : (ret != ARRAY_SIZE(msgs) ? -EIO : 0);

I really need to get that i2c_transfer_exact() going again.

> +}
> +
> +/**
> + * goodix_i2c_write - write data to the i2c slave device.
> + *
> + * @client: i2c device.
> + * @reg: the register to read to.
> + * @buf: raw write data buffer.
> + * @len: length of the buffer to write
> + */
> +static int goodix_i2c_write(struct i2c_client *client,
> +				u16 reg, u8 *buf, int len)
> +{
> +	struct i2c_msg msg;
> +	int ret;
> +	u8 *wbuf;
> +
> +	wbuf = kzalloc(len + 2, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	wbuf[0] = reg >> 8;
> +	wbuf[1] = reg & 0xFF;

Again cpu_to_be16().

> +	memcpy(&wbuf[2], buf, len);
> +
> +	msg.flags = !I2C_M_RD;

Same here, not boolean.

> +	msg.addr  = client->addr;
> +	msg.len   = len + 2;
> +	msg.buf   = wbuf;
> +
> +	ret = i2c_transfer(client->adapter, &msg, 1);
> +	kfree(wbuf);
> +	return ret;
> +}
> +
> +static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
> +{
> +	int touch_num;
> +	int ret;
> +
> +	ret = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, data, 10);
> +	if (ret < 0) {
> +		GOODIX_ERROR("I2C transfer error (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	touch_num = data[0] & 0x0f;
> +	if (touch_num > GOODIX_MAX_TOUCH)
> +		return -EPROTO;
> +
> +	if (touch_num > 1) {
> +		ret = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR + 10,
> +				   &data[10], 8 * (touch_num - 1));
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return touch_num;
> +}
> +
> +static void goodix_ts_parse_touch(struct goodix_ts_data *ts, u8 *coor_data)
> +{
> +	int id = coor_data[0] & 0x0F;
> +	int input_x = get_unaligned_le16(&coor_data[1]);
> +	int input_y = get_unaligned_le16(&coor_data[3]);
> +	int input_w = get_unaligned_le16(&coor_data[5]);
> +
> +	input_mt_slot(ts->input_dev, id);
> +	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
> +	input_report_abs(ts->input_dev, ABS_MT_POSITION_X, input_x);
> +	input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, input_y);
> +	input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, input_w);
> +	input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, input_w);
> +}
> +
> +/**
> + * goodix_ts_work_func - Process incoming IRQ
> + *
> + * @ts: our goodix_ts_data pointer
> + *
> + * Called when the IRQ is triggered. Read the current device state, and push
> + * the input events to the user space.
> + */
> +static void goodix_ts_work_func(struct goodix_ts_data *ts)
> +{
> +	u8  end_cmd[1] = {0};
> +	u8  point_data[1 + 8 * GOODIX_MAX_TOUCH + 1];
> +	int touch_num;
> +	int i;
> +
> +	touch_num = goodix_ts_read_input_report(ts, point_data);
> +	if (touch_num < 0)
> +		goto exit_work_func;
> +
> +	for (i = 0; i < touch_num; i++)
> +		goodix_ts_parse_touch(ts, &point_data[1 + 8 * i]);
> +
> +	input_mt_sync_frame(ts->input_dev);
> +	input_sync(ts->input_dev);
> +
> +exit_work_func:
> +	if (goodix_i2c_write(ts->client,
> +				GOODIX_READ_COOR_ADDR, end_cmd, 1) < 0)
> +		GOODIX_INFO("I2C write end_cmd error");

Why did you need to pull it out of goodix_ts_irq_handler()?

> +}
> +
> +/**
> + * goodix_ts_irq_handler - The IRQ handler
> + *
> + * @irq: interrupt number.
> + * @dev_id: private data pointer.
> + */
> +static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct goodix_ts_data *ts = dev_id;
> +
> +	goodix_ts_work_func(ts);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * goodix_read_config - Read the embedded configuration of the panel
> + *
> + * @ts: our goodix_ts_data pointer
> + *
> + * Must be called during probe
> + */
> +static void goodix_read_config(struct goodix_ts_data *ts)
> +{
> +	int ret;
> +	u8 config[GOODIX_CONFIG_MAX_LENGTH];
> +
> +	ret = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA, config,
> +			   GOODIX_CONFIG_MAX_LENGTH);
> +	if (ret < 0) {
> +		GOODIX_ERROR("Error reading config, use default value!");
> +		ts->abs_x_max = GOODIX_MAX_WIDTH;
> +		ts->abs_y_max = GOODIX_MAX_HEIGHT;
> +		ts->int_trigger_type = GOODIX_INT_TRIGGER;
> +		return;
> +	}
> +
> +	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
> +	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
> +	ts->int_trigger_type = (config[TRIGGER_LOC]) & 0x03;
> +	if ((!ts->abs_x_max) || (!ts->abs_y_max)) {
> +		GOODIX_ERROR("Invalid config, use default value!");
> +		ts->abs_x_max = GOODIX_MAX_WIDTH;
> +		ts->abs_y_max = GOODIX_MAX_HEIGHT;
> +	}
> +}
> +
> +
> +/**
> + * goodix_read_version - Read goodix touchscreen version
> + *
> + * @client: the i2c client
> + * @version: output buffer containing the version on success
> + */
> +static int goodix_read_version(struct i2c_client *client, u16 *version)
> +{
> +	int ret;
> +	int i;
> +	u8 buf[6];
> +
> +	ret = goodix_i2c_read(client, GOODIX_REG_VERSION, buf, sizeof(buf));
> +	if (ret < 0) {
> +		GOODIX_ERROR("GTP read version failed");
> +		return ret;
> +	}
> +
> +	if (version)
> +		*version = get_unaligned_le16(&buf[4]);
> +
> +	for (i = 0; i < 4; i++) {
> +		if (!buf[i])
> +			buf[i] = 0x30;

			buf[i] = '0';

but what if they happen to have some other nonprintable garbage there?

> +	}
> +	GOODIX_INFO("IC VERSION: %c%c%c%c_%02x%02x",
> +			  buf[0], buf[1], buf[2], buf[3], buf[5], buf[4]);
> +
> +	return ret;
> +}
> +
> +/**
> + * goodix_i2c_test - I2C test function to check if the device answers.
> + *
> + * @client: the i2c client
> + */
> +static int goodix_i2c_test(struct i2c_client *client)
> +{
> +	u8 test;
> +	int ret;
> +	int retry = 0;
> +
> +	while (retry++ < 2) {
> +		ret = goodix_i2c_read(client, GOODIX_REG_CONFIG_DATA,
> +				      &test, 1);
> +		if (ret > 0)
> +			return ret;
> +
> +		GOODIX_ERROR("GTP i2c test failed time %d.", retry);
> +		msleep(20);
> +	}
> +	return ret;
> +}
> +
> +/**
> + * goodix_request_irq - Request the IRQ handler
> + *
> + * @ts: our goodix_ts_data pointer
> + *
> + * Must be called during probe
> + */
> +static int goodix_request_irq(struct goodix_ts_data *ts)
> +{
> +	int ret;
> +
> +	ret = devm_request_threaded_irq(&ts->client->dev,
> +					ts->client->irq, NULL,
> +					goodix_ts_irq_handler,
> +					goodix_irq_flags[ts->int_trigger_type],
> +					ts->client->name,
> +					ts);
> +	if (ret) {
> +		GOODIX_ERROR("Request IRQ failed! ERRNO:%d.", ret);
> +		return -1;
> +	}
> +
> +	disable_irq_nosync(ts->client->irq);

Why nosync? And why do you need to disable? Yo just need to request it
later, after you've done querying the device. And why a separate funcion
for basically one statement?

> +	return 0;
> +}
> +
> +/**
> + * goodix_request_input_dev - Allocate, populate and register the input device
> + *
> + * @ts: our goodix_ts_data pointer
> + *
> + * Must be called during probe
> + */
> +static int goodix_request_input_dev(struct goodix_ts_data *ts)
> +{
> +	int ret;
> +
> +	ts->input_dev = devm_input_allocate_device(&ts->client->dev);
> +	if (ts->input_dev == NULL) {
> +		GOODIX_ERROR("Failed to allocate input device.");
> +		return -ENOMEM;
> +	}
> +
> +	ts->input_dev->evbit[0] = BIT_MASK(EV_SYN) |
> +				  BIT_MASK(EV_KEY) |
> +				  BIT_MASK(EV_ABS);
> +
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X, 0,
> +				ts->abs_x_max, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y, 0,
> +				ts->abs_y_max, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +
> +	input_mt_init_slots(ts->input_dev, GOODIX_MAX_TOUCH,
> +			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +
> +	ts->input_dev->name = goodix_ts_name;
> +	ts->input_dev->phys = "input/ts";
> +	ts->input_dev->id.bustype = BUS_I2C;
> +	ts->input_dev->id.vendor = 0x0416;
> +	ts->input_dev->id.product = 0x1001;
> +	ts->input_dev->id.version = 10427;
> +
> +	ret = input_register_device(ts->input_dev);
> +	if (ret) {
> +		GOODIX_ERROR("Failed to register %s input device",
> +			  ts->input_dev->name);
> +		return -ENODEV;

Why -ENODEV instead of ret?

> +	}
> +
> +	return 0;
> +}
> +
> +static int goodix_ts_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct goodix_ts_data *ts;
> +	u16 version_info;
> +
> +	GOODIX_INFO("GTP I2C Address: 0x%02x", client->addr);
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		GOODIX_ERROR("I2C check functionality failed.");
> +		return -ENODEV;
> +	}
> +	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
> +	if (ts == NULL) {

	if (!ts)

is a preferred form (by me at least).

> +		GOODIX_ERROR("Alloc GFP_KERNEL memory failed.");
> +		return -ENOMEM;
> +	}
> +
> +	ts->client = client;
> +	i2c_set_clientdata(client, ts);
> +
> +	ret = goodix_i2c_test(client);
> +	if (ret < 0) {
> +		client->addr = 0x5d;

Umm, why? Let's trust board code/i2c core  to configure the i2c device
properly.

> +		ret = goodix_i2c_test(client);
> +		if (ret < 0) {
> +			GOODIX_ERROR("I2C communication ERROR!");
> +			return -ENODEV;
> +		}
> +		GOODIX_INFO("GTP I2C new Address: 0x%02x", client->addr);
> +	}
> +
> +	goodix_read_config(ts);
> +
> +	ret = goodix_request_input_dev(ts);
> +	if (ret < 0) {
> +		GOODIX_ERROR("GTP request input dev failed");
> +		return ret;
> +	}
> +
> +	ret = goodix_request_irq(ts);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = goodix_read_version(client, &version_info);
> +	if (ret < 0) {
> +		GOODIX_ERROR("Read version failed.");
> +		return ret;
> +	}
> +
> +	enable_irq(ts->client->irq);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id goodix_ts_id[] = {
> +	{ "GDIX1001:00", 0 },
> +	{ }

Do we have to have this table?

> +};
> +
> +static const struct acpi_device_id goodix_acpi_match[] = {
> +	{ "GDIX1001", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
> +
> +static struct i2c_driver goodix_ts_driver = {
> +	.probe = goodix_ts_probe,
> +	.id_table = goodix_ts_id,
> +	.driver = {
> +		.name = "Goodix-TS",
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = goodix_acpi_match,
> +	},
> +};
> +
> +module_i2c_driver(goodix_ts_driver);
> +
> +MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
> +MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
> +MODULE_DESCRIPTION("Goodix touchscreen driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.1.0
> 
> 

Thanks.

-- 
Dmitry
