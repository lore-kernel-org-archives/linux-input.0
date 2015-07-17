From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH RFC V1 2/3] rtc: da9063: Add DA9062 RTC capability to
 DA9063 RTC driver
Date: Sat, 18 Jul 2015 01:45:25 +0200
Message-ID: <20150717234525.GI3487@piout.net>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
 <e2de6b382e8e81b40c0eb466f7b19364c13ba5a9.1436427954.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e2de6b382e8e81b40c0eb466f7b19364c13ba5a9.1436427954.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, David Dajun Chen <david.chen@diasemi.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

Hi,

On 09/07/2015 at 08:45:53 +0100, S Twiss wrote :
> From: S Twiss <stwiss.opensource@diasemi.com>
> 
> Add DA9062 RTC support into the existing DA9063 RTC driver component by
> using generic access tables for common register and bit mask definitions.
> 
> The following change will add generic register and bit mask support to the
> DA9063 RTC. The changes are slightly complicated by requiring support for
> three register sets: DA9063-AD, DA9063-BB and DA9062-AA.
> 
> The following alterations have been made to the DA9063 RTC:
> 
> - Addition of a da9063_compatible_rtc_regmap structure to hold all generic
>   registers and bitmasks for this type of RTC component.
> - A re-write of struct da9063 to use pointers for regmap and compatible
>   registers/masks definitions
> - Addition of a of_device_id table for DA9063 and DA9062 defaults
> - Refactoring functions to use struct da9063_compatible_rtc accesses to
>   generic registers/masks instead of using defines from registers.h
> - Addition of a re-try when reading the RTC inside da9063_rtc_read_time()

Can you separate that change in another patch as it is a change in the
behaviour of the driver? And maybe give a word or two on why this is
needed.

> - Re-work of da9063_rtc_probe() to use of_match_node() and dev_get_regmap()
>   to provide initialisation of generic registers and masks and access to
>   regmap
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
>  Kconfig                   total: 0 errors, 15 warnings, 1600 lines checked
>  rtc-da9063.c              total: 0 errors, 0 warnings, 531 lines checked

This is not true, there is a warning:
WARNING: DT compatible string "dlg,da9062-rtc" appears un-documented
-- check /home/alex/M/linux/Documentation/devicetree/bindings/
#275: FILE: drivers/rtc/rtc-da9063.c:171:
+     { .compatible = "dlg,da9062-rtc", .data = &da9062_aa_regs },

patch 3/3 should come before 2/3 if you want to avoid that.

> diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
> index 7ffc570..e94fb6d 100644
> --- a/drivers/rtc/rtc-da9063.c
> +++ b/drivers/rtc/rtc-da9063.c
> @@ -1,127 +1,274 @@
> -/* rtc-da9063.c - Real time clock device driver for DA9063
> - * Copyright (C) 2013-14  Dialog Semiconductor Ltd.
> +/*
> + * Real time clock device driver for DA9063/DA9062
> + * Copyright (C) 2013-15  Dialog Semiconductor Ltd.
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Library General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Library General Public License for more details.
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   */
>  

Please also list that license change in the commit log. It should also
probably be separated in another patch.

[...]

>  static int da9063_rtc_probe(struct platform_device *pdev)
>  {
> -	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
> -	struct da9063_rtc *rtc;
> +	struct da9063_compatible_rtc *rtc;
> +	const struct da9063_compatible_rtc_regmap *config;
> +	const struct of_device_id *match;
>  	int irq_alarm;
>  	u8 data[RTC_DATA_LEN];
>  	int ret;
>  
> -	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_E,
> -				 DA9063_RTC_EN, DA9063_RTC_EN);
> +	match = of_match_node(da9063_compatible_reg_id_table,
> +			      pdev->dev.of_node);
> +	if (!match)

This will never happen if you are only probed from DT and this is waht
you expect now.

> +		return -ENXIO;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	if (strncmp(match->name, "dlg,da9063-rtc", 14) == 0) {

You must not do that.

You should add a new compatible and change the of_compatible string of
the mfd_cell in drivers/mfd/da9063-core.c onc you know the variant.

> +		struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);
> +
> +		if (chip->variant_code == PMIC_DA9063_AD)
> +			rtc->config = &da9063_ad_regs;
> +	} else
> +		rtc->config = match->data;


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
