From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Thu, 21 Jan 2016 01:37:49 -0800
Message-ID: <20160121093749.GA9467@dtor-ws>
References: <1453348978-32349-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33436 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759102AbcAUJhx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 04:37:53 -0500
Content-Disposition: inline
In-Reply-To: <1453348978-32349-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Lin <yajohn@gmail.com>
Cc: rydberg@euromail.se, dianders@chromium.org, scott.liu@emc.com.tw, jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Jeffrey,

On Thu, Jan 21, 2016 at 12:02:58PM +0800, Jeffrey Lin wrote:
> This patch is porting Raydium I2C touch driver. Developer can enable raydium touch driver by modifying define
> "CONFIG_TOUCHSCREEN_RM_TS".

Thank you for making changes, please see my comments below.

> 
> Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
> ---
>  drivers/input/touchscreen/Kconfig      |  12 +
>  drivers/input/touchscreen/Makefile     |   1 +
>  drivers/input/touchscreen/rm31100_ts.c | 747 +++++++++++++++++++++++++++++++++
>  3 files changed, 760 insertions(+)
>  create mode 100644 drivers/input/touchscreen/rm31100_ts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index c0659eb..ea7e259 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -974,4 +974,16 @@ config TOUCHSCREEN_ZFORCE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zforce_ts.
>  
> +config TOUCHSCREEN_RM_TS
> +	tristate "Raydium I2C Touchscreen"
> +	depends on I2C
> +	help
> +	  Say Y here if you have Raydium series I2C touchscreen,
> +	  such as RM31100 , connected to your system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rm31100_ts.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 944e5b3..1a11974 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -80,3 +80,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_RM_TS)		+= rm31100_ts.o


Please add new entries to makefile in alphabetical order.

> diff --git a/drivers/input/touchscreen/rm31100_ts.c b/drivers/input/touchscreen/rm31100_ts.c
> new file mode 100644
> index 0000000..b1b8087
> --- /dev/null
> +++ b/drivers/input/touchscreen/rm31100_ts.c
> @@ -0,0 +1,747 @@
> +/*
> + * Raydium RM31100_ts touchscreen driver.
> + *
> + * Copyright (C) 2012-2014, Raydium Semiconductor Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2, and only version 2, as published by the
> + * Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Raydium reserves the right to make changes without further notice
> + * to the materials described herein. Raydium does not assume any
> + * liability arising out of the application described herein.
> + *
> + * Contact Raydium Semiconductor Corporation at www.rad-ic.com
> + *
> + */
> +#include <linux/async.h>

You are not using this anymore.

> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/uaccess.h>
> +#include <asm/unaligned.h>
> +#include <linux/input/mt.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define rm31100	0x0
> +#define rm3110x	0x1
> +
> +#define INVALID_DATA	0xff
> +#define MAX_REPORT_TOUCHED_POINTS	10
> +
> +#define I2C_CLIENT_ADDR         0x39
> +#define I2C_DMA_CLIENT_ADDR     0x5A
> +
> +struct rm31100_ts_data {
> +	u8 x_index;
> +	u8 y_index;
> +	u8 z_index;
> +	u8 id_index;
> +	u8 touch_index;
> +	u8 data_reg;
> +	u8 status_reg;
> +	u8 data_size;
> +	u8 touch_bytes;
> +	u8 update_data;
> +	u8 touch_meta_data;
> +	u8 finger_size;
> +};
> +
> +struct rm3110x_ts_platform_data {
> +	u32 dis_min_x; /* display resoltion ABS min*/
> +	u32 dis_max_x;/* display resoltion ABS max*/
> +	u32 dis_min_y;
> +	u32 dis_max_y;
> +	u32 res_x; /* TS resolution unit*/
> +	u32 res_y;
> +	u32 swap_xy;
> +	u8 nfingers;

I believe I already asked, why do we have number of fingers in platform
data?

> +	bool wakeup;
> +};
> +
> +static struct rm31100_ts_data devices[] = {
> +	[0] = {
> +		.x_index = 2,
> +		.y_index = 4,
> +		.z_index = 6,
> +		.id_index = 1,
> +		.data_reg = 0x1,
> +		.status_reg = 0,
> +		.update_data = 0x0,
> +		.touch_bytes = 6,
> +		.touch_meta_data = 1,
> +		.finger_size = 70,
> +	},
> +	[1] = {
> +		.x_index = 2,
> +		.y_index = 4,
> +		.z_index = 6,
> +		.id_index = 1,
> +		.data_reg = 0x0,
> +		.status_reg = 0,
> +		.update_data = 0x0,
> +		.touch_bytes = 6,
> +		.touch_meta_data = 1,
> +		.finger_size = 70,
> +	},

Please attach the instances of this structure as driver_data to the
platform ids instead of using indices.

> +};
> +
> +struct rm31100_ts {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct regulator *dvdd;
> +	struct regulator *avdd;
> +	struct gpio_desc *resout_gpio;
> +	struct rm3110x_ts_platform_data *pdata;
> +	struct rm31100_ts_data *dd;
> +	u8 *touch_data;
> +	u8 device_id;
> +	bool is_suspended;

I do not understand the use of this member.

> +	struct mutex access_lock;

You do not seem to be using this.

> +	u32 pen_irq;
> +	u8 fw_version;
> +	u8 u8_sub_version;
> +};
> +
> +static int rm31100_ts_write_reg_u8(struct i2c_client *client, u8 reg, u8 val)
> +{
> +	int data;
> +
> +	data = i2c_smbus_write_byte_data(client, reg, val);
> +	if (data < 0)
> +		dev_err(&client->dev, "error %d in writing reg 0x%x\n",
> +						 data, reg);
> +
> +	return data;
> +}
> +
> +static int rm31100_ts_read_reg_u8(struct i2c_client *client, u8 reg)
> +{
> +	int data;
> +
> +	data = i2c_smbus_read_byte_data(client, reg);
> +	if (data < 0)
> +		dev_err(&client->dev, "error %d in reading reg 0x%x\n",
> +						 data, reg);
> +
> +	return data;
> +}
> +
> +static int rm31100_ts_read(struct i2c_client *client, u8 reg, u8 *buf, int num)
> +{
> +	struct i2c_msg xfer_msg[2];
> +
> +	xfer_msg[0].addr = client->addr;
> +	xfer_msg[0].len = 1;
> +	xfer_msg[0].flags = 0;
> +	xfer_msg[0].buf = &reg;
> +
> +	xfer_msg[1].addr = client->addr;
> +	xfer_msg[1].len = num;
> +	xfer_msg[1].flags = I2C_M_RD;
> +	xfer_msg[1].buf = buf;
> +
> +	return i2c_transfer(client->adapter, xfer_msg, num);
> +}
> +
> +static int rm31100_ts_write(struct i2c_client *client, u8 *buf, int num)
> +{
> +	struct i2c_msg xfer_msg[1];
> +
> +	xfer_msg[0].addr = client->addr;
> +	xfer_msg[0].len = num;
> +	xfer_msg[0].flags = 0;
> +	xfer_msg[0].buf = buf;
> +
> +	return i2c_transfer(client->adapter, xfer_msg, num);
> +}
> +
> +static ssize_t rm_fw_version_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct rm31100_ts *info = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "Release Version %d.%0d\n",
> +		info->fw_version,
> +		info->u8_sub_version);
> +}
> +
> +static DEVICE_ATTR(fw_version, S_IRUGO, rm_fw_version_show, NULL);
> +
> +static struct attribute *rm_ts_attributes[] = {
> +	&dev_attr_fw_version.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group rm_ts_attr_group = {
> +	.attrs = rm_ts_attributes,
> +};
> +
> +static void report_data(struct rm31100_ts *dev, u16 x, u16 y,
> +	u8 pressure, u8 id)
> +{
> +	struct input_dev *input_dev = dev->input;
> +
> +	if (dev->pdata->swap_xy)
> +		swap(x, y);
> +
> +	input_mt_slot(input_dev, id);
> +	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, true);
> +	input_report_abs(input_dev, ABS_MT_POSITION_X, x);
> +	input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
> +	input_report_abs(input_dev, ABS_MT_PRESSURE, pressure);
> +	input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, dev->dd->finger_size);
> +}
> +
> +static void process_rm31100_data(struct rm31100_ts *ts)
> +{
> +	u8 id, pressure, touches, i;
> +	u16 x, y;
> +
> +	touches = ts->touch_data[ts->dd->touch_index];
> +
> +	if (touches > 0) {
> +		for (i = 0; i < touches; i++) {
> +			id = ts->touch_data[i * ts->dd->touch_bytes +
> +				ts->dd->id_index];
> +			pressure = ts->touch_data[i * ts->dd->touch_bytes +
> +				ts->dd->z_index];
> +			x = get_unaligned_le16(&(ts->touch_data[i *
> +				ts->dd->touch_bytes + ts->dd->x_index]));
> +			y = get_unaligned_le16(&(ts->touch_data[i *
> +				ts->dd->touch_bytes + ts->dd->y_index]));
> +			report_data(ts, x, y, pressure, id);
> +		}
> +	} else
> +		input_mt_sync(ts->input);
> +
> +	input_mt_report_pointer_emulation(ts->input, true);
> +	input_sync(ts->input);
> +}
> +
> +static int rm31100_ts_xy_worker(struct rm31100_ts *work)
> +{
> +	int rc;
> +	struct rm31100_ts *ts = work;
> +
> +	/* read data from DATA_REG */
> +	rc = rm31100_ts_read(ts->client, ts->dd->data_reg, ts->touch_data,
> +	ts->dd->data_size);
> +
> +	if (rc < 0) {
> +		dev_err(&ts->client->dev, "read failed\n");
> +		goto schedule;
> +	}
> +
> +	if (ts->touch_data[ts->dd->touch_index] == INVALID_DATA)
> +		goto schedule;
> +
> +	/* write to STATUS_REG to release lock */
> +	rc = rm31100_ts_write_reg_u8(ts->client,
> +		ts->dd->status_reg, ts->dd->update_data);
> +	if (rc < 0) {
> +		dev_err(&ts->client->dev, "write failed, try once more\n");
> +
> +		rc = rm31100_ts_write_reg_u8(ts->client,
> +			ts->dd->status_reg, ts->dd->update_data);
> +		if (rc < 0)
> +			dev_err(&ts->client->dev, "write failed, exiting\n");
> +	}
> +
> +	process_rm31100_data(ts);
> +schedule:
> +	return rc;
> +}
> +
> +static irqreturn_t rm31100_ts_irq(int irq, void *dev_id)
> +{
> +	struct rm31100_ts *ts = dev_id;
> +	struct device *dev = &ts->client->dev;
> +	int rc;
> +
> +	rc = rm31100_ts_xy_worker(ts);
> +	if (rc < 0) {
> +		dev_err(dev, "Handling message fails in IRQ, %d.\n",
> +			rc);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rm_ts_power_on(struct rm31100_ts *ts)
> +{
> +	int error;
> +
> +	/*
> +	 * If we do not have reset gpio assume platform firmware
> +	 * controls regulators and does power them on for us.
> +	 */
> +	if (IS_ERR_OR_NULL(ts->resout_gpio))
> +		return 0;
> +
> +	gpiod_set_value_cansleep(ts->resout_gpio, 1);
> +
> +	error = regulator_enable(ts->avdd);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"failed to enable avdd regulator: %d\n",
> +			error);
> +		goto release_reset_gpio;
> +	}
> +
> +	error = regulator_enable(ts->dvdd);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"failed to enable dvdd regulator: %d\n",
> +			error);
> +		regulator_disable(ts->dvdd);
> +		goto release_reset_gpio;
> +	}
> +
> +release_reset_gpio:
> +	gpiod_set_value_cansleep(ts->resout_gpio, 0);
> +	if (error)
> +		return error;
> +
> +	msleep(20);
> +
> +	return 0;
> +}
> +
> +static void rm_ts_power_off(void *_data)
> +{
> +	struct rm31100_ts *data = _data;
> +
> +	if (!IS_ERR_OR_NULL(data->resout_gpio)) {
> +		/*
> +		 * Activate reset gpio to prevent leakage through the
> +		 * pin once we shut off power to the controller.
> +		 */
> +		gpiod_set_value_cansleep(data->resout_gpio, 1);
> +		regulator_disable(data->avdd);
> +		regulator_disable(data->dvdd);
> +	}
> +}
> +
> +static int rm31100_ts_init_ts(struct i2c_client *client, struct rm31100_ts *ts)
> +{
> +	/*struct input_dev *input_device;*/
> +	/*int rc = 0;*/
> +
> +	ts->dd = &devices[ts->device_id];
> +
> +	if (!ts->pdata->nfingers) {
> +		dev_err(&client->dev, "Touches information not specified\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ts->device_id == rm3110x) {
> +		if (ts->pdata->nfingers > 2) {
> +			dev_err(&client->dev, "Touches >=1 & <= 2\n");
> +			return -EINVAL;
> +		}
> +		ts->dd->data_size = ts->dd->touch_bytes;
> +		ts->dd->touch_index = 0x0;
> +	} else if (ts->device_id == rm31100) {
> +		if (ts->pdata->nfingers > 10) {
> +			dev_err(&client->dev, "Touches >=1 & <= 10\n");
> +			return -EINVAL;
> +		}
> +		ts->dd->data_size = ts->pdata->nfingers * ts->dd->touch_bytes +
> +						ts->dd->touch_meta_data;
> +		ts->dd->touch_index = 0x0;
> +	}
> +	/* w001 */
> +	else {
> +		ts->dd->data_size = ts->pdata->nfingers * ts->dd->touch_bytes +
> +		ts->dd->touch_meta_data;
> +		ts->dd->touch_index = 0x0;
> +	}
> +
> +	ts->touch_data = kzalloc(ts->dd->data_size, GFP_KERNEL);
> +	if (!ts->touch_data)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void __maybe_unused rm_enter_sleep(struct rm31100_ts *data)
> +{
> +	const u8 sleep_cmd[] = { 0x5A, 0xff, 0x00, 0x0f };
> +	int rc;
> +
> +	rc = rm31100_ts_write(data->client, (u8 *)sleep_cmd,
> +		ARRAY_SIZE(sleep_cmd));
> +	if (rc)
> +		dev_err(&data->client->dev,
> +			"Send sleep failed: %d\n", rc);
> +}
> +
> +static int __maybe_unused rm31100_ts_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct rm31100_ts *ts = i2c_get_clientdata(client);
> +
> +	disable_irq(ts->pen_irq);
> +
> +	if (device_may_wakeup(dev)) {
> +		rm_enter_sleep(ts);
> +		/* mark suspend flag */
> +		ts->is_suspended = (enable_irq_wake(ts->pen_irq) == 0);
> +	} else
> +		rm_ts_power_off(ts);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused rm31100_ts_resume(struct device *dev)
> +{
> +	struct rm31100_ts *ts = dev_get_drvdata(dev);
> +
> +	int rc = 0;
> +
> +	if (device_may_wakeup(dev)) {
> +		disable_irq_wake(ts->pen_irq);
> +
> +		ts->is_suspended = false;
> +	} else {
> +		rc = rm_ts_power_on(ts);
> +		if (rc) {
> +			dev_err(dev, "unable to resume\n");
> +			return rc;
> +		}
> +
> +		enable_irq(ts->pen_irq);
> +
> +		/* Clear the status register of the TS controller */
> +		rc = rm31100_ts_write_reg_u8(ts->client,
> +			ts->dd->status_reg, ts->dd->update_data);
> +		if (rc < 0) {
> +			dev_err(&ts->client->dev,
> +				"write failed, try once more\n");
> +
> +			rc = rm31100_ts_write_reg_u8(ts->client,
> +				ts->dd->status_reg,
> +				ts->dd->update_data);
> +			if (rc < 0)
> +				dev_err(&ts->client->dev,
> +					"write failed, exiting\n");
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void rm_ts_remove_sysfs_group(void *_data)
> +{
> +	struct rm31100_ts *ts = _data;
> +
> +	sysfs_remove_group(&ts->client->dev.kobj, &rm_ts_attr_group);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(rm31100_ts_pm_ops,
> +			 rm31100_ts_suspend, rm31100_ts_resume);
> +
> +static int rm_input_dev_create(struct rm31100_ts *ts)
> +{
> +	struct input_dev *input_device;
> +	int rc = 0;
> +
> +	input_device = input_allocate_device();

devm_input_allocate_device().

> +	if (!input_device) {
> +		rc = -ENOMEM;
> +		goto error_alloc_dev;
> +	}
> +	ts->input = input_device;
> +
> +	input_device->name = "raydium_ts";
> +	input_device->id.bustype = BUS_I2C;
> +	input_device->dev.parent = &ts->client->dev;
> +	input_set_drvdata(input_device, ts);
> +
> +	__set_bit(BTN_TOUCH, input_device->keybit);
> +	__set_bit(EV_ABS, input_device->evbit);
> +	__set_bit(EV_KEY, input_device->evbit);
> +
> +	/* For single touch */
> +	input_set_abs_params(input_device, ABS_X,
> +			     ts->pdata->dis_min_x, ts->pdata->dis_max_x, 0, 0);
> +	input_set_abs_params(input_device, ABS_Y,
> +			     ts->pdata->dis_min_x, ts->pdata->dis_max_y, 0, 0);
> +	input_set_abs_params(input_device, ABS_PRESSURE,
> +			     0, 255, 0, 0);
> +	input_abs_set_res(input_device, ABS_X, ts->pdata->res_x);
> +	input_abs_set_res(input_device, ABS_Y, ts->pdata->res_y);
> +
> +	/* Multitouch input params setup */
> +	rc = input_mt_init_slots(input_device,
> +		MAX_REPORT_TOUCHED_POINTS,
> +		INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (rc)
> +		goto error_unreg_device;
> +
> +	input_set_abs_params(input_device, ABS_MT_POSITION_X,
> +		ts->pdata->dis_min_x, ts->pdata->dis_max_x, 0, 0);
> +	input_set_abs_params(input_device, ABS_MT_POSITION_Y,
> +		ts->pdata->dis_min_y, ts->pdata->dis_max_y, 0, 0);
> +	input_set_abs_params(input_device, ABS_MT_PRESSURE,
> +		0, 0xFF, 0, 0);
> +	input_set_abs_params(input_device, ABS_MT_TOUCH_MAJOR,
> +		0, 0xFF, 0, 0);
> +	input_abs_set_res(input_device, ABS_MT_POSITION_X, ts->pdata->res_x);
> +	input_abs_set_res(input_device, ABS_MT_POSITION_Y, ts->pdata->res_y);
> +
> +	rc = input_register_device(input_device);
> +	if (rc)
> +		goto error_unreg_device;
> +
> +	return 0;
> +
> +error_unreg_device:
> +	input_free_device(input_device);
> +error_alloc_dev:
> +	ts->input = NULL;
> +	return rc;
> +}
> +
> +static int rm31100_initialize(struct i2c_client *client)
> +{
> +	struct rm31100_ts *ts = i2c_get_clientdata(client);
> +	int rc = 0, temp_reg;
> +
> +	/* read one byte to make sure i2c device exists */
> +	if (ts->device_id == rm3110x)
> +		temp_reg = 0x01;
> +	else if (ts->device_id == rm31100)
> +		temp_reg = 0x00;
> +	else
> +		temp_reg = 0x05;
> +
> +	rc = rm31100_ts_read_reg_u8(client, temp_reg);
> +	if (rc < 0) {
> +		dev_err(&client->dev, "i2c sanity check failed\n");
> +		return rc;
> +	}
> +
> +	rc = rm31100_ts_init_ts(client, ts);
> +	if (rc < 0) {
> +		dev_err(&client->dev, "rm31100_ts init failed\n");
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rm31100_ts_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct rm31100_ts *ts;
> +	struct rm3110x_ts_platform_data *pdata = client->dev.platform_data;
> +	int rc;

Please call this variable "error".

> +	union i2c_smbus_data dummy;
> +
> +	ts = devm_kzalloc(&client->dev, sizeof(struct rm31100_ts), GFP_KERNEL);
> +

Stray empty line.

> +	if (!ts)
> +		return -ENOMEM;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +		I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> +		dev_err(&client->dev, "I2C functionality not supported\n");
> +		rc = -EIO;
> +		goto error_touch_data_alloc;
> +	}
> +
> +	ts->client = client;
> +	ts->pdata = pdata;
> +	i2c_set_clientdata(client, ts);
> +	ts->device_id = id->driver_data;
> +
> +	ts->is_suspended = false;
> +
> +	mutex_init(&ts->access_lock);
> +
> +	ts->avdd = devm_regulator_get(&client->dev, "avdd");
> +	if (IS_ERR(ts->avdd)) {
> +		rc = PTR_ERR(ts->avdd);
> +		if (rc != -EPROBE_DEFER)
> +			dev_err(&client->dev,
> +				"Failed to get 'avdd' regulator: %d\n",
> +				rc);
> +		return rc;
> +	}
> +
> +	ts->dvdd = devm_regulator_get(&client->dev, "dvdd");
> +	if (IS_ERR(ts->dvdd)) {
> +		rc = PTR_ERR(ts->dvdd);
> +		if (rc != -EPROBE_DEFER)
> +			dev_err(&client->dev,
> +				"Failed to get 'dvdd' regulator: %d\n",
> +				rc);
> +		return rc;
> +	}

I took a peek at the data sheet and it looks like the chip uses 3 power
supplies, and they have different names from avdd/dvdd. We should be
using the names form the data sheet.

> +
> +	ts->resout_gpio = devm_gpiod_get_optional(&client->dev,
> +		"ts_reset", 0);
> +
> +	if (IS_ERR(ts->resout_gpio)) {
> +		rc = PTR_ERR(ts->resout_gpio);
> +		/*
> +		 * On Chromebooks vendors like to source touch panels from
> +		 * different vendors, but they are connected to the same
> +		 * regulators/GPIO pin. The drivers also use asynchronous
> +		 * probing, which means that more than one driver will
> +		 * attempt to claim the reset line. If we find it busy,
> +		 * let's try again later.
> +		 */
> +		if (rc == -EBUSY) {
> +			dev_info(&client->dev,
> +				 "reset gpio is busy, deferring probe\n");
> +			return -EPROBE_DEFER;
> +		}

As I said in my other email this is Chrome OS specific and doe snot
belong in mainline. Simply return error here, do not try to convert busy
into deferral.

> +
> +		if (rc == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		if (rc != -ENOENT && rc != -ENOSYS) {
> +			dev_err(&client->dev,
> +				"failed to get reset gpio: %d\n",
> +				rc);
> +			return rc;
> +		}
> +	}
> +
> +	rc = rm_ts_power_on(ts);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_add_action(&client->dev, rm_ts_power_off, ts);
> +	if (rc) {
> +		dev_err(&client->dev,
> +			"failed to install power off action: %d\n", rc);
> +		rm_ts_power_off(ts);
> +		return rc;
> +	}
> +
> +	/* Make sure there is something at this address */
> +	if (i2c_smbus_xfer(client->adapter, client->addr, 0,
> +		I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &dummy) < 0)
> +		return -ENODEV;
> +
> +	rc = rm31100_initialize(client);
> +	if (rc < 0) {
> +		dev_err(&client->dev, "probe failed! unbind device.\n");
> +		return rc;
> +	}
> +
> +	rc = rm_input_dev_create(ts);
> +	if (rc) {
> +		dev_err(&client->dev, "%s crated failed, %d\n", __func__, rc);
> +		return rc;
> +	}
> +
> +	rc = devm_request_threaded_irq(&client->dev, ts->pen_irq,
> +					NULL, rm31100_ts_irq,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					client->name, ts);

Where is ts->pen_irq assignment? I do not believe you tested this version
of the driver.

> +	if (rc) {
> +		dev_err(&client->dev, "Failed to register interrupt\n");
> +		return rc;
> +	}
> +
> +	rc = sysfs_create_group(&client->dev.kobj, &rm_ts_attr_group);
> +	if (rc) {
> +		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
> +			rc);
> +		return rc;
> +	}
> +
> +	rc = devm_add_action(&client->dev,
> +				rm_ts_remove_sysfs_group, ts);
> +	if (rc) {
> +		rm_ts_remove_sysfs_group(ts);
> +		dev_err(&client->dev,
> +			"Failed to add sysfs cleanup action: %d\n",
> +			rc);
> +		return rc;
> +	}
> +	return 0;
> +
> +error_touch_data_alloc:
> +	return rc;
> +}
> +
> +static int rm31100_ts_remove(struct i2c_client *client)
> +{
> +	struct rm31100_ts *ts = i2c_get_clientdata(client);
> +
> +	device_init_wakeup(&client->dev, 0);
> +
> +	devm_free_irq(&client->dev, ts->pen_irq, ts);
> +
> +	input_unregister_device(ts->input);
> +
> +	mutex_destroy(&ts->access_lock);
> +
> +	rm_ts_power_off(ts);

You installed power of ass devm action, why do you also callit manually.

> +
> +	kfree(ts->touch_data);
> +	kfree(ts);

This was allocated by devm, you can't release with kfree.

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id rm31100_ts_id[] = {
> +	{"RM31100", 0},
> +	{"RM3110x", 1},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, rm31100_ts_id);
> +
> +
> +static struct i2c_driver rm31100_ts_driver = {
> +	.probe = rm31100_ts_probe,
> +	.remove = rm31100_ts_remove,
> +	.id_table = rm31100_ts_id,
> +	.driver = {
> +		.name = "raydium_ts",
> +	},
> +};
> +
> +static int __init rm31100_ts_init(void)
> +{
> +	int rc;
> +
> +	rc = i2c_add_driver(&rm31100_ts_driver);
> +
> +	return rc;
> +}
> +/* Making this as late init to avoid power fluctuations
> + * during LCD initialization.
> + */
> +module_init(rm31100_ts_init);
> +
> +static void __exit rm31100_ts_exit(void)
> +{
> +	i2c_del_driver(&rm31100_ts_driver);
> +}
> +module_exit(rm31100_ts_exit);

module_i2c_driver() please instead of boilerplate above.

> +
> +MODULE_LICENSE("GPL");

"GPL v2"

> +MODULE_DESCRIPTION("rm31100-rm3110x touchscreen controller driver");
> +MODULE_AUTHOR("Raydium");
> +MODULE_ALIAS("platform:rm31100_ts");
> -- 
> 2.1.2
> 

Thanks.

-- 
Dmitry
