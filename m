From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] input_ gpio_keys: scan gpio state at probe time
Date: Mon, 14 Dec 2009 11:10:55 +0800
Message-ID: <20091214031054.GX28375@buzzloop.caiaq.de>
References: <1259146416-6713-1-git-send-email-daniel@caiaq.de>
 <20091126034612.GA23244@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:56617 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbZLNDLK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2009 22:11:10 -0500
Content-Disposition: inline
In-Reply-To: <20091126034612.GA23244@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jani Nikula <ext-jani.1.nikula@nokia.com>, Mike Rapoport <mike@compulab.co.il>

On Wed, Nov 25, 2009 at 07:46:13PM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 25, 2009 at 11:53:36AM +0100, Daniel Mack wrote:
> > gpio_keys.c registers interrupts at both edges of all given gpio lines
> > and updates the input device when they change. However, the driver fails
> > to check the current line state at probe time.
> > 
> 
> Should not matter for keys really, but is important for swicthes. I
> guess we need to also do this at resume. Does the following still work?

Sorry for the long delay on this. I could finally test this patch and it
works fine, key states are reported correctly after resume.

Thanks,
Daniel

> Input: gpio_keys - scan gpio state at probe time
> 
> From: Daniel Mack <daniel@caiaq.de>
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/keyboard/gpio_keys.c |   36 +++++++++++++++++++++++++-----------
>  1 files changed, 25 insertions(+), 11 deletions(-)
> 
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 8941a8b..1aff3b7 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -37,10 +37,8 @@ struct gpio_keys_drvdata {
>  	struct gpio_button_data data[0];
>  };
>  
> -static void gpio_keys_report_event(struct work_struct *work)
> +static void gpio_keys_report_event(struct gpio_button_data *bdata)
>  {
> -	struct gpio_button_data *bdata =
> -		container_of(work, struct gpio_button_data, work);
>  	struct gpio_keys_button *button = bdata->button;
>  	struct input_dev *input = bdata->input;
>  	unsigned int type = button->type ?: EV_KEY;
> @@ -50,6 +48,14 @@ static void gpio_keys_report_event(struct work_struct *work)
>  	input_sync(input);
>  }
>  
> +static void gpio_keys_work_func(struct work_struct *work)
> +{
> +	struct gpio_button_data *bdata =
> +		container_of(work, struct gpio_button_data, work);
> +
> +	gpio_keys_report_event(bdata);
> +}
> +
>  static void gpio_keys_timer(unsigned long _data)
>  {
>  	struct gpio_button_data *data = (struct gpio_button_data *)_data;
> @@ -81,7 +87,7 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
>  	int irq, error;
>  
>  	setup_timer(&bdata->timer, gpio_keys_timer, (unsigned long)bdata);
> -	INIT_WORK(&bdata->work, gpio_keys_report_event);
> +	INIT_WORK(&bdata->work, gpio_keys_work_func);
>  
>  	error = gpio_request(button->gpio, desc);
>  	if (error < 0) {
> @@ -185,6 +191,11 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
>  		goto fail2;
>  	}
>  
> +	/* get current state of buttons */
> +	for (i = 0; i < pdata->nbuttons; i++)
> +		gpio_keys_report_event(&ddata->data[i]);
> +	input_sync(input);
> +
>  	device_init_wakeup(&pdev->dev, wakeup);
>  
>  	return 0;
> @@ -253,18 +264,21 @@ static int gpio_keys_suspend(struct device *dev)
>  static int gpio_keys_resume(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
>  	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
>  	int i;
>  
> -	if (device_may_wakeup(&pdev->dev)) {
> -		for (i = 0; i < pdata->nbuttons; i++) {
> -			struct gpio_keys_button *button = &pdata->buttons[i];
> -			if (button->wakeup) {
> -				int irq = gpio_to_irq(button->gpio);
> -				disable_irq_wake(irq);
> -			}
> +	for (i = 0; i < pdata->nbuttons; i++) {
> +
> +		struct gpio_keys_button *button = &pdata->buttons[i];
> +		if (button->wakeup && device_may_wakeup(&pdev->dev)) {
> +			int irq = gpio_to_irq(button->gpio);
> +			disable_irq_wake(irq);
>  		}
> +
> +		gpio_keys_report_event(&ddata->data[i]);
>  	}
> +	input_sync(ddata->input);
>  
>  	return 0;
>  }
