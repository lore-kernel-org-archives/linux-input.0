From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 6/6] arm: dts: imx6sx: enable snvs power key
Date: Mon, 25 May 2015 15:39:05 +0800
Message-ID: <20150525073904.GJ3264@dragon>
References: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
 <1432305399-30571-7-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34217 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbEYHjz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 03:39:55 -0400
Received: by pabru16 with SMTP id ru16so65988308pab.1
        for <linux-input@vger.kernel.org>; Mon, 25 May 2015 00:39:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432305399-30571-7-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org

On Fri, May 22, 2015 at 10:36:39PM +0800, Frank.Li@freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> enable snvs ONOFF power key support
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Please use 'ARM: dts: imx6sx: ...' for the patch subject.

> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 3cb3b5b..ad38aea 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -677,6 +677,13 @@
>  					mask = <0x60>;
>  					status = "disabled";
>  				};
> +
> +				snvs_pwrkey: snvs-powerkey {
> +					compatible = "fsl,sec-v4.0-pwrkey";
> +					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +					linux,keycode = <116>; /* KEY_POWER */

With include/dt-bindings/input/input.h, you can use KEY_POWER directly
and save the comment.

Shawn

> +					wakeup;
> +				};
>  			};
>  
>  			epit1: epit@020d0000 {
> -- 
> 1.9.1
> 
