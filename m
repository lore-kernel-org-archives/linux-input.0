From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: wm831x-ts - Fix races with IRQ management
Date: Sun, 13 Mar 2011 11:55:55 +0000
Message-ID: <20110313115555.GA19520@opensource.wolfsonmicro.com>
References: <1298998459-12526-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20110313061410.GA31566@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57290 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754407Ab1CMLz5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Mar 2011 07:55:57 -0400
Content-Disposition: inline
In-Reply-To: <20110313061410.GA31566@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Sat, Mar 12, 2011 at 10:14:10PM -0800, Dmitry Torokhov wrote:

> Hmm, this is quite ugly. The race that you mentioned should be dealt
> with by rearranging the order in which you disable IRQ and enable the
> conversions. I.e. in wm831x_ts_pen_down_irq() you should do:

> 	disable_irq_nosync(wm831x_ts->pd_irq);
> 	wm831x_ts->pendown = true;
> 
> 	...
> 	enable_irq(wm831x_ts->data_irq);

Sadly there's also some sensitivities in the hardware with regard to the
interaction between the interrupt controller and the touchscreen
controller which complicate things somewhat.

> What is needed I guess is wm831x_ts->open flag that
> wm831x_ts_input_open() would set and wm831x_ts_input_close() would reset
> and the interrupt handlers would check before touching the registers
> or enabling their counterparts. wm831x_ts_input_close() would reset the
> flag first and then disable first pd_irq and then data_irq, before
> writing to the control register. The only issue is to keep track of irq
> disble counters.

IIRC I did implement a version of this approach but it causes problems
as if the interrupts fire you really do need to handle them to have
things restart correctly when you reenable.  Possibly we can do
something that fiddles with the workqueue scheduling only.  Also...

> The issue is that wm831x_ts_input_close() is racy; it simply writes into
> WM831X_TOUCH_CONTROL_1 and hopes that it will stick...    

The register I/O operations are locked so they can't race with each
other and the only bit that's really important here is TCH_ENA which is
only updated by open and close - it will stop any of the other bits
taking effect later on.  We ought to explicitly disable the X, Y and Z
conversions in open and have an explicit synchronise_irq() after turning
off the controller, though.  We can also just flush the workqueues
unconditionally and clean up the interrupts once we've done that.

> The issue with enable_irq() not working in the irq handler thread should
> be dealt at the controller level (i.e. fix it so that it works).

This is a genirq restriction which doesn't seem entirely unreasonable to
me, the enable operation needs to take the bus lock which can't be done
within IRQ context as the whole point is to deal with things that can't
run there.  You'd have to check that you were running in the context of
an operation which held the bus lock and then skip the bus locking in
that case only which doesn't seem tasteful and won't work at all if
we're using two different locking IRQ controllers for the two interrupts
(which is entirely possible here).  Scheduling out of IRQ context to
avoid these issues seems much more tasteful.
