From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: silead - Add support for ACPI bus power methods
Date: Sat, 21 Jan 2017 09:33:54 -0800
Message-ID: <20170121173354.GA36944@dtor-ws>
References: <20170101213004.31050-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34369 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdAURd7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 12:33:59 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so7415906pfb.1
        for <linux-input@vger.kernel.org>; Sat, 21 Jan 2017 09:33:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170101213004.31050-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

Hi Hans,

On Sun, Jan 01, 2017 at 10:30:04PM +0100, Hans de Goede wrote:
> On some x86 tablets we cannot directly access the GPIOs as they are
> claimed by the ACPI tables, so first try using acpi_bus_set_power
> and if that works use that instead of directly accessing the GPIO.

This does not belong to individual drivers but either to various buses
(spi, i2c, etc), or to the ACPI power domain code.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/touchscreen/silead.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index f502c84..d3dd9bb 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -30,6 +30,7 @@
>  #include <linux/pm.h>
>  #include <linux/irq.h>
>  
> +#include <acpi/acpi_bus.h>
>  #include <asm/unaligned.h>
>  
>  #define SILEAD_TS_NAME		"silead_ts"
> @@ -71,6 +72,7 @@ enum silead_ts_power {
>  
>  struct silead_ts_data {
>  	struct i2c_client *client;
> +	bool acpi_power;
>  	struct gpio_desc *gpio_power;
>  	struct input_dev *input;
>  	char fw_name[64];
> @@ -125,7 +127,14 @@ static void silead_ts_set_power(struct i2c_client *client,
>  {
>  	struct silead_ts_data *data = i2c_get_clientdata(client);
>  
> -	if (data->gpio_power) {
> +	if (data->acpi_power) {
> +#ifdef CONFIG_ACPI
> +		int ret = acpi_bus_set_power(ACPI_HANDLE(&client->dev),
> +					state ? ACPI_STATE_D0 : ACPI_STATE_D3);
> +		if (ret)
> +			dev_err(&client->dev, "Power error %d\n", ret);
> +#endif
> +	} else if (data->gpio_power) {
>  		gpiod_set_value_cansleep(data->gpio_power, state);
>  		msleep(SILEAD_POWER_SLEEP);
>  	}
> @@ -465,12 +474,21 @@ static int silead_ts_probe(struct i2c_client *client,
>  	if (client->irq <= 0)
>  		return -ENODEV;
>  
> -	/* Power GPIO pin */
> -	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> -	if (IS_ERR(data->gpio_power)) {
> -		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
> -			dev_err(dev, "Shutdown GPIO request failed\n");
> -		return PTR_ERR(data->gpio_power);
> +	/* Power handling, try ACPI companion method first then GPIO */
> +#ifdef CONFIG_ACPI
> +	if (ACPI_COMPANION(&client->dev) &&
> +	    acpi_bus_set_power(ACPI_HANDLE(&client->dev), ACPI_STATE_D3) == 0)
> +		data->acpi_power = true;
> +	else
> +#endif
> +	{
> +		data->gpio_power = devm_gpiod_get_optional(dev, "power",
> +							   GPIOD_OUT_LOW);
> +		if (IS_ERR(data->gpio_power)) {
> +			if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
> +				dev_err(dev, "Power GPIO request failed\n");
> +			return PTR_ERR(data->gpio_power);
> +		}
>  	}
>  
>  	error = silead_ts_setup(client);
> -- 
> 2.9.3
> 

Thanks.

-- 
Dmitry
