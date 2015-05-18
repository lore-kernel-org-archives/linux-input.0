From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 4/7] arm: dts: imx: update snvs to use syscon access
 register
Date: Tue, 19 May 2015 00:17:17 +0200
Message-ID: <20150518221717.GX3338@piout.net>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
 <1431696990-23078-5-git-send-email-Frank.Li@freescale.com>
 <1431938725.3209.15.camel@pengutronix.de>
 <CAHrpEqSxgqUSWFkAh+R4K1oShsWfErE4nndxkYGGktMdkb3=xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41658 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752373AbbERWRU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2015 18:17:20 -0400
Content-Disposition: inline
In-Reply-To: <CAHrpEqSxgqUSWFkAh+R4K1oShsWfErE4nndxkYGGktMdkb3=xw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhi Li <lznuaa@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it, sachin.kamat@linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 18/05/2015 at 14:30:50 -0500, Zhi Li wrote :
> On Mon, May 18, 2015 at 3:45 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Hi Frank,
> >
> > Am Freitag, den 15.05.2015, 21:36 +0800 schrieb Frank.Li@freescale.com:
> >> From: Frank Li <Frank.Li@freescale.com>
> >>
> >> snvs is MFP device. Change dts to use syscon to allocate register resource.
> >>
> >> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> >> ---
> >>  arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++--------
> >>  arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++--------
> >>  arch/arm/boot/dts/imx6sx.dtsi  | 12 ++++--------
> >>  arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
> >>  4 files changed, 15 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> >> index 0482a66..6d8161d 100644
> >> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> >> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> >> @@ -687,21 +687,17 @@
> >>                       };
> >>
> >>                       snvs@020cc000 {
> >> -                             compatible = "fsl,sec-v4.0-mon", "simple-bus";
> >> -                             #address-cells = <1>;
> >> -                             #size-cells = <1>;
> >> -                             ranges = <0 0x020cc000 0x4000>;
> >> +                             compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-bus";
> >
> > The compatible should change from "simple-bus" to "simple-mfd", then.
> 
> After change to simple-mfd,  driver can't been probed. Anything missed?

The pull request is there:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/342131.html

It has landed in linux-next


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
