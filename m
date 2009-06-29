From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH 2/2] input: gpio-keys: avoid possibility of sleeping in
 timer function
Date: Mon, 29 Jun 2009 18:30:38 +0800
Message-ID: <20090629183038.000009c1@unknown>
References: <cover.1246015395.git.ext-jani.1.nikula@nokia.com>
	<7dbf3c1888fe61729b6c9e399971012611122a28.1246015395.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24466 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373AbZF2KcH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 06:32:07 -0400
In-Reply-To: <7dbf3c1888fe61729b6c9e399971012611122a28.1246015395.git.ext-jani.1.nikula@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>, "ext-jani.1.nikula@nokia.com" <ext-jani.1.nikula@nokia.com>

On Fri, 26 Jun 2009 20:15:18 +0800
Jani Nikula <ext-jani.1.nikula@nokia.com> wrote:

> The gpio_get_value function may sleep, so it should not be called in a
> timer function. Move gpio_get_value calls to workqueue.
> 
> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
> ---
>  drivers/input/keyboard/gpio_keys.c |   17 ++++++++++++-----
>  1 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c
> b/drivers/input/keyboard/gpio_keys.c index 9767213..efed0c9 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -22,6 +22,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
> +#include <linux/workqueue.h>
>  
>  #include <asm/gpio.h>
>  
> @@ -29,6 +30,7 @@ struct gpio_button_data {
>  	struct gpio_keys_button *button;
>  	struct input_dev *input;
>  	struct timer_list timer;
> +	struct work_struct work;
>  };
>  
>  struct gpio_keys_drvdata {
> @@ -36,8 +38,10 @@ struct gpio_keys_drvdata {
>  	struct gpio_button_data data[0];
>  };
>  
> -static void gpio_keys_report_event(struct gpio_button_data *bdata)
> +static void gpio_keys_report_event(struct work_struct *work)
>  {
> +	struct gpio_button_data *bdata =
> +		container_of(work, struct gpio_button_data, work);
>  	struct gpio_keys_button *button = bdata->button;
>  	struct input_dev *input = bdata->input;
>  	unsigned int type = button->type ?: EV_KEY;
> @@ -47,11 +51,11 @@ static void gpio_keys_report_event(struct
> gpio_button_data *bdata) input_sync(input);
>  }
>  
> -static void gpio_check_button(unsigned long _data)
> +static void gpio_keys_timer(unsigned long _data)
>  {
>  	struct gpio_button_data *data = (struct gpio_button_data
> *)_data; 
> -	gpio_keys_report_event(data);
> +	schedule_work(&data->work);
>  }
>  
>  static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
> @@ -65,7 +69,7 @@ static irqreturn_t gpio_keys_isr(int irq, void
> *dev_id) mod_timer(&bdata->timer,
>  			jiffies +
> msecs_to_jiffies(button->debounce_interval)); else
> -		gpio_keys_report_event(bdata);
> +		schedule_work(&bdata->work);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -113,7 +117,8 @@ static int __devinit gpio_keys_probe(struct
> platform_device *pdev) bdata->input = input;
>  		bdata->button = button;
>  		setup_timer(&bdata->timer,
> -			    gpio_check_button, (unsigned long)bdata);
> +			    gpio_keys_timer, (unsigned long)bdata);
> +		INIT_WORK(&bdata->work, gpio_keys_report_event);
>  
>  		error = gpio_request(button->gpio, button->desc ?:
> "gpio_keys"); if (error < 0) {
> @@ -174,6 +179,7 @@ static int __devinit gpio_keys_probe(struct
> platform_device *pdev) free_irq(gpio_to_irq(pdata->buttons[i].gpio),
> &ddata->data[i]); if (pdata->buttons[i].debounce_interval)
>  			del_timer_sync(&ddata->data[i].timer);
> +		cancel_work_sync(&ddata->data[i].work);
>  		gpio_free(pdata->buttons[i].gpio);
>  	}
>  
> @@ -199,6 +205,7 @@ static int __devexit gpio_keys_remove(struct
> platform_device *pdev) free_irq(irq, &ddata->data[i]);
>  		if (pdata->buttons[i].debounce_interval)
>  			del_timer_sync(&ddata->data[i].timer);
> +		cancel_work_sync(&ddata->data[i].work);
>  		gpio_free(pdata->buttons[i].gpio);
>  	}
>  

Tested with my board, it works well. Dmitry, could you please consider
to apply it?

Tested-by: Alek Du <alek.du@intel.com>
