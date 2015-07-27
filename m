From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4/5] ARM: dts: imx6ul.dtsi: add TSC support
Date: Mon, 27 Jul 2015 12:28:47 +0100
Message-ID: <20150727112847.GF9169@leverpostej>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
 <1437996407-27266-5-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52520 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbbG0L3T (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 07:29:19 -0400
Content-Disposition: inline
In-Reply-To: <1437996407-27266-5-git-send-email-haibo.chen@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>, "hadess@hadess.net" <hadess@hadess.net>, "mchehab@osg.samsung.com" <mchehab@osg.samsung.com>, "mamlinav@gmail.com" <mamlinav@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "jonathar@broadcom.com" <jonathar@broadcom.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>, "scott.liu@emc.com.tw" <scott.liu@emc.com.tw>, "geert@linux-m68k.org" <geert@linux-m68k.org>, benjamin.tissoire

On Mon, Jul 27, 2015 at 12:26:46PM +0100, Haibo Chen wrote:
> Add imx6ul touchscreen controller support.
> 
> TSC module need ADC2 module to measure the touchscreen
> coordinate value. This patch put TSC and ADC2 together,
> make ADC2 module only be used for TSC, can't be used as
> a normal ADC.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index dc0f5b4..33aac1f 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -484,6 +484,17 @@
>  			reg = <0x02100000 0x100000>;
>  			ranges;
>  
> +			tsc: tsc@02040000 {
> +				compatible = "fsl,imx6ul-tsc";
> +				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
> +				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6UL_CLK_IPG>,
> +					 <&clks IMX6UL_CLK_ADC2>;
> +				clock-names = "tsc", "adc";

These clocks weren't even in the example in the binding documentation.

Mark.
