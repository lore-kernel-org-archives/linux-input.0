From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
Date: Fri, 15 May 2015 13:20:05 -0700
Message-ID: <20150515202005.GA23133@roeck-us.net>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com>
 <55555639.8090505@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
 <5555ED4F.5070003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B6E2@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37633 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934056AbbEOUUO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 16:20:14 -0400
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B22B6E2@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>

On Fri, May 15, 2015 at 03:35:50PM +0000, Opensource [Steve Twiss] wrote:
> 
> > > +
> > > +/* E_WDG_WARN interrupt handler */
> > > +static irqreturn_t da9062_wdt_wdg_warn_irq_handler(int irq, void *data)
> > > +{
> > > +	struct da9062_watchdog *wdt = data;
> > > +
> > > +	dev_notice(wdt->hw->dev, "Watchdog timeout warning trigger.\n");
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> 
> On 15 May 2015 13:58 Guenter Roeck wrote:
> 
>  [...]
>  
> > >>> +
> > >>> +	irq = platform_get_irq_byname(pdev, "WDG_WARN");
> > >>> +	if (irq < 0) {
> > >>> +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
> > >>> +		ret = irq;
> > >>> +		goto error;
> 
> [...]
> 
> > >
> > >> Also, is the interrupt mandatory ? All it does is to display a message.
> > >> Looks very optional to me.
> > >
> > > It is a place holder for something more application specific.
> > > I could remove it, but I figured it would just get re-added when somebody takes the
> > > driver and modifies it for their needs.
> > >
> > > If this is a problem however, it can go.
> > > Please advise ..
> > >
> > 
> > Then this someone should add the code. For the time being, it just increases
> > kernel size and may cause the driver to fail for no good reason. Plus, given
> > the driver apparently works without interrupt, even then it should be
> > optional, and the driver does not have to fail loading if it is not supported on a
> > given platform.
> > 
> 
> Hi Guenter,
> 
> I'm not sure if I got my previous point across there ...
> 
> Leaving this in wouldn't really do any real harm I think. If this feature is not supported
> in somebody's platform then there wouldn't be a problem, the IRQ would fire (as a
> warning that the watchdog was about to time-out), the handler function would be
> executed, it would handle the IRQ -- and that would be it. Nothing would happen apart
> from a debug print.

I didn't get my point across either. Problem is that your driver fails to load
if the interrupt is not there. With the interrupt really being optional, I don't
see the point in making it mandatory just to display a message if it fires.

> 
> There are already examples of this in the kernel, I've not looked very hard ...
> http://lxr.free-electrons.com/source/drivers/mfd/qcom_rpm.c#L412
> http://lxr.free-electrons.com/source/drivers/mfd/arizona-irq.c#L72
> 

Never a good argument to make with me. 100 people doing something wrong
doesn't mean you should continue to do so.

Guenter
