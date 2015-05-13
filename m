From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH v2 1/3] input: keyboad: imx: add snvs power key driver
Date: Wed, 13 May 2015 12:10:06 -0700
Message-ID: <2698983.zamV244jo6@jclayton-pc>
References: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com> <20150513164020.GA11891@dtor-ws> <CAHrpEqRKX_oqT9JKc7=m1Okbq1_30GQOwR_nGPn6aALq2D_-Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36756 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934638AbbEMTKK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 15:10:10 -0400
Received: by pdea3 with SMTP id a3so60208432pde.3
        for <linux-input@vger.kernel.org>; Wed, 13 May 2015 12:10:09 -0700 (PDT)
In-Reply-To: <CAHrpEqRKX_oqT9JKc7=m1Okbq1_30GQOwR_nGPn6aALq2D_-Sw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhi Li <lznuaa@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Robin Gong <b38343@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "Frank.Li@freescale.com" <Frank.Li@freescale.com>, linux-input@vger.kernel.org


Hi Frank.

On Wednesday, May 13, 2015 01:27:39 PM Zhi Li wrote:
> On Wed, May 13, 2015 at 11:40 AM, Dmitry Torokhov
> 
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Frank,
> > 

> > 
> >> +     pdata->ioaddr = of_iomap(np, 0);
> >> +     if (IS_ERR(pdata->ioaddr))
> >> +             return PTR_ERR(pdata->ioaddr);
> > 
> > Umm, you are still leaking it on error path. Can you try doing:
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
> >         if (IS_ERR(pdata->ioaddr))
> >         
> >                 return PTR_ERR(pdata->ioaddr);
> 
> Thank you for comments.
> but I don't use of_iomap here because the resource is shared with the
> other device.
> 
> SNVS included a rtc, a power off, ON/OFF key.
> If I use platform_get_resource and devm_ioremap_resource, rtc driver
> fail to probe.
> 
> best regards
> Frank Li
> 

The fact that you cannot use of_iomap() seems a clear warning of unsafe 
access.
Since it is a shared resource, which you are writing to as well as reading,
perhaps you should set it up for safe access using the  regmap API like the 
GPR registers. 
/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
 
-- 
~Joshua Clayton
