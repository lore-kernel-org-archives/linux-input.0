From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: Make sure wake-up buttons work.
Date: Fri, 7 Nov 2014 15:45:07 -0800
Message-ID: <20141107234507.GB4439@dtor-ws>
References: <20141108103707.45bcc7e3@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:57019 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbaKGXpO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Nov 2014 18:45:14 -0500
Content-Disposition: inline
In-Reply-To: <20141108103707.45bcc7e3@notabene.brown>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Neil,

On Sat, Nov 08, 2014 at 10:37:07AM +1100, NeilBrown wrote:
> 
> 
> If a key is to be used for wake-up, we must not disable
> the interrupt during suspend.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 8c98e97f8e41..0b5e54ae343e 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -526,6 +526,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  	 */
>  	if (!button->can_disable)
>  		irqflags |= IRQF_SHARED;
> +	if (button->wakeup)
> +		irqflags |= IRQF_NO_SUSPEND;

No, enable_irq_wake() should be enough. I believe Rafael has fixed that
in the core, right?

>  
>  	error = devm_request_any_context_irq(&pdev->dev, bdata->irq,
>  					     isr, irqflags, desc, bdata);

Thanks.

-- 
Dmitry
