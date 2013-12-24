From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: support wakeup system from freeze mode
Date: Mon, 23 Dec 2013 16:30:36 -0800
Message-ID: <20131224003036.GA16590@core.coreip.homeip.net>
References: <1387822880-30382-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47114 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758409Ab3LXAak (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 19:30:40 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so3956411pab.5
        for <linux-input@vger.kernel.org>; Mon, 23 Dec 2013 16:30:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387822880-30382-1-git-send-email-b20788@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: sachin.kamat@linaro.org, linux-input@vger.kernel.org

Hi Anson,

On Mon, Dec 23, 2013 at 01:21:20PM -0500, Anson Huang wrote:
> For "freeze" mode of suspend, cpu will go into idle and
> those wakeup sources' irq should NOT be disabled during
> devices suspend, so we need to add IRQF_NO_SUSPEND flag
> for those wakeup sources.
> 
> Steps to test this patch:
> 
> 1. echo freeze > /sys/power/state;
> 2. press gpio key which has wakeup function, then system
>    will resume.

I do no think this is correct approach, otheriwse every driver that can
be a wakeup source would have to use IRQF_NO_SUSPEND flag. The driver
does use enable_irq_wake() in its suspend path, and platform code should
perform all necessary work for this IRQ to be usable as a wakeup source.

Thanks.

> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  drivers/input/keyboard/gpio_keys.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 2db1324..aadb1db 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -473,6 +473,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  
>  		isr = gpio_keys_gpio_isr;
>  		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
> +		if (bdata->button->wakeup)
> +			irqflags |= IRQF_NO_SUSPEND;
>  
>  	} else {
>  		if (!button->irq) {
> -- 
> 1.7.9.5
> 
> 

-- 
Dmitry
