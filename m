From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add generic driver for Zeitec touchscreens
Date: Fri, 15 May 2015 13:43:51 -0700
Message-ID: <20150515204351.GC696@dtor-ws>
References: <1431692566-1574-1-git-send-email-bogdan.g.stefan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35377 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422661AbbEOUn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 16:43:56 -0400
Content-Disposition: inline
In-Reply-To: <1431692566-1574-1-git-send-email-bogdan.g.stefan@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bogdan George Stefan <bogdan.g.stefan@intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bogdan,

On Fri, May 15, 2015 at 03:22:46PM +0300, Bogdan George Stefan wrote:
> This driver adds support for Zeitec touchscreens. It has
> been tested with ZET6273 and ZET9172.
> 
> It supports ACPI and device tree enumeration. For ACPI you need ACPI
> 5.1+ in order to be able to use named GPIOs.
> 
> Screen resolution, the maximum number of fingers supported,
> if the touchscreen has hardware keys are configurable
> using ACPI/DT properties.
> 
> Signed-off-by: Bogdan George Stefan <bogdan.g.stefan@intel.com>
> ---
>  drivers/input/touchscreen/Kconfig  |  12 +
>  drivers/input/touchscreen/Makefile |   1 +
>  drivers/input/touchscreen/zeitec.c | 586 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 599 insertions(+)
>  create mode 100644 drivers/input/touchscreen/zeitec.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 6261fd6..ab82cec 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -27,6 +27,18 @@ config TOUCHSCREEN_88PM860X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called 88pm860x-ts.
>  
> +config TOUCHSCREEN_ZEITEC
> +        tristate "Generic ZEITEC touchscreen"
> +        depends on I2C
> +        help
> +          Say Y here if you have the Zeitec touchscreen connected to
> +          your system.
> +
> +          If unsure, say N.
> +
> +          To compile this driver as a module, choose M here: the
> +          module will be called zeitec.

Indent with tabs please.

