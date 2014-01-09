From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics-rmi4 - cleanup rmi_i2c_probe()
Date: Thu, 9 Jan 2014 00:06:07 -0800
Message-ID: <20140109080607.GB27160@core.coreip.homeip.net>
References: <1389219092-32042-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:54293 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbaAIIGL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 03:06:11 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so2986318pad.31
        for <linux-input@vger.kernel.org>; Thu, 09 Jan 2014 00:06:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389219092-32042-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Wed, Jan 08, 2014 at 02:11:32PM -0800, Christopher Heiny wrote:
> Moves i2c_check_functionality to occur before the gpio_config() call.  This 
> can catch some issues that would otherwise result in mysterious problems
> in gpio_config().
> 
> Reduces debugging output; updates remaining output to be more accurate.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
> 
>  drivers/input/rmi4/rmi_i2c.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index 43b0e53..b4bd8ae 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
> @@ -274,26 +274,24 @@ static int rmi_i2c_probe(struct i2c_client *client,
>  		dev_err(&client->dev, "no platform data\n");
>  		return -EINVAL;
>  	}
> -	dev_info(&client->dev, "Probing %s at %#02x (IRQ %d).\n",
> +	dev_dbg(&client->dev, "Probing %s at %#02x (GPIO %d).\n",
>  		pdata->sensor_name ? pdata->sensor_name : "-no name-",
>  		client->addr, pdata->attn_gpio);
>  
> +	retval = i2c_check_functionality(client->adapter, I2C_FUNC_I2C);
> +	if (!retval) {
> +		dev_err(&client->dev, "i2c_check_functionality error %d.\n",
> +			retval);
> +		return retval;
> +	}
> +
>  	if (pdata->gpio_config) {
> -		dev_dbg(&client->dev, "Configuring GPIOs.\n");
>  		retval = pdata->gpio_config(pdata->gpio_data, true);
>  		if (retval < 0) {
>  			dev_err(&client->dev, "Failed to configure GPIOs, code: %d.\n",
>  				retval);
>  			return retval;
>  		}
> -		dev_info(&client->dev, "Done with GPIO configuration.\n");
> -	}
> -
> -	retval = i2c_check_functionality(client->adapter, I2C_FUNC_I2C);
> -	if (!retval) {
> -		dev_err(&client->dev, "i2c_check_functionality error %d.\n",
> -			retval);
> -		return retval;
>  	}
>  
>  	xport = devm_kzalloc(&client->dev, sizeof(struct rmi_transport_dev),

-- 
Dmitry
