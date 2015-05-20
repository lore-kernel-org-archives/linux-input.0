From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ads7846: do not ignore pendown-gpio flags
Date: Wed, 20 May 2015 09:56:47 -0700
Message-ID: <20150520165647.GD23809@dtor-ws>
References: <20150520072620.GA8930@fifteen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33305 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbbETQ4w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 12:56:52 -0400
Content-Disposition: inline
In-Reply-To: <20150520072620.GA8930@fifteen>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: Daniel Mack <zonque@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Evgeniy,

On Wed, May 20, 2015 at 10:26:20AM +0300, Evgeniy Dushistov wrote:
> At current state ads7846 driver ignore GPIO_ACTIVE_LOW,
> GPIO_ACTIVE_HIGH flags in such dts expression:
> pendown-gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
> 
> In times of usage arch/arm/.. you can handle this
> by get_pendown_state callback passed via platform_data,
> but at now with Device Tree it is impossible to handle
> 1 as interrupt trigger, this patch fixes this.
> 
> Test on beagleboard-xm<-SPI->ads7845
> 
> It made on top of "ads7846: fix ads7846 driver for work with ads7845",
> but can applied with "hunks" on top of Linus's master,
> and it independent of "ads7846: fix ads7846 driver for work with
> ads7845".
> 
> Signed-off-by: Evgeniy A. Dushistov <dushistov@mail.ru>

Can we switch the driver to use gpiod instead? Then the active high/low
condition would be handled automatically.

> ---
>  drivers/input/touchscreen/ads7846.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 76728d4..0a02364 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -140,6 +140,7 @@ struct ads7846 {
>  	void			(*filter_cleanup)(void *data);
>  	int			(*get_pendown_state)(void);
>  	int			gpio_pendown;
> +	bool		        active_low;
>  
>  	void			(*wait_for_sync)(void);
>  };
> @@ -574,7 +575,7 @@ static int get_pendown_state(struct ads7846 *ts)
>  	if (ts->get_pendown_state)
>  		return ts->get_pendown_state();
>  
> -	return !gpio_get_value(ts->gpio_pendown);
> +	return ts->active_low != (!!gpio_get_value(ts->gpio_pendown));
>  }
>  
>  static void null_wait_for_sync(void)
> @@ -1108,11 +1109,13 @@ static const struct of_device_id ads7846_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ads7846_dt_ids);
>  
> -static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
> +static const struct ads7846_platform_data *
> +ads7846_probe_dt(struct device *dev, bool *pen_active_low)
>  {
>  	struct ads7846_platform_data *pdata;
>  	struct device_node *node = dev->of_node;
>  	const struct of_device_id *match;
> +	enum of_gpio_flags gpio_flags;
>  
>  	if (!node) {
>  		dev_err(dev, "Device does not have associated DT data\n");
> @@ -1163,12 +1166,16 @@ static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
>  
>  	pdata->wakeup = of_property_read_bool(node, "linux,wakeup");
>  
> -	pdata->gpio_pendown = of_get_named_gpio(dev->of_node, "pendown-gpio", 0);
> +	pdata->gpio_pendown = of_get_named_gpio_flags(dev->of_node,
> +						      "pendown-gpio",
> +						      0, &gpio_flags);
> +	*pen_active_low = !!(gpio_flags & OF_GPIO_ACTIVE_LOW);
>  
>  	return pdata;
>  }
>  #else
> -static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
> +static const struct ads7846_platform_data *ads7846_probe_dt(
> +	struct device *dev, bool *pen_active_low)
>  {
>  	dev_err(dev, "no platform data defined\n");
>  	return ERR_PTR(-EINVAL);
> @@ -1183,6 +1190,7 @@ static int ads7846_probe(struct spi_device *spi)
>  	struct input_dev *input_dev;
>  	unsigned long irq_flags;
>  	int err;
> +	bool pen_active_low = true;
>  
>  	if (!spi->irq) {
>  		dev_dbg(&spi->dev, "no IRQ?\n");
> @@ -1226,7 +1234,7 @@ static int ads7846_probe(struct spi_device *spi)
>  
>  	pdata = dev_get_platdata(&spi->dev);
>  	if (!pdata) {
> -		pdata = ads7846_probe_dt(&spi->dev);
> +		pdata = ads7846_probe_dt(&spi->dev, &pen_active_low);
>  		if (IS_ERR(pdata)) {
>  			err = PTR_ERR(pdata);
>  			goto err_free_mem;
> @@ -1240,6 +1248,7 @@ static int ads7846_probe(struct spi_device *spi)
>  
>  	ts->vref_mv = pdata->vref_mv;
>  	ts->swap_xy = pdata->swap_xy;
> +	ts->active_low = pen_active_low;
>  
>  	if (pdata->filter != NULL) {
>  		if (pdata->filter_init != NULL) {
> -- 
> 2.3.6
> 
> -- 
> /Evgeniy

-- 
Dmitry
