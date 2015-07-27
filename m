From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 5/5] ARM: dts: imx6ul-14x14-evk.dts: add tsc support
Date: Mon, 27 Jul 2015 22:13:00 +0800
Message-ID: <20150727141259.GO12927@tiger>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
 <1437996407-27266-6-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437996407-27266-6-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kernel@pengutronix.de, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, sbranden@broadcom.com, arnd@arndb.de, mchehab@osg.samsung.com, christian.gmeiner@gmail.com, scott.liu@emc.com.tw, linux-kernel@vger.kernel.org, hdegoede@redhat.com, jonathar@broadcom.com, benjamin.tissoires@redhat.com, hans.verkuil@cisco.com, hadess@hadess.net, linux-input@vger.kernel.org, geert@linux-m68k.org, sebastien.szymanski@armadeus.com, mamlinav@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 27, 2015 at 07:26:47PM +0800, Haibo Chen wrote:
> Add touch screen surpport for i.MX6UL-EVK board.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  arch/arm/boot/dts/imx6ul-14x14-evk.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> index 61b41ee..323d32d 100644
> --- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> +++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> @@ -44,6 +44,15 @@
>  	soc-supply = <&reg_soc>;
>  };
>  
> +&tsc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_tsc>;
> +	status = "okay";

We generally have "status" at the bottom of the property list.

Shawn

> +	xnur-gpio = <&gpio1 3 0>;
> +	measure_delay_time = <0xffff>;
> +	pre_charge_time = <0xfff>;
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> @@ -212,6 +221,15 @@
>  		>;
>  	};
>  
> +	pinctrl_tsc: tscgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01		0xb0
> +			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02		0xb0
> +			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0xb0
> +			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04		0xb0
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX 0x1b0b1
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
