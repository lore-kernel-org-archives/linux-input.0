From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
Date: Wed, 20 May 2015 22:22:07 +0800
Message-ID: <20150520142205.GA24844@dragon>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
 <20150520015851.GB1071@dragon>
 <CAHrpEqS5gAsu6=ut-mPwZiipqKJb=VicRooCPFhEf324kuhnDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33534 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbETOWt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 10:22:49 -0400
Received: by pdbqa5 with SMTP id qa5so70634502pdb.0
        for <linux-input@vger.kernel.org>; Wed, 20 May 2015 07:22:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHrpEqS5gAsu6=ut-mPwZiipqKJb=VicRooCPFhEf324kuhnDQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhi Li <lznuaa@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it, p.zabel@pengutronix.de, alexandre.belloni@free-electrons.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 19, 2015 at 09:44:46PM -0500, Zhi Li wrote:
> On Tue, May 19, 2015 at 8:58 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li@freescale.com wrote:
> >> From: Frank Li <Frank.Li@freescale.com>
> >>
> >> Change from v1 to v2
> >>  - Change simple-bus to simple-mfd
> >>  - RTC remove lock.
> >>  - RTC remove comments "These register offsets are relative to LP (Low Power) range"
> >>  - power off, remove extra space
> >>
> >> SNVS is MPF module.
> >> include rtc, power off, ON/OFF power key
> >>
> >>   arm: imx: power-off: change to syscon to access register
> >>   rtc: arm: imx: snvs: change use syscon to access register
> >> Above two patch change existed power-off and rtc use syscon
> >>
> >>   Document: dt: fsl: snvs: change support syscon
> >>   arm: dts: imx: update snvs to use syscon access register
> >> Update dt file and document
> >>
> >>   input: keyboard: imx: add snvs power key driver
> >>   document: devicetree: input: imx: i.mx snvs power device tree bindings
> >>   arm: dts: imx6sx: enable snvs power key
> >> Added on/off key driver
> >>
> >> Frank Li (6):
> >>   arm: imx: power-off: change to syscon to access register
> >>   rtc: arm: imx: snvs: change use syscon to access register
> >>   Document: dt: fsl: snvs: change support syscon
> >>   arm: dts: imx: update snvs to use syscon access register
> >>   document: devicetree: input: imx: i.mx snvs power device tree bindings
> >>   arm: dts: imx6sx: enable snvs power key
> >
> > So, the series will break existing DTBs for RTC and poweroff, right?
> > If this is unavoidable, should we at least have some warning messages
> > telling users about his breakage?
> 
> How to do that?
> Just added it commit message or need runtime warning?

runtime, so that users can know why their installed DTBs break with the
new kernel.

Shawn
