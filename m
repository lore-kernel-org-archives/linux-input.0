From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH RFC V1 2/3] rtc: da9063: Add DA9062 RTC capability to
 DA9063 RTC driver
Date: Mon, 20 Jul 2015 17:57:50 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B253DC9@SW-EX-MBX02.diasemi.com>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
 <e2de6b382e8e81b40c0eb466f7b19364c13ba5a9.1436427954.git.stwiss.opensource@diasemi.com>
 <20150717234525.GI3487@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150717234525.GI3487@piout.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Lee Jones <lee.jones@linaro.org>, DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, David Dajun Chen <david.chen@diasemi.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On 18 July 2015 00:45, Alexandre Belloni wrote:

> On 09/07/2015 at 08:45:53 +0100, S Twiss wrote :
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > Add DA9062 RTC support into the existing DA9063 RTC driver component by
> > using generic access tables for common register and bit mask definitions.
> >
> > The following change will add generic register and bit mask support to the
> > DA9063 RTC. The changes are slightly complicated by requiring support for
> > three register sets: DA9063-AD, DA9063-BB and DA9062-AA.
> >
> > The following alterations have been made to the DA9063 RTC:

[...]

> > - Addition of a re-try when reading the RTC inside da9063_rtc_read_time()
> 
> Can you separate that change in another patch as it is a change in the
> behaviour of the driver? And maybe give a word or two on why this is
> needed.

Sure.

I will separate this into a new patch and add it at a later date. It is a recommendation
to have this in for both DA9062/3 now, although I have not seen this happen during
my testing -- it should be added.
Something similar happened with the RTC previously -- everything tested fine 
with earlier kernels until the RTC core functions were improved and I picked up a
synchronisation problem with my testing:

http://lxr.free-electrons.com/source/drivers/rtc/rtc-da9063.c#L129

[...]

> > Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
> >  Kconfig                   total: 0 errors, 15 warnings, 1600 lines checked
> >  rtc-da9063.c              total: 0 errors, 0 warnings, 531 lines checked
> 
> This is not true, there is a warning:
> WARNING: DT compatible string "dlg,da9062-rtc" appears un-documented
> -- check /home/alex/M/linux/Documentation/devicetree/bindings/
> #275: FILE: drivers/rtc/rtc-da9063.c:171:
> +     { .compatible = "dlg,da9062-rtc", .data = &da9062_aa_regs },
> 
> patch 3/3 should come before 2/3 if you want to avoid that.

I will re-order the patches accordingly.

[...]

> > diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
> > index 7ffc570..e94fb6d 100644
> > --- a/drivers/rtc/rtc-da9063.c
> > +++ b/drivers/rtc/rtc-da9063.c
> > @@ -1,127 +1,274 @@
> > -/* rtc-da9063.c - Real time clock device driver for DA9063
> > - * Copyright (C) 2013-14  Dialog Semiconductor Ltd.
> > +/*
> > + * Real time clock device driver for DA9063/DA9062
> > + * Copyright (C) 2013-15  Dialog Semiconductor Ltd.
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Library General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
> >   *
> > - * This library is distributed in the hope that it will be useful,
> > + * This program is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Library General Public License for more details.
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> >   */
> >
> 
> Please also list that license change in the commit log. It should also
> probably be separated in another patch.
> 

I can add this to a different patch and change it at a later date.
It is to fix a minor wording problem with the GPL header so it matches the correct
MODULE_LICENSE(""); macro. 

https://lkml.org/lkml/2015/4/18/19

The info at the top of the file needs to remove the LGPL worded text where appropriate:
words such as "Library" from the line "GNU Library General Public License"; and replace
the word "library" with "program" in several places

> [...]
> 
> >  static int da9063_rtc_probe(struct platform_device *pdev)
> >  {
> > -	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
> > -	struct da9063_rtc *rtc;
> > +	struct da9063_compatible_rtc *rtc;
> > +	const struct da9063_compatible_rtc_regmap *config;
> > +	const struct of_device_id *match;
> >  	int irq_alarm;
> >  	u8 data[RTC_DATA_LEN];
> >  	int ret;
> >
> > -	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_E,
> > -				 DA9063_RTC_EN, DA9063_RTC_EN);
> > +	match = of_match_node(da9063_compatible_reg_id_table,
> > +			      pdev->dev.of_node);
> > +	if (!match)
> 
> This will never happen if you are only probed from DT and this is waht
> you expect now.

Yes, I will change this.

> > +		return -ENXIO;
> > +
> > +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> > +	if (!rtc)
> > +		return -ENOMEM;
> > +
> > +	if (strncmp(match->name, "dlg,da9063-rtc", 14) == 0) {
> 
> You must not do that.
> You should add a new compatible and change the of_compatible string of
> the mfd_cell in drivers/mfd/da9063-core.c onc you know the variant.

I can check for a binary comparison against the address of the 
static const struct of_device_id da9063_compatible_reg_id_table[] = {}
entry for DA9063.

The DA9063 driver already associates "dlg,da9063-rtc" with both BB and AD
register maps. I think that altering the string at this point would break backwards
compatibility in the device tree for the DA9063.

The DA9063 core dynamically checks for the chip variant at run-time and then saves
it in the "variant_code". This comes from the original submission of the driver.
Distinguishing DT compatible strings was suggested, but the method conflicted with the
automatic variant detection of the DA9063 chip, and so it was decided against.

https://lkml.org/lkml/2015/1/19/144

[...]

Regards,
Steve
