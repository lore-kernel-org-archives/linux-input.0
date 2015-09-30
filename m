From: maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH v5 1/3] ARM: dts: vf500-colibri: Add device tree node for
 touchscreen support
Date: Wed, 30 Sep 2015 11:20:11 +0530
Message-ID: <20150930055011.GA2515@Sanchayan-Arch.toradex.int>
References: <cover.1441110400.git.maitysanchayan@gmail.com>
 <1f73c4bfeae6bfca605f43e6203419dec38db1c0.1441110400.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1f73c4bfeae6bfca605f43e6203419dec38db1c0.1441110400.git.maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: stefan-XLVq0VzYD2Y@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello Shawn,

The driver has landed in your tree. Can you queue this DT change for the same?

Thanks.

- Sanchayan.

On 15-09-01 18:06:53, Sanchayan Maity wrote:
> Add device tree node for touchscreen support on Colibri VF50. The
> touchscreen functionality on VF50 uses the ADC channels of Vybrid
> and some GPIOs. Also add pinctrl nodes for proper pinmux.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/vf500-colibri-eval-v3.dts |  5 +++
>  arch/arm/boot/dts/vf500-colibri.dtsi        | 47 +++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> index 7fc782c..c3173fc 100644
> --- a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> @@ -15,3 +15,8 @@
>  	model = "Toradex Colibri VF50 on Colibri Evaluation Board";
>  	compatible = "toradex,vf500-colibri_vf50-on-eval", "toradex,vf500-colibri_vf50", "fsl,vf500";
>  };
> +
> +&touchscreen {
> +	vf50-ts-min-pressure = <200>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
> index cee34a3..84f091d 100644
> --- a/arch/arm/boot/dts/vf500-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf500-colibri.dtsi
> @@ -17,4 +17,51 @@
>  	memory {
>  		reg = <0x80000000 0x8000000>;
>  	};
> +
> +	touchscreen: vf50-touchscreen {
> +		compatible = "toradex,vf50-touchscreen";
> +		io-channels = <&adc1 0>,<&adc0 0>,
> +				<&adc0 1>,<&adc1 2>;
> +		xp-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> +		xm-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
> +		yp-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
> +		ym-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "idle","default","gpios";
> +		pinctrl-0 = <&pinctrl_touchctrl_idle>;
> +		pinctrl-1 = <&pinctrl_touchctrl_default>;
> +		pinctrl-2 = <&pinctrl_touchctrl_gpios>;
> +		vf50-ts-min-pressure = <200>;
> +		status = "disabled";
> +	};
> +};
> +
> +&iomuxc {
> +	vf610-colibri {
> +		pinctrl_touchctrl_idle: touchctrl_idle {
> +			fsl,pins = <
> +				VF610_PAD_PTA18__GPIO_8		0x006d
> +				VF610_PAD_PTA19__GPIO_9		0x006c
> +				>;
> +		};
> +
> +		pinctrl_touchctrl_default: touchctrl_default {
> +			fsl,pins = <
> +				VF610_PAD_PTA18__ADC0_SE0	0x0040
> +				VF610_PAD_PTA19__ADC0_SE1	0x0040
> +				VF610_PAD_PTA16__ADC1_SE0	0x0040
> +				VF610_PAD_PTB2__ADC1_SE2	0x0040
> +				>;
> +		};
> +
> +		pinctrl_touchctrl_gpios: touchctrl_gpios {
> +			fsl,pins = <
> +				VF610_PAD_PTA23__GPIO_13	0x22e9
> +				VF610_PAD_PTB23__GPIO_93	0x22e9
> +				VF610_PAD_PTA22__GPIO_12	0x22e9
> +				VF610_PAD_PTA11__GPIO_4		0x22e9
> +				>;
> +		};
> +	};
>  };
> -- 
> 2.5.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
