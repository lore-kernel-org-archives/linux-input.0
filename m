From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v6] input: touchscreen: Add generic driver for Silead
 touchscreens
Date: Tue, 12 Jul 2016 10:10:24 +0200
Message-ID: <ec036758-aeb5-0ba3-1867-2b6d82f60ab9@redhat.com>
References: <1468252304-22850-1-git-send-email-hdegoede@redhat.com>
 <20160712000103.GD26822@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55642 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbcGLIKb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 04:10:31 -0400
In-Reply-To: <20160712000103.GD26822@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Wessel Blokzijl <wesselb94@gmail.com>, Siebren Vroegindeweij <siebren.vroegindeweij@gmail.com>, Robert Dolca <robert.dolca@intel.com>, Daniel Jansen <djaniboe@gmail.com>

Hi,

On 12-07-16 02:01, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Mon, Jul 11, 2016 at 05:51:44PM +0200, Hans de Goede wrote:
>> From: Robert Dolca <robert.dolca@intel.com>
>>
>> This driver adds support for Silead touchscreens. It has been tested
>> with GSL1680 and GSL3680 touch panels.
>>
>> It supports ACPI and device tree enumeration. Screen resolution,
>> the maximum number of fingers supported and firmware name are
>> configurable.
>>
>> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
>> Signed-off-by: Daniel Jansen <djaniboe@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v6:
>> -Default to 5 fingers if max-fingers is not specified
>
> From the conversations with Robert, IIRC, the number of touches is not
> really property of a given controller, but rather firmware that is
> currently loaded into it and theoretically can change. Given this fact,
> can we simply expect up to 10 contacts and do not use the property at
> all?

We actually write the max-fingers value to a register in the
chip:

	error = i2c_smbus_write_byte_data(client, SILEAD_REG_TOUCH_NR,
					data->max_fingers);

So we need the property, because AFAIK we cannot just write 10 for
"firmware" which only supports 5.

Also note there really is not firmware, the "firmware" files contain
pin configuration data and lookup tables to go from analog pin
measurements to reported values. One can upgrade a touchscreen from
say 800x480 resolution to 1024x600 by using another "firmware" as long
as the 2 use the same pin config (same pins connected to the same
senselines of the touchscreen).



