From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Wed, 16 Sep 2009 09:28:54 -0700
Message-ID: <20090916162853.GA4970@core.coreip.homeip.net>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53492 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759607AbZIPQ27 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 12:28:59 -0400
Received: by bwz19 with SMTP id 19so3619936bwz.37
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 09:29:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Sep 16, 2009 at 07:03:18PM +0400, Dmitry Eremin-Solenikov wrote:
> There is nothing that disallows gpio-keys to share it's IRQ line
> w/ other drivers. Make it use IRQF_SHARED in request_irq().
> 
> An example of other driver with which I'd like to share IRQ line
> for GPIO buttons is ledtrig-gpio.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/input/keyboard/gpio_keys.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index efed0c9..9fc2fab 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -147,6 +147,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
>  		}
>  
>  		error = request_irq(irq, gpio_keys_isr,
> +				    IRQF_SHARED |
>  				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>  				    button->desc ? button->desc : "gpio_keys",
>  				    bdata);

How will you determine which device generated the interrupt? Because you
can't return IRQ_HANDLED unconditionally and expect both devices work
reliably.

-- 
Dmitry
