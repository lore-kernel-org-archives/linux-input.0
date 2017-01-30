From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Mon, 30 Jan 2017 20:57:43 +0100
Message-ID: <8df05aa4-8703-b62c-6262-fe400c99b56a@gmail.com>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36733 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdA3T6k (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Jan 2017 14:58:40 -0500
In-Reply-To: <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>

On 01/30/2017 04:41 PM, Boris Brezillon wrote:
> Rename devm_get_gpiod_from_child() into
> devm_fwnode_get_gpiod_from_child() to reflect the fact that this
> function is operating on a fwnode object.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/gpio/devres.c                     | 11 ++++++-----
>  drivers/input/keyboard/gpio_keys.c        |  3 ++-
>  drivers/input/keyboard/gpio_keys_polled.c |  5 +++--
>  drivers/leds/leds-gpio.c                  |  2 +-
>  drivers/video/fbdev/amba-clcd-nomadik.c   |  8 ++++----
>  include/linux/gpio/consumer.h             |  8 ++++----
>  6 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
> index b760cbbb41d8..dfbbd92d21b6 100644
> --- a/drivers/gpio/devres.c
> +++ b/drivers/gpio/devres.c
> @@ -123,7 +123,8 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
>  EXPORT_SYMBOL(devm_gpiod_get_index);
>  
>  /**
> - * devm_get_gpiod_from_child - get a GPIO descriptor from a device's child node
> + * devm_fwnode_get_gpiod_from_child - get a GPIO descriptor from a device's
> + *				      child node
>   * @dev:	GPIO consumer
>   * @con_id:	function within the GPIO consumer
>   * @child:	firmware node (child of @dev)
> @@ -131,9 +132,9 @@ EXPORT_SYMBOL(devm_gpiod_get_index);
>   * GPIO descriptors returned from this function are automatically disposed on
>   * driver detach.
>   */
> -struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
> -					    const char *con_id,
> -					    struct fwnode_handle *child)
> +struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
> +						   const char *con_id,
> +						   struct fwnode_handle *child)
>  {
>  	static const char * const suffixes[] = { "gpios", "gpio" };
>  	char prop_name[32]; /* 32 is max size of property name */
> @@ -168,7 +169,7 @@ struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
>  
>  	return desc;
>  }
> -EXPORT_SYMBOL(devm_get_gpiod_from_child);
> +EXPORT_SYMBOL(devm_fwnode_get_gpiod_from_child);
>  
>  /**
>   * devm_gpiod_get_index_optional - Resource-managed gpiod_get_index_optional()
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 582462d0af75..ef6813c1f759 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -481,7 +481,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  	spin_lock_init(&bdata->lock);
>  
>  	if (child) {
> -		bdata->gpiod = devm_get_gpiod_from_child(dev, NULL, child);
> +		bdata->gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL,
> +								child);
>  		if (IS_ERR(bdata->gpiod)) {
>  			error = PTR_ERR(bdata->gpiod);
>  			if (error == -ENOENT) {
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> index bed4f2086158..c0c9f2133ecd 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -303,8 +303,9 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>  				return -EINVAL;
>  			}
>  
> -			bdata->gpiod = devm_get_gpiod_from_child(dev, NULL,
> -								 child);
> +			bdata->gpiod = devm_fwnode_get_gpiod_from_child(dev,
> +									NULL,
> +									child);
>  			if (IS_ERR(bdata->gpiod)) {
>  				error = PTR_ERR(bdata->gpiod);
>  				if (error != -EPROBE_DEFER)
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index d400dcaf4d29..c0ef838fc993 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -174,7 +174,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
>  		const char *state = NULL;
>  		struct device_node *np = to_of_node(child);
>  
> -		led.gpiod = devm_get_gpiod_from_child(dev, NULL, child);
> +		led.gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL, child);
>  		if (IS_ERR(led.gpiod)) {
>  			fwnode_handle_put(child);
>  			return ERR_CAST(led.gpiod);

For leds-gpio:

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

> diff --git a/drivers/video/fbdev/amba-clcd-nomadik.c b/drivers/video/fbdev/amba-clcd-nomadik.c
> index 0c06fcaaa6e8..a4c58c650f8c 100644
> --- a/drivers/video/fbdev/amba-clcd-nomadik.c
> +++ b/drivers/video/fbdev/amba-clcd-nomadik.c
> @@ -184,7 +184,7 @@ static void tpg110_init(struct device *dev, struct device_node *np,
>  {
>  	dev_info(dev, "TPG110 display init\n");
>  
> -	grestb = devm_get_gpiod_from_child(dev, "grestb", &np->fwnode);
> +	grestb = devm_fwnode_get_gpiod_from_child(dev, "grestb", &np->fwnode);
>  	if (IS_ERR(grestb)) {
>  		dev_err(dev, "no GRESTB GPIO\n");
>  		return;
> @@ -192,19 +192,19 @@ static void tpg110_init(struct device *dev, struct device_node *np,
>  	/* This asserts the GRESTB signal, putting the display into reset */
>  	gpiod_direction_output(grestb, 1);
>  
> -	scen = devm_get_gpiod_from_child(dev, "scen", &np->fwnode);
> +	scen = devm_fwnode_get_gpiod_from_child(dev, "scen", &np->fwnode);
>  	if (IS_ERR(scen)) {
>  		dev_err(dev, "no SCEN GPIO\n");
>  		return;
>  	}
>  	gpiod_direction_output(scen, 0);
> -	scl = devm_get_gpiod_from_child(dev, "scl", &np->fwnode);
> +	scl = devm_fwnode_get_gpiod_from_child(dev, "scl", &np->fwnode);
>  	if (IS_ERR(scl)) {
>  		dev_err(dev, "no SCL GPIO\n");
>  		return;
>  	}
>  	gpiod_direction_output(scl, 0);
> -	sda = devm_get_gpiod_from_child(dev, "sda", &np->fwnode);
> +	sda = devm_fwnode_get_gpiod_from_child(dev, "sda", &np->fwnode);
>  	if (IS_ERR(sda)) {
>  		dev_err(dev, "no SDA GPIO\n");
>  		return;
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index fb0fde686cb1..2ce4bc164735 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -136,9 +136,9 @@ struct fwnode_handle;
>  
>  struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
>  					 const char *propname);
> -struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
> -					    const char *con_id,
> -					    struct fwnode_handle *child);
> +struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
> +						const char *con_id,
> +						struct fwnode_handle *child);
>  #else /* CONFIG_GPIOLIB */
>  
>  static inline int gpiod_count(struct device *dev, const char *con_id)
> @@ -417,7 +417,7 @@ static inline struct gpio_desc *fwnode_get_named_gpiod(
>  	return ERR_PTR(-ENOSYS);
>  }
>  
> -static inline struct gpio_desc *devm_get_gpiod_from_child(
> +static inline struct gpio_desc *devm_fwnode_get_gpiod_from_child(
>  	struct device *dev, const char *con_id, struct fwnode_handle *child)
>  {
>  	return ERR_PTR(-ENOSYS);
> 

-- 
Best regards,
Jacek Anaszewski