> +
>  config TOUCHSCREEN_ADS7846
>  	tristate "ADS7846/TSC2046/AD7873 and AD(S)7843 based touchscreens"
>  	depends on SPI_MASTER
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 0242fea..95c249d 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -81,3 +81,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_ZEITEC)	+= zeitec.o
> diff --git a/drivers/input/touchscreen/zeitec.c b/drivers/input/touchscreen/zeitec.c
> new file mode 100644
> index 0000000..6270cc3
> --- /dev/null
> +++ b/drivers/input/touchscreen/zeitec.c
> @@ -0,0 +1,586 @@
> +/*
> + * Driver for Zeitec touchscreens.
> + *
> + * Copyright (c) 2015 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
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
> +#include <linux/acpi.h>
> +#include <linux/gpio.h>
> +#include <linux/firmware.h>
> +
> +#define FLASH_SIZE_ZET6273			0xA000
> +#define ZET_TOTAL_PKT_SIZE			70
> +#define ZET_MODEL_PKT_SIZE			17
> +
> +#define ZET_ROM_TYPE_UNKNOWN			0x00
> +#define ZET_ROM_TYPE_SRAM			0x02
> +#define ZET_ROM_TYPE_OTP			0x06
> +#define ZET_ROM_TYPE_FLASH			0x0F
> +
> +#define ZET_FLASH_PAGE_LEN			128
> +
> +#define ZET_CMD_GET_CODEOPTION			0x27
> +#define ZET_CMD_GET_INFORMATION			0xB2
> +#define ZET_CMD_WRITE_PASSWORD			0x20
> +#define ZET_CMD_WRITE_PROGRAM			0x22
> +#define ZET_CMD_READ_CODE_OPTION		0x27
> +#define ZET_CMD_RESET_MCU			0x29
> +#define ZET_CMD_WRITE_SFR			0x2B
> +#define ZET_CMD_READ_SFR			0x2C
> +#define ZET_CMD_ENTER_SLEEP			0xB1
> +
> +#define ZET_PASSWORD_HIBYTE			0xC5
> +#define ZET_PASSWORD_LOBYTE			0x9D

Have you tried to define password as 0xc59d and then just use
cpu_to_le16() to convert it to the proper representation?

> +
> +#define ZET_TS_WAKEUP_LOW_PERIOD		10
> +#define ZET_TS_WAKEUP_HIGH_PERIOD		20
> +
> +#define ZET_FINGER_REPROT_DATA_HEADER		0x3C
> +#define ZET_PAGE_HEADER_COMMAND_LEN		3
> +#define FINGER_PACK_SIZE			4
> +#define FINGER_HEADER_SHIFT			3
> +#define ZET_FINGER_OFFSET		(FINGER_PACK_SIZE + \
> +					 FINGER_HEADER_SHIFT)
> +
> +#define ZET_MODEL_6273	0x6270
> +#define ZET_MODEL_9172	0x9172
> +
> +#define ZET_RESOLUTION_X		"touchscreen-size-x"
> +#define ZET_RESOLUTION_Y		"touchscreen-size-y"
> +#define ZET_MAX_FINGERS			"max-fingers"
> +#define ZET_HAS_KEYS			"has-keys"
> +
> +struct zet_ts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	u16 resolution_x;
> +	u16 resolution_y;
> +	u8 finger_num;
> +	u16 finger_packet_size;
> +	struct gpio_desc *reset;
> +	struct gpio_desc *irq;
> +	u8 device_model;
> +	u8 rom_type;
> +	u16 model_type;
> +	u8 has_keys;
> +	char fw_name[32];
> +};
> +
> +struct zet_finger_coordinate {
> +	u32 report_x;
> +	u32 report_y;
> +	u32 report_z;
> +	u8 valid;
> +};
> +
> +static void zet_ts_reset(struct zet_ts_data *ts)
> +{
> +	gpiod_set_value_cansleep(ts->reset, 0);

Reset GPIO is typically active low, but gpiod takes care of inverting
the value so if it is coded properly you set it to "1" to activate.

> +	usleep_range(ZET_TS_WAKEUP_LOW_PERIOD, ZET_TS_WAKEUP_LOW_PERIOD + 1);

Hmm, do you really need that precise sleep? maybe msleep(10) will do
(and if it sleeps for 20 msec so be it)?

> +	gpiod_set_value_cansleep(ts->reset, 1);
> +	usleep_range(ZET_TS_WAKEUP_HIGH_PERIOD, ZET_TS_WAKEUP_HIGH_PERIOD + 1);
> +}
> +
> +static int zet_i2c_read_tsdata(struct i2c_client *client, u8 *data, u8 length)
> +{
> +	struct i2c_msg msg;
> +
> +	msg.addr     = client->addr;
> +	msg.flags    = I2C_M_RD;
> +	msg.len      = length;
> +	msg.buf      = data;
> +	return i2c_transfer(client->adapter, &msg, 1);

Why not i2c_master_recv()?

> +}
> +
> +static int zet_i2c_write_tsdata(struct i2c_client *client, u8 *data, u8 length)
> +{
> +	struct i2c_msg msg;
> +
> +	msg.addr     = client->addr;
> +	msg.flags    = 0;
> +	msg.len      = length;
> +	msg.buf      = data;
> +	return i2c_transfer(client->adapter, &msg, 1);

i2c_master_send()?

> +}
> +
> +static int zet_get_model_type(struct zet_ts_data *ts)
> +{
> +	u8 ts_in_data[ZET_MODEL_PKT_SIZE];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(ts->client,
> +					    ZET_CMD_GET_CODEOPTION,
> +					    ZET_MODEL_PKT_SIZE, ts_in_data);
> +	if (ret < 0) {
> +		dev_err(&ts->client->dev, "I2C read error= %d\n", ret);
> +		return ret;
> +	}
> +
> +	ts->model_type = (ts_in_data[7] << 8) | ts_in_data[6];

	ts->model_type = le16_to_cpup((__le16 *)&ts_in_data[6]);

> +
> +	switch (ts->model_type) {
> +	case ZET_MODEL_6273:
> +	case ZET_MODEL_9172:
> +		ts->rom_type = ZET_ROM_TYPE_SRAM;
> +		snprintf(ts->fw_name, sizeof(ts->fw_name),
> +			 "zet%x.bin", ts->model_type);
> +		break;
> +	default:
> +		ts->rom_type = ZET_ROM_TYPE_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zet_ts_get_information(struct zet_ts_data *ts)
> +{
> +	int error;
> +
> +	error = device_property_read_u16(&ts->client->dev,
> +					 ZET_RESOLUTION_X,
> +					 &ts->resolution_x);
> +	if (error < 0) {
> +		dev_err(&ts->client->dev, "Failed to read %s property\n",
> +			ZET_RESOLUTION_X);
> +		return error;
> +	}
> +
> +	error = device_property_read_u16(&ts->client->dev,
> +					 ZET_RESOLUTION_Y,
> +					 &ts->resolution_y);
> +	if (error < 0) {
> +		dev_err(&ts->client->dev, "Failed to read %s property\n",
> +			ZET_RESOLUTION_Y);
> +		return error;
> +	}
> +
> +	error = device_property_read_u8(&ts->client->dev,
> +					ZET_MAX_FINGERS,
> +					&ts->finger_num);
> +	if (error < 0) {
> +		dev_err(&ts->client->dev, "Failed to read %s property\n",
> +			ZET_MAX_FINGERS);
> +		return error;
> +	}

It would be nice if we had some sanity checking for ts->finger_num.
Also, it is pretty unusual to have number of touches encoded in device
tree instead of being property of hardware.

> +
> +	error = device_property_read_u8(&ts->client->dev,
> +					ZET_HAS_KEYS,
> +					&ts->has_keys);
> +	if (error < 0) {
> +		dev_err(&ts->client->dev, "Failed to read %s property\n",
> +			ZET_HAS_KEYS);
> +		return error;
> +	}

Same here. Can we retrieve this data from the device itself?

> +
> +	if (ts->has_keys == 0)
> +		ts->finger_packet_size  = 3 + 4 * ts->finger_num;
> +	else
> +		ts->finger_packet_size  = 3 + 4 * ts->finger_num + 1;

How about:

	ts->finger_packet_size  = 3 + 4 * ts->finger_num;
	if (ts->has_keys)
		ts->finger_packet_size += 1;

> +
> +	return 0;
> +}
> +
> +static int zet_gpio_probe(struct zet_ts_data *ts)
> +{
> +	struct device *dev;
> +	struct gpio_desc *gpiod;
> +	int err;
> +
> +	dev = &ts->client->dev;
> +
> +	gpiod = devm_gpiod_get(dev, "int", GPIOD_IN);
> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);
> +		dev_err(dev, "get int failed: %d\n", err);
> +		return err;
> +	}
> +
> +	ts->irq = gpiod;
> +
> +	gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);
> +		dev_err(dev, "get reset failed: %d\n", err);
> +		return err;
> +	}
> +
> +	ts->reset = gpiod;
> +
> +	return 0;
> +}
> +
> +static int zet_request_input_dev(struct zet_ts_data *ts)
> +{
> +	int error;
> +
> +	ts->input_dev = devm_input_allocate_device(&ts->client->dev);
> +	if (!ts->input_dev) {
> +		dev_err(&ts->client->dev, "Failed to allocate input device.\n");
> +		return -ENOMEM;
> +	}
> +
> +	ts->input_dev->evbit[0] = BIT_MASK(EV_SYN) |
> +				  BIT_MASK(EV_KEY) |
> +				  BIT_MASK(EV_ABS);

I do not think you need to initialize evbit explicitly.

> +
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X, 0,
> +			     ts->resolution_x, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y, 0,
> +			     ts->resolution_y, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);

You are not emitting these events so they should not be in capabilities.

> +
> +	input_mt_init_slots(ts->input_dev, ts->finger_num,
> +			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +
> +	ts->input_dev->name = "Zeitec touchscreen";
> +	ts->input_dev->phys = "input/ts";
> +	ts->input_dev->id.bustype = BUS_HOST;
> +
> +	error = input_register_device(ts->input_dev);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to register input device: %d\n", error);
> +		return error;
> +	}
> +
> +	__set_bit(INPUT_PROP_DIRECT, ts->input_dev->propbit);
> +
> +	return 0;
> +}
> +
> +static bool zet_ts_check_skip_page(const u8 *data)
> +{
> +	int j;
> +
> +	for (j = 0 ; j < ZET_FLASH_PAGE_LEN ; j++) {
> +		if (data[j] != 0xFF)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int zet_cmd_writepage(struct zet_ts_data *ts,
> +			     int page_id,
> +			     const u8 *buf)
> +{
> +	u8 tx_buf[ZET_PAGE_HEADER_COMMAND_LEN + ZET_FLASH_PAGE_LEN];
> +	int error;
> +
> +	switch (ts->model_type) {
> +	case ZET_MODEL_6273:
> +	case ZET_MODEL_9172:
> +		tx_buf[0] = ZET_CMD_WRITE_PROGRAM;
> +		tx_buf[1] = (page_id & 0xff);
> +		tx_buf[2] = (u8)(page_id >> 8);
> +		break;
> +	default:
> +		kfree(tx_buf);
> +		return -EINVAL;
> +	}
> +
> +	memmove(tx_buf + ZET_PAGE_HEADER_COMMAND_LEN, buf, ZET_FLASH_PAGE_LEN);
> +
> +	/*
> +	 * i2c_smbus functions only allow us to write 32 bytes at a time
> +	 * We need to write 131 at a time for each page. i2c_transfer
> +	 * is needed here
> +	 */
> +	error = zet_i2c_write_tsdata(ts->client, tx_buf,
> +				     ZET_PAGE_HEADER_COMMAND_LEN +
> +				     ZET_FLASH_PAGE_LEN);
> +	if (error < 0) {
> +		dev_err(&ts->client->dev,
> +			"Failed to write firmware page: %d\n", page_id);
> +	}
> +
> +	return 0;
> +}
> +
> +static int zet_cmd_unlock_device(struct zet_ts_data *ts)
> +{
> +	u16 data;
> +
> +	data = ZET_PASSWORD_LOBYTE << 8 | ZET_PASSWORD_HIBYTE;
> +	return i2c_smbus_write_word_data(ts->client,
> +					 ZET_CMD_WRITE_PASSWORD, data);
> +}
> +
> +static int zet_download_firmware(struct zet_ts_data *ts)
> +{
> +	const struct firmware *fw;
> +	int flash_rest_len = 0;
> +	int flash_page_id = 0;
> +	int error = 0;
> +	int offset;
> +
> +	error = request_firmware(&fw, ts->fw_name, &ts->client->dev);
> +	if (error != 0) {
> +		dev_err(&ts->client->dev,
> +			"Unable to open firmware %s\n",
> +			ts->fw_name);
> +		return error;
> +	}
> +
> +	flash_rest_len = fw->size;
> +
> +	while (flash_rest_len > 0) {
> +		offset = flash_page_id * ZET_FLASH_PAGE_LEN;
> +		if (zet_ts_check_skip_page(fw->data + offset)) {
> +			flash_rest_len -= ZET_FLASH_PAGE_LEN;
> +			flash_page_id += 1;
> +			continue;
> +		}
> +
> +		error = zet_cmd_writepage(ts, flash_page_id,
> +					  fw->data + offset);
> +		if (error < 0)
> +			return error;
> +
> +		flash_rest_len -= ZET_FLASH_PAGE_LEN;
> +		flash_page_id++;
> +	}
> +
> +	error = i2c_smbus_write_byte(ts->client, ZET_CMD_RESET_MCU);
> +	if (error < 0)
> +		dev_err(&ts->client->dev,
> +			"Unable to reset device %d\n", error);
> +
> +	usleep_range(10, 11);

msleep(10)?

> +
> +	zet_ts_reset(ts);

I do not see you releasing firmware.

> +
> +	return 0;
> +}
> +
> +static void zet_process_events(struct zet_ts_data *ts)
> +{
> +	u8 ts_data[ZET_TOTAL_PKT_SIZE];
> +	int error;
> +	int i;
> +	u16 valid;
> +	u8 pressed;
> +	u8 offset;
> +	struct zet_finger_coordinate finger_report[5];

Why do you need an array of these? You can process and report them one
by one.

> +
> +	/*
> +	 * We do not read from a specific register as i2c_smbus function
> +	 * require. We know exactly how many bytes are available on the
> +	 * first read after an IRQ and use isc_transfer for it
> +	 */
> +	error = zet_i2c_read_tsdata(ts->client,
> +				    &ts_data[0], ts->finger_packet_size);
> +	if (error < 0) {
> +		dev_err(&ts->client->dev,
> +			"Unable to open read touch info %d\n",
> +			error);
> +		return;
> +	}
> +
> +	if (ts_data[0] != ZET_FINGER_REPROT_DATA_HEADER)
> +		return;
> +
> +	valid = ts_data[1];
> +	valid = (valid << 8) | ts_data[2];

	valid = get_unaligned_be16(&ts_dat[1]);

> +
> +	for (i = 0; i < ts->finger_num; i++) {
> +		pressed = (valid >> (16 - i - 1)) & 0x1;
> +		if (pressed == 0)
> +			continue;


Hmm, I wonder if the following is not simpler:

		if (!(valid & BIT(15 - i)))
			continue;

> +
> +		/* get the finger data */
> +		offset = FINGER_HEADER_SHIFT + FINGER_PACK_SIZE * i;
> +		finger_report[i].report_x =
> +			(u8)(ts_data[offset] >> 4) * 256 +
> +			(u8)ts_data[offset + 1];

Why all these casts? And if anything I'd expect casting
ts_data[offset] >> 4 to u16 or u32.

> +
> +		finger_report[i].report_y =
> +			(u8)(ts_data[offset] & 0x0f) * 256 +
> +			(u8)ts_data[offset + 2];
> +
> +		finger_report[i].report_z = 0;

Why do we need this?

> +		finger_report[i].valid = pressed;

And this?

> +
> +		input_mt_slot(ts->input_dev, i);
> +		input_mt_report_slot_state(ts->input_dev,
> +					   MT_TOOL_FINGER,
> +					   true);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
> +				 finger_report[i].report_x);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
> +				 finger_report[i].report_y);
> +	}
> +
> +	input_mt_sync_frame(ts->input_dev);
> +	input_sync(ts->input_dev);
> +}
> +
> +static irqreturn_t zet_ts_irq_handler(int irq, void *dev_id)
> +{
> +	zet_process_events((struct zet_ts_data *)dev_id);
> +	return IRQ_HANDLED;
> +}
> +
> +static int zet_ts_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct zet_ts_data *ts;
> +	int error = 0;

