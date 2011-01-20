From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: replace request_irq by request_any_context_irq in
 keyboard GPIO driver
Date: Thu, 20 Jan 2011 00:13:19 -0800
Message-ID: <20110120081319.GC2498@core.coreip.homeip.net>
References: <1294825292-24134-1-git-send-email-philippe.langlais@stericsson.com>
 <1294825292-24134-2-git-send-email-philippe.langlais@stericsson.com>
 <20110120075348.GE30522@core.coreip.homeip.net>
 <4D37EB9F.4040103@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55787 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1ATIN0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 03:13:26 -0500
Received: by iyj18 with SMTP id 18so306609iyj.19
        for <linux-input@vger.kernel.org>; Thu, 20 Jan 2011 00:13:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D37EB9F.4040103@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Philippe Langlais <philippe.langlais@stericsson.com>, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

Hi Trilok,

On Thu, Jan 20, 2011 at 01:30:31PM +0530, Trilok Soni wrote:
> Hi Dmitry,
> 
> On 1/20/2011 1:23 PM, Dmitry Torokhov wrote:
> > Hi Philippe,
> > 
> > On Wed, Jan 12, 2011 at 10:41:32AM +0100, Philippe Langlais wrote:
> >> Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
> >> ---
> >>  drivers/input/keyboard/gpio_keys.c |    6 +++---
> >>  1 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> >> index 6069abe..eb30063 100644
> >> --- a/drivers/input/keyboard/gpio_keys.c
> >> +++ b/drivers/input/keyboard/gpio_keys.c
> >> @@ -322,7 +322,7 @@ static void gpio_keys_report_event(struct gpio_button_data *bdata)
> >>  	struct gpio_keys_button *button = bdata->button;
> >>  	struct input_dev *input = bdata->input;
> >>  	unsigned int type = button->type ?: EV_KEY;
> >> -	int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
> >> +	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
> >>  
> >>  	input_event(input, type, button->code, !!state);
> >>  	input_sync(input);
> >> @@ -410,8 +410,8 @@ static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
> >>  	if (!button->can_disable)
> >>  		irqflags |= IRQF_SHARED;
> >>  
> >> -	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
> >> -	if (error) {
> >> +	error = request_any_context_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
> >> +	if (error < 0) {
> > 
> > No, this it not correct. request_any_context_irq() means that you could
> > either get a hardirq or a treaded one. However above you are changing to
> > gpio_get_value_cansleep() which indicates that you can sleep.
> > 
> > You need to either revert to gpio_get_value() or explicitly request
> > threaded IRQ.
> 
> This could be problem. Say, we are doing request_any_context_irq(..) and gpio is over slow-bus,
> so we naturally get into the threaded code, and in the thread handler we are calling gpio_get_value(..),
> but in this case gpio_get_value could throw a warning that we should call gpio_get_value_cansleep(...)
> because sleep attribute is added into the gpiolib hook implementation for these gpios.
> 
> Now suppose gpio is memory mapped and we enter into the hardirq and calling sleep variant into the 
> handler code will be naturally bad. 
> 
> How about checking maysleep explicitly here while using the request_any_context_irq() call though
> the semantics of gpiolib framework discourages that. 
> 

Any drawbacks for explicitly switching to threaded IRQ and keeping
gpio_get_value_cansleep()? (That was the 2nd option I mentioned BTW).

-- 
Dmitry
