From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] input: touchscreen: crtouch_ts: Add driver
Date: Fri, 24 Jun 2016 15:04:27 -0700
Message-ID: <20160624220427.GA11719@dtor-ws>
References: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
 <1466797486-31558-3-git-send-email-tony.felice@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466797486-31558-3-git-send-email-tony.felice-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anthony Felice <tony.felice-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, mwelling-EkmVulN54Sk@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org, maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Anthony,

On Fri, Jun 24, 2016 at 03:44:44PM -0400, Anthony Felice wrote:
> Add driver for the Vybrid Tower CRTouch-based touchscreen. This is
> required for the touchscreen on the TWR-LCD-RGB to work on the Vybrid
> Tower platform.
> 
> There is a known issue with this driver: rarely, SW1 on the TWR-LCD-RGB
> module needs to be pressed in order for the touchscreen to begin
> functioning.

Hmm. Could it be that you want level interrupt and not edge? Or maybe
you want to read state after requesting interrupt?

> 
> Signed-off-by: Anthony Felice <tony.felice-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/crtouch_ts.txt      |  14 ++
>  drivers/input/touchscreen/Kconfig                  |  10 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/crtouch_ts.c             | 279 +++++++++++++++++++++
>  4 files changed, 304 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
>  create mode 100644 drivers/input/touchscreen/crtouch_ts.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> new file mode 100644
> index 0000000..cfb966c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> @@ -0,0 +1,14 @@
> +* Freescale CRTOUCH based touchscreen
> +
> +Required Properties:
> +- compatible must be fsl,crtouch_ts
> +- reg: I2C address of the touchscreen
> +- irq-gpio: GPIO to use as event IRQ
> +
> +Example:
> +
> +	touch: crtouch@49 {
> +		compatible = "fsl,crtouch_ts";
> +		reg = <0x49>;
> +		irq-gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;

You are not using it as gpio but only as interrupt source, so please
set it up as regular interrupt and let I2C core set it up for you so
that you will only need to call request_irq(client->irq, ...)

		interrupts = <&gpio0 21 IRQ_TYPE_EDGE_FALLING>;

> +	};
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 8ecdc38..799e342 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1155,4 +1155,14 @@ config TOUCHSCREEN_ROHM_BU21023
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bu21023_ts.
>  
> +config TOUCHSCREEN_CRTOUCH
> +	tristate "Freescale CRTOUCH based touchscreen"
> +	depends on I2C
> +	help
> +	  Say Y here if you have a CRTOUCH based touchscreen
> +	  controller.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called crtouch_ts.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index f42975e..8cb0a7a 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -95,3 +95,4 @@ obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
> +obj-$(CONFIG_TOUCHSCREEN_CRTOUCH)	+= crtouch_ts.o
> diff --git a/drivers/input/touchscreen/crtouch_ts.c b/drivers/input/touchscreen/crtouch_ts.c
> new file mode 100644
> index 0000000..bb87a8e
> --- /dev/null
> +++ b/drivers/input/touchscreen/crtouch_ts.c
> @@ -0,0 +1,279 @@
> +/*
> + * Driver for Freescale Semiconductor CRTOUCH - A Resistive and Capacitive
> + * touch device with i2c interface
> + *
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/gpio.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +
> +/* Resistive touch sense status registers */
> +#define RES_STA_ERROR			0x00
> +#define RES_STA_STATUS1			0x01
> +#define	RES_STA_STATUS2			0x02
> +#define RES_STA_X_MSB			0x03
> +#define RES_STA_X_LSB			0x04
> +#define RES_STA_Y_MSB			0x05
> +#define RES_STA_Y_LSB			0x06
> +#define RES_STA_PRES_MSB		0x07
> +#define RES_STA_RRES_LSB		0x08
> +#define RES_STA_FIFO_STATUS		0x09
> +#define RES_STA_FIFO_X_MSB		0x0a
> +#define RES_STA_FIFO_X_LSB		0x0b
> +#define RES_STA_FIFO_Y_MSB		0x0c
> +#define RES_STA_FIFO_Y_LSB		0x0d
> +#define RES_STA_FIFO_PRES_MSB		0x0e
> +#define RES_STA_FIFO_PRES_LSB		0x0f
> +#define RES_STA_UART_BRATE_MSB		0x10
> +#define RES_STA_UART_BRATE_MID		0x11
> +#define RES_STA_UART_BRATE_LSB		0x12
> +#define RES_STA_DEV_IDEN		0x13
> +#define RES_STA_SLIDE_DISPLACE		0x14
> +#define RES_STA_ROTATE_ANGLE		0x15
> +
> +/* Resistive touch configuration registers */
> +#define CR_CON_SYSTEM			0x40
> +#define CR_CON_TRIG_EVENT		0x41
> +#define CR_CON_FIFO_SETUP		0x42
> +#define CR_CON_SAMPLING_RATE		0x43
> +#define CR_CON_X_DELAY_MSB		0x44
> +#define CR_CON_X_DELAY_LSB		0x45
> +#define CR_CON_Y_DELAY_MSB		0x46
> +#define CR_CON_Y_DELAY_LSB		0x47
> +#define CR_CON_Z_DELAY_MSB		0x48
> +#define CR_CON_Z_DELAY_LSB		0x49
> +#define CR_CON_DIS_HOR_MSB		0x4a
> +#define CR_CON_DIS_HOR_LSB		0x4b
> +#define CR_CON_DIS_VER_MSB		0x4c
> +#define CR_CON_DIS_VER_LSB		0x4d
> +#define CR_CON_SLIDE_STEPS		0x4e
> +
> +#define RTST_EVENT			BIT(7)
> +#define RTS2T_EVENT			BIT(6)
> +#define RTSZ_EVENT			BIT(5)
> +#define RTSR_EVENT			BIT(4)
> +#define RTSS_EVENT			BIT(3)
> +#define RTSF_EVENT			BIT(2)
> +#define RTSRDY_EVENT			BIT(0)
> +
> +#define RTSSD_MASK			BIT(2)
> +#define RTSSD_H_NEG			BIT(2)
> +#define RTSSD_V_POS			BIT(3)
> +#define RTSSD_V_NEG			BIT(4)
> +
> +#define RTSRD_MASK			BIT(4)
> +#define RTSRD_COUNTER_CLK_WISE		BIT(4)
> +
> +#define RTSZD_MASK			BIT(5)
> +#define RTSZD_ZOOM_OUT			BIT(5)
> +
> +#define CRTOUCH_MAX_FINGER		2
> +#define CRTOUCH_MAX_AREA		0xfff
> +#define CRTOUCH_MAX_X			0x01df
> +#define CRTOUCH_MAX_Y			0x010f
> +
> +struct crtouch_ts_data {
> +	struct i2c_client	*client;
> +	struct input_dev	*input_dev;
> +};
> +
> +static u8 crtouch_read_reg(struct i2c_client *client, int addr)
> +{
> +	return i2c_smbus_read_byte_data(client, addr);
> +}
> +
> +static int crtouch_write_reg(struct i2c_client *client, int addr, int data)
> +{
> +	return i2c_smbus_write_byte_data(client, addr, data);
> +}
> +
> +static void calibration_pointer(u16 *x_orig, u16 *y_orig)
> +{
> +	u16 x, y;
> +
> +	x = CRTOUCH_MAX_X - *x_orig;
> +	*x_orig = x;
> +
> +	y = CRTOUCH_MAX_Y - *y_orig;
> +	*y_orig = y;
> +}
> +
> +static irqreturn_t crtouch_ts_interrupt(int irq, void *dev_id)
> +{
> +	struct crtouch_ts_data *data = dev_id;
> +	struct i2c_client *client = data->client;
> +	u8 status1;
> +	u16 valuep, valuex, valuey;
> +
> +	status1 = crtouch_read_reg(client, RES_STA_STATUS1);
> +
> +	/* For single touch */
> +	if (status1 & RTST_EVENT) {
> +		valuep = crtouch_read_reg(client, RES_STA_PRES_MSB);
> +		valuep = ((valuep << 8) |
> +			crtouch_read_reg(client, RES_STA_RRES_LSB));

Is it possible to read 2 bytes at once?

> +		valuex = crtouch_read_reg(client, RES_STA_X_MSB);
> +		valuex = ((valuex << 8) |
> +			crtouch_read_reg(client, RES_STA_X_LSB));
> +		valuey = crtouch_read_reg(client, RES_STA_Y_MSB);
> +		valuey = ((valuey << 8) |
> +			crtouch_read_reg(client, RES_STA_Y_LSB));
> +		calibration_pointer(&valuex, &valuey);

I'd do conversion inline - it is clearer what is going on.

> +		input_report_key(data->input_dev, BTN_TOUCH, 1);
> +		input_report_abs(data->input_dev, ABS_X, valuex);
> +		input_report_abs(data->input_dev, ABS_Y, valuey);
> +		input_report_abs(data->input_dev, ABS_PRESSURE, valuep);
> +		input_sync(data->input_dev);
> +	} else {
> +		input_report_abs(data->input_dev, ABS_PRESSURE, 0);
> +		input_event(data->input_dev, EV_KEY, BTN_TOUCH, 0);
> +		input_sync(data->input_dev);
> +	}

input_sync() can go here.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void crtouch_ts_reg_init(struct crtouch_ts_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +
> +	crtouch_write_reg(client, CR_CON_SYSTEM, 0x9c);
> +	crtouch_write_reg(client, CR_CON_TRIG_EVENT, 0xf9);
> +	crtouch_write_reg(client, CR_CON_FIFO_SETUP, 0x1f);
> +	crtouch_write_reg(client, CR_CON_SAMPLING_RATE, 0x08);
> +	crtouch_write_reg(client, CR_CON_DIS_HOR_MSB, 0x01);
> +	crtouch_write_reg(client, CR_CON_DIS_HOR_LSB, 0xdf);
> +	crtouch_write_reg(client, CR_CON_DIS_VER_MSB, 0x01);
> +	crtouch_write_reg(client, CR_CON_DIS_VER_LSB, 0x0f);

Should we fetch any of this data from DTS? I assume CR_CON_DIS_HOR/VER
is resolution? Or not?

Also, why no error handling?

> +}
> +
> +static int crtouch_ts_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct crtouch_ts_data *data;
> +	struct input_dev *input_dev;
> +	int error = -1, irq_gpio;
> +
> +	dev_info(&client->dev, "Freescale CRTOUCH driver\n");

Please drop this.

> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	input_dev = input_allocate_device();

Please use devm* and you will be able to get rid of crtouch_ts_remove().

> +	if (!data || !input_dev) {
> +		dev_err(&client->dev, "Failed to allocate memory\n");
> +		error = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	data->client = client;
> +	data->input_dev = input_dev;
> +
> +	input_dev->name = "crtouch_ts";
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = &client->dev;
> +
> +	/* For single touch */
> +	__set_bit(EV_KEY, input_dev->evbit);
> +	__set_bit(BTN_TOUCH, input_dev->keybit);
> +	__set_bit(EV_ABS, input_dev->evbit);
> +	__set_bit(ABS_X, input_dev->absbit);
> +	__set_bit(ABS_Y, input_dev->absbit);
> +	__set_bit(ABS_PRESSURE, input_dev->absbit);
> +
> +	input_set_abs_params(input_dev, ABS_X, 0, CRTOUCH_MAX_X, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, CRTOUCH_MAX_Y, 0, 0);
> +	input_set_abs_params(input_dev, ABS_PRESSURE, 0,
> +			     CRTOUCH_MAX_AREA, 0, 0);
> +
> +	input_set_drvdata(input_dev, data);
> +
> +	crtouch_ts_reg_init(data);
> +
> +	irq_gpio = of_get_named_gpio(client->dev.of_node, "irq-gpio", 0);
> +	if (!gpio_is_valid(irq_gpio))
> +		goto err_free_mem;
> +
> +	error = gpio_request_one(irq_gpio, GPIOF_IN, "TS_IRQ");
> +	if (error) {
> +		dev_err(&client->dev, "Failed to request gpio\n");
> +		goto err_free_mem;
> +	}
> +
> +	error = request_threaded_irq(gpio_to_irq(irq_gpio), NULL,
> +				     crtouch_ts_interrupt,
> +				     IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
> +				     "crtouch_ts", data);

As i mentioned above replace everything starting with of_get_named_gpio
with:

	error = devm_request_threaded_irq(&cleint->dev, client->irq,
					  NULL, crtouch_ts_interrupt,
					  IRQF_ONESHOT,
					  "crtouch_ts", data);

> +
> +	if (error) {
> +		dev_err(&client->dev, "Failed to register interrupt\n");
> +		goto err_free_mem;
> +	}
> +
> +	error = input_register_device(data->input_dev);
> +	if (error)
> +		goto err_free_irq;
> +
> +	i2c_set_clientdata(client, data);
> +	return 0;
> +
> +err_free_irq:
> +	free_irq(client->irq, data);
> +err_free_mem:
> +	input_free_device(input_dev);
> +	kfree(data);
> +	return error;
> +}
> +
> +static int crtouch_ts_remove(struct i2c_client *client)
> +{
> +	struct crtouch_ts_data *data = i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, data);
> +	input_unregister_device(data->input_dev);
> +	kfree(data);

With devm it can all be dropped.

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id crtouch_ts_id[] = {
> +	{"crtouch_ts", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, crtouch_ts_id);
> +
> +static const struct of_device_id crtouch_ts_dt_ids[] = {
> +	{ .compatible = "fsl,crtouch_ts", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, crtouch_ts_dt_ids);
> +
> +static struct i2c_driver crtouch_ts_i2c_driver = {
> +	.driver = {
> +		   .name = "crtouch_ts",
> +		   .owner = THIS_MODULE,

No need to set owner.

> +		   .of_match_table = crtouch_ts_dt_ids,

			.of_match_table = of_match_ptr(crtouch_ts_dt_ids),

Also, no PM methods?

> +		   },
> +	.probe = crtouch_ts_probe,
> +	.remove = crtouch_ts_remove,
> +	.id_table = crtouch_ts_id,
> +};
> +
> +module_i2c_driver(crtouch_ts_i2c_driver);
> +
> +MODULE_AUTHOR("Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>");
> +MODULE_DESCRIPTION("Touchscreen driver for Freescale CRTOUCH");
> +MODULE_LICENSE("GPL");
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
