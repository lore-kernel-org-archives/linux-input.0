From: Zhi Li <lznuaa@gmail.com>
Subject: Re: [PATCH 2/3] input: keyboad: imx: add snvs power key driver
Date: Tue, 12 May 2015 15:37:41 -0500
Message-ID: <CAHrpEqQpyO=Fzu206xPUwQE+cvk7rpTd0r0A_bL-V1UWgT7+XA@mail.gmail.com>
References: <1431449438-19460-1-git-send-email-Frank.Li@freescale.com>
	<1431449438-19460-2-git-send-email-Frank.Li@freescale.com>
	<20150512184328.GC20725@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33603 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbbELUhm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2015 16:37:42 -0400
Received: by qgdy78 with SMTP id y78so11069116qgd.0
        for <linux-input@vger.kernel.org>; Tue, 12 May 2015 13:37:41 -0700 (PDT)
In-Reply-To: <20150512184328.GC20725@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Robin Gong <b38343@freescale.com>

>> +             ret = devm_request_irq(&pdev->dev, pdata->irq,
>> +                                     imx_snvs_pwrkey_interrupt,
>> +                                     IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, pdev->name, pdev);
>
> Why IRQF_NO_SUSPEND? Also should we not get trigger type from OF data?
>
wake up by PWRON key in freeze mode

Do you have any example to get trigger type from OF data?

best regards
Frank Li
