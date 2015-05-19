From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [rtc-linux] [PATCH V2 1/4] mfd: da9062: DA9062 MFD core driver
Date: Tue, 19 May 2015 08:34:45 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22B961@SW-EX-MBX02.diasemi.com>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <af5a7d289bb149e9111ebc70bb0589a994ee2407.1431621833.git.stwiss.opensource@diasemi.com>
 <20150516085328.GI3338@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150516085328.GI3338-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 16 May 2015 09:53 Alexandre Belloni wrote:

Hi Alexandre,

> On 14/05/2015 at 17:43:52 +0100, S Twiss wrote :

[...]

> > +	{
> > +		.name		= "da9062-watchdog",
> > +		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
> > +		.resources	= da9062_wdt_resources,
> > +		.of_compatible  = "dlg,da9062-wdt",
> > +	},
> > +	{
> > +		.name		= "da9062-onkey",
> > +		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
> > +		.resources	= da9062_onkey_resources,
> > +		.of_compatible  = "dlg,da9062-onkey",
> > +	},
> > +	{
> > +		.name		= "da9062-thermal",
> > +		.num_resources	= ARRAY_SIZE(da9062_thermal_resources),
> > +		.resources	= da9062_thermal_resources,
> > +		.of_compatible  = "dlg,da9062-thermal",
> > +	},
> > +	{
> > +		.name		= "da9062-rtc",
> > +		.num_resources	= ARRAY_SIZE(da9062_rtc_resources),
> > +		.resources	= da9062_rtc_resources,
> > +		.of_compatible  = "dlg,da9062-rtc",
> 
> Did you try to use "da9063-rtc"? The register set seems to be exactly
> the same. Unfortunately, the datasheet are not available on the diasemi
> website...

I will remove the DA9062 OnKey and RTC parts with a view to putting them back
when I do the work for the DA9063 alterations.

> Also, the .of_compatibles are not necessary because you don't add any of
> bindings to the underlying drivers. The match happens on .name.
> 
> > diff --git a/include/linux/mfd/da9062/registers.h
> b/include/linux/mfd/da9062/registers.h
> > new file mode 100644
> > index 0000000..d07c2bc
> > --- /dev/null
> > +++ b/include/linux/mfd/da9062/registers.h
> 
> Comparing that file with da9063/registers.h, It really seems that
> DA062AA, DA9063AD and DA9063BB are register compatible, apart from a
> few
> differences in the regulator and the gpio count.
> 
> Also, at least the watchdog and rtc driver are duplicating their da9063
> counterpart. I'm not trying to annoy you, I just want you to understand
> that the less code is duplicated, the easiest it will be to maintain
> later.

This has come up a lot lately.

https://lkml.org/lkml/2015/4/24/304
https://lkml.org/lkml/2015/5/13/383
https://lkml.org/lkml/2015/5/6/505
https://lkml.org/lkml/2015/5/18/511

The short answer is that the DA9062 and DA9063 chips are not identical. Although
their numbers are sequential and there are functional similarities for some of the
components, this is not the norm for the two chips.

In some cases re-using driver components from DA9063 is a good way forward, but
making all components part of a monolithic driver would make both DA9062 and
DA9063 over complicated and unmaintainable -- in my opinion.

However it's not just my opinion we have to consider here I think.

The RTC and OnKey in this case can be done fairly easily I think -- there can be some
re-use in those components -- although there are fairly important RTC differences between
the DA9063 AD and DA9063 BB silicon revisions (in the form of a new register, different
functionality in the alarm and a register shift). So even that is not a straight-forward
"swap" to run DA9062.

Regards,
Steve

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
