From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add support for the Samsung S6SY761 touchscreen
Date: Thu, 21 Sep 2017 13:56:07 -0700
Message-ID: <20170921205607.GA15858@dtor-ws>
References: <CGME20170921132940epcas2p35b501f1ccc79d55c0427bb1ed36e10c6@epcas2p3.samsung.com>
 <20170921132950.17452-1-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170921132950.17452-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi Andi,

On Thu, Sep 21, 2017 at 10:29:50PM +0900, Andi Shyti wrote:
> The S6SY761 touchscreen is a capicitive multi-touch controller
> for mobile use. It's connected with i2c at the address 0x48.
> 
> This commit provides a basic version of the driver which can
> handle only initialization, touch events and power states.
> 
> The controller is controlled by a firmware which, in the version
> I currently have, doesn't provide all the possible
> functionalities mentioned in the datasheet.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  .../bindings/input/touchscreen/samsung,s6sy761.txt |  34 ++
>  drivers/input/touchscreen/Kconfig                  |  11 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/s6sy761.c                | 618 +++++++++++++++++++++
>  4 files changed, 664 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
>  create mode 100644 drivers/input/touchscreen/s6sy761.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
> new file mode 100644
> index 000000000000..d9b7c2ff611e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
> @@ -0,0 +1,34 @@
> +* Samsung S6SY761 touchscreen controller
> +
> +Required properties:
> +- compatible		: must be "samsung,s6sy761"
> +- reg			: I2C slave address, (e.g. 0x48)
> +- interrupt-parent	: the phandle to the interrupt controller which provides
> +			  the interrupt
> +- interrupts		: interrupt specification
> +- avdd-supply		: analogic power supply
> +- vdd-supply		: power supply
> +
> +Optional properties:
> +- touchscreen-size-x	: see touchscreen.txt. This property is embedded in the
> +			  device. If defined it forces a different x resolution.
> +- touchscreen-size-y	: see touchscreen.txt. This property is embedded in the
> +			  device. If defined it forces a different y resolution.
> +
> +Example:
> +
> +i2c@00000000 {
> +
> +	/* ... */
> +
> +	touchscreen@48 {
> +		compatible = "samsung,s6sy761";
> +		reg = <0x48>;
> +		interrupt-parent = <&gpa1>;
> +		interrupts = <1 IRQ_TYPE_NONE>;
> +		avdd-supply = <&ldo30_reg>;
> +		vdd-supply = <&ldo31_reg>;
> +		touchscreen-size-x = <4096>;
> +		touchscreen-size-y = <4096>;
> +	};
> +};
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 176b1a74b2b7..c903db4cf7b2 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -383,6 +383,17 @@ config TOUCHSCREEN_S3C2410
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called s3c2410_ts.
>  
> +config TOUCHSCREEN_S6SY761
> +	tristate "Samsung S6SY761 Touchscreen driver"
> +	depends on I2C
> +	help
> +	  Say Y if you have the Samsung S6SY761 driver
> +
> +	  If unsure, say N
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called s6sy761.
> +
>  config TOUCHSCREEN_GUNZE
>  	tristate "Gunze AHL-51S touchscreen"
>  	select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 6badce87037b..4f63439211fd 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
>  obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+= pixcir_i2c_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_RM_TS)		+= raydium_i2c_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_S6SY761)	+= s6sy761.o
>  obj-$(CONFIG_TOUCHSCREEN_SILEAD)	+= silead.o
>  obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)	+= sis_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
> diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
> new file mode 100644
> index 000000000000..9e6e622f8aa3
> --- /dev/null
> +++ b/drivers/input/touchscreen/s6sy761.c
> @@ -0,0 +1,618 @@
> +/*
> + * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> + * Author: Andi Shyti <andi.shyti@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Samsung S6SY761 Touchscreen device driver
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* commands */
> +#define S6SY761_SENSE_ON		0x10
> +#define S6SY761_SENSE_OFF		0x11
> +#define S6SY761_TOUCH_FUNCTION		0x30 /* R/W for get/set */
> +#define S6SY761_FIRMWARE_INTEGRITY	0x21
> +#define S6SY761_PANEL_ID		0x23
> +#define S6SY761_DEVICE_ID		0x52
> +#define S6SY761_BOOT_STATUS		0x55
> +#define S6SY761_READ_ONE_EVENT		0x60
> +#define S6SY761_READ_ALL_EVENT		0x61
> +#define S6SY761_CLEAR_EVENT_STACK	0x62
> +#define S6SY761_APPLICATION_MODE	0xe4
> +#define S6SY761_TS_STATUS		0xaf
> +
> +/* events */
> +#define S6SY761_EVENT_INFO		0x02
> +#define S6SY761_EVENT_VENDOR_INFO	0x07
> +
> +/* info */
> +#define S6SY761_INFO_BOOT_COMPLETE	0x00
> +
> +/* firmware status */
> +#define S6SY761_FW_OK			0x80
> +
> +/*
> + * the functionalities are put as a reference
> + * as in the device I am using none of them
> + * works therefore not used in this driver yet.
> + */
> +/* touchscreen functionalities */
> +#define S6SY761_MASK_TOUCH		BIT(0)
> +#define S6SY761_MASK_HOVER		BIT(1)
> +#define S6SY761_MASK_COVER		BIT(2)
> +#define S6SY761_MASK_GLOVE		BIT(3)
> +#define S6SY761_MASK_STYLUS		BIT(4)
> +#define S6SY761_MASK_PALM		BIT(5)
> +#define S6SY761_MASK_WET		BIT(6)
> +#define S6SY761_MASK_PROXIMITY		BIT(7)
> +
> +/* event id */
> +#define S6SY761_EVENT_ID_COORDINATE	0x00
> +#define S6SY761_EVENT_ID_STATUS		0x01
> +
> +/* event register masks */
> +#define S6SY761_MASK_TOUCH_STATE	0xc0 /* byte 0 */
> +#define S6SY761_MASK_TID		0x3c
> +#define S6SY761_MASK_EID		0x03
> +#define S6SY761_MASK_X			0xf0 /* byte 3 */
> +#define S6SY761_MASK_Y			0x0f
> +#define S6SY761_MASK_Z			0x3f /* byte 6 */
> +#define S6SY761_MASK_LEFT_EVENTS	0x3f /* byte 7 */
> +#define S6SY761_MASK_TOUCH_TYPE		0xc0 /* MSB in byte 6, LSB in byte 7 */
> +
> +/* event touch state values */
> +#define S6SY761_TS_NONE			0x00
> +#define S6SY761_TS_PRESS		0x01
> +#define S6SY761_TS_MOVE			0x02
> +#define S6SY761_TS_RELEASE		0x03
> +
> +/* application modes */
> +#define S6SY761_APP_NORMAL		0x0
> +#define S6SY761_APP_LOW_POWER		0x1
> +#define S6SY761_APP_TEST		0x2
> +#define S6SY761_APP_FLASH		0x3
> +#define S6SY761_APP_SLEEP		0x4
> +
> +#define S6SY761_EVENT_SIZE	8
> +#define S6SY761_EVENT_COUNT	32
> +#define S6SY761_ALL_EVENT	(S6SY761_EVENT_SIZE * S6SY761_EVENT_COUNT)
> +#define S6SY761_DEVID_SIZE	3
> +#define S6SY761_PANEL_ID_SIZE	11
> +#define S6SY761_TS_STATUS_SIZE	5
> +#define S6SY761_MAX_FINGERS	10
> +
> +#define S6SY761_DEV_NAME	"s6sy761"
> +
> +enum s6sy761_regulators {
> +	S6SY761_REGULATOR_VDD,
> +	S6SY761_REGULATOR_AVDD,
> +};
> +
> +struct s6sy761_data {
> +	struct i2c_client *client;
> +	struct regulator_bulk_data regulators[2];
> +	struct input_dev *input;
> +	struct touchscreen_properties prop;
> +	struct mutex mutex;
> +
> +	u8 data[S6SY761_ALL_EVENT];
> +
> +	u16 devid;
> +	s32 prev_pm_state;
> +	u8 tx_channel;
> +};
> +
> +
> +/*
> + * We can't simply use i2c_smbus_read_i2c_block_data because we
> + * need to read more than 255 bytes
> + */
> +static int s6sy761_read_events(struct s6sy761_data *sdata, u16 left_event)
> +{
> +	u8 cmd = S6SY761_READ_ALL_EVENT;
> +	struct i2c_msg msgs[2] = {
> +		{
> +			.addr	= sdata->client->addr,
> +			.len	= 1,
> +			.buf	= &cmd,
> +		},
> +		{
> +			.addr	= sdata->client->addr,
> +			.flags	= I2C_M_RD,
> +			.len	= left_event,
> +			.buf	= sdata->data + S6SY761_EVENT_COUNT,
> +		},
> +	};
> +	int ret;
> +
> +	ret = i2c_transfer(sdata->client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret == ARRAY_SIZE(msgs) ? 0 : -EIO;
> +}
> +
> +static void s6sy761_report_coordinates(struct s6sy761_data *sdata, u8 *event)
> +{
> +	u8 tid = ((event[0] & S6SY761_MASK_TID) >> 2) - 1;

Should we make sure that event[0] & S6SY761_MASK_TID is not 0?

> +	u8 major = event[4];
> +	u8 minor = event[5];
> +	u8 z = event[6] & S6SY761_MASK_Z;
> +	u16 x = (event[1] << 3) | ((event[3] & S6SY761_MASK_X) >> 4);
> +	u16 y = (event[2] << 3) | (event[3] & S6SY761_MASK_Y);
> +
> +	input_mt_slot(sdata->input, tid);
> +
> +	input_mt_report_slot_state(sdata->input, MT_TOOL_FINGER, true);
> +	input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
> +	input_report_abs(sdata->input, ABS_MT_POSITION_Y, y);
> +	input_report_abs(sdata->input, ABS_MT_TOUCH_MAJOR, major);
> +	input_report_abs(sdata->input, ABS_MT_TOUCH_MINOR, minor);
> +	input_report_abs(sdata->input, ABS_MT_PRESSURE, z);
> +
> +	input_sync(sdata->input);
> +}
> +
> +static void s6sy761_report_release(struct s6sy761_data *sdata, u8 *event)
> +{
> +	u8 tid = ((event[0] & S6SY761_MASK_TID) >> 2) - 1;
> +
> +	input_mt_slot(sdata->input, tid);
> +	input_mt_report_slot_state(sdata->input, MT_TOOL_FINGER, false);
> +
> +	input_sync(sdata->input);
> +}
> +
> +static void s6sy761_handle_coordinates(struct s6sy761_data *sdata, u8 *event)
> +{
> +	u8 touch_state = (event[0] & S6SY761_MASK_TOUCH_STATE) >> 6;
> +
> +	switch (touch_state) {
> +
> +	case S6SY761_TS_NONE:
> +		break;
> +	case S6SY761_TS_RELEASE:
> +		s6sy761_report_release(sdata, event);
> +		break;
> +	case S6SY761_TS_PRESS:
> +	case S6SY761_TS_MOVE:
> +		s6sy761_report_coordinates(sdata, event);
> +		break;
> +	}
> +}
> +
> +static void s6sy761_handle_events(struct s6sy761_data *sdata, u8 left_event)
> +{
> +	int i;
> +
> +	for (i = 0; i < left_event; i++) {
> +		u8 *event = &sdata->data[i * S6SY761_EVENT_SIZE];
> +		u8 event_id = event[0] & S6SY761_MASK_EID;
> +
> +		if (!event[0])
> +			return;
> +
> +		switch (event_id) {
> +
> +		case S6SY761_EVENT_ID_COORDINATE:
> +			s6sy761_handle_coordinates(sdata, event);
> +			break;
> +
> +		case S6SY761_EVENT_ID_STATUS:
> +			break;
> +
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static irqreturn_t s6sy761_irq_handler(int irq, void *dev)
> +{
> +	struct s6sy761_data *sdata = dev;
> +	int ret;
> +	u8 left_event;
> +
> +	mutex_lock(&sdata->mutex);
> +	if (unlikely(!sdata->input))
> +		goto out;
> +
> +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> +					    S6SY761_READ_ONE_EVENT,
> +					    S6SY761_EVENT_SIZE,
> +					    sdata->data);
> +	if (ret < 0) {
> +		dev_err(&sdata->client->dev, "failed to read events\n");
> +		goto out;
> +	}
> +
> +	if (!sdata->data[0])
> +		goto out;
> +
> +	left_event = sdata->data[7] & S6SY761_MASK_LEFT_EVENTS;
> +	if (unlikely(left_event > S6SY761_EVENT_COUNT - 1))
> +		goto out;
> +
> +	if (left_event) {
> +		ret = s6sy761_read_events(sdata,
> +					  left_event * S6SY761_EVENT_COUNT);
> +		if (ret < 0) {
> +			dev_err(&sdata->client->dev, "failed to read events\n");
> +			goto out;
> +		}
> +	}
> +
> +	s6sy761_handle_events(sdata, left_event +  1);
> +
> +	i2c_smbus_write_byte(sdata->client, S6SY761_CLEAR_EVENT_STACK);
> +
> +out:
> +	mutex_unlock(&sdata->mutex);
> +	return IRQ_HANDLED;
> +}
> +
> +static int s6sy761_input_open(struct input_dev *dev)
> +{
> +	struct s6sy761_data *sdata = input_get_drvdata(dev);
> +
> +	return i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
> +}
> +
> +static void s6sy761_input_close(struct input_dev *dev)
> +{
> +	struct s6sy761_data *sdata = input_get_drvdata(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_OFF);
> +	if (ret)
> +		dev_err(&sdata->client->dev, "failed to turn off sensing\n");
> +}
> +
> +static ssize_t s6sy761_sysfs_devid(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%#x\n", sdata->devid);
> +}
> +
> +static ssize_t s6sy761_sysfs_low_power_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> +	s32 ret;
> +
> +	ret = i2c_smbus_read_byte_data(sdata->client, S6SY761_APPLICATION_MODE);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n", (ret == S6SY761_APP_LOW_POWER) ? 1 : 0);
> +}
> +
> +static ssize_t s6sy761_sysfs_low_power_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> +	unsigned long value;
> +	s32 ret;
> +	u8 new_status;
> +
> +	if (kstrtoul(buf, 0, &value))
> +		return -EINVAL;
> +
> +	/*
> +	 * The device does not respond to read/write in low power,
> +	 * it will enable only in case of external events (e.g. touch).
> +	 * The i2c read will fail as expected if no external events occur
> +	 */

I am not quite sure how to parse this. Are you saying that the device in
low power mode will wake up when touched? Then your runtime PM
implementation seems incomplete.

In any case, I'd rather we did not expose this state as a custom
attribute.

> +	ret = i2c_smbus_read_byte_data(sdata->client, S6SY761_APPLICATION_MODE);
> +	if (ret < 0)
> +		return len;
> +
> +	if (!value == !(ret == S6SY761_APP_LOW_POWER))
> +		return len;
> +
> +	/*
> +	 * datasheet says that when disabling the low power,
> +	 * the device should move to normal mode
> +	 */
> +	new_status = (value) ? S6SY761_APP_LOW_POWER : S6SY761_APP_NORMAL;
> +
> +	ret = i2c_smbus_write_byte_data(sdata->client,
> +					S6SY761_APPLICATION_MODE,
> +					new_status);
> +	if (ret < 0)
> +		dev_err(dev, "failed to enable low power mode\n");
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR(devid, 0444, s6sy761_sysfs_devid, NULL);
> +static DEVICE_ATTR(low_power, 0644, s6sy761_sysfs_low_power_show,
> +					s6sy761_sysfs_low_power_store);
> +
> +static struct attribute *s6sy761_sysfs_attrs[] = {
> +	&dev_attr_devid.attr,
> +	&dev_attr_low_power.attr,
> +	NULL
> +};
> +
> +static struct attribute_group s6sy761_attribute_group = {
> +	.attrs = s6sy761_sysfs_attrs
> +};
> +
> +static int s6sy761_hw_init(struct s6sy761_data *sdata)
> +{
> +	u8 buffer[S6SY761_PANEL_ID_SIZE]; /* larger read size */
> +	u8 event;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(sdata->regulators),
> +				    sdata->regulators);
> +	if (ret)
> +		return ret;
> +
> +	msleep(140);
> +
> +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> +					    S6SY761_READ_ONE_EVENT,
> +					    S6SY761_EVENT_SIZE,
> +					    buffer);
> +	if (ret < 0)
> +		return ret;
> +
> +	event = (buffer[0] >> 2) & 0xf;
> +
> +	if ((event != S6SY761_EVENT_INFO &&
> +		event != S6SY761_EVENT_VENDOR_INFO) ||
> +		buffer[1] != S6SY761_INFO_BOOT_COMPLETE)
> +		return -ENODEV;
> +
> +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> +					    S6SY761_DEVICE_ID,
> +					    S6SY761_DEVID_SIZE,
> +					    buffer);
> +	if (ret < 0)
> +		return ret;
> +
> +	sdata->devid = buffer[1] << 8 | buffer[2];

	get_unaligned_be16()?

