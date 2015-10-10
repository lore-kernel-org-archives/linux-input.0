From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input:keyboard: add Cypress button driver for Intel
 Platform
Date: Fri, 9 Oct 2015 17:40:48 -0700
Message-ID: <20151010004048.GA14662@dtor-ws>
References: <1444385976-57339-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35504 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbbJJAkw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 20:40:52 -0400
Received: by pabve7 with SMTP id ve7so41847698pab.2
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2015 17:40:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444385976-57339-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-input@vger.kernel.org

Hi Qipeng,

On Fri, Oct 09, 2015 at 06:19:36PM +0800, Qipeng Zha wrote:
> This driver is to support Cypress CY8CMBR3XXX family controller,
> which is used as button input for Intel platforms.

Overall it does not look like pure keyboard device, I'd move into
drivers/input/misc. Are you planning on supporting sliteds, leds, etc?

Also, why only Intel platforms?

> 
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> ---
>  drivers/input/keyboard/Kconfig            |   7 +
>  drivers/input/keyboard/Makefile           |   1 +
>  drivers/input/keyboard/cypress-keyboard.c | 278 ++++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
>  create mode 100644 drivers/input/keyboard/cypress-keyboard.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index a89ba7c..f39f148 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -686,4 +686,11 @@ config KEYBOARD_CAP11XX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cap11xx.
>  
> +config KEYBOARD_CYPRESS_BUTTON
> +	tristate "Cypress Button"

Please be a bit more descriptive.

> +	depends on I2C
> +	help
> +	  Say Y here to enable support for Cypress button for
> +	  Intel platforms.

To compile this dirver as module...

