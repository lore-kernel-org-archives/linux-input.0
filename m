From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] input synaptics-rmi4: Bug fixes to ATTN GPIO handling.
Date: Wed, 18 Dec 2013 06:39:44 -0800
Message-ID: <20131218143944.GG28504@core.coreip.homeip.net>
References: <1387311361-29411-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54639 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab3LROjr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Dec 2013 09:39:47 -0500
Received: by mail-pa0-f46.google.com with SMTP id kl14so5962174pab.5
        for <linux-input@vger.kernel.org>; Wed, 18 Dec 2013 06:39:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387311361-29411-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Chris,

On Tue, Dec 17, 2013 at 12:16:01PM -0800, Christopher Heiny wrote:
> This patch fixes two bugs in handling of the RMI4 attention line GPIO.
> 
> 1) in enable_sensor(), make sure the attn_gpio is defined before attempting to
> get its value.
> 
> 2) in rmi_driver_probe(), declare the name of the attn_gpio, then
> request the attn_gpio before attempting to export it.
> 
> Also introduces a GPIO_LABEL constant for identifying the attention GPIO.
> 

I was looking at the patch some more and I have some concerns with it.

> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
>  drivers/input/rmi4/rmi_driver.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index a30c7d3..33fb8f8 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -169,7 +169,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
>  
>  	data->enabled = true;
>  
> -	if (!pdata->level_triggered &&
> +	if (pdata->attn_gpio && !pdata->level_triggered &&

O is perfectly fine GPIO number, you want to use gpio_is_valid() hete. I
also wonder why do you need such elaborate check. Can we simply "flush"
device before enabling interrupts?

>  		    gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity)
>  		retval = process_interrupt_requests(rmi_dev);
>  
> @@ -807,6 +807,8 @@ static int rmi_driver_remove(struct device *dev)
>  	return 0;
>  }
>  
> +static const char GPIO_LABEL[] = "attn";
> +
>  static int rmi_driver_probe(struct device *dev)
>  {
>  	struct rmi_driver *rmi_driver;
> @@ -959,20 +961,24 @@ static int rmi_driver_probe(struct device *dev)
>  	}
>  
>  	if (IS_ENABLED(CONFIG_RMI4_DEV) && pdata->attn_gpio) {
> -		retval = gpio_export(pdata->attn_gpio, false);
> +		retval = gpio_request(pdata->attn_gpio, GPIO_LABEL);

Here it is too late to request GPIO. You have been converting it to IRQ,
enabling that IRQ and calling gpio_get_value() so GPIO should have
already been requested by now.

So you need to move this code up. You may also consider using
gpio_request_one() and use GPIOF_EXPORT flag if you want to export it.
It would also be nice to set the direction (GPIOF_DIR_IN).

I also do not see matching call to gpio_free() in remove().

>  		if (retval) {
> -			dev_warn(dev, "WARNING: Failed to export ATTN gpio!\n");
> -			retval = 0;
> +			dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code: %d.\n",
> +				pdata->attn_gpio, retval);
>  		} else {
> -			retval = gpio_export_link(dev,
> -						  "attn", pdata->attn_gpio);
> +			retval = gpio_export(pdata->attn_gpio, false);
>  			if (retval) {
> -				dev_warn(dev,
> -					"WARNING: Failed to symlink ATTN gpio!\n");
> -				retval = 0;
> +				dev_warn(dev, "WARNING: Failed to export ATTN gpio %d, code: %d.\n",
> +					pdata->attn_gpio, retval);
>  			} else {
> -				dev_info(dev, "Exported ATTN GPIO %d.",
> -					pdata->attn_gpio);
> +				retval = gpio_export_link(dev, GPIO_LABEL,
> +							  pdata->attn_gpio);
> +				if (retval)
> +					dev_warn(dev,
> +						"WARNING: Failed to symlink ATTN gpio!\n");
> +				else
> +					dev_info(dev, "Exported ATTN GPIO %d.",
> +						pdata->attn_gpio);
>  			}
>  		}
>  	}

Thanks.

-- 
Dmitry
