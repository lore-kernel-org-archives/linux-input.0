From: Zhi Li <lznuaa@gmail.com>
Subject: Re: [PATCH 2/3] input: keyboad: imx: add snvs power key driver
Date: Wed, 13 May 2015 09:35:09 -0500
Message-ID: <CAHrpEqRJfRq0Y_1Xd5r9KvNut6H_4RGOkWZvo=78_iwhNY0qvg@mail.gmail.com>
References: <1431449438-19460-1-git-send-email-Frank.Li@freescale.com>
	<1431449438-19460-2-git-send-email-Frank.Li@freescale.com>
	<20150512184328.GC20725@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33395 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933344AbbEMOfJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 10:35:09 -0400
Received: by oica37 with SMTP id a37so32640913oic.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2015 07:35:09 -0700 (PDT)
In-Reply-To: <20150512184328.GC20725@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Robin Gong <b38343@freescale.com>

>> +static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
>> +{
>> +     struct platform_device *pdev = dev_id;
>> +     struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
>> +     void __iomem *ioaddr = pdata->ioaddr;
>> +     u32 lp_status;
>> +
>> +     pm_wakeup_event(pdata->input->dev.parent, 0);
>> +     lp_status = readl_relaxed(ioaddr + SNVS_LPSR_REG);
>> +     if (lp_status & SNVS_LPSR_SPO)
>> +             mod_timer(&pdata->check_timer, jiffies + msecs_to_jiffies(2));
>
> Why 2 and not 1 or 0?
>

I checked internal team about this. no special reason for that.
Just do debounce.

best regards
Frank Li
