From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Fri, 16 Mar 2012 01:32:01 -0700
Message-ID: <20120316083201.GA4139@core.coreip.homeip.net>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-4-git-send-email-david@protonic.nl>
 <20120316072004.GB16291@core.coreip.homeip.net>
 <20120316091701.4ee5f380@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55243 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032640Ab2CPIcG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 04:32:06 -0400
Received: by dajr28 with SMTP id r28so5826898daj.19
        for <linux-input@vger.kernel.org>; Fri, 16 Mar 2012 01:32:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120316091701.4ee5f380@archvile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david.jander@protonic.nl>
Cc: David Jander <david@protonic.nl>, Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org

On Fri, Mar 16, 2012 at 09:17:01AM +0100, David Jander wrote:
> On Fri, 16 Mar 2012 00:20:04 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi David,
> > 
> > On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
> > > Use a threaded interrupt handler in order to permit the handler to use
> > > a GPIO driver that causes things like I2C transactions being done inside
> > > the handler context.
> > > Also, gpio_keys_init needs to be declared as a late_initcall, to make sure
> > > all needed GPIO drivers have been loaded if the drivers are built into the
> > > kernel.
> > 
> > Don't want to resurrect the whole initcall discussion, but could you
> > tell me again why the interrup handler needs to be threaded? We do not
> > access hardware from it, hardware is accessed from workqueue context.
> > Here is the ISR in its entirety:
> 
> Sorry, the reason described is apparently not very clear. The real reason seems
> to be that I would like this driver to work with I2C GPIO expanders, and its
> the GPIO expanders "interrupt controller" which has itself a threaded handler
> (due to I2C transfers done in it to ack an IRQ). So this is actually a nested
> and threaded interrupt controller (because the IRQ line of the GPIO expander
> is connected to a different GPIO acting itself also as interrupt line).
> In irq/manage.c, function __setup_irq():
> 
> ...
> 	/*
> 	 * Check whether the interrupt nests into another interrupt
> 	 * thread.
> 	 */
> 	nested = irq_settings_is_nested_thread(desc);
> 	if (nested) {
> 		if (!new->thread_fn) {
> 			ret = -EINVAL;
> 			goto out_mput;
> 		}
> ...
> 
> This is were requesting a non-threaded IRQ from this GPIO controller will fail.
> 
> I know this is not a trivial setup, but IMHO it is very useful (for
> connecting keyboards), and a nice demonstration of the powerful features this
> GPIO driver has :-)

Thanks for the explanation of your setup.

> 
> > static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
> > {
> >         struct gpio_button_data *bdata = dev_id;
> >         const struct gpio_keys_button *button = bdata->button;
> > 
> >         BUG_ON(irq != gpio_to_irq(button->gpio));
> > 
> >         if (bdata->timer_debounce)
> >                 mod_timer(&bdata->timer,
> >                         jiffies + msecs_to_jiffies(bdata->timer_debounce));
> >         else
> >                 schedule_work(&bdata->work);
> > 
> >         return IRQ_HANDLED;
> > }
> > 
> > It looks to me that non-threaded handler would work as well? Or
> > gpio_to_irq() can sleep with certain chips?
> 
> Not in my case. I just checked again. If I change request_threaded_irq() to
> request_irq(), I get this:
> 
> ...
> [    6.409810] gpio-keys gpio_keys.0: Unable to claim irq 0; error -22
> [    6.416106] gpio-keys: probe of gpio_keys.0 failed with error -22
> ...
> 
> This error -22 (-EINVAL) is returned from __setup_irq() (see above).

But the original code used request_any_context_irq() which should have
taken care of your nested IRQ setup:

int request_any_context_irq(unsigned int irq, irq_handler_t handler,
                            unsigned long flags, const char *name, void *dev_id)
{
        struct irq_desc *desc = irq_to_desc(irq);
        int ret;

        if (!desc)
                return -EINVAL;

        if (irq_settings_is_nested_thread(desc)) {
                ret = request_threaded_irq(irq, NULL, handler,
                                           flags, name, dev_id);
                return !ret ? IRQC_IS_NESTED : ret;
        }

        ret = request_irq(irq, handler, flags, name, dev_id);
        return !ret ? IRQC_IS_HARDIRQ : ret;
}

Thanks.

-- 
Dmitry
