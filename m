From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 3/4] iio: mxs: Implement support for touchscreen
Date: Thu, 13 Dec 2012 17:56:32 +0100
Message-ID: <201212131756.33129.marex@denx.de>
References: <1354893893-26338-1-git-send-email-marex@denx.de> <201212082218.19338.marex@denx.de> <50C65A8C.7060304@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:37365 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002Ab2LMRYE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Dec 2012 12:24:04 -0500
In-Reply-To: <50C65A8C.7060304@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Torokhov <dmitry.torokhov@gmail.com>

Dear Jonathan Cameron,

> On 12/08/2012 09:18 PM, Marek Vasut wrote:
> > Dear Jonathan Cameron,
> > 
> >> On 12/07/2012 03:24 PM, Marek Vasut wrote:
> >>> This patch implements support for sampling of a touchscreen into
> >>> the MXS LRADC driver. The LRADC block allows configuring some of
> >>> it's channels into special mode where they either output the drive
> >>> voltage or sample it, allowing it to operate a 4-wire or 5-wire
> >>> resistive touchscreen.
> >>> 
> >>> In case the touchscreen mode is enabled, the LRADC slot #7 is
> >>> reserved for touchscreen only, therefore it is not possible to
> >>> sample 8 LRADC channels at time, but only 7 channels.
> >>> 
> >>> The touchscreen controller is configured such that the PENDOWN event
> >>> disables touchscreen interrupts and triggers execution of worker
> >>> thread, which then polls the touchscreen controller for X, Y and
> >>> Pressure values. This reduces the overhead of interrupt-driven
> >>> operation. Upon the PENUP event, the worker thread re-enables the
> >>> PENDOWN detection interrupt and exits.
> >>> 
> >>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> >>> Cc: Jonathan Cameron <jic23@kernel.org>
> >>> Cc: Shawn Guo <shawn.guo@linaro.org>
> >> 
> >> cc added for linux input and Dmitry.
> >> 
> >> I'd like to gather some opinions on the best way to handle these touch
> >> screen devices when are sharing some hardware with more generic adc's
> >> as here.
> >> 
> >> What we have is effectively a weird mulitplexing of different signals?
> >> 
> >> So could we treat the various axis as separate channels of a normal
> >> adc (even if they are infact coming from the same pins)?
> > 
> > You can not. You also need to control voltage output to various plates to
> > be able to sample it from the other plate. See the comment in my patch
> > close to the big table explaining all this mayhem.
> 
> Sure you need to play with the the 'real' channels to put voltages on the
> right ones etc.  This is special purpose hardware though so what I was
> suggesting was to create 'virtual' channels associated with each axis.

Whew!

> These would then effectively do exactly what you are doing here in that
> a 3 numbers would be generated to push on to input.  It'd just be a little
> less direct.... I'm not particularly sure it's a good idea, but it could
> be done ;)

See my previous email, maybe you can get one of those MX233 each-boards and 
connect some touchscreen to it ? It will provide you with insane controller and 
lot of fun for xmas ;-)

> >> Then we could
> >> have a go at having a generic touch screen driver acting as an IIO
> >> consumer? (the interrupt driven IIO consumer stuff should be going in in
> >> the comming merge window, but the example input driver didn't get
> >> cleaned up in time.)
> > 
> > That'd be very nice indeed. But as I said above, you'd need to add
> > ability to control ADC channels so you can configure them as voltage
> > outputs. That'd be fine, but I need to do such configuration thrice in
> > one TS sampling cycle (I need to configure the TS for sampling X-axis,
> > Y-axis and pressure). Add the overhead of reading the ADC channels via
> > some interface instead of being able to directly trigger them. I'd hate
> > to have laggy touchscreen pointer or my system spending too much time in
> > kernel -- the kthread that samples the touchscreen already does consume
> > some power.
> 
> Yes there would indeed be some overhead and clearly you have some very
> tight requirements here.  It might be possible to do this with a low
> enough overhead, I'm really not sure without trying it!
> 
> > Also please consider the device with this LRADC is a 450MHz ARM system,
> > so it has not much processing muscle.
> > 
> > Besides (inbound rant), I suspect all this would add even more complexity
> > to this already complex IIO stuff.
> :
> :)

Sorry ;-)

> >> The tricks in here with switching from interrupt triggered to polled is
> >> a little nasty but I'll take your word for it that it is necessary!
> > 
> > Let's bury this topic please, I'm still shedding bloody tears ... I spent
> > two days trying to figure this part out. The hardware is nasty, period.
> 
> You have my sympathy.  Sometimes these hardware guys do seem to get carried
> away :)

They went all out here :(

> >> As you have it sitting on a different delay channel you'd have to have
> >> these 'magic channels' as a separate IIO device anyway.  The scan
> >> would then include all the magic channels.
> > 
> > I got lost here. But anyway, this whole device behaves as a single IIO
> > device so far providing only the ADCs, yes.
> 
> Sure.  If you did do the 'virtual' channel for each axis things suggested
> above, it would be triggered separately from the adc channels.  As we have
> only one trigger (and triggered scan setup) per IIO device, this would
> require a pair of them.

This took me a bit to gurk down ;-)

> >> Hmm.  I'm not sure of the best way to handle this so fully
> >> open to suggestions!
> > 
> > I'm all ears as well. On the other hand, I'd love to have some sort of
> > this implementation in 3.8 (is that even possible anymore?).
> 
> Sadly no chance for 3.8 at this stage.  Couple of weeks too late now.

Ah ok. It's be nice though, it's not any critical part of kernel too.

> >> In some ways perhaps it is better to conclude
> >> these channels are so touch screen specific (when the hardware is
> >> enabled) that it's better to do as you have done here.
> > 
> > The idea sounds really good, I'm only afraid it's too much work with too
> > little gain. And the overhead of this sollution is a bit worrying as
> > well.
> 
> Agreed. The overhead may be a problem particularly if we involve triggers
> (which would require interrupt handling etc).  Might be possible to work
> without them here, but that would be fiddly.

That reminds me of the ACPI ALS thing. Yep.

> > NOTE: I'm a lazy bastard <--- does that count as a valid reason for not
> > implementing it this way ? ;-)
> 
> It is certainly a reason ;)

Hehe :)

> I only really brought this suggestion up as it is roughly I'd 'like'
> to see touch screens handled.  I have no issue with other solutions but
> want to keep options open and if we were to change this over to something
> close to what I suggest we would have an interesting issue as suddenly a
> whole load more platform data would be needed (to tie the more generic
> IIO bit to a touchscreen consumer driver).

Yes, I agree with your point.

> Anyhow, curriously enough none of my test boards have a screen let
> alone a touch one so I'm hardly experienced in this area and so before
> I merge this I would like some comments from the input side of things
> (and an ACK from Dmitry).
> 
> At least we have plenty of time before 3.9!
[...]

Thanks for the review and discussion! I'll send V2 as soon as I'm back home to 
test the adjustments!
