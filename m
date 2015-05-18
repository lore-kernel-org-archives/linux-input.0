From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
Date: Mon, 18 May 2015 16:03:06 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22B8FE@SW-EX-MBX02.diasemi.com>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com>
 <55555639.8090505@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
 <5555ED4F.5070003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B6E2@SW-EX-MBX02.diasemi.com>
 <20150515202005.GA23133@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B8C8@SW-EX-MBX02.diasemi.com>
 <20150518152737.GA14403@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.137]:46740 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932131AbbERQDR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2015 12:03:17 -0400
In-Reply-To: <20150518152737.GA14403@roeck-us.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>


On 18 May 2015 16:28 Guenter Roeck wrote:

> On Mon, May 18, 2015 at 02:15:01PM +0000, Opensource [Steve Twiss]
> wrote:
> > On 15 May 2015 21:20 Guenter Roeck,
> >
> > > > > > +
> > > > > > +/* E_WDG_WARN interrupt handler */
> > > > > > +static irqreturn_t da9062_wdt_wdg_warn_irq_handler(int irq, void*data)
> > > > > > +{
> > > > > > +	struct da9062_watchdog *wdt = data;
> > > > > > +
> > > > > > +	dev_notice(wdt->hw->dev, "Watchdog timeout warning trigger.\n");
> > > > > > +	return IRQ_HANDLED;
> > > > > > +}
> > > > > > +
> > > >
> > > > On 15 May 2015 13:58 Guenter Roeck wrote:
> > > >
> > > >  [...]
> > > >
> > > > > >>> +
> > > > > >>> +	irq = platform_get_irq_byname(pdev, "WDG_WARN");
> > > > > >>> +	if (irq < 0) {
> > > > > >>> +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
> > > > > >>> +		ret = irq;
> 
> Hi Steve,

Hi Guenter,

> Since the interrupt is optional, the driver should also not fail to load
> if no interrupt is assigned to it in the first place.

Yeah. I've been thinking about it and I agree now. I'll erase the handler. 

> On a separate note, there was a comment stating that the da9062 watchdog
> is identical to the da9063 watchdog. If so, why can't you just use the da9063
> watchdog driver ?

Well, the short answer to this is, it's not the same. I was just in the process of
replying to that other thread. The OnKey and RTC are functionally similar, so I
am going to look at integrating the two drivers in some future patch sets, but
the watchdog is definitely not based upon DA9063.

I did mention this in a previous thread: 
https://lkml.org/lkml/2015/5/6/505

Regards,
Steve
