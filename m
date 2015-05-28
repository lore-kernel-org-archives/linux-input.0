From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v5 0/6] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
Date: Thu, 28 May 2015 14:13:53 +0200
Message-ID: <20150528121353.GP2185@piout.net>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
 <20150527121052.GH16165@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58606 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752201AbbE1MN4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 08:13:56 -0400
Content-Disposition: inline
In-Reply-To: <20150527121052.GH16165@dragon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Frank.Li@freescale.com, lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org

On 27/05/2015 at 20:10:53 +0800, Shawn Guo wrote :
> On Wed, May 27, 2015 at 12:25:56AM +0800, Frank.Li@freescale.com wrote:
> > Frank Li (5):
> >   rtc: arm: imx: snvs: change use syscon to access register
> >   Document: dt: fsl: snvs: change support syscon
> >   ARM: dts: imx: update snvs to use syscon access register
> >   Document: devicetree: input: imx: i.mx snvs power device tree bindings
> >   ARM: dts: imx6sx: enable snvs power key
> > 
> > Robin Gong (1):
> >   input: keyboard: imx: add snvs power key driver
> 
> The series looks fine to me now.  But I can only apply those two dts
> patches after the driver and binding parts get landed on mainline.
> Hopefully, you can get them in during the coming merge window through
> subsystem trees, so that I can pick up dts part after v4.2-rc1 comes
> out.
> 

Actually, I was thinking you could take the whole series in your tree
(at least, I'm speaking for the RTC part).
Else, I'm wondering who should take the documentation changes.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
