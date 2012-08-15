From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx6q-sabrelite: add eeti egalax
Date: Wed, 15 Aug 2012 21:01:11 +0800
Message-ID: <20120815130108.GB2258@S2101-09.ap.freescale.net>
References: <1345026708-14139-1-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-2-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-3-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-4-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:47805 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab2HONBW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 09:01:22 -0400
Received: by ggdk6 with SMTP id k6so1716000ggd.19
        for <linux-input@vger.kernel.org>; Wed, 15 Aug 2012 06:01:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345026708-14139-4-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Wed, Aug 15, 2012 at 06:31:48PM +0800, Hui Wang wrote:
> i.MX6Q sabrelite board uses i2c3 to connect an eeti egalax
> touchscreen controller, add it as an i2c slave device in the dts.
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |   16 ++++++++++++++++
>  arch/arm/boot/dts/imx6q.dtsi          |    7 +++++++
>  2 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 72f30f3..4a68e1f 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -54,6 +54,7 @@
>  							   144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
>  							   121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
>  							   953  0x80000000	/* MX6Q_PAD_GPIO_0__CCM_CLKO */
> +							   972  0x10		/* MX6Q_PAD_GPIO_9__GPIO_1_9 */
>  							   >;
>  					};
>  				};
> @@ -115,6 +116,21 @@
>  					VDDIO-supply = <&reg_3p3v>;
>  				};
>  			};
> +
> +			i2c@021a8000 { /* I2C3 */
> +				status = "okay";
> +				clock-frequency = <100000>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2c3_1>;
> +
> +				egalax_ts@04 {
> +					compatible = "eeti,egalax_ts";
> +					reg = <0x04>;
> +					interrupt-parent = <&gpio1>;
> +					interrupts = <9 2>;

So you take this interrupt as falling-edge, while I see IRQF_TRIGGER_LOW
is used in driver with request_threaded_irq call.

Regards,
Shawn

> +					wakeup-gpios = <&gpio1 9 0>;
> +				};
> +			};
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index fd57079..6f833b3 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -552,6 +552,13 @@
>  					};
>  				};
>  
> +				i2c3 {
> +					pinctrl_i2c3_1: i2c3grp-1 {
> +						fsl,pins = <1013 0x4001b8b1	/* MX6Q_PAD_GPIO_5__I2C3_SCL */
> +							    1037 0x4001b8b1>;	/* MX6Q_PAD_GPIO_16__I2C3_SDA */
> +					};
> +				};
> +
>  				serial2 {
>  					pinctrl_serial2_1: serial2grp-1 {
>  						fsl,pins = <183 0x1b0b1		/* MX6Q_PAD_EIM_D26__UART2_TXD */
> -- 
> 1.7.6
> 
