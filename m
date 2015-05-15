From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
Date: Fri, 15 May 2015 15:35:50 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22B6E2@SW-EX-MBX02.diasemi.com>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com>
 <55555639.8090505@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
 <5555ED4F.5070003@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5555ED4F.5070003-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


> > +
> > +/* E_WDG_WARN interrupt handler */
> > +static irqreturn_t da9062_wdt_wdg_warn_irq_handler(int irq, void *data)
> > +{
> > +	struct da9062_watchdog *wdt = data;
> > +
> > +	dev_notice(wdt->hw->dev, "Watchdog timeout warning trigger.\n");
> > +	return IRQ_HANDLED;
> > +}
> > +

On 15 May 2015 13:58 Guenter Roeck wrote:

 [...]
 
> >>> +
> >>> +	irq = platform_get_irq_byname(pdev, "WDG_WARN");
> >>> +	if (irq < 0) {
> >>> +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
> >>> +		ret = irq;
> >>> +		goto error;

[...]

> >
> >> Also, is the interrupt mandatory ? All it does is to display a message.
> >> Looks very optional to me.
> >
> > It is a place holder for something more application specific.
> > I could remove it, but I figured it would just get re-added when somebody takes the
> > driver and modifies it for their needs.
> >
> > If this is a problem however, it can go.
> > Please advise ..
> >
> 
> Then this someone should add the code. For the time being, it just increases
> kernel size and may cause the driver to fail for no good reason. Plus, given
> the driver apparently works without interrupt, even then it should be
> optional, and the driver does not have to fail loading if it is not supported on a
> given platform.
> 

Hi Guenter,

I'm not sure if I got my previous point across there ...

Leaving this in wouldn't really do any real harm I think. If this feature is not supported
in somebody's platform then there wouldn't be a problem, the IRQ would fire (as a
warning that the watchdog was about to time-out), the handler function would be
executed, it would handle the IRQ -- and that would be it. Nothing would happen apart
from a debug print.

There are already examples of this in the kernel, I've not looked very hard ...
http://lxr.free-electrons.com/source/drivers/mfd/qcom_rpm.c#L412
http://lxr.free-electrons.com/source/drivers/mfd/arizona-irq.c#L72

The problem with removing it is, I am depreciating the functionality of the chip.
Unless there is a really good reason -- I would like to leave this part in please.
If I was to take this part out then there could be an argument to remove WDG_WARN
from the resource of the MFD -- but that would then hide this watchdog warning
functionality completely.

The function da9062_wdt_wdg_warn_irq_handler() is blank -- and it just does nothing
apart from handle the IRQ. But it is an important feature of the chip .. say for a developer
to add in their product code to send a uevent into userspace to trigger a watchdog kick
(for instance).. but that part is very specific and usually only part of a final system
integration. I've just left the function as a stub for that reason.

There is the possibility that the function platform_get_irq_byname() could fail
but that would mean an different type of critical failure.

Regards,
Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
