From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] GPIO button wth wakeup attribute is supposed to wake the system up
Date: Tue, 08 Jul 2014 22:52:52 +0200
Message-ID: <13019301.98tkdHyOVf@vostro.rjw.lan>
References: <53A2340D.9030503@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56747 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750845AbaGHUer (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jul 2014 16:34:47 -0400
In-Reply-To: <53A2340D.9030503@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On Thursday, June 19, 2014 08:51:25 AM Li, Aubrey wrote:
> When the wakeup attribute is set, the GPIO button is capable of
> waking up the system from sleep states, including the "freeze"
> sleep state.  For that to work, its driver needs to pass the
> IRQF_NO_SUSPEND flag to devm_request_any_context_irq(), or the
> interrupt will be disabled by suspend_device_irqs() and the
> system won't be woken up by it from the "freeze" sleep state.
> 
> The suspend_device_irqs() routine is a workaround for drivers
> that mishandle interrupts triggered when the devices handled
> by them are suspended, so it is safe to use IRQF_NO_SUSPEND in
> all drivers that don't have that problem.
> 
> The affected/tested machines include Dell Venue 11 Pro and Asus T100TA.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

OK

Due to the lack of response (ie. no objections) and because the issue
addressed by this patch is real, I'm queuing it up as a PM-related fix
for 3.17.

Rafael


> ---
>  drivers/input/keyboard/gpio_keys.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 8c98e97..b046dc6 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -527,6 +527,14 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  	if (!button->can_disable)
>  		irqflags |= IRQF_SHARED;
>  
> +	/*
> +	 * If platform has specified the wakeup attribute of the button,
> +	 * we add IRQF_NO_SUSPEND to desc->action->flag. So the wake up
> +	 * interrupt will not be disabled in suspend_device_irqs
> +	 */
> +	if (button->wakeup)
> +		irqflags |= IRQF_NO_SUSPEND;
> +
>  	error = devm_request_any_context_irq(&pdev->dev, bdata->irq,
>  					     isr, irqflags, desc, bdata);
>  	if (error < 0) {
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
