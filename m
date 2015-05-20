From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
Date: Wed, 20 May 2015 09:58:51 +0800
Message-ID: <20150520015851.GB1071@dragon>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, a.zummo@towertech.it, p.zabel@pengutronix.de, alexandre.belloni@free-electrons.com, devicetree@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li@freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Change from v1 to v2
>  - Change simple-bus to simple-mfd
>  - RTC remove lock.
>  - RTC remove comments "These register offsets are relative to LP (Low Power) range"
>  - power off, remove extra space
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

So, the series will break existing DTBs for RTC and poweroff, right?
If this is unavoidable, should we at least have some warning messages
telling users about his breakage?

Shawn

> 
> Robin Gong (1):
>   input: keyboard: imx: add snvs power key driver
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
>  drivers/rtc/rtc-snvs.c                             | 128 +++++-------
>  12 files changed, 417 insertions(+), 146 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt
>  create mode 100644 drivers/input/keyboard/snvs_pwrkey.c
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
