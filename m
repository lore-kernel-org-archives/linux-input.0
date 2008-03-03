From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] input: add debouncing for generic gpio input device
 gpio_key.c
Date: Mon, 3 Mar 2008 14:28:57 -0800
Message-ID: <20080303142857.5f177f1c.akpm@linux-foundation.org>
References: <47C10987.9020804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48773 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754559AbYCCWaF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Mar 2008 17:30:05 -0500
In-Reply-To: <47C10987.9020804@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Keith Mok <ek9852@gmail.com>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On Sun, 24 Feb 2008 14:07:03 +0800
Keith Mok <ek9852@gmail.com> wrote:

> This patch add debouncing support for the generic gpio input device, since debouncing is most likely to happen.
> 
> Comments welcome.
> 
> Signed-off-by: Keith Mok <ek9852@gmail.com>
> ---
> Keith Mok
> 
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 6a9ca4b..79b460e 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -26,26 +26,36 @@
>  
>  #include <asm/gpio.h>
>  
> +static void do_gpio_keys_tasklet(unsigned long);
> +static void do_gpio_keys_timer(unsigned long);
> +
> +static struct timer_list gpio_keys_timer;

DEFINE_TIMER() could be used here.  Then we can remove the runtime
setup_timer().

> +DECLARE_TASKLET_DISABLED(gpio_keys_tasklet, do_gpio_keys_tasklet, 0);
> +static spinlock_t suspend_lock;

Please use DEFINE_SPINLOCK(), then remove the runtime spin_lock_init().

> +static void do_gpio_keys_tasklet(unsigned long data)
> +{
> +	int pressed;
> +	int i;
> +	struct platform_device *pdev = (struct platform_device*)data;
> +	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
> +	struct input_dev *input = platform_get_drvdata(pdev);
> +
> +	/* check for any changes */
> +	pressed = 0;
> +	for (i = 0; i < pdata->nbuttons; i++) {
> +		struct gpio_keys_button *button = &pdata->buttons[i];
> +		int gpio = button->gpio;
> +
> +		unsigned int type = button->type ?: EV_KEY;
> +		int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
> +
> +		input_event(input, type, button->code, !!state);
> +		pressed |= !!state;
> +		input_sync(input);
> +	}
> +	if(pressed) {

Please always pass patches through scripts/checkpatch.pl.


