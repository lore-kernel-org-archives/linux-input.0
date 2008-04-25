From: Justin Waters <justin.waters@timesys.com>
Subject: Re: [PATCH 1/2] atmel_tsadcc: Device driver for AT91SAM9RL
	Touchscreen
Date: Fri, 25 Apr 2008 17:37:33 -0400
Message-ID: <1209159453.6990.48.camel@justin-linux>
References: <1209149798-20418-1-git-send-email-justin.waters@timesys.com>
	 <1209149798-20418-2-git-send-email-justin.waters@timesys.com>
	 <20080425211041.GC28497@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exchange07.timesys.com ([209.114.137.35]:34484 "EHLO
	exchange07.timesys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933050AbYDYVhj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 17:37:39 -0400
In-Reply-To: <20080425211041.GC28497@flint.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux@maxim.org.za" <linux@maxim.org.za>

Thank you for the comments.  I've inlined responses below:

On Fri, 2008-04-25 at 17:10 -0400, Russell King - ARM Linux wrote:
> > +config TOUCHSCREEN_ATMEL_TSADCC
> > +     tristate "Atmel Touchscreen Interface"
> 
> No dependencies.  So does this mean this'll build and link on an
> x86 platform?
> 
I was actually thinking that this IP will end up on an AVR32 platform as
well, so I intentionally tried to avoid making the driver too ARM
specific.  However, I definitely see the point of specifying
ARCH_AT91SAM9RL and worrying about adding additional support for new
platforms later, so I'll add that in.

> > +/* These values are dependent upon the performance of the ADC.  Ideally,
> > + * These should be as close to the startup time and debounce time as
> > + * possible (without going over).  These assume an optimally setup ADC as
> > + * per the electrical characteristics of the AT91SAM9RL tsadcc module
> > + */
> > +#define TS_POLL_DELAY   (1 * 1000000)   /* ns delay before the first sample */
> > +#define TS_POLL_PERIOD  (5 * 1000000)   /* ns delay between samples */
> 
> So 1ms and 5ms...  Not particularly high resolution...
> 
> > +static enum hrtimer_restart atmel_tsadcc_timer(struct hrtimer *handle)
> 
> So this uses the highres timer infrastructure.  Does this build if
> CONFIG_HIGH_RES_TIMERS is not set?
> 
Thank you for catching this.  I'll definitely revisit this.  Since HRT
support is not mainline for the SAM9 platforms, I'm going to remove all
references to it and worry about high resolution timer support at a
later time.

> > +     /* Remap Register Memory */
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     ts->reg_start = res->start;
> > +     ts->reg_length = res->end - res->start +1;
> 
> So if no memory resources were passed, this oopses.
Ouch, sorry about that.  I'll get a check in there.

I'll also take care of the whitespace issues and #defines as well.

-Justin Waters

