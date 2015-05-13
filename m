From: Zhi Li <lznuaa@gmail.com>
Subject: Re: [PATCH v2 1/3] input: keyboad: imx: add snvs power key driver
Date: Wed, 13 May 2015 14:57:00 -0500
Message-ID: <CAHrpEqQi8pyf3r4E0WroNroa2sQvrhfwjUgZv=iUgGxTnJWtLg@mail.gmail.com>
References: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
	<20150513164020.GA11891@dtor-ws>
	<CAHrpEqRKX_oqT9JKc7=m1Okbq1_30GQOwR_nGPn6aALq2D_-Sw@mail.gmail.com>
	<2698983.zamV244jo6@jclayton-pc>
	<CAHrpEqQ2a8uHZm9+eVjB=fFHrNwo6rf5G4WKA4fX_UiA=QteCw@mail.gmail.com>
	<20150513194454.GD11891@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35382 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934135AbbEMT5B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 15:57:01 -0400
Received: by oign205 with SMTP id n205so40054114oig.2
        for <linux-input@vger.kernel.org>; Wed, 13 May 2015 12:57:01 -0700 (PDT)
In-Reply-To: <20150513194454.GD11891@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joshua Clayton <stillcompiling@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Robin Gong <b38343@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "Frank.Li@freescale.com" <Frank.Li@freescale.com>, linux-input@vger.kernel.org

On Wed, May 13, 2015 at 2:44 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, May 13, 2015 at 02:27:46PM -0500, Zhi Li wrote:
>> On Wed, May 13, 2015 at 2:10 PM, Joshua Clayton
>> <stillcompiling@gmail.com> wrote:
>> >
>> > Hi Frank.
>> >
>> > On Wednesday, May 13, 2015 01:27:39 PM Zhi Li wrote:
>> >> On Wed, May 13, 2015 at 11:40 AM, Dmitry Torokhov
>> >>
>> >> <dmitry.torokhov@gmail.com> wrote:
>> >> > Hi Frank,
>> >> >
>> >
>> >> >
>> >> >> +     pdata->ioaddr = of_iomap(np, 0);
>> >> >> +     if (IS_ERR(pdata->ioaddr))
>> >> >> +             return PTR_ERR(pdata->ioaddr);
>> >> >
>> >> > Umm, you are still leaking it on error path. Can you try doing:
>> >> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >> >         pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
>> >> >         if (IS_ERR(pdata->ioaddr))
>> >> >
>> >> >                 return PTR_ERR(pdata->ioaddr);
>> >>
>> >> Thank you for comments.
>> >> but I don't use of_iomap here because the resource is shared with the
>> >> other device.
>> >>
>> >> SNVS included a rtc, a power off, ON/OFF key.
>> >> If I use platform_get_resource and devm_ioremap_resource, rtc driver
>> >> fail to probe.
>> >>
>> >> best regards
>> >> Frank Li
>> >>
>> >
>> > The fact that you cannot use of_iomap() seems a clear warning of unsafe
>> > access.
>> > Since it is a shared resource, which you are writing to as well as reading,
>> > perhaps you should set it up for safe access using the  regmap API like the
>> > GPR registers.
>> > /include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
>>
>> I read driver again clearfully. It is safed shared with rtc driver directly.
>> Because pwr key driver just read a irq status register and other one
>> register, which used only in this driver.
>>
>> Just w1c (write 1 clear) register. it is atomic access by hardware.
>
> It does not really matter, driver has to claim resources it is using to
> make sure other parties are not accessing its registers. If registers
> are shared you need to have a 3rd party mediator.

I can change to use syscon.
but other two driver(rtc and power off) need change also.

>
>>
>> PowerKey use difference irq number with RTC part.
>
> Yes and so they can run simultaneously and step on each other's feet,
> right?

Yes.

>
> Thanks.
>
> --
> Dmitry
