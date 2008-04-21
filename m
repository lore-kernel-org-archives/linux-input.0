From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] gpio-keys debouncing support
Date: Mon, 21 Apr 2008 18:40:19 +0400
Message-ID: <20080421144019.GA6516@doriath.ww600.siemens.net>
References: <20080319221323.GA2710@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:60924 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbYDUOkm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 10:40:42 -0400
Received: by ug-out-1314.google.com with SMTP id z38so691953ugc.16
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 07:40:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080319221323.GA2710@doriath.ww600.siemens.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru

Hi,

What about this patch? I still got no comments.

On Thu, Mar 20, 2008 at 01:13:23AM +0300, Dmitry Baryshkov wrote:
> Sometimes the gpio line can generates jitter while transitioning
> from one state to another. Implement a way to filter such noise during
> transitions.
> 
> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> ---
>  drivers/input/keyboard/Kconfig     |    7 +++
>  drivers/input/keyboard/gpio_keys.c |   96 ++++++++++++++++++++++++++++++++++--
>  include/linux/gpio_keys.h          |    6 ++
>  3 files changed, 104 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 8ea709b..0fb4592 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -295,6 +295,13 @@ config KEYBOARD_GPIO
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called gpio-keys.
>  
> +config KEYBOARD_GPIO_DEBOUNCE
> +	bool "GPIO Buttons debouncer"
> +	depends on KEYBOARD_GPIO
> +	help
> +	  This driver will enable the debouncer in the gpio-keys
> +	  driver for pins that take some time to come to stable state.
> +
>  config KEYBOARD_MAPLE
>  	tristate "Maple bus keyboard"
>  	depends on SH_DREAMCAST && MAPLE
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 6a9ca4b..577dfea 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -26,6 +26,39 @@
>  
>  #include <asm/gpio.h>
>  
> +#ifdef CONFIG_KEYBOARD_GPIO_DEBOUNCE
> +struct gpio_debounce_data {
> +	struct platform_device *pdev;
> +	struct gpio_keys_button *button;
> +	int state;
> +	int count;
> +};
> +
> +static void gpio_debounce_timer(unsigned long _data)
> +{
> +	struct gpio_debounce_data *data = (struct gpio_debounce_data *)_data;
> +	struct gpio_keys_button *button = data->button;
> +	int gpio = button->gpio;
> +	unsigned int type = button->type ?: EV_KEY;
> +	int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
> +	struct input_dev *input = platform_get_drvdata(data->pdev);
> +
> +	if (state != data->state) {
> +		data->count = 0;
> +		data->state = state;
> +		mod_timer(&button->timer, jiffies +
> +					msecs_to_jiffies(button->interval));
> +	} else if (data->count < button->count) {
> +		data->count ++;
> +		mod_timer(&button->timer, jiffies +
> +					msecs_to_jiffies(button->interval));
> +	} else {
> +		input_event(input, type, button->code, !!state);
> +		input_sync(input);
> +	}
> +}
> +#endif
> +
>  static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
>  {
>  	int i;
> @@ -38,11 +71,21 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
>  		int gpio = button->gpio;
>  
>  		if (irq == gpio_to_irq(gpio)) {
> -			unsigned int type = button->type ?: EV_KEY;
> -			int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
> +#ifdef CONFIG_KEYBOARD_GPIO_DEBOUNCE
> +			if (button->count) {
> +				if (!timer_pending(&button->timer))
> +					mod_timer(&button->timer, jiffies +
> +							msecs_to_jiffies(
> +							button->interval));
> +			} else
> +#endif
> +			{
> +				unsigned int type = button->type ?: EV_KEY;
> +				int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
>  
> -			input_event(input, type, button->code, !!state);
> -			input_sync(input);
> +				input_event(input, type, button->code, !!state);
> +				input_sync(input);
> +			}
>  		}
>  	}
>  
> @@ -103,6 +146,31 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
>  			gpio_free(button->gpio);
>  			goto fail;
>  		}
> +#ifdef CONFIG_KEYBOARD_GPIO_DEBOUNCE
> +		if (button->count && button->interval) {
> +			struct gpio_debounce_data *data;
> +			data = kzalloc(sizeof(struct gpio_debounce_data), GFP_KERNEL);
> +			if (!data) {
> +				error = -ENOMEM;
> +				pr_err("gpio-keys: Unable to allocate debounce data"
> +					" for GPIO %d, error %d\n",
> +					button->gpio, error);
> +				gpio_free(button->gpio);
> +				goto fail;
> +			}
> +
> +			data->pdev = pdev;
> +			data->button = button;
> +			data->state = -1;
> +
> +			init_timer(&button->timer);
> +			button->timer.function = gpio_debounce_timer;
> +			button->timer.data = (unsigned long)data;
> +
> +			mod_timer(&button->timer, jiffies +
> +					msecs_to_jiffies(button->interval));
> +		}
> +#endif
>  
>  		error = request_irq(irq, gpio_keys_isr,
>  				    IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_RISING |
> @@ -112,6 +180,12 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
>  		if (error) {
>  			pr_err("gpio-keys: Unable to claim irq %d; error %d\n",
>  				irq, error);
> +#ifdef CONFIG_KEYBOARD_GPIO_DEBOUNCE
> +			if (button->count) {
> +				del_timer_sync(&button->timer);
> +				kfree((void*)button->timer.data);
> +			}
> +#endif
>  			gpio_free(button->gpio);
>  			goto fail;
>  		}
> @@ -136,6 +210,12 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
>   fail:
>  	while (--i >= 0) {
>  		free_irq(gpio_to_irq(pdata->buttons[i].gpio), pdev);
> +#ifdef CONFIG_KEYBOARD_GPIO_DEBOUNCE
> +		if (pdata->buttons[i].count) {
> +			del_timer_sync(&pdata->buttons[i].timer);
> +			kfree((void*)pdata->buttons[i].timer.data);
> +		}
> +#endif
>  		gpio_free(pdata->buttons[i].gpio);
>  	}
>  
> @@ -156,6 +236,12 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
>  	for (i = 0; i < pdata->nbuttons; i++) {
>  		int irq = gpio_to_irq(pdata->buttons[i].gpio);
>  		free_irq(irq, pdev);
> +#ifdef CONFIG_KEYBOARD_GPIO_DEBOUNCE
> +		if (pdata->buttons[i].count) {
> +			del_timer_sync(&pdata->buttons[i].timer);
> +			kfree((void*)pdata->buttons[i].timer.data);
> +		}
> +#endif
>  		gpio_free(pdata->buttons[i].gpio);
>  	}
>  
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> index c6d3a9d..2432e62 100644
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
> @@ -9,6 +9,12 @@ struct gpio_keys_button {
>  	char *desc;
>  	int type;		/* input event type (EV_KEY, EV_SW) */
>  	int wakeup;		/* configure the button as a wake-up source */
> +#ifdef CONFIG_KEYBOARD_GPIO_DEBOUNCE
> +	int count;
> +	int interval;		/* in msecs */
> +	/* private: */
> +	struct timer_list	timer;
> +#endif
>  };
>  
>  struct gpio_keys_platform_data {
> -- 
> 1.5.4.3
> 
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
With best wishes
Dmitry

