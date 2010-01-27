From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 10:33:58 -0800
Message-ID: <20100127183358.GB8723@core.coreip.homeip.net>
References: <1264614644.2463.143.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:52992 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab0A0SeQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 13:34:16 -0500
Received: by pzk28 with SMTP id 28so2152251pzk.4
        for <linux-input@vger.kernel.org>; Wed, 27 Jan 2010 10:34:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264614644.2463.143.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Alberto,

On Wed, Jan 27, 2010 at 06:50:44PM +0100, Alberto Panizzo wrote:
> The MXC family of Application Processors is shipped with a Keypad Port
> supported now by this driver.
> 
> The peripheral can control up to an 8x8 matrix key pad where all the scanning
> procedure is done via software.
> 
> The hardware provide two interrupts: one for a key pressed (KDI) and one for
> all key releases (KRI). There is also a simple circuit for glitch reduction
> (said for synchronization) made by two series of 3 D-latches clocked by the
> keypad-clock that stabilize the interrupts sources.
> KDI and KRI are fired only if the respective conditions are maintained for at
> last 4 keypad-clock cycle.
> 
> Those simple synchronization circuits are used also for multiple key pressures:
> between a KDI and a KRI the driver reset the sync circuit and re-enable the KDI
> interrupt so after 3 keypad-clock cycle another KDI is fired making possible to
> repeat the matrix scan operation.
> 
> This algorithm is done through the interrupt management code and delayed by a
> proper (and longer) debounce interval controlled by the platform initialization.
> If a key is pressed for a lot of time, the driver relaxes the interrupt re-enabling
> procedure to not over load the cpu in a long time keypad interaction.
> 

I was looking at the debounce logic and I am not quite sure about it.
Normally you have 2 ways for dealing with jitter:

1. You let interrupts to come in and reschedule the scan until they stop
   arriving. Then to tak ethe stable reading.

2. You inhibit interrupt, take a reading and schedule another reading in
   the future. If they match you decide that reading is stable otherwise
    you schedule another reading.

In your case you seem to be simply postponing the reading but this does
not guarantee that the reading is stable.

I also do not think that yopu need 2 timers - you can easily requeue
currently running timer.

BTW, you need to pay close attention to the races between re-enabling
intterrupts (form the timer context) and inhibiting interrupts when you
close the device. Currently there is a race - if you close the device
while scan is scheduled the timer will re-enable them again. You disable
all rows so I am not sure if it is possible for interrupts to be raised
again at this point, but if it is, then you porbbaly need a spinlock
there.

> +
> +static void mxc_keypad_relax_timer_handler(unsigned long data)
> +{
> +	struct mxc_keypad *keypad = (struct mxc_keypad *) data;
> +	unsigned short reg_val;
> +
> +	/* 10. Clear KPKD and KPKR status bits
> +	 *     Set the KPKR sync chain and clear the KPKD sync chain */
> +	reg_val = readw(keypad->mmio_base + KPSR);
> +	reg_val |= KBD_STAT_KPKD | KBD_STAT_KPKR |
> +		   KBD_STAT_KDSC | KBD_STAT_KRSS;
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +
> +	/* Re enable interrupts and clear sync reset bits.
> +	 * Next KDI is used for detect multiple pressures. */
> +	reg_val = readw(keypad->mmio_base + KPSR);
> +	reg_val &= ~(KBD_STAT_KDSC | KBD_STAT_KRSS);
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +
> +	reg_val |= KBD_STAT_KDIE | KBD_STAT_KRIE;
> +	if (keypad->irq_type == MXC_IRQ_KRI)
> +		reg_val &= ~KBD_STAT_KRIE;

So we are keeping the press interrupt always... As far as I understand
this will cause us to effectively poll the matrix as long as at least
one key is pressed. Why do we even need to bother with release interrupt
then?

Thanks.

-- 
Dmitry
