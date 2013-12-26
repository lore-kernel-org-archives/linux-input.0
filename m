From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] input synaptics-rmi4: Bug fixes to ATTN GPIO handling.
Date: Thu, 26 Dec 2013 14:37:18 -0800
Message-ID: <20131226223718.GC18562@core.coreip.homeip.net>
References: <1387853059-19099-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34329 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab3LZWhV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Dec 2013 17:37:21 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so8441027pdj.29
        for <linux-input@vger.kernel.org>; Thu, 26 Dec 2013 14:37:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387853059-19099-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Chris,

On Mon, Dec 23, 2013 at 06:44:19PM -0800, Christopher Heiny wrote:
> This patch fixes some bugs in handling of the RMI4 attention line GPIO.
> 
> 1) in enable_sensor(), eliminate the complicated check on ATTN and just 
> call process_interrupt_requests().  This will have minimal overhead if ATTN
> is not asserted, and clears the state of the RMI4 device in any case.
> 
> 2) Correctly free the GPIO in rmi_driver_remove().
> 
> 3) in rmi_driver_probe()
>     - declare the name of the attention gpio (GPIO_LABEL)
>     - use gpio_request_one() to get the gpio and export it.
>     - simplify conditional gpio acquisition logic and combine with interrupt
>       setup
> 
> 4) use gpio_is_valid() instead of comparing to 0.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
>  drivers/input/rmi4/rmi_driver.c | 43 ++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index a30c7d3..9b02358 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -140,7 +140,6 @@ static int enable_sensor(struct rmi_device *rmi_dev)
>  	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>  	struct rmi_phys_device *rmi_phys;
>  	int retval = 0;
> -	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
>  
>  	if (data->enabled)
>  		return 0;
> @@ -169,11 +168,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
>  
>  	data->enabled = true;
>  
> -	if (!pdata->level_triggered &&
> -		    gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity)
> -		retval = process_interrupt_requests(rmi_dev);
> -
> -	return retval;
> +	return process_interrupt_requests(rmi_dev);
>  }
>  
>  static void rmi_free_function_list(struct rmi_device *rmi_dev)
> @@ -800,13 +795,20 @@ static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend, rmi_driver_resume);
>  static int rmi_driver_remove(struct device *dev)
>  {
>  	struct rmi_device *rmi_dev = to_rmi_device(dev);
> +	const struct rmi_device_platform_data *pdata =
> +					to_rmi_platform_data(rmi_dev);
>  
>  	disable_sensor(rmi_dev);
>  	rmi_free_function_list(rmi_dev);
>  
> +	if (gpio_is_valid(pdata->attn_gpio))
> +		gpio_free(pdata->attn_gpio);

It looks like you let driver registration to continue even if GPIO
request fails. You probably need to introduce a flag indicating whether
you successfully requested gpio or not. Or you can treat failure to
acquire gpio as fatal.

> +
>  	return 0;
>  }
>  
> +static const char GPIO_LABEL[] = "attn";
> +
>  static int rmi_driver_probe(struct device *dev)
>  {
>  	struct rmi_driver *rmi_driver;
> @@ -937,7 +939,7 @@ static int rmi_driver_probe(struct device *dev)
>  		mutex_init(&data->suspend_mutex);
>  	}
>  
> -	if (pdata->attn_gpio) {
> +	if (gpio_is_valid(pdata->attn_gpio)) {
>  		data->irq = gpio_to_irq(pdata->attn_gpio);
>  		if (pdata->level_triggered) {
>  			data->irq_flags = IRQF_ONESHOT |
> @@ -948,24 +950,17 @@ static int rmi_driver_probe(struct device *dev)
>  				(pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
>  				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>  		}
> -	} else
> -		data->poll_interval = ktime_set(0,
> -			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
> -			DEFAULT_POLL_INTERVAL_MS) * 1000 * 1000);
> -
> -	if (data->f01_container->dev.driver) {
> -		/* Driver already bound, so enable ATTN now. */
> -		enable_sensor(rmi_dev);
> -	}
>  
> -	if (IS_ENABLED(CONFIG_RMI4_DEV) && pdata->attn_gpio) {

Do you really need to export gpio if you do not have RMI4_DEV option?

> -		retval = gpio_export(pdata->attn_gpio, false);
> +		retval = gpio_request_one(pdata->attn_gpio,
> +					  GPIOF_EXPORT | GPIOF_DIR_IN,
> +					  GPIO_LABEL);
>  		if (retval) {
> -			dev_warn(dev, "WARNING: Failed to export ATTN gpio!\n");
> +			dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code=%d.\n",
> +				 pdata->attn_gpio, retval);
>  			retval = 0;
>  		} else {
>  			retval = gpio_export_link(dev,
> -						  "attn", pdata->attn_gpio);
> +						  GPIO_LABEL, pdata->attn_gpio);
>  			if (retval) {
>  				dev_warn(dev,
>  					"WARNING: Failed to symlink ATTN gpio!\n");
> @@ -975,6 +970,14 @@ static int rmi_driver_probe(struct device *dev)
>  					pdata->attn_gpio);
>  			}
>  		}
> +	} else
> +		data->poll_interval = ktime_set(0,
> +			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
> +			DEFAULT_POLL_INTERVAL_MS) * 1000 * 1000);
> +
> +	if (data->f01_container->dev.driver) {
> +		/* Driver already bound, so enable ATTN now. */
> +		enable_sensor(rmi_dev);
>  	}
>  
>  	return 0;

Thanks.

-- 
Dmitry
