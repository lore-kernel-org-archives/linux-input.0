From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend 0/7] Change snvs rtc and poweroff to use syscon
 add pwrkey driver
Date: Fri, 15 May 2015 11:28:46 -0700
Message-ID: <20150515182846.GB696@dtor-ws>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35641 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbbEOS2u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 14:28:50 -0400
Content-Disposition: inline
In-Reply-To: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, robh+dt@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, sachin.kamat@linaro.org, p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Fri, May 15, 2015 at 09:36:23PM +0800, Frank.Li@freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Resend to add rtc and reset  maintainer.
> 
> SNVS is MPF module.
> include rtc, power off, ON/OFF power key
>   
>   arm: imx: power-off: change to syscon to access register
>   rtc: arm: imx: snvs: change use syscon to access register
> Above two patch change existed power-off and rtc use syscon
> 
>   Document: dt: fsl: snvs: change support syscon
>   arm: dts: imx: update snvs to use syscon access register
> Update dt file and document
> 
>   input: keyboard: imx: add snvs power key driver
>   document: devicetree: input: imx: i.mx snvs power device tree bindings
>   arm: dts: imx6sx: enable snvs power key
> Added on/off key driver
> 
> Frank Li (6):
>   arm: imx: power-off: change to syscon to access register
>   rtc: arm: imx: snvs: change use syscon to access register
>   Document: dt: fsl: snvs: change support syscon
>   arm: dts: imx: update snvs to use syscon access register
>   document: devicetree: input: imx: i.mx snvs power device tree bindings
>   arm: dts: imx6sx: enable snvs power key
> 
> Robin Gong (1):
>   input: keyboard: imx: add snvs power key driver

OK, I am now happy with the input part, but we span several subsystems
now. How do we want to merge this?

> 
>  .../devicetree/bindings/crypto/fsl-sec4.txt        |  93 +++++++--
>  .../devicetree/bindings/input/snvs-pwrkey.txt      |   1 +
>  .../bindings/power_supply/imx-snvs-poweroff.txt    |  24 +--
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  12 +-
>  arch/arm/boot/dts/imx6sl.dtsi                      |  12 +-
>  arch/arm/boot/dts/imx6sx.dtsi                      |  19 +-
>  arch/arm/boot/dts/vfxxx.dtsi                       |   9 +-
>  drivers/input/keyboard/Kconfig                     |  11 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/snvs_pwrkey.c               | 232 +++++++++++++++++++++
>  drivers/power/reset/imx-snvs-poweroff.c            |  21 +-
>  drivers/rtc/rtc-snvs.c                             | 124 +++++------
>  12 files changed, 417 insertions(+), 142 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt
>  create mode 100644 drivers/input/keyboard/snvs_pwrkey.c
> 
> -- 
> 1.9.1
> 

-- 
Dmitry