>  endif
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 4707678..5a73138 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_KEYBOARD_TEGRA)		+= tegra-kbc.o
>  obj-$(CONFIG_KEYBOARD_TWL4030)		+= twl4030_keypad.o
>  obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
>  obj-$(CONFIG_KEYBOARD_W90P910)		+= w90p910_keypad.o
> +obj-$(CONFIG_KEYBOARD_CYPRESS_BUTTON)	+= cypress-keyboard.o
> diff --git a/drivers/input/keyboard/cypress-keyboard.c b/drivers/input/keyboard/cypress-keyboard.c
> new file mode 100644
> index 0000000..4a2e7f7
> --- /dev/null
> +++ b/drivers/input/keyboard/cypress-keyboard.c
> @@ -0,0 +1,278 @@
> +/*
> + * Cypress button driver
> + *
> + * Copyright (c) 2015, Intel Corporation.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/acpi.h>
> +
> +/* registers */
> +#define SENSOR_EN	0x0
> +#define		SENSOR_CS0	0
> +#define		SENSOR_CS1	1
> +#define BUTTON_STAT	0xAA
> +#define		BUTTON_ACTIVE	1
> +
> +/* retry I2C transfer in case of autosleep */
> +#define I2C_RETRY_TIMES		10
> +
> +struct cy_kb {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct mutex mutex;
> +	unsigned int irq;
> +	int gpio;
> +	u16 button_status;
> +	bool suspended;
> +};
> +
> +static int cy_kb_read(struct cy_kb *data,
> +		      u16 reg, u16 len, void *buf)
> +{
> +	int ret;
> +	u8 regbuf[1];
> +	struct i2c_msg xfer[2];
> +	int retry = I2C_RETRY_TIMES;
> +
> +	regbuf[0] = reg & 0xff;
> +
> +	xfer[0].addr = data->client->addr;
> +	xfer[0].flags = 0;
> +	xfer[0].len = sizeof(regbuf);
> +	xfer[0].buf = regbuf;
> +
> +	xfer[1].addr = data->client->addr;
> +	xfer[1].flags = I2C_M_RD;
> +	xfer[1].len = len;
> +	xfer[1].buf = buf;
> +
> +retry_read:
> +	ret = i2c_transfer(data->client->adapter, xfer, ARRAY_SIZE(xfer));
> +	if (ret != ARRAY_SIZE(xfer)) {
> +		if (retry--) {
> +			dev_dbg(&data->client->dev, "i2c read retry\n");
> +			goto retry_read;
> +		} else {
> +			dev_err(&data->client->dev, "i2c transfer failed (%d)\n",
> +				ret);
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int cy_kb_write(struct cy_kb *data, u8 reg, u16 val)
> +{
> +	int ret;
> +	u8 *buf;
> +	int count;
> +	int retry = I2C_RETRY_TIMES;
> +
> +	count = sizeof(val) + 1;
> +	buf = kmalloc(count, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf[0] = reg & 0xff;
> +	memcpy(&buf[1], &val, sizeof(val));
> +
> +retry_write:
> +	ret = i2c_master_send(data->client, buf, count);
> +	if (ret != count) {
> +		if (retry--) {
> +			dev_dbg(&data->client->dev, "i2c write retry\n");
> +			goto retry_write;
> +		} else {
> +			dev_err(&data->client->dev, "i2c send failed (%d)\n",
> +				ret);
> +			ret = -EIO;
> +		}
> +	} else {
> +		ret = 0;
> +	}
> +
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static irqreturn_t cy_kb_interrupt(int irq, void *dev_id)
> +{
> +	int ret;
> +	u8 buf = 0x0;
> +	struct cy_kb *data = dev_id;
> +
> +	mutex_lock(&data->mutex);

Why do you need this mutex? What can you be racing with?

> +
> +	ret = cy_kb_read(data, BUTTON_STAT, sizeof(buf), &buf);
> +	if (ret) {
> +		dev_err(&data->client->dev, "can't read button status\n");
> +		goto out;
> +	}
> +	dev_dbg(&data->client->dev, "Button status 0x%02x\n", buf);
> +
> +	if ((buf ^ data->button_status) & (BUTTON_ACTIVE << SENSOR_CS0)) {
> +		input_event(data->input_dev, EV_KEY, KEY_BACK,
> +			(buf >> SENSOR_CS0) & BUTTON_ACTIVE);
> +	}
> +
> +	if ((buf ^ data->button_status) & (BUTTON_ACTIVE << SENSOR_CS1)) {
> +		input_event(data->input_dev, EV_KEY, KEY_MENU,
> +			(buf >> SENSOR_CS1) & BUTTON_ACTIVE);
> +	}
> +
> +	input_sync(data->input_dev);
> +	data->button_status = buf;
> +out:
> +	mutex_unlock(&data->mutex);
> +	return IRQ_HANDLED;
> +}
> +
> +static int cy_kb_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct cy_kb *data;
> +	struct gpio_desc *gpio;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct cy_kb), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->mutex);
> +	data->client = client;
> +	data->irq = client->irq;
> +	gpio = devm_gpiod_get_index(&client->dev, "cypress_gpio_int", 0);
> +	if (!IS_ERR(gpio)) {
> +		data->gpio = desc_to_gpio(gpio);
> +		data->irq = gpiod_to_irq(gpio_to_desc(data->gpio));
> +	} else
> +		dev_err(&client->dev, "Failed to get gpio interrupt\n");

Why do you need gpio if you are not using it as gpio? Platform should
set right irq in client structure.

> +
> +	ret = request_threaded_irq(data->irq, NULL, cy_kb_interrupt,
> +				     IRQF_TRIGGER_LOW | IRQF_ONESHOT,

I'd rather we relied on platform to set up interrupt trigger.

> +				     client->name, data);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to register irq\n");
> +		return ret;
> +	}
> +
> +	data->input_dev = input_allocate_device();

This is too late: IRQ may already arrive before you allocated the
device.

> +	if (!data->input_dev) {
> +		dev_err(&client->dev, "Failed to allocate input device\n");
> +		ret = -ENOMEM;
> +		goto err_alloc_input;
> +	}
> +	data->input_dev->name = client->name;
> +	data->input_dev->id.bustype = BUS_I2C;
> +	data->input_dev->dev.parent = &data->client->dev;
> +	input_set_capability(data->input_dev, EV_KEY, KEY_BACK);
> +	input_set_capability(data->input_dev, EV_KEY, KEY_MENU);

Can we pass the button codes via DT/ACPI properties instead of
hard coding?

> +	ret = input_register_device(data->input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to register input device\n");
> +		goto err_reg_input;
> +	}
> +
> +	return 0;
> +
> +err_reg_input:
> +	input_free_device(data->input_dev);
> +err_alloc_input:
> +	free_irq(data->irq, data);
> +	gpio_free(data->gpio);
> +
> +	return ret;
> +}
> +
> +static int cy_kb_remove(struct i2c_client *client)
> +{
> +	struct cy_kb *data = i2c_get_clientdata(client);
> +
> +	free_irq(data->irq, data);
> +	gpio_free(data->gpio);
> +	input_unregister_device(data->input_dev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cy_kb_suspend(struct device *dev)

Please use __maybe_unused instead of #ifdef.

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct cy_kb *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->mutex);
> +	if (!data->suspended)

How can it be suspended here?

> +		cy_kb_write(data, SENSOR_EN, 0);
> +	data->suspended = true;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static int cy_kb_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct cy_kb *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->mutex);
> +	if (data->suspended) {
> +		u16 val = (1 << SENSOR_CS0) | (1 << SENSOR_CS1);
> +
> +		cy_kb_write(data, SENSOR_EN, val);
> +	}
> +	data->suspended = false;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +static SIMPLE_DEV_PM_OPS(cy_kb_pm_ops, cy_kb_suspend, cy_kb_resume);
> +#endif
> +
> +static const struct i2c_device_id cy_kb_id[] = {
> +	{ "CY8M3108:00", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, cy_kb_id);
> +
> +static struct acpi_device_id cy_kb_acpi_id[] = {
> +	{ "CY8M3108", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, cy_kb_acpi_id);
> +
> +static struct i2c_driver cy_kb_driver = {
> +	.driver = {
> +		.name	= "cypressbutton",
> +		.acpi_match_table = ACPI_PTR(cy_kb_acpi_id),
> +#ifdef CONFIG_PM_SLEEP
> +		.pm = &cy_kb_pm_ops,
> +#endif
> +	},
> +	.probe	= cy_kb_probe,
> +	.remove	= cy_kb_remove,
> +	.id_table = cy_kb_id,
> +};
> +
> +module_i2c_driver(cy_kb_driver);
> +
> +MODULE_AUTHOR("Qipeng Zha<qipeng.zha@intel.com>");
> +MODULE_DESCRIPTION("Cypress CY8CMBRXXX driver");
> +MODULE_LICENSE("GPL v2");

The copyright notice at the beginning of the file mentions GPL v2+ but
MODULE_LICENSE states v2 only, please make consistent.

Thanks.

-- 
Dmitry