Do not initialize variables unless it is needed by the code flow.

> +	int flags;
> +
> +	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "I2C check functionality failed.\n");
> +		return -ENXIO;
> +	}
> +
> +	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +	ts->client = client;
> +
> +	error = zet_gpio_probe(ts);
> +	if (error)
> +		return error;
> +
> +	if (client->irq < 0 && ts->irq)
> +		client->irq = gpiod_to_irq(ts->irq);

Why do we need to do this? Interrupt should be specified by either
device tree or ACPI data and i2c core will parse and set it up for us.

> +
> +	i2c_set_clientdata(client, ts);
> +
> +	gpiod_set_value_cansleep(ts->reset, 0);
> +	usleep_range(ZET_TS_WAKEUP_LOW_PERIOD, ZET_TS_WAKEUP_LOW_PERIOD + 1);

Why not zet_reset()?

> +
> +	error = zet_cmd_unlock_device(ts);
> +	if (error < 0) {
> +		dev_err(&client->dev,
> +			"Could not unlock device. error: %d\n", error);
> +		return error;
> +	}
> +
> +	error = zet_get_model_type(ts);
> +	if (error < 0)
> +		return error;
> +
> +	error = zet_download_firmware(ts);
> +	if (error < 0)
> +		return error;

Hmm, it looks like firmware is not needed to determine the
characteristics of the touchscreen. It would be better to postpone doing
this until input device is opened; this way you can build the driver
into the kernel and not worry about firmware not being ready.

