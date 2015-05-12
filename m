From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: keyboad: imx: add snvs power key driver
Date: Tue, 12 May 2015 14:21:26 -0700
Message-ID: <20150512212126.GG20725@dtor-ws>
References: <1431449438-19460-1-git-send-email-Frank.Li@freescale.com>
 <1431449438-19460-2-git-send-email-Frank.Li@freescale.com>
 <20150512184328.GC20725@dtor-ws>
 <CAHrpEqQpyO=Fzu206xPUwQE+cvk7rpTd0r0A_bL-V1UWgT7+XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38838 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933135AbbELVVa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2015 17:21:30 -0400
Received: by igbhj9 with SMTP id hj9so27409644igb.1
        for <linux-input@vger.kernel.org>; Tue, 12 May 2015 14:21:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHrpEqQpyO=Fzu206xPUwQE+cvk7rpTd0r0A_bL-V1UWgT7+XA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhi Li <lznuaa@gmail.com>
Cc: "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Robin Gong <b38343@freescale.com>

On Tue, May 12, 2015 at 03:37:41PM -0500, Zhi Li wrote:
> >> +             ret = devm_request_irq(&pdev->dev, pdata->irq,
> >> +                                     imx_snvs_pwrkey_interrupt,
> >> +                                     IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, pdev->name, pdev);
> >
> > Why IRQF_NO_SUSPEND? Also should we not get trigger type from OF data?
> >
> wake up by PWRON key in freeze mode

enable_irq_wake() should adjust the handler as needed, the driver should
request flags that are needed for it's own operations.

> 
> Do you have any example to get trigger type from OF data?

You can retrieve the flags via irqd_get_trigger_type() for example, but
you do not need to do that, because OF code will set up interrupt
properly (based on DTS) when creating the corresponsing platform device
(see of_irq_parse_and_map). so you just need to do:

	ret = devm_request_irq(&pdev->dev, pdata->irq,
			       imx_snvs_pwrkey_interrupt,
			       0, pdev->name, pdev);

Thanks.

-- 
Dmitry
