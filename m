From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Thu, 28 Jan 2010 00:11:00 -0800
Message-ID: <20100128081100.GA22497@core.coreip.homeip.net>
References: <1264614644.2463.143.camel@realization>
 <20100127183358.GB8723@core.coreip.homeip.net>
 <1264621419.2463.236.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:62451 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab0A1ILI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2010 03:11:08 -0500
Received: by pxi12 with SMTP id 12so363955pxi.33
        for <linux-input@vger.kernel.org>; Thu, 28 Jan 2010 00:11:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264621419.2463.236.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 27, 2010 at 08:43:39PM +0100, Alberto Panizzo wrote:
> Hi Dmitry,
> 
> On mer, 2010-01-27 at 10:33 -0800, Dmitry Torokhov wrote:
> > Hi Alberto,
> > 
> > On Wed, Jan 27, 2010 at 06:50:44PM +0100, Alberto Panizzo wrote:
> > > The MXC family of Application Processors is shipped with a Keypad Port
> > > supported now by this driver.
> > > 
> > > The peripheral can control up to an 8x8 matrix key pad where all the scanning
> > > procedure is done via software.
> > > 
> > > The hardware provide two interrupts: one for a key pressed (KDI) and one for
> > > all key releases (KRI). There is also a simple circuit for glitch reduction
> > > (said for synchronization) made by two series of 3 D-latches clocked by the
> > > keypad-clock that stabilize the interrupts sources.
> > > KDI and KRI are fired only if the respective conditions are maintained for at
> > > last 4 keypad-clock cycle.
> > > 
> > > Those simple synchronization circuits are used also for multiple key pressures:
> > > between a KDI and a KRI the driver reset the sync circuit and re-enable the KDI
> > > interrupt so after 3 keypad-clock cycle another KDI is fired making possible to
> > > repeat the matrix scan operation.
> > > 
> > > This algorithm is done through the interrupt management code and delayed by a
> > > proper (and longer) debounce interval controlled by the platform initialization.
> > > If a key is pressed for a lot of time, the driver relaxes the interrupt re-enabling
> > > procedure to not over load the cpu in a long time keypad interaction.
> > > 
> > 
> > I was looking at the debounce logic and I am not quite sure about it.
> > Normally you have 2 ways for dealing with jitter:
> > 
> > 1. You let interrupts to come in and reschedule the scan until they stop
> >    arriving. Then to tak ethe stable reading.
> > 
> > 2. You inhibit interrupt, take a reading and schedule another reading in
> >    the future. If they match you decide that reading is stable otherwise
> >     you schedule another reading.
> > 
> > In your case you seem to be simply postponing the reading but this does
> > not guarantee that the reading is stable.
> 
> Yes, because of the glitch suppression circuit, I suppose that when
> an interrupt arrive, it is a key pressure for sure.
> Then I assume that the matrix will be stable after a proper debounce
> time (test look fine with 20 ms).
> 
> 1 should be a more accurate way, I can study an implementation.
> 
> > 
> > I also do not think that yopu need 2 timers - you can easily requeue
> > currently running timer.
> 
> The first version I made was with one timer: if for too many repeating 
> interrupts the matrix state do not change, the scanning procedure was 
> scheduled with a summed delay.
> 
> It resulted in a degradation of responsiveness and more key pressure 
> losing. It is a better choice to let the scanning procedure near the 
> interrupt.

Hmm, that is unexpected result. I am pretty sure if was implementation
deficiency and you can achieve the same performance with one timer and
unified timer function.

> 
> Changing the timer handler over the time? Would be acceptable?

No, it is a bad taste.

-- 
Dmitry
