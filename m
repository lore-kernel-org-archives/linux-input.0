From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
	GPIO chips.
Date: Fri, 16 Mar 2012 10:18:15 +0000
Message-ID: <20120316101815.GE32060@trinity.fluff.org>
References: <1308042491-20203-1-git-send-email-david@protonic.nl> <1308042491-20203-4-git-send-email-david@protonic.nl> <20120316072004.GB16291@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:37134 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422683Ab2CPLUP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 07:20:15 -0400
Content-Disposition: inline
In-Reply-To: <20120316072004.GB16291@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Jander <david@protonic.nl>, Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org

On Fri, Mar 16, 2012 at 12:20:04AM -0700, Dmitry Torokhov wrote:
> Hi David,
> 
> On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
> > Use a threaded interrupt handler in order to permit the handler to use
> > a GPIO driver that causes things like I2C transactions being done inside
> > the handler context.
> > Also, gpio_keys_init needs to be declared as a late_initcall, to make sure
> > all needed GPIO drivers have been loaded if the drivers are built into the
> > kernel.
> 
> Don't want to resurrect the whole initcall discussion, but could you
> tell me again why the interrup handler needs to be threaded? We do not
> access hardware from it, hardware is accessed from workqueue context.
> Here is the ISR in its entirety:
> 
> static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
> {
>         struct gpio_button_data *bdata = dev_id;
>         const struct gpio_keys_button *button = bdata->button;
> 
>         BUG_ON(irq != gpio_to_irq(button->gpio));

Why on earth do we need this? this looks like something that is not
necessary and in my view a waste of cpu cycles.
 
>         if (bdata->timer_debounce)
>                 mod_timer(&bdata->timer,
>                         jiffies + msecs_to_jiffies(bdata->timer_debounce));
>         else
>                 schedule_work(&bdata->work);
> 
>         return IRQ_HANDLED;
> }
> 
> It looks to me that non-threaded handler would work as well? Or
> gpio_to_irq() can sleep with certain chips?

See above comment, I'd go with just remove it and unthread.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

