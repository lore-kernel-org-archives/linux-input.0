From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio-beeper: Simplify GPIO handling
Date: Fri, 28 Mar 2014 01:38:36 -0700
Message-ID: <20140328083836.GL22093@core.coreip.homeip.net>
References: <1395164746-14395-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:33529 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbaC1Iik (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 04:38:40 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so4629199pbb.8
        for <linux-input@vger.kernel.org>; Fri, 28 Mar 2014 01:38:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1395164746-14395-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

Hi Alexander,

On Tue, Mar 18, 2014 at 09:45:46PM +0400, Alexander Shiyan wrote:
> This patch simplifies GPIO handling in the driver by using GPIO
> functions based on descriptors. As a result this driver now can
> be used for boards without DT support.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/input/misc/Kconfig       |  2 +-
>  drivers/input/misc/gpio-beeper.c | 37 ++++++++++++++-----------------------
>  2 files changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 762e6d2..0623e99 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -224,7 +224,7 @@ config INPUT_GP2A
>  
>  config INPUT_GPIO_BEEPER
>  	tristate "Generic GPIO Beeper support"
> -	depends on OF_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say Y here if you have a beeper connected to a GPIO pin.
>  
> diff --git a/drivers/input/misc/gpio-beeper.c b/drivers/input/misc/gpio-beeper.c
> index b757435..a57f15e 100644
> --- a/drivers/input/misc/gpio-beeper.c
> +++ b/drivers/input/misc/gpio-beeper.c
> @@ -1,7 +1,7 @@
>  /*
>   * Generic GPIO beeper driver
>   *
> - * Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
> + * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -11,7 +11,7 @@
>  
>  #include <linux/input.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
>  #include <linux/workqueue.h>
>  #include <linux/platform_device.h>
>  
> @@ -19,21 +19,15 @@
>  
>  struct gpio_beeper {
>  	struct work_struct	work;
> -	int			gpio;
> -	bool			active_low;
> -	bool			beeping;
> +	struct gpio_desc	*desc;
> +	int			beeping;
>  };
>  
> -static void gpio_beeper_toggle(struct gpio_beeper *beep, bool on)
> -{
> -	gpio_set_value_cansleep(beep->gpio, on ^ beep->active_low);
> -}
> -
>  static void gpio_beeper_work(struct work_struct *work)
>  {
>  	struct gpio_beeper *beep = container_of(work, struct gpio_beeper, work);
>  
> -	gpio_beeper_toggle(beep, beep->beeping);
> +	gpiod_set_value_cansleep(beep->desc, beep->beeping);
>  }
>  
>  static int gpio_beeper_event(struct input_dev *dev, unsigned int type,
> @@ -59,24 +53,24 @@ static void gpio_beeper_close(struct input_dev *input)
>  	struct gpio_beeper *beep = input_get_drvdata(input);
>  
>  	cancel_work_sync(&beep->work);
> -	gpio_beeper_toggle(beep, false);
> +	gpiod_set_value_cansleep(beep->desc, 0);

These chunks do not seem to fit patch description and I would argue not
make driver simpler. Please split out.

Thanks!

>  }
>  
>  static int gpio_beeper_probe(struct platform_device *pdev)
>  {
>  	struct gpio_beeper *beep;
> -	enum of_gpio_flags flags;
>  	struct input_dev *input;
> -	unsigned long gflags;
>  	int err;
>  
>  	beep = devm_kzalloc(&pdev->dev, sizeof(*beep), GFP_KERNEL);
>  	if (!beep)
>  		return -ENOMEM;
>  
> -	beep->gpio = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
> -	if (!gpio_is_valid(beep->gpio))
> -		return beep->gpio;
> +	beep->desc = devm_gpiod_get(&pdev->dev, NULL);
> +	if (!beep->desc)
> +		return -EINVAL;
> +	if (IS_ERR(beep->desc))
> +		return PTR_ERR(beep->desc);
>  
>  	input = devm_input_allocate_device(&pdev->dev);
>  	if (!input)
> @@ -94,10 +88,7 @@ static int gpio_beeper_probe(struct platform_device *pdev)
>  
>  	input_set_capability(input, EV_SND, SND_BELL);
>  
> -	beep->active_low = flags & OF_GPIO_ACTIVE_LOW;
> -	gflags = beep->active_low ? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
> -
> -	err = devm_gpio_request_one(&pdev->dev, beep->gpio, gflags, pdev->name);
> +	err = gpiod_direction_output(beep->desc, 0);
>  	if (err)
>  		return err;
>  
> @@ -106,7 +97,7 @@ static int gpio_beeper_probe(struct platform_device *pdev)
>  	return input_register_device(input);
>  }
>  
> -static struct of_device_id gpio_beeper_of_match[] = {
> +static struct of_device_id __maybe_unused gpio_beeper_of_match[] = {
>  	{ .compatible = BEEPER_MODNAME, },
>  	{ }
>  };
> @@ -116,7 +107,7 @@ static struct platform_driver gpio_beeper_platform_driver = {
>  	.driver	= {
>  		.name		= BEEPER_MODNAME,
>  		.owner		= THIS_MODULE,
> -		.of_match_table	= gpio_beeper_of_match,
> +		.of_match_table	= of_match_ptr(gpio_beeper_of_match),
>  	},
>  	.probe	= gpio_beeper_probe,
>  };
> -- 
> 1.8.3.2
> 

-- 
Dmitry
