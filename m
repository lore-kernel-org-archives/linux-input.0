From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 0/6] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
Date: Mon, 1 Jun 2015 12:45:52 -0700
Message-ID: <20150601194552.GD30024@dtor-ws>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
 <20150527121052.GH16165@dragon>
 <20150528121353.GP2185@piout.net>
 <CAHrpEqShyPKeKYdVZ05_qsbx0cC387a2QPCdbhR5C968n=ED0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34543 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbbFATp5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jun 2015 15:45:57 -0400
Content-Disposition: inline
In-Reply-To: <CAHrpEqShyPKeKYdVZ05_qsbx0cC387a2QPCdbhR5C968n=ED0A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhi Li <lznuaa@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Shawn Guo <shawn.guo@linaro.org>, "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, May 28, 2015 at 08:18:24AM -0500, Zhi Li wrote:
> On Thu, May 28, 2015 at 7:13 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 27/05/2015 at 20:10:53 +0800, Shawn Guo wrote :
> >> On Wed, May 27, 2015 at 12:25:56AM +0800, Frank.Li@freescale.com w=
rote:
> >> > Frank Li (5):
> >> >   rtc: arm: imx: snvs: change use syscon to access register
> >> >   Document: dt: fsl: snvs: change support syscon
> >> >   ARM: dts: imx: update snvs to use syscon access register
> >> >   Document: devicetree: input: imx: i.mx snvs power device tree =
bindings
> >> >   ARM: dts: imx6sx: enable snvs power key
> >> >
> >> > Robin Gong (1):
> >> >   input: keyboard: imx: add snvs power key driver
> >>
> >> The series looks fine to me now.  But I can only apply those two d=
ts
> >> patches after the driver and binding parts get landed on mainline.
> >> Hopefully, you can get them in during the coming merge window thro=
ugh
> >> subsystem trees, so that I can pick up dts part after v4.2-rc1 com=
es
> >> out.
> >>
> >
> > Actually, I was thinking you could take the whole series in your tr=
ee
> > (at least, I'm speaking for the RTC part).
> > Else, I'm wondering who should take the documentation changes.
> >
>=20
> Dmitry Torokhov:
>=20
> what's your opinion about input part=EF=BC=9F

I am fine with it merged through Shawn's tree. I added my ack to the ma=
il
in question.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
