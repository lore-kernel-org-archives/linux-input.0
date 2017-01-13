From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/1] of: Pass GPIO label down to gpiod_request when
 using get_gpiod_from_child
Date: Fri, 13 Jan 2017 12:01:38 +0100
Message-ID: <11509256.sASrU01HFQ@amdc3058>
References: <CGME20170112164013epcas5p41425c343028efaff169f1a9ed38b4365@epcas5p4.samsung.com>
 <20170112163924.4414-1-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <20170112163924.4414-1-alexander.stein@systec-electronic.com>
Sender: linux-leds-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org


Hi,

On Thursday, January 12, 2017 05:39:24 PM Alexander Stein wrote:
> Currently all users of fwnode_get_named_gpiod() have no way to specify a
> label for the GPIO. So GPIOs listed in debugfs are shown with label "?".
> With this change a proper label is used.
> Also adjust all users so they can pass a label, properly retrieved from
> device tree properties.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> ---
> v2:
> * Non-RFC
> * This patch is rebased on gpio/for-next branch and cherry-picked commit
> 2715bbe from https://bitbucket.org/andy-shev/linux.git
> 
>  drivers/gpio/devres.c                     |  5 +++--
>  drivers/gpio/gpiolib.c                    |  5 +++--
>  drivers/input/keyboard/gpio_keys.c        |  3 ++-
>  drivers/input/keyboard/gpio_keys_polled.c |  3 ++-
>  drivers/leds/leds-gpio.c                  | 13 +++++++------
>  drivers/video/fbdev/amba-clcd-nomadik.c   | 12 ++++++++----

