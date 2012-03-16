From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Fri, 16 Mar 2012 00:20:04 -0700
Message-ID: <20120316072004.GB16291@core.coreip.homeip.net>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-4-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37561 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758132Ab2CPHUL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 03:20:11 -0400
Received: by iagz16 with SMTP id z16so5050722iag.19
        for <linux-input@vger.kernel.org>; Fri, 16 Mar 2012 00:20:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308042491-20203-4-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org

Hi David,

On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
> Use a threaded interrupt handler in order to permit the handler to use
> a GPIO driver that causes things like I2C transactions being done inside
> the handler context.
> Also, gpio_keys_init needs to be declared as a late_initcall, to make sure
> all needed GPIO drivers have been loaded if the drivers are built into the
> kernel.

Don't want to resurrect the whole initcall discussion, but could you
tell me again why the interrup handler needs to be threaded? We do not
access hardware from it, hardware is accessed from workqueue context.
Here is the ISR in its entirety:

static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
{
        struct gpio_button_data *bdata = dev_id;
        const struct gpio_keys_button *button = bdata->button;

        BUG_ON(irq != gpio_to_irq(button->gpio));

        if (bdata->timer_debounce)
                mod_timer(&bdata->timer,
                        jiffies + msecs_to_jiffies(bdata->timer_debounce));
        else
                schedule_work(&bdata->work);

        return IRQ_HANDLED;
}

It looks to me that non-threaded handler would work as well? Or
gpio_to_irq() can sleep with certain chips?

Thanks.

-- 
Dmitry
