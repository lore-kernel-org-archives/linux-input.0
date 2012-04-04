From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] matrix_keypad: convert to threaded IRQs
Date: Wed, 4 Apr 2012 01:10:15 -0700
Message-ID: <20120404081015.GA8376@core.coreip.homeip.net>
References: <1333440600-4183-1-git-send-email-rusko.peter@prolan.hu>
 <20120403163706.GA24832@core.coreip.homeip.net>
 <4F7BFAFE.4020809@prolan.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:57016 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab2DDIKV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Apr 2012 04:10:21 -0400
Received: by dake40 with SMTP id e40so635963dak.11
        for <linux-input@vger.kernel.org>; Wed, 04 Apr 2012 01:10:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7BFAFE.4020809@prolan.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Rusko <rusko.peter@prolan.hu>
Cc: Yong Zhang <yong.zhang0@gmail.com>, w.sang@pengutronix.de, linux-input@vger.kernel.org

On Wed, Apr 04, 2012 at 09:40:46AM +0200, Peter Rusko wrote:
> On 2012-04-03 18:37, Dmitry Torokhov wrote:
> >On Tue, Apr 03, 2012 at 10:10:00AM +0200, Peter Rusko wrote:
> >>Tested on Ka-Ro TX28 SOC
> >
> >Needs justification; plus this is not how debounce works - you need to
> >postpone scan until IRQ line settles, not simply wait so many
> >milliseconds.
> What is the difference there? The previous driver has the same effect,
> it used a delayed work to wait:
> 
> 	if (unlikely(keypad->scan_pending || keypad->stopped))
> 		goto out;
> 
> 	disable_row_irqs(keypad);
> 	keypad->scan_pending = true;
> 	schedule_delayed_work(&keypad->work,
> 		msecs_to_jiffies(keypad->pdata->debounce_ms));
> 
> Are you saying that I should reschedule the scan every time an interrupt
> arrives (before the 'goto out' line) and decrease timeout?

Hmm, you are right, it does not do what I thought, I mixed it up with
gpio_keys driver. Maybe this parameter should not have been called
debounce_ms as normally debounce means you wait specified time and if no
state change happened within that period the contact is assumed to be
settled. Here we have just settle time after which we assume everything
is settled even though state might still be changing. Anyway, probably
topic for a separate patch if we want to make real debounce.

However your change, in case of non-clustered IRQs, will cause several
scans of matrix being performed simultaneously which is not good.

> 
> >
> >I think what you really need is request_any_context_irq().
> In that case, I'll have to get back to delayed work.

Yep, just change request_irq to request_any_context_irq and be done with
it. I assume you want threaded IRQ because you have a GPIO expander with
nested IRQs?

Thanks.

-- 
Dmitry
