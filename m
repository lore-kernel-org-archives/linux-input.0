From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH V1 04/10] watchdog: da9061: watchdog driver (RFC)
Date: Thu, 6 Oct 2016 16:28:14 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE242C@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Zhang Rui <rui.zhang@intel.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Guenter,

Thanks for your reply.

On 06 October 2016 14:28, Guenter Roeck, wrote:

> To: Steve Twiss; LINUX-KERNEL; LINUX-WATCHDOG; Wim Van Sebroeck
> Subject: Re: [PATCH V1 04/10] watchdog: da9061: watchdog driver

[...]

> > @@ -180,6 +180,11 @@ static const struct watchdog_info da9062_watchdog_info = {
> >  	.identity = "DA9062 WDT",
> >  };
> >
> > +static const struct watchdog_info da9061_watchdog_info = {
> > +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> > +	.identity = "DA9061 WDT",
> 
> This adds a lot of complexity to the driver just to be able to display "DA9061".
> Why not just change the existing identity to "DA9061/DA9062 WDT" ?

This is true.
I am using the compatible string to pick a different configuration .data block:

{ .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
{ .compatible = "dlg,da9061-watchdog", .data = &da9061_watchdog_info },

when the only real difference between the DA9061 and DA9062 watchdog driver
is the name. Functionally they are identical in this case.
This was a similar comment in Dialog's internal review on this exact same point.
"Why not just report one thing?"

My answer to that was because it would allow to distinguish between different chips.
The watchdog driver would report the correct chip type, despite the driver always
being for DA9062.

This exact same thing would happen with da9063-onkey and da9062-thermal also.
For the ONKEY it is marginally confused by needing to support 63, but for 62 and 61
it is the same thing. Only the name is different.

I have TO:'d Dmitry Torokhov; Eduardo Valentin; Zhang Rui, for that reason.

But, it is just my opinion to keep the "name" different.
This will not be my decision if accepted into the Linux kernel, but I would like to 
at least be consistent for DA9061 and DA9062 so ... is this an issue?

The same question applies to thermal and onkey as well.

Regards,
Steve
