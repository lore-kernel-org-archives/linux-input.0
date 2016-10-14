From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 05/10] thermal: da9062/61: Thermal junction
 temperature monitoring driver
Date: Fri, 14 Oct 2016 13:07:59 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE3443@SW-EX-MBX02.diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <b5ce58ca00f7ab30a025d24083549241f135b0e9.1475743411.git.stwiss.opensource@diasemi.com>
 <3bc9fd76-2885-b07a-9df8-7802b7535da2@ti.com>
 <6ED8E3B22081A4459DAC7699F3695FB7018CCE2815@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CCE2815@SW-EX-MBX02.diasemi.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

An update.

On: 07 October 2016 18:49, Steve Twiss wrote:
> On 07 October 2016 06:29, Keerthy [mailto:a0393675@ti.com] wrote:
> > On Thursday 06 October 2016 02:13 PM, Steve Twiss wrote:
> > > From: Steve Twiss <stwiss.opensource@diasemi.com>
[...]
> > > +static const struct da9062_thermal_config da9062_config = {
> > > +	.name = "da9062-thermal",
> > > +};
> > > +
> > > +static const struct da9062_thermal_config da9061_config = {
> > > +	.name = "da9061-thermal",
> > > +};
> > > +
> > > +static const struct of_device_id da9062_compatible_reg_id_table[] = {
> > > +	{ .compatible = "dlg,da9062-thermal", .data = &da9062_config },
> > > +	{ .compatible = "dlg,da9061-thermal", .data = &da9061_config },
> >
> > Two separate compatible values. Do you have anything different apart
> > from the name? Why use 2 compatibles when there is absolutely no
> > difference?
> 
> Yes.
> This was a comment for the watchdog device driver as well. My concern was having
> multiple devices (61 and 62) in the same system -- and allowing the driver to report
> the hardware difference.
> 
> There is discussion going on about this in other threads. Not certain of the
> final outcome yet, apart from my existing proposal should be changed.

An answer to this came from comments by Dmitry Torokhov and Guenter Roeck, who
suggested this: https://lkml.org/lkml/2016/10/7/641

I will take a look at this for V2.

Regards,
Steve
