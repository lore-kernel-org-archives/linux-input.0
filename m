From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] input: Add support for ChipOne icn8318
 based touchscreens
Date: Mon, 23 Feb 2015 16:46:11 +0100
Message-ID: <54EB4B43.7000100@redhat.com>
References: <1424705290-19172-1-git-send-email-hdegoede@redhat.com> <1424705290-19172-2-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBAFFVWTQKGQEBR777JY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1424705290-19172-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 23-02-15 16:28, Hans de Goede wrote:
> The ChipOne icn8318 is an i2c capacitive touchscreen controller typically
> used in cheap android tablets, this commit adds a driver for it.
>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

And just when I think I'm done I discover there are spurious evdev events being
send after a close + open of the evdev node. I'll send a v2 of this set fixing this
shortly.

Regards,

Hans


> ---
>   .../bindings/input/touchscreen/chipone_icn8318.txt |  46 +++
>   .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>   MAINTAINERS                                        |   7 +
>   drivers/input/touchscreen/Kconfig                  |  13 +
>   drivers/input/touchscreen/Makefile                 |   1 +
>   drivers/input/touchscreen/chipone_icn8318.c        | 307 +++++++++++++++++++++
>   6 files changed, 375 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
>   create mode 100644 drivers/input/touchscreen/chipone_icn8318.c
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt b/Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
> new file mode 100644
> index 0000000..b405493
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
> @@ -0,0 +1,46 @@
> +* ChipOne icn8318 I2C touchscreen controller
> +
> +Required properties:
> + - compatible		  : "chipone,icn8318"
> + - reg			  : I2C slave address of the chip (0x40)
> + - interrupt-parent	  : a phandle pointing to the interrupt controller
> +			    serving the interrupt for this chip
> + - interrupts		  : interrupt specification for the icn8318 interrupt
> + - wake-gpios		  : GPIO specification for the WAKE input
> + - touchscreen-size-x	  : horizontal resolution of touchscreen (in pixels)
> + - touchscreen-size-y	  : vertical resolution of touchscreen (in pixels)
> +
> +Optional properties:
> + - pinctrl-names	  : should be "default"
> + - pinctrl-0:		  : a phandle pointing to the pin settings for the
> +			    control gpios
> + - touchscreen-fuzz-x	  : horizontal noise value of the absolute input
> +			    device (in pixels)
> + - touchscreen-fuzz-y	  : vertical noise value of the absolute input
> +			    device (in pixels)
> + - touchscreen-inverted-x : X axis is inverted (boolean)
> + - touchscreen-inverted-y : Y axis is inverted (boolean)
> + - touchscreen-swap-x-y	  : X and Y axis are swapped (boolean)
> +			    Swapping is done after inverting the axis
> +
> +Example:
> +
> +i2c@00000000 {
> +	/* ... */
> +
> +	chipone_icn8318@40 {
> +		compatible = "chipone,icn8318";
> +		reg = <0x40>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_wake_pin_p66>;
> +		wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <480>;
> +		touchscreen-inverted-x;
> +		touchscreen-swap-x-y;
> +	};
> +
> +	/* ... */
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index cc8848f..a4cb25e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -35,6 +35,7 @@ capella	Capella Microsystems, Inc
>   cavium	Cavium, Inc.
>   cdns	Cadence Design Systems Inc.
>   chipidea	Chipidea, Inc
> +chipone		ChipOne
>   chipspark	ChipSPARK
>   chrp	Common Hardware Reference Platform
>   chunghwa	Chunghwa Picture Tubes Ltd.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddc5a8c..d39304c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2512,6 +2512,13 @@ L:	linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>   S:	Maintained
>   F:	drivers/usb/chipidea/
>
> +CHIPONE ICN8318 I2C TOUCHSCREEN DRIVER
> +M:	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> +L:	linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
> +F:	drivers/input/touchscreen/chipone_icn8318.c
> +
>   CHROME HARDWARE PLATFORM SUPPORT
>   M:	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
>   S:	Maintained
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 5891752..19ca23e 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -140,6 +140,19 @@ config TOUCHSCREEN_BU21013
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called bu21013_ts.
>
> +config TOUCHSCREEN_CHIPONE_ICN8318
> +	tristate "chipone icn8318 touchscreen controller"
> +	depends on GPIOLIB
> +	depends on I2C
> +	depends on OF
> +	help
> +	  Say Y here if you have a ChipOne icn8318 based I2C touchscreen.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called chipone_icn8318.
> +
>   config TOUCHSCREEN_CY8CTMG110
>   	tristate "cy8ctmg110 touchscreen"
>   	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 0242fea..9517ae4 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
>   obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
>   obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+= auo-pixcir-ts.o
>   obj-$(CONFIG_TOUCHSCREEN_BU21013)	+= bu21013_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_CHIPONE_ICN8318)	+= chipone_icn8318.o
>   obj-$(CONFIG_TOUCHSCREEN_CY8CTMG110)	+= cy8ctmg110_ts.o
>   obj-$(CONFIG_TOUCHSCREEN_CYTTSP_CORE)	+= cyttsp_core.o
>   obj-$(CONFIG_TOUCHSCREEN_CYTTSP_I2C)	+= cyttsp_i2c.o cyttsp_i2c_common.o
> diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
> new file mode 100644
> index 0000000..d47e7dd
> --- /dev/null
> +++ b/drivers/input/touchscreen/chipone_icn8318.c
> @@ -0,0 +1,307 @@
> +/*
> + * Driver for ChipOne icn8318 i2c touchscreen controller
> + *
> + * Copyright (c) 2015 Red Hat Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * Red Hat authors:
> + * Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#define ICN8318_REG_POWER		4
> +#define ICN8318_REG_TOUCHDATA		16
> +
> +#define ICN8318_POWER_ACTIVE		0
> +#define ICN8318_POWER_MONITOR		1
> +#define ICN8318_POWER_HIBERNATE		2
> +
> +#define ICN8318_MAX_TOUCHES		5
> +
> +struct icn8318_touch {
> +	__u8 slot;
> +	__be16 x;
> +	__be16 y;
> +	__u8 pressure;	/* Seems more like finger width then pressure really */
> +	__u8 event;
> +#define ICN8318_EVENT_UPDATE	3
> +#define ICN8318_EVENT_END	4
> +} __packed;
> +
> +struct icn8318_touch_data {
> +	__u8 softbutton;
> +	__u8 touch_count;
> +	struct icn8318_touch touches[ICN8318_MAX_TOUCHES];
> +} __packed;
> +
> +struct icn8318_data {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct gpio_desc *wake_gpio;
> +	u32 max_x;
> +	u32 max_y;
> +	bool invert_x;
> +	bool invert_y;
> +	bool swap_x_y;
> +};
> +
> +static int icn8318_read_touch_data(struct i2c_client *client,
> +				   struct icn8318_touch_data *touch_data)
> +{
> +	u8 reg = ICN8318_REG_TOUCHDATA;
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = client->addr,
> +			.len = 1,
> +			.buf = &reg
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = sizeof(struct icn8318_touch_data),
> +			.buf = (u8 *)touch_data
> +		}
> +	};
> +
> +	return i2c_transfer(client->adapter, msg, 2);
> +}
> +
> +static irqreturn_t icn8318_irq(int irq, void *dev_id)
> +{
> +	struct icn8318_data *data = dev_id;
> +	struct device *dev = &data->client->dev;
> +	struct icn8318_touch_data touch_data;
> +	int i, ret, x, y;
> +
> +	ret = icn8318_read_touch_data(data->client, &touch_data);
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading touch data: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (touch_data.softbutton) {
> +		/*
> +		 * Other data is invalid when a softbutton is pressed.
> +		 * This needs some extra devicetree bindings to map the icn8318
> +		 * softbutton codes to evdev codes. Currently no known devices
> +		 * use this.
> +		 */
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (touch_data.touch_count > ICN8318_MAX_TOUCHES) {
> +		dev_warn(dev, "Too much touches %d > %d\n",
> +			 touch_data.touch_count, ICN8318_MAX_TOUCHES);
> +		touch_data.touch_count = ICN8318_MAX_TOUCHES;
> +	}
> +
> +	for (i = 0; i < touch_data.touch_count; i++) {
> +		struct icn8318_touch *touch = &touch_data.touches[i];
> +
> +		input_mt_slot(data->input, touch->slot);
> +		input_mt_report_slot_state(data->input, MT_TOOL_FINGER,
> +					   touch->event != ICN8318_EVENT_END);
> +		if (touch->event == ICN8318_EVENT_END)
> +			continue;
> +
> +		x = be16_to_cpu(touch->x);
> +		y = be16_to_cpu(touch->y);
> +
> +		if (data->invert_x)
> +			x = data->max_x - x;
> +
> +		if (data->invert_y)
> +			y = data->max_y - y;
> +
> +		if (!data->swap_x_y) {
> +			input_event(data->input, EV_ABS, ABS_MT_POSITION_X, x);
> +			input_event(data->input, EV_ABS, ABS_MT_POSITION_Y, y);
> +		} else {
> +			input_event(data->input, EV_ABS, ABS_MT_POSITION_X, y);
> +			input_event(data->input, EV_ABS, ABS_MT_POSITION_Y, x);
> +		}
> +	}
> +
> +	input_mt_sync_frame(data->input);
> +	input_sync(data->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int icn8318_start(struct input_dev *dev)
> +{
> +	struct icn8318_data *data = input_get_drvdata(dev);
> +
> +	enable_irq(data->client->irq);
> +	gpiod_set_value_cansleep(data->wake_gpio, 1);
> +
> +	return 0;
> +}
> +
> +static void icn8318_stop(struct input_dev *dev)
> +{
> +	struct icn8318_data *data = input_get_drvdata(dev);
> +
> +	disable_irq(data->client->irq);
> +	i2c_smbus_write_byte_data(data->client, ICN8318_REG_POWER,
> +				  ICN8318_POWER_HIBERNATE);
> +	gpiod_set_value_cansleep(data->wake_gpio, 0);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int icn8318_suspend(struct device *dev)
> +{
> +	struct icn8318_data *data = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	mutex_lock(&data->input->mutex);
> +	if (data->input->users)
> +		icn8318_stop(data->input);
> +	mutex_unlock(&data->input->mutex);
> +
> +	return 0;
> +}
> +
> +static int icn8318_resume(struct device *dev)
> +{
> +	struct icn8318_data *data = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	mutex_lock(&data->input->mutex);
> +	if (data->input->users)
> +		icn8318_start(data->input);
> +	mutex_unlock(&data->input->mutex);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(icn8318_pm_ops, icn8318_suspend, icn8318_resume);
> +
> +static int icn8318_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
> +	struct icn8318_data *data;
> +	struct input_dev *input;
> +	u32 fuzz_x = 0, fuzz_y = 0;
> +	int error;
> +
> +	if (!client->irq) {
> +		dev_err(dev, "Error no irq specified\n");
> +		return -EINVAL;
> +	}
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->wake_gpio = devm_gpiod_get(dev, "wake", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->wake_gpio)) {
> +		error = PTR_ERR(data->wake_gpio);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Error getting wake gpio: %d\n", error);
> +		return error;
> +	}
> +
> +	if (of_property_read_u32(np, "touchscreen-size-x", &data->max_x) ||
> +	    of_property_read_u32(np, "touchscreen-size-y", &data->max_y)) {
> +		dev_err(dev, "Error touchscreen-size-x and/or -y missing\n");
> +		return -EINVAL;
> +	}
> +	/* Optional */
> +	of_property_read_u32(np, "touchscreen-fuzz-x", &fuzz_x);
> +	of_property_read_u32(np, "touchscreen-fuzz-y", &fuzz_y);
> +	data->invert_x = of_property_read_bool(np, "touchscreen-inverted-x");
> +	data->invert_y = of_property_read_bool(np, "touchscreen-inverted-y");
> +	data->swap_x_y = of_property_read_bool(np, "touchscreen-swap-x-y");
> +
> +	input = devm_input_allocate_device(dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	input->name = client->name;
> +	input->id.bustype = BUS_I2C;
> +	input->open = icn8318_start;
> +	input->close = icn8318_stop;
> +	input->dev.parent = dev;
> +
> +	if (!data->swap_x_y) {
> +		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> +				     data->max_x, fuzz_x, 0);
> +		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> +				     data->max_y, fuzz_y, 0);
> +	} else {
> +		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> +				     data->max_y, fuzz_y, 0);
> +		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> +				     data->max_x, fuzz_x, 0);
> +	}
> +
> +	error = input_mt_init_slots(input, ICN8318_MAX_TOUCHES,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error)
> +		return error;
> +
> +	data->client = client;
> +	data->input = input;
> +	input_set_drvdata(input, data);
> +
> +	error = devm_request_threaded_irq(dev, client->irq, NULL, icn8318_irq,
> +					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					  client->name, data);
> +	if (error) {
> +		dev_err(dev, "Error requesting irq: %d\n", error);
> +		return error;
> +	}
> +
> +	/* Stop device till opened */
> +	icn8318_stop(data->input);
> +
> +	error = input_register_device(input);
> +	if (error)
> +		return error;
> +
> +	i2c_set_clientdata(client, data);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id icn8318_of_match[] = {
> +	{ .compatible = "chipone,icn8318" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, icn8318_of_match);
> +
> +/* This is useless for OF-enabled devices, but it is needed by I2C subsystem */
> +static const struct i2c_device_id icn8318_i2c_id[] = {
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, icn8318_i2c_id);
> +
> +static struct i2c_driver icn8318_driver = {
> +	.driver = {
> +		.owner	= THIS_MODULE,
> +		.name	= "chipone_icn8318",
> +		.pm	= &icn8318_pm_ops,
> +		.of_match_table = icn8318_of_match,
> +	},
> +	.probe = icn8318_probe,
> +	.id_table = icn8318_i2c_id,
> +};
> +
> +module_i2c_driver(icn8318_driver);
> +
> +MODULE_DESCRIPTION("ChipOne icn8318 I2C Touchscreen Driver");
> +MODULE_AUTHOR("Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>");
> +MODULE_LICENSE("GPL");
>