> +
> +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> +					    S6SY761_PANEL_ID,
> +					    S6SY761_PANEL_ID_SIZE,
> +					    buffer);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* the user hasn't specified the touchscreen resolution */
> +	if (!sdata->prop.max_x)
> +		sdata->prop.max_x = buffer[0] << 8 | buffer[1];
> +
> +	if (!sdata->prop.max_y)
> +		sdata->prop.max_y = buffer[2] << 8 | buffer[3];
> +
> +	/* check if both max_x and max_y have a value */
> +	if (unlikely(!sdata->prop.max_x || !sdata->prop.max_y))

This is not in hot path, we do not need unlikely() here.

> +		return -EINVAL;
> +
> +	/* if no tx channels defined, at least keep one */
> +	sdata->tx_channel = !buffer[8] ? 1 : buffer[8];

	sdata->tx_channel = max(buffer[8], 1);

> +
> +	ret = i2c_smbus_read_byte_data(sdata->client,
> +				       S6SY761_FIRMWARE_INTEGRITY);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret != S6SY761_FW_OK)
> +		return -ENODEV;
> +
> +	ret = i2c_smbus_read_byte_data(sdata->client, S6SY761_BOOT_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> +					    S6SY761_TS_STATUS,
> +					    S6SY761_TS_STATUS_SIZE,
> +					    buffer);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_write_word_data(sdata->client,
> +					S6SY761_TOUCH_FUNCTION,
> +					S6SY761_MASK_TOUCH);
> +	if (ret)
> +		return ret;
> +
> +	enable_irq(sdata->client->irq);
> +
> +	return 0;
> +}
> +
> +static void s6sy761_power_off(void *data)
> +{
> +	struct s6sy761_data *sdata = data;
> +
> +	disable_irq(sdata->client->irq);
> +	regulator_bulk_disable(ARRAY_SIZE(sdata->regulators),
> +						sdata->regulators);
> +}
> +
> +static int s6sy761_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct s6sy761_data *sdata;
> +	int err;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +						I2C_FUNC_SMBUS_BYTE_DATA |
> +						I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -ENODEV;
> +
> +	sdata = devm_kzalloc(&client->dev, sizeof(*sdata), GFP_KERNEL);
> +	if (!sdata)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, sdata);
> +	sdata->client = client;
> +	mutex_init(&sdata->mutex);
> +
> +	sdata->regulators[S6SY761_REGULATOR_VDD].supply = "vdd";
> +	sdata->regulators[S6SY761_REGULATOR_AVDD].supply = "avdd";
> +	err = devm_regulator_bulk_get(&client->dev,
> +				      ARRAY_SIZE(sdata->regulators),
> +				      sdata->regulators);
> +	if (err)
> +		return err;
> +
> +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					s6sy761_irq_handler,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					"s6sy761_irq", sdata);
> +	if (err)
> +		return err;
> +
> +	disable_irq(client->irq);

