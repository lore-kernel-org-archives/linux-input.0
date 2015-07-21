From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH V2 3/3] rtc: da9063: Add DA9062 RTC capability to DA9063
 RTC driver
Date: Tue, 21 Jul 2015 12:01:51 +0200
Message-ID: <20150721100151.GC2853@piout.net>
References: <cover.1437471790.git.stwiss.opensource@diasemi.com>
 <93f0906ed7db18b893385b60a43b02f248dfe9a6.1437471790.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48128 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752791AbbGUKBy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 06:01:54 -0400
Content-Disposition: inline
In-Reply-To: <93f0906ed7db18b893385b60a43b02f248dfe9a6.1437471790.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, David Dajun Chen <david.chen@diasemi.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>

Hi Steve,

it looks mostly good, a few more comments:

On 21/07/2015 at 10:43:10 +0100, S Twiss wrote :
> -	if (val & (DA9063_E_ALARM))
> +	if (val & (config->rtc_event_alarm_mask))
unneeded parenthesis here

> +	if (of_device_is_compatible(pdev->dev.of_node, "dlg,da9063-rtc")) {
> +		struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);
> +
> +		if (chip->variant_code == PMIC_DA9063_AD)
> +			rtc->config = &da9063_ad_regs;
> +	} else
> +		rtc->config = match->data;

Both arms of the if should use braces.

Also, what happens if it is a da9063, BB variant? I guess rtc->config
will not be set.

maybe you should write:

rtc->config = match->data;
if (of_device_is_compatible(pdev->dev.of_node, "dlg,da9063-rtc")) {
     struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);

     if (chip->variant_code == PMIC_DA9063_AD)
         rtc->config = &da9063_ad_regs;
}


> @@ -348,5 +515,5 @@ module_platform_driver(da9063_rtc_driver);
>  
>  MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
>  MODULE_DESCRIPTION("Real time clock device driver for Dialog DA9063");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");

This should be part of the license change.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