>
>> -Improve devicetree binding doc: improve wake-gpios description, use
>>  "See touchscreen.txt" where applicable
>> ---
>>  .../bindings/input/touchscreen/silead_gsl1680.txt  |  36 ++
>>  drivers/input/touchscreen/Kconfig                  |  13 +
>>  drivers/input/touchscreen/Makefile                 |   1 +
>>  drivers/input/touchscreen/silead.c                 | 652 +++++++++++++++++++++
>>  4 files changed, 702 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>>  create mode 100644 drivers/input/touchscreen/silead.c
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>> new file mode 100644
>> index 0000000..1e58d37
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>> @@ -0,0 +1,36 @@
>> +* GSL 1680 touchscreen controller
>> +
>> +Required properties:
>> +- compatible		  : "silead,gsl1680"
>> +- reg			  : I2C slave address of the chip (0x40)
>> +- interrupt-parent	  : a phandle pointing to the interrupt controller
>> +			    serving the interrupt for this chip
>> +- interrupts		  : interrupt specification for the gsl1680 interrupt
>> +- power-gpios		  : Specification for the pin connected to the gsl1680's
>> +			    shutdown input. This needs to be driven high to take the
>> +			    gsl1680 out of its low power state
>> +- touchscreen-size-x	  : See touchscreen.txt
>> +- touchscreen-size-y	  : See touchscreen.txt
>> +- touchscreen-max-fingers : maximum number of fingers the touchscreen can detect
>> +
>> +Optional properties:
>> +- touchscreen-inverted-x  : See touchscreen.txt
>> +- touchscreen-inverted-y  : See touchscreen.txt
>> +- touchscreen-swapped-x-y : See touchscreen.txt
>> +
>> +Example:
>> +
>> +i2c@00000000 {
>> +	gsl1680: touchscreen@40 {
>> +		compatible = "silead,gsl1680";
>> +		reg = <0x40>;
>> +		interrupt-parent = <&pio>;
>> +		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>;
>> +		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>;
>> +		touchscreen-size-x = <480>;
>> +		touchscreen-size-y = <800>;
>> +		touchscreen-max-fingers = <5>;
>> +		touchscreen-inverted-x;
>> +		touchscreen-swapped-x-y;
>> +	};
>> +};
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>> index 8ecdc38..cdd7c4c 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -1155,4 +1155,17 @@ config TOUCHSCREEN_ROHM_BU21023
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called bu21023_ts.
>>
>> +config TOUCHSCREEN_SILEAD
>> +	tristate "Silead I2C touchscreen"
>> +	depends on I2C
>> +	help
>> +	  Say Y here if you have the Silead touchscreen connected to
>> +	  your system.
>> +
>> +	  If unsure, say N.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called silead.
>> +
>> +
>>  endif
>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
>> index f42975e..8ffa0fd 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -95,3 +95,4 @@ obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
>> +obj-$(CONFIG_TOUCHSCREEN_SILEAD)	+= silead.o
>> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
>> new file mode 100644
>> index 0000000..22d3546
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/silead.c
>> @@ -0,0 +1,652 @@
>> +/* -------------------------------------------------------------------------
>> + * Copyright (C) 2014-2015, Intel Corporation
>> + *
>> + * Derived from:
>> + *  gslX68X.c
>> + *  Copyright (C) 2010-2015, Shanghai Sileadinc Co.Ltd
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + * -------------------------------------------------------------------------
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/acpi.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/delay.h>
>> +#include <linux/firmware.h>
>> +#include <linux/input.h>
>> +#include <linux/input/mt.h>
>> +#include <linux/pm.h>
>> +#include <linux/irq.h>
>> +
>> +#define SILEAD_TS_NAME "silead_ts"
>> +
>> +#define SILEAD_REG_RESET	0xE0
>> +#define SILEAD_REG_DATA		0x80
>> +#define SILEAD_REG_TOUCH_NR	0x80
>> +#define SILEAD_REG_POWER	0xBC
>> +#define SILEAD_REG_CLOCK	0xE4
>> +#define SILEAD_REG_STATUS	0xB0
>> +#define SILEAD_REG_ID		0xFC
>> +#define SILEAD_REG_MEM_CHECK	0xB0
>> +
>> +#define SILEAD_STATUS_OK	0x5A5A5A5A
>> +#define SILEAD_TS_DATA_LEN	44
>> +#define SILEAD_CLOCK		0x04
>> +
>> +#define SILEAD_CMD_RESET	0x88
>> +#define SILEAD_CMD_START	0x00
>> +
>> +#define SILEAD_POINT_DATA_LEN	0x04
>> +#define SILEAD_POINT_Y_OFF      0x00
>> +#define SILEAD_POINT_Y_MSB_OFF	0x01
>> +#define SILEAD_POINT_X_OFF	0x02
>> +#define SILEAD_POINT_X_MSB_OFF	0x03
>> +#define SILEAD_POINT_HSB_MASK	0x0F
>> +#define SILEAD_TOUCH_ID_MASK	0xF0
>> +
>> +#define SILEAD_CMD_SLEEP_MIN	10000
>> +#define SILEAD_CMD_SLEEP_MAX	20000
>> +#define SILEAD_POWER_SLEEP	20
>> +#define SILEAD_STARTUP_SLEEP	30
>> +
>> +#define SILEAD_MAX_FINGERS	10
>> +#define SILEAD_MAX_X		4096
>> +#define SILEAD_MAX_Y		4096
>> +
>> +enum silead_ts_power {
>> +	SILEAD_POWER_ON  = 1,
>> +	SILEAD_POWER_OFF = 0
>> +};
>> +
>> +struct silead_ts_data {
>> +	struct i2c_client *client;
>> +	struct gpio_desc *gpio_power;
>> +	struct input_dev *input;
>> +	const char *custom_fw_name;
>> +	char fw_name[I2C_NAME_SIZE];
>> +	u32 x_max;
>> +	u32 y_max;
>> +	u32 max_fingers;
>> +	bool x_invert;
>> +	bool y_invert;
>> +	bool xy_swap;
>> +	u32 chip_id;
>> +	struct input_mt_pos pos[SILEAD_MAX_FINGERS];
>> +	int slots[SILEAD_MAX_FINGERS];
>> +	int id[SILEAD_MAX_FINGERS];
>> +};
>> +
>> +struct silead_fw_data {
>> +	u32 offset;
>> +	u32 val;
>> +};
>> +
>> +static int silead_ts_request_input_dev(struct silead_ts_data *data)
>> +{
>> +	struct device *dev = &data->client->dev;
>> +	int error;
>> +
>> +	data->input = devm_input_allocate_device(dev);
>> +	if (!data->input) {
>> +		dev_err(dev,
>> +			"Failed to allocate input device\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (!data->xy_swap) {
>> +		input_set_abs_params(data->input, ABS_MT_POSITION_X, 0,
>> +				     data->x_max, 0, 0);
>> +		input_set_abs_params(data->input, ABS_MT_POSITION_Y, 0,
>> +				     data->y_max, 0, 0);
>> +	} else {
>> +		input_set_abs_params(data->input, ABS_MT_POSITION_X, 0,
>> +				     data->y_max, 0, 0);
>> +		input_set_abs_params(data->input, ABS_MT_POSITION_Y, 0,
>> +				     data->x_max, 0, 0);
>> +	}
>> +
>> +	input_mt_init_slots(data->input, data->max_fingers,
>> +			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED |
>> +			    INPUT_MT_TRACK);
>> +
>> +	data->input->name = SILEAD_TS_NAME;
>> +	data->input->phys = "input/ts";
>> +	data->input->id.bustype = BUS_I2C;
>> +
>> +	error = input_register_device(data->input);
>> +	if (error) {
>> +		dev_err(dev, "Failed to register input device: %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void silead_ts_report_touch(struct silead_ts_data *data, u16 x, u16 y,
>> +				   u8 id)
>> +{
>> +	if (data->x_invert)
>> +		x = data->x_max - x;
>> +
>> +	if (data->y_invert)
>> +		y = data->y_max - y;
>> +
>> +	if (data->xy_swap)
>> +		swap(x, y);
>> +
>> +	input_mt_slot(data->input, id);
>> +	input_mt_report_slot_state(data->input, MT_TOOL_FINGER, true);
>> +	input_report_abs(data->input, ABS_MT_POSITION_X, x);
>> +	input_report_abs(data->input, ABS_MT_POSITION_Y, y);
>> +}
>> +
>> +static void silead_ts_set_power(struct i2c_client *client,
>> +				enum silead_ts_power state)
>> +{
>> +	struct silead_ts_data *data = i2c_get_clientdata(client);
>> +
>> +	if (data->gpio_power) {
>> +		gpiod_set_value_cansleep(data->gpio_power, state);
>> +		msleep(SILEAD_POWER_SLEEP);
>> +	}
>> +}
>> +
>> +static void silead_ts_read_data(struct i2c_client *client)
>> +{
>> +	struct silead_ts_data *data = i2c_get_clientdata(client);
>> +	struct device *dev = &client->dev;
>> +	u8 buf[SILEAD_TS_DATA_LEN];
>> +	int x, y, touch_nr, error, i, offset;
>> +
>> +	error = i2c_smbus_read_i2c_block_data(client, SILEAD_REG_DATA,
>> +					    SILEAD_TS_DATA_LEN, buf);
>> +	if (error < 0) {
>> +		dev_err(dev, "Data read error %d\n", error);
>> +		return;
>> +	}
>> +
>> +	touch_nr = buf[0];
>
> What is touch NR? I.e. can we use it as slot ID instead of resorting to
> in-kernel tracking?

On some models yes, the problem is we do not really know which models so
we're keeping this info here to try and enable using the hardware
tracking on later models and use in kernel tracking everywhere now.

>
>> +
> Extra blank line.

Will fix for the next version (which I will do when we've agreement on
how to deal with your other remarks).

>
>> +	if (touch_nr < 0)
>> +		return;
>> +
>> +	if (touch_nr > data->max_fingers) {
>> +		dev_warn(dev, "More touches reported then supported %d > %d\n",
>> +			 touch_nr, data->max_fingers);
>> +		touch_nr = data->max_fingers;
>> +	}
>> +
>> +	dev_dbg(dev, "Touch number: %d\n", touch_nr);
>> +
>> +	for (i = 0; i < touch_nr; i++) {
>> +		offset = (i + 1) * SILEAD_POINT_DATA_LEN;
>> +
>> +		/* Bits 4-7 are the touch id */
>> +		data->id[i] = (buf[offset + SILEAD_POINT_X_MSB_OFF] &
>> +			      SILEAD_TOUCH_ID_MASK) >> 4;
>> +
>> +		/* Bits 0-3 are MSB of X */
>> +		buf[offset + SILEAD_POINT_X_MSB_OFF] =
>> +					buf[offset + SILEAD_POINT_X_MSB_OFF] &
>> +					SILEAD_POINT_HSB_MASK;
>> +
>> +		/* Bits 0-3 are MSB of Y */
>> +		buf[offset + SILEAD_POINT_Y_MSB_OFF] =
>> +					buf[offset + SILEAD_POINT_Y_MSB_OFF] &
>> +					SILEAD_POINT_HSB_MASK;
>> +
>> +		y = le16_to_cpup((__le16 *)(buf + offset + SILEAD_POINT_Y_OFF));
>> +		x = le16_to_cpup((__le16 *)(buf + offset + SILEAD_POINT_X_OFF));
>> +
>> +		data->pos[i].x = x;
>> +		data->pos[i].y = y;
>> +	}
>> +
>> +	input_mt_assign_slots(data->input, data->slots, data->pos, touch_nr, 0);
>> +
>> +	for (i = 0; i < touch_nr; i++) {
>> +		silead_ts_report_touch(data, data->pos[i].x, data->pos[i].y,
>> +				       data->slots[i]);
>> +
>> +		dev_dbg(dev, "x=%d y=%d hw_id=%d sw_id=%d\n", data->pos[i].x,
>> +			data->pos[i].y, data->id[i], data->slots[i]);
>> +	}
>> +
>> +	input_mt_sync_frame(data->input);
>> +	input_sync(data->input);
>> +}
>> +
>> +static int silead_ts_init(struct i2c_client *client)
>> +{
>> +	struct silead_ts_data *data = i2c_get_clientdata(client);
>> +	int error;
>> +
>> +	error = i2c_smbus_write_byte_data(client, SILEAD_REG_RESET,
>> +					SILEAD_CMD_RESET);
>> +	if (error)
>> +		goto i2c_write_err;
>> +	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
>> +
>> +	error = i2c_smbus_write_byte_data(client, SILEAD_REG_TOUCH_NR,
>> +					data->max_fingers);
>> +	if (error)
>> +		goto i2c_write_err;
>> +	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
>> +
>> +	error = i2c_smbus_write_byte_data(client, SILEAD_REG_CLOCK,
>> +					  SILEAD_CLOCK);
>> +	if (error)
>> +		goto i2c_write_err;
>> +	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
>> +
>> +	error = i2c_smbus_write_byte_data(client, SILEAD_REG_RESET,
>> +					SILEAD_CMD_START);
>> +	if (error)
>> +		goto i2c_write_err;
>> +	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
>> +
>> +	return 0;
>> +
>> +i2c_write_err:
>> +	dev_err(&client->dev, "Registers clear error %d\n", error);
>> +	return error;
>> +}
>> +
>> +static int silead_ts_reset(struct i2c_client *client)
>> +{
>> +	int error;
>> +
>> +	error = i2c_smbus_write_byte_data(client, SILEAD_REG_RESET,
>> +					SILEAD_CMD_RESET);
>> +	if (error)
>> +		goto i2c_write_err;
>> +	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
>> +
>> +	error = i2c_smbus_write_byte_data(client, SILEAD_REG_CLOCK,
>> +					  SILEAD_CLOCK);
>> +	if (error)
>> +		goto i2c_write_err;
>> +	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
>> +
>> +	error = i2c_smbus_write_byte_data(client, SILEAD_REG_POWER,
>> +					SILEAD_CMD_START);
>> +	if (error)
>> +		goto i2c_write_err;
>> +	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
>> +
>> +	return 0;
>> +
>> +i2c_write_err:
>> +	dev_err(&client->dev, "Chip reset error %d\n", error);
>> +	return error;
>> +}
>> +
>> +static int silead_ts_startup(struct i2c_client *client)
>> +{
>> +	int error;
>> +
>> +	error = i2c_smbus_write_byte_data(client, SILEAD_REG_RESET, 0x00);
>> +	if (error) {
>> +		dev_err(&client->dev, "Startup error %d\n", error);
>> +		return error;
>> +	}
>> +	msleep(SILEAD_STARTUP_SLEEP);
>> +
>> +	return 0;
>> +}
>> +
>> +static int silead_ts_load_fw(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct silead_ts_data *data = i2c_get_clientdata(client);
>> +	unsigned int fw_size, i;
>> +	const struct firmware *fw;
>> +	struct silead_fw_data *fw_data;
>> +	int error;
>> +
>> +	dev_dbg(dev, "Firmware file name: %s", data->fw_name);
>> +
>> +	if (data->custom_fw_name)
>> +		error = request_firmware(&fw, data->custom_fw_name, dev);
>> +	else
>> +		error = request_firmware(&fw, data->fw_name, dev);
>> +
>> +	if (error) {
>> +		dev_err(dev, "Firmware request error %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	fw_size = fw->size / sizeof(*fw_data);
>> +	fw_data = (struct silead_fw_data *)fw->data;
>> +
>> +	for (i = 0; i < fw_size; i++) {
>> +		error = i2c_smbus_write_i2c_block_data(client,
>> +						       fw_data[i].offset,
>> +						       4,
>> +						       (u8 *)&fw_data[i].val);
>> +		if (error) {
>> +			dev_err(dev, "Firmware load error %d\n", error);
>> +			goto release_fw_err;
>> +		}
>> +	}
>> +
>> +	release_firmware(fw);
>> +	return 0;
>> +
>> +release_fw_err:
>> +	release_firmware(fw);
>> +	return error;
>> +}
>> +
>> +static u32 silead_ts_get_status(struct i2c_client *client)
>> +{
>> +	int error;
>> +	u32 status;
>> +
>> +	error = i2c_smbus_read_i2c_block_data(client, SILEAD_REG_STATUS, 4,
>> +					    (u8 *)&status);
>> +	if (error < 0) {
>> +		dev_err(&client->dev, "Status read error %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	return le32_to_cpu(status);
>> +}
>> +
>> +static int silead_ts_get_id(struct i2c_client *client)
>> +{
>> +	struct silead_ts_data *data = i2c_get_clientdata(client);
>> +	int error;
>> +
>> +	error = i2c_smbus_read_i2c_block_data(client, SILEAD_REG_ID, 4,
>> +					    (u8 *)&data->chip_id);
>> +
>> +	data->chip_id = le32_to_cpu(data->chip_id);
>> +
>> +	if (error < 0) {
>> +		dev_err(&client->dev, "Chip ID read error %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int silead_ts_setup(struct i2c_client *client)
>> +{
>> +	struct silead_ts_data *data = i2c_get_clientdata(client);
>> +	struct device *dev = &client->dev;
>> +	int error;
>> +	u32 status;
>> +
>> +	silead_ts_set_power(client, SILEAD_POWER_OFF);
>> +	silead_ts_set_power(client, SILEAD_POWER_ON);
>> +
>> +	error = silead_ts_get_id(client);
>> +	if (error)
>> +		return error;
>> +	dev_info(dev, "Silead chip ID: 0x%8X", data->chip_id);
>> +
>> +	error = silead_ts_init(client);
>> +	if (error)
>> +		return error;
>> +
>> +	error = silead_ts_reset(client);
>> +	if (error)
>> +		return error;
>> +
>> +	error = silead_ts_load_fw(client);
>> +	if (error)
>> +		return error;
>> +
>> +	error = silead_ts_startup(client);
>> +	if (error)
>> +		return error;
>> +
>> +	status = silead_ts_get_status(client);
>> +	if (status != SILEAD_STATUS_OK) {
>> +		dev_err(dev, "Initialization error, status: 0x%X\n", status);
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t silead_ts_threaded_irq_handler(int irq, void *id)
>> +{
>> +	struct silead_ts_data *data = id;
>> +	struct i2c_client *client = data->client;
>> +
>> +	silead_ts_read_data(client);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int silead_ts_read_props(struct i2c_client *client)
>> +{
>> +	struct silead_ts_data *data = i2c_get_clientdata(client);
>> +	struct device *dev = &client->dev;
>> +	int error;
>> +
>> +	error = device_property_read_u32(dev, "touchscreen-size-x",
>> +					&data->x_max);
>> +	if (error) {
>> +		dev_dbg(dev, "Resolution X read error %d\n", error);
>> +		data->x_max = SILEAD_MAX_X;
>> +	}
>> +	data->x_max--; /* Property contains size not max */
>> +
>> +	error = device_property_read_u32(dev, "touchscreen-size-y",
>> +					&data->y_max);
>> +	if (error) {
>> +		dev_dbg(dev, "Resolution Y read error %d\n", error);
>> +		data->y_max = SILEAD_MAX_Y;
>> +	}
>> +	data->y_max--; /* Property contains size not max */
>> +
>> +	error = device_property_read_u32(dev, "touchscreen-max-fingers",
>> +					 &data->max_fingers);
>> +	if (error) {
>> +		dev_dbg(dev, "Max fingers read error %d\n", error);
>> +		data->max_fingers = 5; /* Most devices handle up-to 5 fingers */
>> +	}
>> +
>> +	error = device_property_read_string(dev, "touchscreen-fw-name",
>> +					  &data->custom_fw_name);
>> +	if (error)
>> +		dev_dbg(dev, "Firmware file name read error. Using default.");
>
> Why do we need separate variable for this?

As said the firmware is not really firmware, but configuration data and
each different digitizer (or the same digitizer wired up differently)
needs different configuration data.

>> +
>> +	data->x_invert = device_property_read_bool(dev,
>> +						"touchscreen-inverted-x");
>> +	data->y_invert = device_property_read_bool(dev,
>> +						"touchscreen-inverted-y");
>> +	data->xy_swap = device_property_read_bool(dev,
>> +						"touchscreen-swapped-x-y");
>> +
>> +	dev_dbg(dev, "x_max = %d, y_max = %d, max_fingers = %d, x_invert = %d, y_invert = %d, xy_swap = %d",
>> +		data->x_max, data->y_max, data->max_fingers, data->x_invert,
>> +		data->y_invert, data->xy_swap);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_ACPI
>> +static int silead_ts_set_default_fw_name(struct silead_ts_data *data,
>> +					 const struct i2c_device_id *id)
>> +{
>> +	const struct acpi_device_id *acpi_id;
>> +	struct device *dev = &data->client->dev;
>> +	int i;
>> +
>> +	if (ACPI_HANDLE(dev)) {
>> +		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
>> +		if (!acpi_id)
>> +			return -ENODEV;
>> +
>> +		snprintf(data->fw_name, sizeof(data->fw_name), "%s.fw",
>> +			acpi_id->id);
>> +
>> +		for (i = 0; i < strlen(data->fw_name); i++)
>> +			data->fw_name[i] = tolower(data->fw_name[i]);
>> +	} else {
>> +		snprintf(data->fw_name, sizeof(data->fw_name), "%s.fw",
>> +			id->name);
>> +	}
>> +
>> +	return 0;
>> +}
>> +#else
>> +static int silead_ts_set_default_fw_name(struct silead_ts_data *data,
>> +					 const struct i2c_device_id *id)
>> +{
>> +	snprintf(data->fw_name, sizeof(data->fw_name), "%s.fw", id->name);
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static int silead_ts_probe(struct i2c_client *client,
>> +			   const struct i2c_device_id *id)
>> +{
>> +	struct silead_ts_data *data;
>> +	struct device *dev = &client->dev;
>> +	int error;
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_I2C |
>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
>> +				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
>> +		dev_err(dev, "I2C functionality check failed\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(client, data);
>> +	data->client = client;
>> +
>> +	error = silead_ts_set_default_fw_name(data, id);
>> +	if (error)
>> +		return error;
>> +
>> +	/* We must have the IRQ provided by DT or ACPI subsytem */
>> +	if (client->irq <= 0)
>> +		return -ENODEV;
>> +
>> +	/* Power GPIO pin */
>> +	data->gpio_power = devm_gpiod_get_index(dev, "power",
>> +						0, GPIOD_OUT_LOW);
>
> Why "get index" and not devm_gpiod_get_optional()?
>
>> +	if (IS_ERR(data->gpio_power)) {
>> +		dev_dbg(dev, "Shutdown GPIO request failed\n");
>> +		data->gpio_power = NULL;
>
> You want to abort on errors, especially if you get -EPROBE_DEFER.
>
>> +	}
>> +
>> +	error = silead_ts_read_props(client);
>> +	if (error)
>> +		return error;
>> +
>> +	error = silead_ts_setup(client);
>> +	if (error)
>> +		return error;
>> +
>> +	error = silead_ts_request_input_dev(data);
>> +	if (error)
>> +		return error;
>> +
>> +	error = devm_request_threaded_irq(dev, client->irq, NULL,
>> +					silead_ts_threaded_irq_handler,
>> +					IRQF_ONESHOT | IRQ_TYPE_EDGE_RISING,
>
> Please just use IRQF_ONESHOT and rely on platform code (ACPI. DT, etc)
> to specify interrupt trigger.

Ack, will fix.

>> +					client->name, data);
>> +	if (error) {
>> +		dev_err(dev, "IRQ request failed %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	dev_dbg(dev, "Probing succeded\n");
>
> You'd see if it failed... Just drop.

Ack, will fix.

>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused silead_ts_suspend(struct device *dev)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +
>> +	silead_ts_set_power(client, SILEAD_POWER_OFF);
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused silead_ts_resume(struct device *dev)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	int error, status;
>> +
>> +	silead_ts_set_power(client, SILEAD_POWER_ON);
>> +
>> +	error = silead_ts_reset(client);
>> +	if (error)
>> +		return error;
>> +
>> +	error = silead_ts_startup(client);
>> +	if (error)
>> +		return error;
>> +
>> +	status = silead_ts_get_status(client);
>> +	if (status != SILEAD_STATUS_OK) {
>> +		dev_err(dev, "Resume error, status: 0x%X\n", status);
>
> "%#02X"

Ack, will fix.

>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(silead_ts_pm, silead_ts_suspend, silead_ts_resume);
>> +
>> +static const struct i2c_device_id silead_ts_id[] = {
>> +	{ "gsl1680", 0 },
>> +	{ "gsl1688", 0 },
>> +	{ "gsl3670", 0 },
>> +	{ "gsl3675", 0 },
>> +	{ "gsl3692", 0 },
>> +	{ "mssl1680", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, silead_ts_id);
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id silead_ts_acpi_match[] = {
>> +	{ "GSL1680", 0 },
>> +	{ "GSL1688", 0 },
>> +	{ "GSL3670", 0 },
>> +	{ "GSL3675", 0 },
>> +	{ "GSL3692", 0 },
>> +	{ "MSSL1680", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
>> +#endif
>> +
>> +static struct i2c_driver silead_ts_driver = {
>> +	.probe = silead_ts_probe,
>> +	.id_table = silead_ts_id,
>> +	.driver = {
>> +		.name = SILEAD_TS_NAME,
>> +		.owner = THIS_MODULE,
>> +		.acpi_match_table = ACPI_PTR(silead_ts_acpi_match),
>> +		.pm = &silead_ts_pm,
>> +	},
>> +};
>> +module_i2c_driver(silead_ts_driver);
>> +
>> +MODULE_AUTHOR("Robert Dolca <robert.dolca@intel.com>");
>> +MODULE_DESCRIPTION("Silead I2C touchscreen driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.7.4
>>
>
> Thanks.

Please let me know if you're happy with my answers to your remarks /
questions which I've not marked as "will fix" and then I'll do a v7.

Regards,

Hans