> +
> +	error = zet_ts_get_information(ts);
> +	if (error < 0)
> +		return error;
> +
> +	error = zet_request_input_dev(ts);
> +	if (error)
> +		return error;
> +
> +	flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;

The trigger should be already set up from ACPI/device tree data; just
use IRQF_ONESHOT.

> +	error = devm_request_threaded_irq(&ts->client->dev, client->irq,
> +					  NULL, zet_ts_irq_handler,
> +					  flags, client->name, ts);
> +	if (error) {
> +		dev_err(&client->dev, "request IRQ failed: %d\n", error);
> +		return error;
> +	}
> +
> +	return error;
> +}
> +
> +static int zet_suspend(struct device *dev)
> +{
> +	int error;
> +	struct input_dev *input;
> +	struct zet_ts_data *ts;
> +
> +	input = to_input_dev(dev);
> +	ts = input_get_drvdata(input);

This has not been tested ever. Hint: the device here is i2c_client, not
input_dev.

> +
> +	disable_irq(ts->client->irq);
> +
> +	usleep_range(5, 6);

Why is this needed?

> +
> +	error = i2c_smbus_write_byte(ts->client, ZET_CMD_ENTER_SLEEP);
> +	if (error < 0)
> +		dev_err(dev, "could not enter sleep error= %d\n", error);

Should we abort suspend in this case?

> +	else
> +		dev_dbg(dev, "sleeping\n");
> +
> +	return 0;
> +}
> +
> +static int zet_wakeup(struct device *dev)
> +{
> +	struct input_dev *input;
> +	struct zet_ts_data *ts;
> +
> +	input = to_input_dev(dev);
> +	ts = input_get_drvdata(input);
> +
> +	enable_irq(ts->client->irq);
> +
> +	zet_ts_reset(ts);
> +
> +	return 0;
> +}
> +
> +static int zet_ts_remove(struct i2c_client *client)
> +{
> +	i2c_set_clientdata(client, NULL);

This is done by i2c core, please drop zet_ts_remove() altogether.

> +	return 0;
> +}
> +
> +static const struct i2c_device_id zet_ts_idtable[] = {
> +	{ "zet6273", 0 },
> +	{ "zet9172", 0 },
> +	{ }
> +};
> +

