From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: touchscreen: Remove duplicate ft6236 driver
Date: Thu, 4 Aug 2016 08:21:55 -0700
Message-ID: <20160804152155.GB5504@dtor-ws>
References: <1470039362-3271-1-git-send-email-hdegoede@redhat.com>
 <1470039362-3271-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1470039362-3271-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLorF2uMehF1BdA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 01, 2016 at 10:16:02AM +0200, Hans de Goede wrote:
> The new(ish) ft6236 simply re-implements the M09 protocol of the
> (much) older edt-ft5x06.c driver.
> 
> This commit removes this duplicate driver and adds the i2c ids and
> dt compatible string to the edt-ft5x06.c driver to keep compatibility.
> 
> Cc: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
> Cc: Noralf Trønnes <noralf-L59+Z2yzLorF2uMehF1BdA@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/Kconfig      |  13 --
>  drivers/input/touchscreen/Makefile     |   1 -
>  drivers/input/touchscreen/edt-ft5x06.c |   8 +
>  drivers/input/touchscreen/ft6236.c     | 326 ---------------------------------
>  4 files changed, 8 insertions(+), 340 deletions(-)
>  delete mode 100644 drivers/input/touchscreen/ft6236.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 64e7501..198945d 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -305,19 +305,6 @@ config TOUCHSCREEN_EGALAX_SERIAL
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called egalax_ts_serial.
>  
> -config TOUCHSCREEN_FT6236
> -	tristate "FT6236 I2C touchscreen"
> -	depends on I2C
> -	depends on GPIOLIB || COMPILE_TEST
> -	help
> -	  Say Y here to enable support for the I2C connected FT6x06 and
> -	  FT6x36 family of capacitive touchscreen drivers.
> -
> -	  If unsure, say N.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ft6236.
> -
>  config TOUCHSCREEN_FUJITSU
>  	tristate "Fujitsu serial touchscreen"
>  	select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index a4b00d0..a144c4e 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -36,7 +36,6 @@ obj-$(CONFIG_TOUCHSCREEN_ELAN)		+= elants_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
>  obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
> -obj-$(CONFIG_TOUCHSCREEN_FT6236)	+= ft6236.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index d19bf45..481d8ba 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1071,9 +1071,15 @@ static const struct edt_i2c_chip_data edt_ft5506_data = {
>  	.max_support_points = 10,
>  };
>  
> +static const struct edt_i2c_chip_data edt_ft6236_data = {
> +	.max_support_points = 2,
> +};
> +
>  static const struct i2c_device_id edt_ft5x06_ts_id[] = {
>  	{ .name = "edt-ft5x06", .driver_data = (long)&edt_ft5x06_data },
>  	{ .name = "edt-ft5506", .driver_data = (long)&edt_ft5506_data },
> +	/* Note no edt- prefix for compatibility with the ft6236.c driver */
> +	{ .name = "ft6236", .driver_data = (long)&edt_ft6236_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
> @@ -1084,6 +1090,8 @@ static const struct of_device_id edt_ft5x06_of_match[] = {
>  	{ .compatible = "edt,edt-ft5306", .data = &edt_ft5x06_data },
>  	{ .compatible = "edt,edt-ft5406", .data = &edt_ft5x06_data },
>  	{ .compatible = "edt,edt-ft5506", .data = &edt_ft5506_data },
> +	/* Note focaltech vendor prefix for compatibility with ft6236.c */
> +	{ .compatible = "focaltech,ft6236", .data = &edt_ft6236_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, edt_ft5x06_of_match);
> diff --git a/drivers/input/touchscreen/ft6236.c b/drivers/input/touchscreen/ft6236.c
> deleted file mode 100644
> index d240d2e..0000000
> --- a/drivers/input/touchscreen/ft6236.c
> +++ /dev/null
> @@ -1,326 +0,0 @@
> -/*
> - * FocalTech FT6236 TouchScreen driver.
> - *
> - * Copyright (c) 2010  Focal tech Ltd.
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/i2c.h>
> -#include <linux/input.h>
> -#include <linux/input/mt.h>
> -#include <linux/interrupt.h>
> -#include <linux/module.h>
> -#include <linux/property.h>
> -
> -#define FT6236_MAX_TOUCH_POINTS		2
> -
> -#define FT6236_REG_TH_GROUP		0x80
> -#define FT6236_REG_PERIODACTIVE		0x88
> -#define FT6236_REG_LIB_VER_H		0xa1
> -#define FT6236_REG_LIB_VER_L		0xa2
> -#define FT6236_REG_CIPHER		0xa3
> -#define FT6236_REG_FIRMID		0xa6
> -#define FT6236_REG_FOCALTECH_ID		0xa8
> -#define FT6236_REG_RELEASE_CODE_ID	0xaf
> -
> -#define FT6236_EVENT_PRESS_DOWN		0
> -#define FT6236_EVENT_LIFT_UP		1
> -#define FT6236_EVENT_CONTACT		2
> -#define FT6236_EVENT_NO_EVENT		3
> -
> -struct ft6236_data {
> -	struct i2c_client *client;
> -	struct input_dev *input;
> -	struct gpio_desc *reset_gpio;
> -	u32 max_x;
> -	u32 max_y;
> -	bool invert_x;
> -	bool invert_y;
> -	bool swap_xy;
> -};
> -
> -/*
> - * This struct is a touchpoint as stored in hardware.  Note that the id,
> - * as well as the event, are stored in the upper nybble of the hi byte.
> - */
> -struct ft6236_touchpoint {
> -	union {
> -		u8 xhi;
> -		u8 event;
> -	};
> -	u8 xlo;
> -	union {
> -		u8 yhi;
> -		u8 id;
> -	};
> -	u8 ylo;
> -	u8 weight;
> -	u8 misc;
> -} __packed;
> -
> -/* This packet represents the register map as read from offset 0 */
> -struct ft6236_packet {
> -	u8 dev_mode;
> -	u8 gest_id;
> -	u8 touches;
> -	struct ft6236_touchpoint points[FT6236_MAX_TOUCH_POINTS];
> -} __packed;
> -
> -static int ft6236_read(struct i2c_client *client, u8 reg, u8 len, void *data)
> -{
> -	int error;
> -
> -	error = i2c_smbus_read_i2c_block_data(client, reg, len, data);
> -	if (error < 0)
> -		return error;
> -
> -	if (error != len)
> -		return -EIO;
> -
> -	return 0;
> -}
> -
> -static irqreturn_t ft6236_interrupt(int irq, void *dev_id)
> -{
> -	struct ft6236_data *ft6236 = dev_id;
> -	struct device *dev = &ft6236->client->dev;
> -	struct input_dev *input = ft6236->input;
> -	struct ft6236_packet buf;
> -	u8 touches;
> -	int i, error;
> -
> -	error = ft6236_read(ft6236->client, 0, sizeof(buf), &buf);
> -	if (error) {
> -		dev_err(dev, "read touchdata failed %d\n", error);
> -		return IRQ_HANDLED;
> -	}
> -
> -	touches = buf.touches & 0xf;
> -	if (touches > FT6236_MAX_TOUCH_POINTS) {
> -		dev_dbg(dev,
> -			"%d touch points reported, only %d are supported\n",
> -			touches, FT6236_MAX_TOUCH_POINTS);
> -		touches = FT6236_MAX_TOUCH_POINTS;
> -	}
> -
> -	for (i = 0; i < touches; i++) {
> -		struct ft6236_touchpoint *point = &buf.points[i];
> -		u16 x = ((point->xhi & 0xf) << 8) | buf.points[i].xlo;
> -		u16 y = ((point->yhi & 0xf) << 8) | buf.points[i].ylo;
> -		u8 event = point->event >> 6;
> -		u8 id = point->id >> 4;
> -		bool act = (event == FT6236_EVENT_PRESS_DOWN ||
> -			    event == FT6236_EVENT_CONTACT);
> -
> -		input_mt_slot(input, id);
> -		input_mt_report_slot_state(input, MT_TOOL_FINGER, act);
> -		if (!act)
> -			continue;
> -
> -		if (ft6236->invert_x)
> -			x = ft6236->max_x - x;
> -
> -		if (ft6236->invert_y)
> -			y = ft6236->max_y - y;
> -
> -		if (ft6236->swap_xy) {
> -			input_report_abs(input, ABS_MT_POSITION_X, y);
> -			input_report_abs(input, ABS_MT_POSITION_Y, x);
> -		} else {
> -			input_report_abs(input, ABS_MT_POSITION_X, x);
> -			input_report_abs(input, ABS_MT_POSITION_Y, y);
> -		}
> -	}
> -
> -	input_mt_sync_frame(input);
> -	input_sync(input);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static u8 ft6236_debug_read_byte(struct ft6236_data *ft6236, u8 reg)
> -{
> -	struct i2c_client *client = ft6236->client;
> -	u8 val = 0;
> -	int error;
> -
> -	error = ft6236_read(client, reg, 1, &val);
> -	if (error)
> -		dev_dbg(&client->dev,
> -			"error reading register 0x%02x: %d\n", reg, error);
> -
> -	return val;
> -}
> -
> -static void ft6236_debug_info(struct ft6236_data *ft6236)
> -{
> -	struct device *dev = &ft6236->client->dev;
> -
> -	dev_dbg(dev, "Touch threshold is %d\n",
> -		ft6236_debug_read_byte(ft6236, FT6236_REG_TH_GROUP) * 4);
> -	dev_dbg(dev, "Report rate is %dHz\n",
> -		ft6236_debug_read_byte(ft6236, FT6236_REG_PERIODACTIVE) * 10);
> -	dev_dbg(dev, "Firmware library version 0x%02x%02x\n",
> -		ft6236_debug_read_byte(ft6236, FT6236_REG_LIB_VER_H),
> -		ft6236_debug_read_byte(ft6236, FT6236_REG_LIB_VER_L));
> -	dev_dbg(dev, "Firmware version 0x%02x\n",
> -		ft6236_debug_read_byte(ft6236, FT6236_REG_FIRMID));
> -	dev_dbg(dev, "Chip vendor ID 0x%02x\n",
> -		ft6236_debug_read_byte(ft6236, FT6236_REG_CIPHER));
> -	dev_dbg(dev, "CTPM vendor ID 0x%02x\n",
> -		ft6236_debug_read_byte(ft6236, FT6236_REG_FOCALTECH_ID));
> -	dev_dbg(dev, "Release code version 0x%02x\n",
> -		ft6236_debug_read_byte(ft6236, FT6236_REG_RELEASE_CODE_ID));
> -}
> -
> -static void ft6236_reset(struct ft6236_data *ft6236)
> -{
> -	if (!ft6236->reset_gpio)
> -		return;
> -
> -	gpiod_set_value_cansleep(ft6236->reset_gpio, 1);
> -	usleep_range(5000, 20000);
> -	gpiod_set_value_cansleep(ft6236->reset_gpio, 0);
> -	msleep(300);
> -}
> -
> -static int ft6236_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> -{
> -	struct device *dev = &client->dev;
> -	struct ft6236_data *ft6236;
> -	struct input_dev *input;
> -	u32 fuzz_x = 0, fuzz_y = 0;
> -	u8 val;
> -	int error;
> -
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> -		return -ENXIO;
> -
> -	if (!client->irq) {
> -		dev_err(dev, "irq is missing\n");
> -		return -EINVAL;
> -	}
> -
> -	ft6236 = devm_kzalloc(dev, sizeof(*ft6236), GFP_KERNEL);
> -	if (!ft6236)
> -		return -ENOMEM;
> -
> -	ft6236->client = client;
> -	ft6236->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> -						     GPIOD_OUT_LOW);
> -	if (IS_ERR(ft6236->reset_gpio)) {
> -		error = PTR_ERR(ft6236->reset_gpio);
> -		if (error != -EPROBE_DEFER)
> -			dev_err(dev, "error getting reset gpio: %d\n", error);
> -		return error;
> -	}
> -
> -	ft6236_reset(ft6236);
> -
> -	/* verify that the controller is present */
> -	error = ft6236_read(client, 0x00, 1, &val);
> -	if (error) {
> -		dev_err(dev, "failed to read from controller: %d\n", error);
> -		return error;
> -	}
> -
> -	ft6236_debug_info(ft6236);
> -
> -	input = devm_input_allocate_device(dev);
> -	if (!input)
> -		return -ENOMEM;
> -
> -	ft6236->input = input;
> -	input->name = client->name;
> -	input->id.bustype = BUS_I2C;
> -
> -	if (device_property_read_u32(dev, "touchscreen-size-x",
> -				     &ft6236->max_x) ||
> -	    device_property_read_u32(dev, "touchscreen-size-y",
> -				     &ft6236->max_y)) {
> -		dev_err(dev, "touchscreen-size-x and/or -y missing\n");
> -		return -EINVAL;
> -	}
> -
> -	device_property_read_u32(dev, "touchscreen-fuzz-x", &fuzz_x);
> -	device_property_read_u32(dev, "touchscreen-fuzz-y", &fuzz_y);
> -	ft6236->invert_x = device_property_read_bool(dev,
> -						     "touchscreen-inverted-x");
> -	ft6236->invert_y = device_property_read_bool(dev,
> -						     "touchscreen-inverted-y");
> -	ft6236->swap_xy = device_property_read_bool(dev,
> -						    "touchscreen-swapped-x-y");
> -
> -	if (ft6236->swap_xy) {
> -		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> -				     ft6236->max_y, fuzz_y, 0);
> -		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> -				     ft6236->max_x, fuzz_x, 0);
> -	} else {
> -		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> -				     ft6236->max_x, fuzz_x, 0);
> -		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> -				     ft6236->max_y, fuzz_y, 0);
> -	}
> -
> -	error = input_mt_init_slots(input, FT6236_MAX_TOUCH_POINTS,
> -				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> -	if (error)
> -		return error;
> -
> -	error = devm_request_threaded_irq(dev, client->irq, NULL,
> -					  ft6236_interrupt, IRQF_ONESHOT,
> -					  client->name, ft6236);
> -	if (error) {
> -		dev_err(dev, "request irq %d failed: %d\n", client->irq, error);
> -		return error;
> -	}
> -
> -	error = input_register_device(input);
> -	if (error) {
> -		dev_err(dev, "failed to register input device: %d\n", error);
> -		return error;
> -	}
> -
> -	return 0;
> -}
> -
> -#ifdef CONFIG_OF
> -static const struct of_device_id ft6236_of_match[] = {
> -	{ .compatible = "focaltech,ft6236", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, ft6236_of_match);
> -#endif
> -
> -static const struct i2c_device_id ft6236_id[] = {
> -	{ "ft6236", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, ft6236_id);
> -
> -static struct i2c_driver ft6236_driver = {
> -	.driver = {
> -		.name = "ft6236",
> -		.of_match_table = of_match_ptr(ft6236_of_match),
> -	},
> -	.probe = ft6236_probe,
> -	.id_table = ft6236_id,
> -};
> -module_i2c_driver(ft6236_driver);
> -
> -MODULE_AUTHOR("Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>");
> -MODULE_AUTHOR("Noralf Trønnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>");
> -MODULE_DESCRIPTION("FocalTech FT6236 TouchScreen driver");
> -MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
