From: Zhi Li <lznuaa@gmail.com>
Subject: Re: [PATCH v5 0/6] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
Date: Thu, 28 May 2015 08:18:24 -0500
Message-ID: <CAHrpEqShyPKeKYdVZ05_qsbx0cC387a2QPCdbhR5C968n=ED0A@mail.gmail.com>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
	<20150527121052.GH16165@dragon>
	<20150528121353.GP2185@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:32810 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbbE1NSY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 09:18:24 -0400
In-Reply-To: <20150528121353.GP2185@piout.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, May 28, 2015 at 7:13 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 27/05/2015 at 20:10:53 +0800, Shawn Guo wrote :
>> On Wed, May 27, 2015 at 12:25:56AM +0800, Frank.Li@freescale.com wro=
te:
>> > Frank Li (5):
>> >   rtc: arm: imx: snvs: change use syscon to access register
>> >   Document: dt: fsl: snvs: change support syscon
>> >   ARM: dts: imx: update snvs to use syscon access register
>> >   Document: devicetree: input: imx: i.mx snvs power device tree bi=
ndings
>> >   ARM: dts: imx6sx: enable snvs power key
>> >
>> > Robin Gong (1):
>> >   input: keyboard: imx: add snvs power key driver
>>
>> The series looks fine to me now.  But I can only apply those two dts
>> patches after the driver and binding parts get landed on mainline.
>> Hopefully, you can get them in during the coming merge window throug=
h
>> subsystem trees, so that I can pick up dts part after v4.2-rc1 comes
>> out.
>>
>
> Actually, I was thinking you could take the whole series in your tree
> (at least, I'm speaking for the RTC part).
> Else, I'm wondering who should take the documentation changes.
>

Dmitry Torokhov:

what's your opinion about input part=EF=BC=9F

best regards
=46rank Li

>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