#ifdef CONFIG_ACPI

> +static const struct acpi_device_id zeitec_acpi_match[] = {
> +	{ "ZET6273", 0 },
> +	{ "ZET9172", 0 },
> +	{ }
> +};

#endif

> +
> +static const struct dev_pm_ops zet_pm_ops = {
> +		SET_SYSTEM_SLEEP_PM_OPS(zet_suspend, zet_wakeup)
> +};

Just use

static SIMPLE_DEV_PM_OPS(zet_pm_ops, zet_suspend, zet_wakeup);

> +
> +static struct i2c_driver zet_i2c_driver = {
> +	.class = I2C_CLASS_HWMON,

Why?

> +	.driver = {
> +		.owner	= THIS_MODULE,
> +		.name	= "zeitec_ts",
> +		.pm		= &zet_pm_ops,
> +		.acpi_match_table = ACPI_PTR(zeitec_acpi_match),
> +	},
> +	.probe		= zet_ts_probe,
> +	.remove		= zet_ts_remove,
> +	.id_table	= zet_ts_idtable,
> +};
> +
> +module_i2c_driver(zet_i2c_driver);
> +
> +MODULE_AUTHOR("Bogdan George Stefan <bogdan.g.stefan@intel.com>");
> +MODULE_DESCRIPTION("ZEITEC I2C Touch Screen driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