Can you request IRQ after allocating and setting up the input device?
Then you do not need to check for its presence in the interrupt handler.

> +
> +	err = devm_add_action_or_reset(&client->dev, s6sy761_power_off, sdata);
> +	if (err)
> +		return err;
> +
> +	err = s6sy761_hw_init(sdata);
> +	if (err)
> +		return err;
> +
> +	sdata->input = devm_input_allocate_device(&client->dev);
> +	if (!sdata->input)
> +		return -ENOMEM;
> +
> +	sdata->input->name = S6SY761_DEV_NAME;
> +	sdata->input->id.bustype = BUS_I2C;
> +	sdata->input->open = s6sy761_input_open;
> +	sdata->input->close = s6sy761_input_close;
> +
> +	touchscreen_parse_properties(sdata->input, true, &sdata->prop);
> +
> +	input_set_abs_params(sdata->input, ABS_MT_POSITION_X, 0,
> +			     sdata->prop.max_x, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_MT_POSITION_Y, 0,
> +			     sdata->prop.max_y, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
> +	/* the pressure is represented in 6 bits */
> +	input_set_abs_params(sdata->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
> +
> +	err = input_mt_init_slots(sdata->input,
> +				  sdata->tx_channel,
> +				  INPUT_MT_DIRECT);
> +	if (err)
> +		return err;
> +
> +	input_set_drvdata(sdata->input, sdata);
> +
> +	err = input_register_device(sdata->input);
> +	if (err)
> +		return err;
> +
> +	err = sysfs_create_group(&sdata->client->dev.kobj,
> +				 &s6sy761_attribute_group);

We have devm_device_add_groups() now.

> +	if (err)
> +		return err;
> +
> +	pm_runtime_enable(&client->dev);
> +
> +	return 0;
> +}
> +
> +static int s6sy761_remove(struct i2c_client *client)
> +{
> +	pm_runtime_disable(&client->dev);
> +	sysfs_remove_group(&client->dev.kobj, &s6sy761_attribute_group);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused s6sy761_runtime_suspend(struct device *dev)
> +{
> +	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> +
> +	sdata->prev_pm_state = i2c_smbus_read_byte_data(sdata->client,
> +						S6SY761_APPLICATION_MODE);
> +	if (sdata->prev_pm_state < 0)
> +		return sdata->prev_pm_state;
> +
> +	return i2c_smbus_write_byte_data(sdata->client,
> +				S6SY761_APPLICATION_MODE, S6SY761_APP_SLEEP);
> +}
> +
> +static int __maybe_unused s6sy761_runtime_resume(struct device *dev)
> +{
> +	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> +
> +	return i2c_smbus_write_byte_data(sdata->client,
> +				S6SY761_APPLICATION_MODE, sdata->prev_pm_state);
> +}
> +
> +static int __maybe_unused s6sy761_suspend(struct device *dev)
> +{
> +	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> +
> +	s6sy761_power_off(sdata);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused s6sy761_resume(struct device *dev)
> +{
> +	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> +
> +	return s6sy761_hw_init(sdata);
> +}
> +
> +static const struct dev_pm_ops s6sy761_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(s6sy761_suspend, s6sy761_resume)
> +	SET_RUNTIME_PM_OPS(s6sy761_runtime_suspend,
> +				s6sy761_runtime_resume, NULL)
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id s6sy761_of_match[] = {
> +	{ .compatible = "samsung,s6sy761", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, s6sy761_of_match);
> +#endif
> +
> +static const struct i2c_device_id s6sy761_id[] = {
> +	{ "s6sy761", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, stmfts_id);
> +
> +static struct i2c_driver s6sy761_driver = {
> +	.driver = {
> +		.name = S6SY761_DEV_NAME,
> +		.of_match_table = of_match_ptr(s6sy761_of_match),
> +		.pm = &s6sy761_pm_ops,
> +	},
> +	.probe = s6sy761_probe,
> +	.remove = s6sy761_remove,
> +	.id_table = s6sy761_id,
> +};
> +
> +module_i2c_driver(s6sy761_driver);
> +
> +MODULE_AUTHOR("Andi Shyti <andi.shyti@samsung.com>");
> +MODULE_DESCRIPTION("Samsung S6SY761 Touch Screen");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.14.1
> 

Thanks.

-- 
Dmitry