For fbdev part:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  include/linux/gpio/consumer.h             | 12 ++++++++----
>  7 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
> index 6d77b60..d196be7 100644
> --- a/drivers/gpio/devres.c
> +++ b/drivers/gpio/devres.c
> @@ -140,7 +140,8 @@ EXPORT_SYMBOL(devm_gpiod_get_index);
>  struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
>  					    const char *con_id,
>  					    struct fwnode_handle *child,
> -					    enum gpiod_flags flags)
> +					    enum gpiod_flags flags,
> +					    const char *label)
>  {
>  	char prop_name[32]; /* 32 is max size of property name */
>  	struct gpio_desc **dr;
> @@ -160,7 +161,7 @@ struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
>  			snprintf(prop_name, sizeof(prop_name), "%s",
>  					    gpio_suffixes[i]);
>  
> -		desc = fwnode_get_named_gpiod(child, prop_name, flags);
> +		desc = fwnode_get_named_gpiod(child, prop_name, flags, label);
>  		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
>  			break;
>  	}
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 46a4334..59d3d96 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3317,7 +3317,8 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
>   */
>  struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
>  					 const char *propname,
> -					 enum gpiod_flags dflags)
> +					 enum gpiod_flags dflags,
> +					 const char *label)
>  {
>  	struct gpio_desc *desc = ERR_PTR(-ENODEV);
>  	unsigned long lflags = 0;
> @@ -3348,7 +3349,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
>  	if (IS_ERR(desc))
>  		return desc;
>  
> -	ret = gpiod_request(desc, NULL);
> +	ret = gpiod_request(desc, label);
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 9de4b87..2ec74d9 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -481,7 +481,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  	spin_lock_init(&bdata->lock);
>  
>  	if (child) {
> -		bdata->gpiod = devm_get_gpiod_from_child(dev, NULL, child, GPIOD_IN);
> +		bdata->gpiod = devm_get_gpiod_from_child(dev, NULL, child,
> +							 GPIOD_IN, desc);
>  		if (IS_ERR(bdata->gpiod)) {
>  			error = PTR_ERR(bdata->gpiod);
>  			if (error == -ENOENT) {
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> index fd7ab4d..5e35c56 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -305,7 +305,8 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>  
>  			bdata->gpiod = devm_get_gpiod_from_child(dev, NULL,
>  								 child,
> -								 GPIOD_IN);
> +								 GPIOD_IN,
> +								 button->desc);
>  			if (IS_ERR(bdata->gpiod)) {
>  				error = PTR_ERR(bdata->gpiod);
>  				if (error != -EPROBE_DEFER)
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index 00cc671..6c4825d 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -174,12 +174,6 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
>  		const char *state = NULL;
>  		struct device_node *np = to_of_node(child);
>  
> -		led.gpiod = devm_get_gpiod_from_child(dev, NULL, child, GPIOD_ASIS);
> -		if (IS_ERR(led.gpiod)) {
> -			fwnode_handle_put(child);
> -			return ERR_CAST(led.gpiod);
> -		}
> -
>  		ret = fwnode_property_read_string(child, "label", &led.name);
>  		if (ret && IS_ENABLED(CONFIG_OF) && np)
>  			led.name = np->name;
> @@ -188,6 +182,13 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
>  			return ERR_PTR(-EINVAL);
>  		}
>  
> +		led.gpiod = devm_get_gpiod_from_child(dev, NULL, child,
> +						      GPIOD_ASIS, led.name);
> +		if (IS_ERR(led.gpiod)) {
> +			fwnode_handle_put(child);
> +			return ERR_CAST(led.gpiod);
> +		}
> +
>  		fwnode_property_read_string(child, "linux,default-trigger",
>  					    &led.default_trigger);
>  
> diff --git a/drivers/video/fbdev/amba-clcd-nomadik.c b/drivers/video/fbdev/amba-clcd-nomadik.c
> index 2e800d7..9175ad9 100644
> --- a/drivers/video/fbdev/amba-clcd-nomadik.c
> +++ b/drivers/video/fbdev/amba-clcd-nomadik.c
> @@ -185,22 +185,26 @@ static void tpg110_init(struct device *dev, struct device_node *np,
>  	dev_info(dev, "TPG110 display init\n");
>  
>  	/* This asserts the GRESTB signal, putting the display into reset */
> -	grestb = devm_get_gpiod_from_child(dev, "grestb", &np->fwnode, GPIOD_OUT_HIGH);
> +	grestb = devm_get_gpiod_from_child(dev, "grestb", &np->fwnode,
> +					   GPIOD_OUT_HIGH, "grestb");
>  	if (IS_ERR(grestb)) {
>  		dev_err(dev, "no GRESTB GPIO\n");
>  		return;
>  	}
> -	scen = devm_get_gpiod_from_child(dev, "scen", &np->fwnode, GPIOD_OUT_LOW);
> +	scen = devm_get_gpiod_from_child(dev, "scen", &np->fwnode,
> +					 GPIOD_OUT_LOW, "scen");
>  	if (IS_ERR(scen)) {
>  		dev_err(dev, "no SCEN GPIO\n");
>  		return;
>  	}
> -	scl = devm_get_gpiod_from_child(dev, "scl", &np->fwnode, GPIOD_OUT_LOW);
> +	scl = devm_get_gpiod_from_child(dev, "scl", &np->fwnode, GPIOD_OUT_LOW,
> +					"scl");
>  	if (IS_ERR(scl)) {
>  		dev_err(dev, "no SCL GPIO\n");
>  		return;
>  	}
> -	sda = devm_get_gpiod_from_child(dev, "sda", &np->fwnode, GPIOD_OUT_LOW);
> +	sda = devm_get_gpiod_from_child(dev, "sda", &np->fwnode, GPIOD_OUT_LOW,
> +					"sda");
>  	if (IS_ERR(sda)) {
>  		dev_err(dev, "no SDA GPIO\n");
>  		return;
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 930d100..80bad7e 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -136,11 +136,13 @@ struct fwnode_handle;
>  
>  struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
>  					 const char *propname,
> -					 enum gpiod_flags dflags);
> +					 enum gpiod_flags dflags,
> +					 const char *label);
>  struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
>  					    const char *con_id,
>  					    struct fwnode_handle *child,
> -					    enum gpiod_flags flags);
> +					    enum gpiod_flags flags,
> +					    const char *label);
>  #else /* CONFIG_GPIOLIB */
>  
>  static inline int gpiod_count(struct device *dev, const char *con_id)
> @@ -416,7 +418,8 @@ struct fwnode_handle;
>  static inline
>  struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
>  					 const char *propname,
> -					 enum gpiod_flags dflags)
> +					 enum gpiod_flags dflags,
> +					 const char *label)
>  {
>  	return ERR_PTR(-ENOSYS);
>  }
> @@ -425,7 +428,8 @@ static inline
>  struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
>  					    const char *con_id,
>  					    struct fwnode_handle *child,
> -					    enum gpiod_flags flags)
> +					    enum gpiod_flags flags,
> +					    const char *label)
>  {
>  	return ERR_PTR(-ENOSYS);
>  }
