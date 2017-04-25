From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] Input: add support for the STMicroelectronics
 FingerTip touchscreen
Date: Tue, 25 Apr 2017 11:31:18 +0900
Message-ID: <20170425023118.4xitk2dzzffftowh@gangnam.samsung>
References: <20170327130743.27783-1-andi.shyti@samsung.com>
 <CGME20170327130756epcas1p321726d525c31814c3f76895b895739cd@epcas1p3.samsung.com>
 <20170327130743.27783-3-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <20170327130743.27783-3-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

again, kindly ping. This patch has been posted on March 27th and
this is the third time I ask you a feedback about it.

Please let me know,
Andi

On Mon, Mar 27, 2017 at 10:07:43PM +0900, Andi Shyti wrote:
> The stmfts (ST-Microelectronics FingerTip S) touchscreen device
> is a capacitive multi-touch controller mainly for mobile use.
> 
> It's connected through i2c bus at the address 0x49 and it
> interfaces with userspace through input event interface.
> 
> At the current state it provides a touchscreen multitouch
> functionality up to 10 fingers. Each finger is enumerated with a
> distinctive id (from 0 to 9).
> 
> If enabled the device can support single "touch" hovering, by
> providing three coordinates, x, y and distance.
> 
> It is possible to select the touchkey functionality which
> provides a basic two keys interface for "home" and "back" menu,
> typical in mobile phones.
> 
> Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/input/touchscreen/Kconfig  |  12 +
>  drivers/input/touchscreen/Makefile |   1 +
>  drivers/input/touchscreen/stmfts.c | 805 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 818 insertions(+)
>  create mode 100644 drivers/input/touchscreen/stmfts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 33c62e5de4fa..f8631c64290d 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1114,6 +1114,18 @@ config TOUCHSCREEN_ST1232
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called st1232_ts.
>  
> +config TOUCHSCREEN_STMFTS
> +	tristate "STMicroelectronics STMFTS touchscreen"
> +	depends on I2C
> +	depends on INPUT
> +	depends on LEDS_CLASS
> +	help
> +	  Say Y here if you want support for STMicroelectronics
> +	  STMFTS touchscreen.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stmfts.
> +
>  config TOUCHSCREEN_STMPE
>  	tristate "STMicroelectronics STMPE touchscreens"
>  	depends on MFD_STMPE
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 18e476948e44..6badce87037b 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SILEAD)	+= silead.o
>  obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)	+= sis_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
> +obj-$(CONFIG_TOUCHSCREEN_STMFTS)	+= stmfts.o
>  obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+= sun4i-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SUR40)		+= sur40.o
> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
> new file mode 100644
> index 000000000000..2e18b1456f42
> --- /dev/null
> +++ b/drivers/input/touchscreen/stmfts.c
> @@ -0,0 +1,805 @@
> +/*
> + * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> + * Author: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * STMicroelectronics FTS Touchscreen device driver
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* I2C commands */
> +#define STMFTS_READ_INFO			0x80
> +#define STMFTS_READ_STATUS			0x84
> +#define STMFTS_READ_ONE_EVENT			0x85
> +#define STMFTS_READ_ALL_EVENT			0x86
> +#define STMFTS_LATEST_EVENT			0x87
> +#define STMFTS_SLEEP_IN				0x90
> +#define STMFTS_SLEEP_OUT			0x91
> +#define STMFTS_MS_MT_SENSE_OFF			0x92
> +#define STMFTS_MS_MT_SENSE_ON			0x93
> +#define STMFTS_SS_HOVER_SENSE_OFF		0x94
> +#define STMFTS_SS_HOVER_SENSE_ON		0x95
> +#define STMFTS_MS_KEY_SENSE_OFF			0x9a
> +#define STMFTS_MS_KEY_SENSE_ON			0x9b
> +#define STMFTS_SYSTEM_RESET			0xa0
> +#define STMFTS_CLEAR_EVENT_STACK		0xa1
> +#define STMFTS_FULL_FORCE_CALIBRATION		0xa2
> +#define STMFTS_MS_CX_TUNING			0xa3
> +#define STMFTS_SS_CX_TUNING			0xa4
> +
> +/* events */
> +#define STMFTS_EV_NO_EVENT			0x00
> +#define STMFTS_EV_MULTI_TOUCH_DETECTED		0x02
> +#define STMFTS_EV_MULTI_TOUCH_ENTER		0x03
> +#define STMFTS_EV_MULTI_TOUCH_LEAVE		0x04
> +#define STMFTS_EV_MULTI_TOUCH_MOTION		0x05
> +#define STMFTS_EV_HOVER_ENTER			0x07
> +#define STMFTS_EV_HOVER_LEAVE			0x08
> +#define STMFTS_EV_HOVER_MOTION			0x09
> +#define STMFTS_EV_KEY_STATUS			0x0e
> +#define STMFTS_EV_ERROR				0x0f
> +#define STMFTS_EV_CONTROLLER_READY		0x10
> +#define STMFTS_EV_SLEEP_OUT_CONTROLLER_READY	0x11
> +#define STMFTS_EV_STATUS			0x16
> +#define STMFTS_EV_DEBUG				0xdb
> +
> +/* multi touch related event masks */
> +#define STMFTS_MASK_EVENT_ID			0x0f
> +#define STMFTS_MASK_TOUCH_ID			0xf0
> +#define STMFTS_MASK_LEFT_EVENT			0x0f
> +#define STMFTS_MASK_X_MSB			0x0f
> +#define STMFTS_MASK_Y_LSB			0xf0
> +
> +/* key related event masks */
> +#define STMFTS_MASK_KEY_NO_TOUCH		0x00
> +#define STMFTS_MASK_KEY_MENU			0x01
> +#define STMFTS_MASK_KEY_BACK			0x02
> +
> +#define STMFTS_EVENT_SIZE	8
> +#define STMFTS_STACK_DEPTH	32
> +#define STMFTS_DATA_MAX_SIZE	(STMFTS_EVENT_SIZE * STMFTS_STACK_DEPTH)
> +#define STMFTS_MAX_FINGERS	10
> +#define STMFTS_DEV_NAME		"stmfts"
> +
> +enum stmfts_regulators {
> +	STMFTS_REGULATOR_VDD,
> +	STMFTS_REGULATOR_AVDD,
> +};
> +
> +struct stmfts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct led_classdev led_cdev;
> +	struct mutex mutex;
> +
> +	struct touchscreen_properties prop;
> +
> +	struct regulator_bulk_data regulators[2];
> +
> +	/* ledvdd will be used also to check
> +	 * whether the LED is supported
> +	 */
> +	struct regulator *ledvdd;
> +
> +	u16 chip_id;
> +	u8 chip_ver;
> +	u16 fw_ver;
> +	u8 config_id;
> +	u8 config_ver;
> +
> +	u8 data[STMFTS_DATA_MAX_SIZE];
> +
> +	struct completion signal;
> +
> +	bool use_key;
> +	bool led_status;
> +	bool hover_enabled;
> +	bool running;
> +};
> +
> +static int stmfts_read_i2c_block_data(struct stmfts_data *sdata)
> +{
> +	struct i2c_msg msgs[2];
> +	u8 cmd = STMFTS_READ_ALL_EVENT;
> +
> +	msgs[0].addr = sdata->client->addr;
> +	msgs[0].flags = 0;
> +	msgs[0].len = 1;
> +	msgs[0].buf = &cmd;
> +
> +	msgs[1].addr = sdata->client->addr;
> +	msgs[1].flags = I2C_M_RD;
> +	msgs[1].len = STMFTS_DATA_MAX_SIZE - STMFTS_EVENT_SIZE;
> +	msgs[1].buf = sdata->data + STMFTS_EVENT_SIZE;
> +
> +	return i2c_transfer(sdata->client->adapter, msgs, ARRAY_SIZE(msgs));
> +}
> +
> +static void stmfts_brightness_set(struct led_classdev *led_cdev,
> +					enum led_brightness value)
> +{
> +	struct stmfts_data *sdata = container_of(led_cdev,
> +					struct stmfts_data, led_cdev);
> +
> +	if (value == sdata->led_status || !sdata->ledvdd)
> +		return;
> +
> +	if (!value) {
> +		regulator_disable(sdata->ledvdd);
> +	} else {
> +		int err = regulator_enable(sdata->ledvdd);
> +
> +		if (err)
> +			dev_warn(&sdata->client->dev,
> +				"failed to disable ledvdd regulator\n");
> +	}
> +
> +	sdata->led_status = value;
> +}
> +
> +static enum led_brightness stmfts_brightness_get(struct led_classdev *led_cdev)
> +{
> +	struct stmfts_data *sdata = container_of(led_cdev,
> +						struct stmfts_data, led_cdev);
> +
> +	return !!regulator_is_enabled(sdata->ledvdd);
> +}
> +
> +static void stmfts_parse_event(struct stmfts_data *sdata)
> +{
> +	u8 id, t_id;
> +	u16 x, y, z, maj, min, orientation, area;
> +	u8 *event;
> +	int i;
> +
> +	for (i = 0; i < STMFTS_STACK_DEPTH; i++) {
> +		event = &sdata->data[i*STMFTS_EVENT_SIZE];
> +
> +		id = event[0] & STMFTS_MASK_EVENT_ID;
> +		t_id = (event[0] & STMFTS_MASK_TOUCH_ID) >> 4;
> +
> +		switch (id) {
> +		case STMFTS_EV_NO_EVENT:
> +			return;
> +
> +		case STMFTS_EV_MULTI_TOUCH_ENTER:
> +		case STMFTS_EV_MULTI_TOUCH_LEAVE:
> +		case STMFTS_EV_MULTI_TOUCH_MOTION:
> +			if (id == STMFTS_EV_MULTI_TOUCH_ENTER)
> +				input_mt_report_slot_state(sdata->input,
> +							MT_TOOL_FINGER, true);
> +			else if (id == STMFTS_EV_MULTI_TOUCH_LEAVE)
> +				input_mt_report_slot_state(sdata->input,
> +							MT_TOOL_FINGER, false);
> +
> +			x = event[1] | ((event[2] & STMFTS_MASK_X_MSB) << 8);
> +			y = (event[2] >> 4) | (event[3] << 4);
> +
> +			maj = event[4];
> +			min = event[5];
> +			orientation = event[6];
> +			area = event[7];
> +
> +			input_mt_slot(sdata->input, t_id);
> +			input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
> +			input_report_abs(sdata->input, ABS_MT_POSITION_Y, y);
> +			input_report_abs(sdata->input, ABS_MT_TOUCH_MAJOR, maj);
> +			input_report_abs(sdata->input, ABS_MT_TOUCH_MINOR, min);
> +			input_report_abs(sdata->input, ABS_MT_PRESSURE, area);
> +			input_report_abs(sdata->input, ABS_MT_ORIENTATION,
> +								orientation);
> +			input_sync(sdata->input);
> +
> +			break;
> +
> +		case STMFTS_EV_HOVER_ENTER:
> +		case STMFTS_EV_HOVER_LEAVE:
> +		case STMFTS_EV_HOVER_MOTION:
> +			x = (event[2] << 4) | (event[4] >> 4);
> +			y = (event[3] << 4) | (event[4] & STMFTS_MASK_Y_LSB);
> +			z = event[5];
> +			orientation = event[6] & STMFTS_MASK_Y_LSB;
> +
> +			input_report_abs(sdata->input, ABS_X, x);
> +			input_report_abs(sdata->input, ABS_Y, y);
> +			input_report_abs(sdata->input, ABS_DISTANCE, z);
> +			input_sync(sdata->input);
> +
> +			break;
> +
> +		case STMFTS_EV_KEY_STATUS:
> +			switch (event[2]) {
> +			case 0:
> +				input_report_key(sdata->input, KEY_BACK, 0);
> +				input_report_key(sdata->input, KEY_MENU, 0);
> +				break;
> +
> +			case STMFTS_MASK_KEY_BACK:
> +				input_report_key(sdata->input, KEY_BACK, 1);
> +				break;
> +
> +			case STMFTS_MASK_KEY_MENU:
> +				input_report_key(sdata->input, KEY_MENU, 1);
> +				break;
> +
> +			default:
> +				dev_warn(&sdata->client->dev,
> +						"unknown key event\n");
> +			}
> +
> +			input_sync(sdata->input);
> +			break;
> +
> +		case STMFTS_EV_ERROR:
> +			dev_warn(&sdata->client->dev,
> +					"error code: 0x%x%x%x%x%x%x",
> +					event[6], event[5], event[4],
> +					event[3], event[2], event[1]);
> +			break;
> +
> +		default:
> +			dev_err(&sdata->client->dev,
> +				"unknown event 0x%x\n", event[0]);
> +		}
> +	}
> +}
> +
> +static irqreturn_t stmfts_irq_handler(int irq, void *dev)
> +{
> +	struct stmfts_data *sdata = dev;
> +	int ret;
> +
> +	mutex_lock(&sdata->mutex);
> +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> +						STMFTS_READ_ONE_EVENT,
> +						STMFTS_EVENT_SIZE, sdata->data);
> +
> +	if (ret < 0 || ret != STMFTS_EVENT_SIZE)
> +		goto exit;
> +
> +	switch (sdata->data[0]) {
> +	case STMFTS_EV_CONTROLLER_READY:
> +	case STMFTS_EV_SLEEP_OUT_CONTROLLER_READY:
> +	case STMFTS_EV_STATUS:
> +		complete(&sdata->signal);
> +	case STMFTS_EV_NO_EVENT:
> +	case STMFTS_EV_DEBUG:
> +		break;
> +
> +	default:
> +		if (unlikely(!sdata->input))
> +			goto exit;
> +
> +		ret = stmfts_read_i2c_block_data(sdata);
> +		if (ret < 0)
> +			goto exit;
> +
> +		stmfts_parse_event(sdata);
> +	}
> +
> +exit:
> +	mutex_unlock(&sdata->mutex);
> +	return IRQ_HANDLED;
> +}
> +
> +static int stmfts_write_and_wait(struct stmfts_data *sdata, const u8 cmd)
> +{
> +	int err;
> +
> +	err = i2c_smbus_write_byte(sdata->client, cmd);
> +	if (err)
> +		return err;
> +
> +	err = wait_for_completion_timeout(&sdata->signal,
> +					msecs_to_jiffies(1000));
> +
> +	return !err ? -ETIMEDOUT : 0;
> +}
> +
> +static int stmfts_input_open(struct input_dev *dev)
> +{
> +	int ret;
> +	struct stmfts_data *sdata = input_get_drvdata(dev);
> +
> +	ret = pm_runtime_get_sync(&sdata->client->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte(sdata->client, STMFTS_MS_MT_SENSE_ON);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&sdata->mutex);
> +	sdata->running = true;
> +
> +	if (sdata->hover_enabled) {
> +		ret = i2c_smbus_write_byte(sdata->client,
> +						STMFTS_SS_HOVER_SENSE_ON);
> +		if (ret)
> +			dev_warn(&sdata->client->dev,
> +						"failed to enable hover\n");
> +	}
> +	mutex_unlock(&sdata->mutex);
> +
> +	if (sdata->use_key) {
> +		ret = i2c_smbus_write_byte(sdata->client,
> +						STMFTS_MS_KEY_SENSE_ON);
> +		if (ret)
> +			/* I can still use only the touch screen */
> +			dev_warn(&sdata->client->dev,
> +						"failed to enable touchkey\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void stmfts_input_close(struct input_dev *dev)
> +{
> +	int ret;
> +	struct stmfts_data *sdata = input_get_drvdata(dev);
> +
> +	ret = i2c_smbus_write_byte(sdata->client, STMFTS_MS_MT_SENSE_OFF);
> +	if (ret)
> +		dev_warn(&sdata->client->dev,
> +					"failed to disable touchscreen\n");
> +
> +	mutex_lock(&sdata->mutex);
> +	sdata->running = false;
> +
> +	if (sdata->hover_enabled) {
> +		ret = i2c_smbus_write_byte(sdata->client,
> +					STMFTS_SS_HOVER_SENSE_OFF);
> +		if (ret)
> +			dev_warn(&sdata->client->dev,
> +						"failed to disable hover\n");
> +	}
> +	mutex_unlock(&sdata->mutex);
> +
> +	if (sdata->use_key) {
> +		i2c_smbus_write_byte(sdata->client, STMFTS_MS_KEY_SENSE_OFF);
> +		if (ret)
> +			dev_warn(&sdata->client->dev,
> +					"failed to disable touchkey\n");
> +	}
> +
> +	pm_runtime_put_sync(&sdata->client->dev);
> +}
> +
> +static ssize_t stmfts_sysfs_chip_id(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "0x%x\n", sdata->chip_id);
> +}
> +
> +static ssize_t stmfts_sysfs_chip_version(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", sdata->chip_ver);
> +}
> +
> +static ssize_t stmfts_sysfs_fw_ver(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", sdata->fw_ver);
> +}
> +
> +static ssize_t stmfts_sysfs_config_id(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "0x%x\n", sdata->config_id);
> +}
> +
> +static ssize_t stmfts_sysfs_config_version(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", sdata->config_ver);
> +}
> +
> +static ssize_t stmfts_sysfs_read_status(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +	u8 status[4];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> +					STMFTS_READ_STATUS, 4, status);
> +
> +	return sprintf(buf, "0x%x\n", status[0]);
> +}
> +
> +static ssize_t stmfts_sysfs_hover_enable_read(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", sdata->hover_enabled);
> +}
> +
> +static ssize_t stmfts_sysfs_hover_enable_write(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	unsigned long value;
> +	int err;
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	if (kstrtoul(buf, 0, &value))
> +		return -EINVAL;
> +
> +	mutex_lock(&sdata->mutex);
> +
> +	if (value & sdata->hover_enabled)
> +		goto out;
> +
> +	if (!sdata->running) {
> +		sdata->hover_enabled = !!value;
> +		goto out;
> +	}
> +
> +	if (value) {
> +		err = i2c_smbus_write_byte(sdata->client,
> +						STMFTS_SS_HOVER_SENSE_ON);
> +		sdata->hover_enabled = !err;
> +	} else {
> +		err = i2c_smbus_write_byte(sdata->client,
> +					STMFTS_SS_HOVER_SENSE_OFF);
> +		sdata->hover_enabled = !!err;
> +	}
> +
> +	if (err)
> +		dev_warn(&sdata->client->dev, "failed to %s hover\n",
> +						value ? "enable" : "disable");
> +out:
> +	mutex_unlock(&sdata->mutex);
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR(chip_id, 0444, stmfts_sysfs_chip_id, NULL);
> +static DEVICE_ATTR(chip_version, 0444, stmfts_sysfs_chip_version, NULL);
> +static DEVICE_ATTR(fw_ver, 0444, stmfts_sysfs_fw_ver, NULL);
> +static DEVICE_ATTR(config_id, 0444, stmfts_sysfs_config_id, NULL);
> +static DEVICE_ATTR(config_version, 0444, stmfts_sysfs_config_version, NULL);
> +static DEVICE_ATTR(status, 0444, stmfts_sysfs_read_status, NULL);
> +static DEVICE_ATTR(hover_enable, 0644, stmfts_sysfs_hover_enable_read,
> +					stmfts_sysfs_hover_enable_write);
> +
> +static struct attribute *stmfts_sysfs_attrs[] = {
> +	&dev_attr_chip_id.attr,
> +	&dev_attr_chip_version.attr,
> +	&dev_attr_fw_ver.attr,
> +	&dev_attr_config_id.attr,
> +	&dev_attr_config_version.attr,
> +	&dev_attr_status.attr,
> +	&dev_attr_hover_enable.attr,
> +	NULL
> +};
> +
> +static struct attribute_group stmfts_attribute_group = {
> +	.attrs = stmfts_sysfs_attrs
> +};
> +
> +static int stmfts_power_on(struct stmfts_data *sdata)
> +{
> +	int err;
> +	u8 reg[8];
> +
> +	err = regulator_bulk_enable(ARRAY_SIZE(sdata->regulators),
> +							sdata->regulators);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * the datasheet does not specify the power on time, but considering
> +	 * that the reset time is < 10ms, I sleep 20ms to be sure
> +	 */
> +	msleep(20);
> +
> +	err = i2c_smbus_read_i2c_block_data(sdata->client,
> +					STMFTS_READ_INFO, 8, reg);
> +	if (err < 0)
> +		return err;
> +	if (err != 8)
> +		return -EIO;
> +
> +	sdata->chip_id = (reg[6] << 8) | reg[7];
> +	sdata->chip_ver = reg[0];
> +	sdata->fw_ver = (reg[2] << 8) | reg[3];
> +	sdata->config_id = reg[4];
> +	sdata->config_ver = reg[5];
> +
> +	reinit_completion(&sdata->signal);
> +
> +	enable_irq(sdata->client->irq);
> +	err = stmfts_write_and_wait(sdata, STMFTS_SYSTEM_RESET);
> +	if (err)
> +		return err;
> +
> +	err = stmfts_write_and_wait(sdata, STMFTS_SLEEP_OUT);
> +	if (err)
> +		return err;
> +
> +	/* optional tuning */
> +	err = stmfts_write_and_wait(sdata, STMFTS_MS_CX_TUNING);
> +	if (err)
> +		dev_warn(&sdata->client->dev, "failed to perform mutual auto tune\n");
> +
> +	/* optional tuning */
> +	err = stmfts_write_and_wait(sdata, STMFTS_SS_CX_TUNING);
> +	if (err)
> +		dev_warn(&sdata->client->dev, "failed to perform self auto tune\n");
> +
> +	err = stmfts_write_and_wait(sdata, STMFTS_FULL_FORCE_CALIBRATION);
> +	if (err)
> +		return err;
> +
> +	/* at this point no one is using the touchscreen
> +	 * and I don't really care about the return value
> +	 */
> +	i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
> +
> +	return 0;
> +}
> +
> +static void stmfts_power_off(void *data)
> +{
> +	struct stmfts_data *sdata = data;
> +
> +	disable_irq(sdata->client->irq);
> +	regulator_bulk_disable(ARRAY_SIZE(sdata->regulators),
> +						sdata->regulators);
> +}
> +
> +/* This function is void because I don't want to prevent using the touch key
> + * only because the LEDs don't get registered
> + */
> +static int stmfts_enable_led(struct stmfts_data *sdata)
> +{
> +	int err;
> +
> +	/* get the regulator for powering the leds on */
> +	sdata->ledvdd = devm_regulator_get(&sdata->client->dev, "ledvdd");
> +	if (IS_ERR(sdata->ledvdd))
> +		return PTR_ERR(sdata->ledvdd);
> +
> +	sdata->led_cdev.name = STMFTS_DEV_NAME;
> +	sdata->led_cdev.max_brightness = LED_ON;
> +	sdata->led_cdev.brightness = LED_OFF;
> +	sdata->led_cdev.brightness_set = stmfts_brightness_set;
> +	sdata->led_cdev.brightness_get = stmfts_brightness_get;
> +
> +	err = devm_led_classdev_register(&sdata->client->dev, &sdata->led_cdev);
> +	if (err) {
> +		devm_regulator_put(sdata->ledvdd);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stmfts_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	int err;
> +	struct stmfts_data *sdata;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +						I2C_FUNC_SMBUS_BYTE_DATA |
> +						I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -ENODEV;
> +
> +	if (!client->dev.of_node)
> +		return -ENOENT;
> +
> +	sdata = devm_kzalloc(&client->dev, sizeof(*sdata), GFP_KERNEL);
> +	if (!sdata)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, sdata);
> +
> +	mutex_init(&sdata->mutex);
> +
> +	sdata->regulators[STMFTS_REGULATOR_VDD].supply = "vdd";
> +	sdata->regulators[STMFTS_REGULATOR_AVDD].supply = "avdd";
> +	err = devm_regulator_bulk_get(&client->dev,
> +			ARRAY_SIZE(sdata->regulators), sdata->regulators);
> +	if (err)
> +		return err;
> +
> +	err = devm_add_action_or_reset(&client->dev, stmfts_power_off, sdata);
> +	if (err)
> +		return err;
> +
> +	sdata->client = client;
> +
> +	init_completion(&sdata->signal);
> +
> +	/*
> +	 * Do not enable interrupts by default.
> +	 * One possible case when an IRQ can be already rased is e.g. if the
> +	 * regulator is set as always on and the stmfts device sends an IRQ as
> +	 * soon as it gets powered, de-synchronizing the power on sequence.
> +	 * During power on, the device will be reset and all the initialization
> +	 * IRQ will be resent.
> +	 */
> +	irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
> +	err = devm_request_threaded_irq(&client->dev, client->irq,
> +					NULL, stmfts_irq_handler,
> +					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +					"stmfts_irq", sdata);
> +	if (err)
> +		return err;
> +
> +	dev_info(&client->dev, "initializing ST-Microelectronics FTS...\n");
> +	err = stmfts_power_on(sdata);
> +	if (err)
> +		return err;
> +
> +	sdata->use_key = of_property_read_bool(client->dev.of_node,
> +						"touch-key-connected");
> +
> +	sdata->input = devm_input_allocate_device(&client->dev);
> +	if (!sdata->input)
> +		return -ENOMEM;
> +
> +	sdata->input->name = STMFTS_DEV_NAME;
> +	sdata->input->id.bustype = BUS_I2C;
> +	sdata->input->open = stmfts_input_open;
> +	sdata->input->close = stmfts_input_close;
> +
> +	touchscreen_parse_properties(sdata->input, true, &sdata->prop);
> +
> +	input_set_abs_params(sdata->input, ABS_MT_POSITION_X, 0,
> +						sdata->prop.max_x, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_MT_POSITION_Y, 0,
> +						sdata->prop.max_y, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_MT_ORIENTATION, 0, 255, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_DISTANCE, 0, 255, 0, 0);
> +
> +	if (sdata->use_key) {
> +		input_set_capability(sdata->input, EV_KEY, KEY_MENU);
> +		input_set_capability(sdata->input, EV_KEY, KEY_BACK);
> +	}
> +
> +	err = input_mt_init_slots(sdata->input,
> +				STMFTS_MAX_FINGERS, INPUT_MT_DIRECT);
> +	if (err)
> +		return err;
> +
> +	input_set_drvdata(sdata->input, sdata);
> +	err = input_register_device(sdata->input);
> +	if (err)
> +		return err;
> +
> +	if (sdata->use_key) {
> +		err = stmfts_enable_led(sdata);
> +		if (err) {
> +			/* even if the LEDs have failed to be initialized and
> +			 * used in the driver, I can still use the device even
> +			 * without LEDs. The ledvdd regulator pointer will be
> +			 * used as a flag.
> +			 */
> +			dev_warn(&client->dev,
> +					"unable to use touchkey leds\n");
> +			sdata->ledvdd = NULL;
> +		}
> +	}
> +
> +	err = sysfs_create_group(&sdata->client->dev.kobj,
> +					&stmfts_attribute_group);
> +	if (err)
> +		return err;
> +
> +	pm_runtime_enable(&client->dev);
> +
> +	return 0;
> +}
> +
> +static int stmfts_remove(struct i2c_client *client)
> +{
> +	pm_runtime_disable(&client->dev);
> +	sysfs_remove_group(&client->dev.kobj, &stmfts_attribute_group);
> +
> +	return 0;
> +}
> +
> +static int stmfts_runtime_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	ret = i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
> +	if (ret)
> +		dev_warn(dev, "failed to suspend device\n");
> +
> +	return ret;
> +}
> +
> +static int stmfts_runtime_resume(struct device *dev)
> +{
> +	int ret;
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	ret = i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_OUT);
> +	if (ret)
> +		dev_err(dev, "failed to resume device\n");
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused stmfts_suspend(struct device *dev)
> +{
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	stmfts_power_off(sdata);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused stmfts_resume(struct device *dev)
> +{
> +	struct stmfts_data *sdata = dev_get_drvdata(dev);
> +
> +	return stmfts_power_on(sdata);
> +}
> +
> +static const struct dev_pm_ops stmfts_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(stmfts_suspend, stmfts_resume)
> +	SET_RUNTIME_PM_OPS(stmfts_runtime_suspend, stmfts_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id stmfts_of_match[] = {
> +	{ .compatible = "st,stmfts", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, stmfts_of_match);
> +
> +static const struct i2c_device_id stmfts_id[] = {
> +	{ "stmfts", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, stmfts_id);
> +
> +static struct i2c_driver stmfts_driver = {
> +	.driver = {
> +		.name = STMFTS_DEV_NAME,
> +		.of_match_table = of_match_ptr(stmfts_of_match),
> +		.pm = &stmfts_pm_ops,
> +	},
> +	.probe = stmfts_probe,
> +	.remove = stmfts_remove,
> +	.id_table = stmfts_id,
> +};
> +
> +module_i2c_driver(stmfts_driver);
> +
> +MODULE_AUTHOR("Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_DESCRIPTION("STMicroelectronics FTS Touch Screen");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.11.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
