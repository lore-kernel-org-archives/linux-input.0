From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: Re: [PATCH v6 3/9] Input: goodix - reset device at init
Date: Tue, 22 Sep 2015 00:54:02 +0300
Message-ID: <20150922005402.bbde595120baa2fdaddabbd8@gmail.com>
References: <1442327483-19407-1-git-send-email-irina.tirdea@intel.com>
	<1442327483-19407-4-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36350 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbbIUV4b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 17:56:31 -0400
In-Reply-To: <1442327483-19407-4-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Tue, 15 Sep 2015 17:31:17 +0300
Irina Tirdea <irina.tirdea@intel.com> wrote:

> After power on, it is recommended that the driver resets the device.
> The reset procedure timing is described in the datasheet and is used
> at device init (before writing device configuration) and
> for power management. It is a sequence of setting the interrupt
> and reset pins high/low at specific timing intervals. This procedure
> also includes setting the slave address to the one specified in the
> ACPI/device tree.
> 
> This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> driver gt9xx.c for Android (publicly available in Android kernel
> trees for various devices).
> 
> For reset the driver needs to control the interrupt and
> reset gpio pins (configured through ACPI/device tree). For devices
> that do not have the gpio pins declared, the functionality depending
> on these pins will not be available, but the device can still be used
> with basic functionality.
>

I tested this patch on ARM tablet Wexler TAB7200 with GT911 touchscreen 
controller. All works fine.

Tested-by: Aleksei Mamlin <mamlinav@gmail.com>

> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  .../bindings/input/touchscreen/goodix.txt          |   5 +
>  drivers/input/touchscreen/goodix.c                 | 136 +++++++++++++++++++++
>  2 files changed, 141 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index 8ba98ee..c0715f8 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -12,6 +12,8 @@ Required properties:
>   - reg			: I2C address of the chip. Should be 0x5d or 0x14
>   - interrupt-parent	: Interrupt controller to which the chip is connected
>   - interrupts		: Interrupt to which the chip is connected
> + - gpios		: GPIOS the chip is connected to: first one is the
> +			  interrupt gpio and second one the reset gpio.
>  
>  Example:
>  
> @@ -23,6 +25,9 @@ Example:
>  			reg = <0x5d>;
>  			interrupt-parent = <&gpio>;
>  			interrupts = <0 0>;
> +
> +			gpios = <&gpio1 0 0>, /* INT */
> +				<&gpio1 1 0>; /* RST */
>  		};
>  
>  		/* ... */
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 7be6eab..9c58583 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -17,6 +17,7 @@
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> +#include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/input.h>
>  #include <linux/input/mt.h>
> @@ -37,6 +38,8 @@ struct goodix_ts_data {
>  	unsigned int int_trigger_type;
>  	bool rotated_screen;
>  	int cfg_len;
> +	struct gpio_desc *gpiod_int;
> +	struct gpio_desc *gpiod_rst;
>  };
>  
>  #define GOODIX_MAX_HEIGHT		4096
> @@ -89,6 +92,30 @@ static const struct dmi_system_id rotated_screen[] = {
>  	{}
>  };
>  
> +/*
> + * ACPI table specifies gpio pins in this order: first rst pin and
> + * then interrupt pin.
> + */
> +static const struct dmi_system_id goodix_rst_pin_first[] = {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		.ident = "WinBook TW100",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TW100")
> +		}
> +	},
> +	{
> +		.ident = "WinBook TW700",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TW700")
> +		},
> +	},
> +#endif
> +	{}
> +};
> +
>  /**
>   * goodix_i2c_read - read data from a register of the i2c slave device.
>   *
> @@ -237,6 +264,102 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static int goodix_int_sync(struct goodix_ts_data *ts)
> +{
> +	int error;
> +
> +	error = gpiod_direction_output(ts->gpiod_int, 0);
> +	if (error)
> +		return error;
> +	msleep(50);				/* T5: 50ms */
> +
> +	return gpiod_direction_input(ts->gpiod_int);
> +}
> +
> +/**
> + * goodix_reset - Reset device during power on
> + *
> + * @ts: goodix_ts_data pointer
> + */
> +static int goodix_reset(struct goodix_ts_data *ts)
> +{
> +	int error;
> +
> +	/* begin select I2C slave addr */
> +	error = gpiod_direction_output(ts->gpiod_rst, 0);
> +	if (error)
> +		return error;
> +	msleep(20);				/* T2: > 10ms */
> +	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
> +	error = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
> +	if (error)
> +		return error;
> +	usleep_range(100, 2000);		/* T3: > 100us */
> +	error = gpiod_direction_output(ts->gpiod_rst, 1);
> +	if (error)
> +		return error;
> +	usleep_range(6000, 10000);		/* T4: > 5ms */
> +	/* end select I2C slave addr */
> +	error = gpiod_direction_input(ts->gpiod_rst);
> +	if (error)
> +		return error;
> +	return goodix_int_sync(ts);
> +}
> +
> +/**
> + * goodix_get_gpio_config - Get GPIO config from ACPI/DT
> + *
> + * @ts: goodix_ts_data pointer
> + */
> +static int goodix_get_gpio_config(struct goodix_ts_data *ts,
> +				  const struct i2c_device_id *i2c_id)
> +{
> +	int error;
> +	struct device *dev;
> +	struct gpio_desc *gpiod;
> +	/* Default gpio pin order: irq, rst */
> +	int irq_idx = 0, rst_idx = 1;
> +
> +	if (!ts->client)
> +		return -EINVAL;
> +	dev = &ts->client->dev;
> +
> +	if (dmi_check_system(goodix_rst_pin_first)) {
> +		dev_dbg(&ts->client->dev,
> +			"Applying 'reverse gpio pin order' quirk\n");
> +		rst_idx = 0;
> +		irq_idx = 1;
> +	}
> +
> +	/* Get interrupt GPIO pin number */
> +	gpiod = devm_gpiod_get_index(dev, NULL, irq_idx, GPIOD_IN);
> +	if (IS_ERR(gpiod)) {
> +		error = PTR_ERR(gpiod);
> +		if (error != -EPROBE_DEFER)
> +			dev_warn(dev, "Failed to get GPIO %d: %d\n",
> +				 irq_idx, error);
> +		if (error == -ENOENT)
> +			return 0;
> +		return error;
> +	}
> +	ts->gpiod_int = gpiod;
> +
> +	/* Get the reset line GPIO pin number */
> +	gpiod = devm_gpiod_get_index(dev, NULL, rst_idx, GPIOD_IN);
> +	if (IS_ERR(gpiod)) {
> +		error = PTR_ERR(gpiod);
> +		if (error != -EPROBE_DEFER)
> +			dev_warn(dev, "Failed to get GPIO %d: %d\n",
> +				 rst_idx, error);
> +		if (error == -ENOENT)
> +			return 0;
> +		return error;
> +	}
> +	ts->gpiod_rst = gpiod;
> +
> +	return 0;
> +}
> +
>  /**
>   * goodix_read_config - Read the embedded configuration of the panel
>   *
> @@ -405,6 +528,19 @@ static int goodix_ts_probe(struct i2c_client *client,
>  	ts->client = client;
>  	i2c_set_clientdata(client, ts);
>  
> +	error = goodix_get_gpio_config(ts, id);
> +	if (error)
> +		return error;
> +
> +	if (ts->gpiod_int && ts->gpiod_rst) {
> +		/* reset the controller */
> +		error = goodix_reset(ts);
> +		if (error) {
> +			dev_err(&client->dev, "Controller reset failed.\n");
> +			return error;
> +		}
> +	}
> +
>  	error = goodix_i2c_test(client);
>  	if (error) {
>  		dev_err(&client->dev, "I2C communication failure: %d\n", error);
> -- 
> 1.9.1
> 


-- 
Thanks and regards,
Aleksei Mamlin
