From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
Date: Mon, 18 May 2015 14:15:01 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22B8C8@SW-EX-MBX02.diasemi.com>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com>
 <55555639.8090505@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
 <5555ED4F.5070003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B6E2@SW-EX-MBX02.diasemi.com>
 <20150515202005.GA23133@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150515202005.GA23133@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On 15 May 2015 21:20 Guenter Roeck,

> > > > +
> > > > +/* E_WDG_WARN interrupt handler */
> > > > +static irqreturn_t da9062_wdt_wdg_warn_irq_handler(int irq, void*data)
> > > > +{
> > > > +	struct da9062_watchdog *wdt = data;
> > > > +
> > > > +	dev_notice(wdt->hw->dev, "Watchdog timeout warning trigger.\n");
> > > > +	return IRQ_HANDLED;
> > > > +}
> > > > +
> >
> > On 15 May 2015 13:58 Guenter Roeck wrote:
> >
> >  [...]
> >
> > > >>> +
> > > >>> +	irq = platform_get_irq_byname(pdev, "WDG_WARN");
> > > >>> +	if (irq < 0) {
> > > >>> +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
> > > >>> +		ret = irq;
> > > >>> +		goto error;
> >
> > [...]
> >
> > > >
> > > >> Also, is the interrupt mandatory ? All it does is to display a message.
> > > >> Looks very optional to me.
> > > >
> > > > It is a place holder for something more application specific.
> > > > I could remove it, but I figured it would just get re-added when somebody takes the
> > > > driver and modifies it for their needs.
> > > >
> > > > If this is a problem however, it can go.
> > > > Please advise ..
> > > >
> > >
> > > Then this someone should add the code. For the time being, it just increases
> > > kernel size and may cause the driver to fail for no good reason. Plus, given
> > > the driver apparently works without interrupt, even then it should be
> > > optional, and the driver does not have to fail loading if it is not supported on a
> > > given platform.
> > >
> >
> > Hi Guenter,
> >
> > I'm not sure if I got my previous point across there ...
> >
> > Leaving this in wouldn't really do any real harm I think. If this feature is not supported
> > in somebody's platform then there wouldn't be a problem, the IRQ would fire (as a
> > warning that the watchdog was about to time-out), the handler function would be
> > executed, it would handle the IRQ -- and that would be it. Nothing would happen apart
> > from a debug print.
> 
> I didn't get my point across either. Problem is that your driver fails to load
> if the interrupt is not there. With the interrupt really being optional, I don't
> see the point in making it mandatory just to display a message if it fires.
> 

Hi Guenter,

Ok. I see now. 

It's not a mandatory interrupt and so it should not fail the whole driver upon an error from
the devm_request_threaded_irq() request ... I will let it pass through if there is a problem and
just display a debug message. Something like this:

@@ -234,11 +234,9 @@ static int da9062_wdt_probe(struct platform_device *pdev)
                           da9062_wdt_wdg_warn_irq_handler,
                            IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
                           "WDG_WARN", wdt);
-       if (ret) {
-               dev_err(wdt->hw->dev,
+       if (ret)
+               dev_dbg(wdt->hw->dev,
                        "Failed to request watchdog device IRQ.\n");
-               return ret;
-       }
 
        ret = watchdog_register_device(&wdt->wdtdev);
        if (ret < 0) {


I think I've understood now. I guess this is it..
I'll send a PATCH V3 with this change.

Regards,
Steve
