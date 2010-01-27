From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v4] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 20:43:39 +0100
Message-ID: <1264621419.2463.236.camel@realization>
References: <1264614644.2463.143.camel@realization>
	 <20100127183358.GB8723@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:35012 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab0A0Tnq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 14:43:46 -0500
Received: by ewy19 with SMTP id 19so833034ewy.21
        for <linux-input@vger.kernel.org>; Wed, 27 Jan 2010 11:43:45 -0800 (PST)
In-Reply-To: <20100127183358.GB8723@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Dmitry,

On mer, 2010-01-27 at 10:33 -0800, Dmitry Torokhov wrote:
> Hi Alberto,
> 
> On Wed, Jan 27, 2010 at 06:50:44PM +0100, Alberto Panizzo wrote:
> > The MXC family of Application Processors is shipped with a Keypad Port
> > supported now by this driver.
> > 
> > The peripheral can control up to an 8x8 matrix key pad where all the scanning
> > procedure is done via software.
> > 
> > The hardware provide two interrupts: one for a key pressed (KDI) and one for
> > all key releases (KRI). There is also a simple circuit for glitch reduction
> > (said for synchronization) made by two series of 3 D-latches clocked by the
> > keypad-clock that stabilize the interrupts sources.
> > KDI and KRI are fired only if the respective conditions are maintained for at
> > last 4 keypad-clock cycle.
> > 
> > Those simple synchronization circuits are used also for multiple key pressures:
> > between a KDI and a KRI the driver reset the sync circuit and re-enable the KDI
> > interrupt so after 3 keypad-clock cycle another KDI is fired making possible to
> > repeat the matrix scan operation.
> > 
> > This algorithm is done through the interrupt management code and delayed by a
> > proper (and longer) debounce interval controlled by the platform initialization.
> > If a key is pressed for a lot of time, the driver relaxes the interrupt re-enabling
> > procedure to not over load the cpu in a long time keypad interaction.
> > 
> 
> I was looking at the debounce logic and I am not quite sure about it.
> Normally you have 2 ways for dealing with jitter:
> 
> 1. You let interrupts to come in and reschedule the scan until they stop
>    arriving. Then to tak ethe stable reading.
> 
> 2. You inhibit interrupt, take a reading and schedule another reading in
>    the future. If they match you decide that reading is stable otherwise
>     you schedule another reading.
> 
> In your case you seem to be simply postponing the reading but this does
> not guarantee that the reading is stable.

Yes, because of the glitch suppression circuit, I suppose that when
an interrupt arrive, it is a key pressure for sure.
Then I assume that the matrix will be stable after a proper debounce
time (test look fine with 20 ms).

1 should be a more accurate way, I can study an implementation.

> 
> I also do not think that yopu need 2 timers - you can easily requeue
> currently running timer.

The first version I made was with one timer: if for too many repeating 
interrupts the matrix state do not change, the scanning procedure was 
scheduled with a summed delay.

It resulted in a degradation of responsiveness and more key pressure 
losing. It is a better choice to let the scanning procedure near the 
interrupt.

Changing the timer handler over the time? Would be acceptable?
> 
> BTW, you need to pay close attention to the races between re-enabling
> intterrupts (form the timer context) and inhibiting interrupts when you
> close the device. Currently there is a race - if you close the device
> while scan is scheduled the timer will re-enable them again. You disable
> all rows so I am not sure if it is possible for interrupts to be raised
> again at this point, but if it is, then you porbbaly need a spinlock
> there.

This is a true race condition that I've not caught!
> 
> > +
> > +static void mxc_keypad_relax_timer_handler(unsigned long data)
> > +{
> > +	struct mxc_keypad *keypad = (struct mxc_keypad *) data;
> > +	unsigned short reg_val;
> > +
> > +	/* 10. Clear KPKD and KPKR status bits
> > +	 *     Set the KPKR sync chain and clear the KPKD sync chain */
> > +	reg_val = readw(keypad->mmio_base + KPSR);
> > +	reg_val |= KBD_STAT_KPKD | KBD_STAT_KPKR |
> > +		   KBD_STAT_KDSC | KBD_STAT_KRSS;
> > +	writew(reg_val, keypad->mmio_base + KPSR);
> > +
> > +	/* Re enable interrupts and clear sync reset bits.
> > +	 * Next KDI is used for detect multiple pressures. */
> > +	reg_val = readw(keypad->mmio_base + KPSR);
> > +	reg_val &= ~(KBD_STAT_KDSC | KBD_STAT_KRSS);
> > +	writew(reg_val, keypad->mmio_base + KPSR);
> > +
> > +	reg_val |= KBD_STAT_KDIE | KBD_STAT_KRIE;
> > +	if (keypad->irq_type == MXC_IRQ_KRI)
> > +		reg_val &= ~KBD_STAT_KRIE;
> 
> So we are keeping the press interrupt always... As far as I understand
> this will cause us to effectively poll the matrix as long as at least
> one key is pressed. Why do we even need to bother with release interrupt
> then?
> 
> Thanks.


I always keep the press interrupt because of matrix-rescan in a long 
time pressure of a key, to find multiple key pressures.
Resetting the press interrupt synchronization chain will reset also 
the interrupt status bit, and if the press condition hold for the next
3*keypad_clock_periods, it is fired another press interrupt.

I can think at an architecture that after a key pressure event
continually reschedule a matrix scan in the future to look for changes
in the matrix until all keys are released.. but need a consistent 
analysis of timings.


