From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH v1 2/4] ARM: dts: vf500-colibri: Add device tree node for
 touchscreen support
Date: Fri, 03 Jul 2015 15:50:11 +0200
Message-ID: <347f8e8a9ec4c71bab9713bc2e980ebb@agner.ch>
References: <cover.1435646447.git.maitysanchayan@gmail.com>
 <2fa8c45a15acc7fdcf75611d46530a643858115d.1435646447.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2fa8c45a15acc7fdcf75611d46530a643858115d.1435646447.git.maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 2015-06-30 08:54, Sanchayan Maity wrote:
> Add device tree node for touchscreen support on Colibri VF50. The
> touchscreen functionality on VF50 uses the ADC channels of Vybrid
> and some GPIOs. Also add pinctrl nodes for proper pinmux.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/vf500-colibri-eval-v3.dts |  4 +++
>  arch/arm/boot/dts/vf500-colibri.dtsi        | 46 +++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> index 7fc782c..c5efb57 100644
> --- a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> @@ -15,3 +15,7 @@
>  	model = "Toradex Colibri VF50 on Colibri Evaluation Board";
>  	compatible = "toradex,vf500-colibri_vf50-on-eval",
> "toradex,vf500-colibri_vf50", "fsl,vf500";
>  };
> +
> +&touchctrl {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi
> b/arch/arm/boot/dts/vf500-colibri.dtsi
> index cee34a3..4807a32 100644
> --- a/arch/arm/boot/dts/vf500-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf500-colibri.dtsi
> @@ -17,4 +17,50 @@
>  	memory {
>  		reg = <0x80000000 0x8000000>;
>  	};
> +
> +	touchctrl: vf50_touchctrl {
> +		compatible = "toradex,vf50-touchctrl";
> +		io-channels = <&adc1 0>,<&adc0 0>,
> +				<&adc0 1>,<&adc1 2>;
> +		xp-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> +		xm-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
> +		yp-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
> +		ym-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> +		pen-detect-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
> +		pen-pullup-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "idle","default","gpios";
> +		pinctrl-0 = <&pinctrl_touchctrl_idle>;
> +		pinctrl-1 = <&pinctrl_touchctrl_default>;
> +		pinctrl-2 = <&pinctrl_touchctrl_gpios>;
> +		status = "disabled";
> +	};
> +};
> +
> +&iomuxc {
> +	vf610-colibri {
> +		pinctrl_touchctrl_idle: touchctrl_idle {
> +			fsl,pins = <
> +				VF610_PAD_PTA18__GPIO_8		0x206d

I think the detect pin should be in Hi-Z, not be pulled up. Probably the
resistance over the plates is much smaller on pen down, hence it doesn't
matter too much.

> +				VF610_PAD_PTA19__GPIO_9		0x206d
> +				>;
> +		};
> +
> +		pinctrl_touchctrl_default: touchctrl_default {
> +			fsl,pins = <
> +				VF610_PAD_PTA18__ADC0_SE0	0x2060
> +				VF610_PAD_PTA19__ADC0_SE1	0x2060
> +				VF610_PAD_PTA16__ADC1_SE0	0x2060
> +				VF610_PAD_PTB2__ADC1_SE2	0x2060
> +				>;
> +		};
> +
> +		pinctrl_touchctrl_gpios: touchctrl_gpios {
> +			fsl,pins = <
> +				VF610_PAD_PTA23__GPIO_13	0x22ed
> +				VF610_PAD_PTB23__GPIO_93	0x22ed
> +				VF610_PAD_PTA22__GPIO_12	0x22ed
> +				VF610_PAD_PTA11__GPIO_4		0x22ed
> +				>;
> +		};

Hm, those have pull-ups on too, since you set them as output in the
drivers open function, I don't think this is necessary.

> +	};
>  };

--
Stefan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
