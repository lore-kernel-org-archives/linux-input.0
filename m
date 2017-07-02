From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] input: gpio_keys: handle the missing key press
 event in resume phase
Date: Sun, 2 Jul 2017 13:39:48 -0700
Message-ID: <20170702203948.GB3935@dtor-ws>
References: <20170628102940.15670-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34738 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdGBUjv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 2 Jul 2017 16:39:51 -0400
Content-Disposition: inline
In-Reply-To: <20170628102940.15670-1-enric.balletbo@collabora.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Phil Blundell <pb@handhelds.org>, groeck@chromium.org, Joseph Lo <josephl@nvidia.com>

On Wed, Jun 28, 2017 at 12:29:40PM +0200, Enric Balletbo i Serra wrote:
> From: Joseph Lo <josephl@nvidia.com>
> 
> The GPIO key press event might be missed in the resume phase, if the key
> had been released before the system had been resumed to the stage that it
> could capture the press event. So we simulate the wakeup key press event
> in case the key had been released by the time we got interrupt handler
> to run.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> This patch was sent long time ago [1] but apparently did not receive feedback
> and seems that nobody take care of it. I think might be interesting have this
> upstream so I resend this version just rebased on top of mainline and tested
> on a veyron device.

Applied, thank you.

> 
> [1] https://patchwork.kernel.org/patch/7157201/
> 
>  drivers/input/keyboard/gpio_keys.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index da3d362..a047b9a 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -48,6 +48,7 @@ struct gpio_button_data {
>  	spinlock_t lock;
>  	bool disabled;
>  	bool key_pressed;
> +	bool suspended;
>  };
>  
>  struct gpio_keys_drvdata {
> @@ -396,8 +397,20 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>  
>  	BUG_ON(irq != bdata->irq);
>  
> -	if (bdata->button->wakeup)
> +	if (bdata->button->wakeup) {
> +		const struct gpio_keys_button *button = bdata->button;
> +
>  		pm_stay_awake(bdata->input->dev.parent);
> +		if (bdata->suspended  &&
> +		    (button->type == 0 || button->type == EV_KEY)) {
> +			/*
> +			 * Simulate wakeup key press in case the key has
> +			 * already released by the time we got interrupt
> +			 * handler to run.
> +			 */
> +			input_report_key(bdata->input, button->code, 1);
> +		}
> +	}
>  
>  	mod_delayed_work(system_wq,
>  			 &bdata->work,
> @@ -855,6 +868,7 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
>  			struct gpio_button_data *bdata = &ddata->data[i];
>  			if (bdata->button->wakeup)
>  				enable_irq_wake(bdata->irq);
> +			bdata->suspended = true;
>  		}
>  	} else {
>  		mutex_lock(&input->mutex);
> @@ -878,6 +892,7 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
>  			struct gpio_button_data *bdata = &ddata->data[i];
>  			if (bdata->button->wakeup)
>  				disable_irq_wake(bdata->irq);
> +			bdata->suspended = false;
>  		}
>  	} else {
>  		mutex_lock(&input->mutex);
> -- 
> 2.9.3
> 

-- 
Dmitry
