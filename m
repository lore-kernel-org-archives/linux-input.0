From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 7/8] ARM: sun7i: dt: Add AXP209 support
 to various boards
Date: Sat, 15 Mar 2014 16:45:08 +0100
Message-ID: <53247584.8060701@redhat.com>
References: <1394898225-28452-1-git-send-email-carlo@caione.org> <1394898225-28452-8-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBFXLSGMQKGQEFSHDM5I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1394898225-28452-8-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

Thanks for your continued work on this.

On 03/15/2014 04:43 PM, Carlo Caione wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 12 ++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 13 +++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 12 ++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index 5c51cb8..9ad7da5 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -53,6 +53,18 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2c0_pins_a>;
>  			status = "okay";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			axp: axp20x@34 {
> +				reg = <0x34>;
> +				interrupt-parent = <&nmi_intc>;
> +				interrupts = <0 8>;
> +
> +				axp,system-power-controller;

Shouldn't this be dropped now (all 3 of them) ?

Regards,

Hans

> +
> +				/include/ "x-powers-axp209.dtsi"
> +			};
>  		};
>  
>  		i2c1: i2c@01c2b000 {
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index f9dcb61..aab77f9 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -38,6 +38,19 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2c0_pins_a>;
>  			status = "okay";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			axp: axp20x@34 {
> +				reg = <0x34>;
> +				interrupt-parent = <&nmi_intc>;
> +				interrupts = <0 8>;
> +
> +				axp,system-power-controller;
> +
> +				/include/ "x-powers-axp209.dtsi"
> +			};
> +
>  		};
>  
>  		i2c1: i2c@01c2b000 {
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> index ead3013..a5fe5d0 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -65,6 +65,18 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2c0_pins_a>;
>  			status = "okay";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			axp: axp20x@34 {
> +				reg = <0x34>;
> +				interrupt-parent = <&nmi_intc>;
> +				interrupts = <0 8>;
> +
> +				axp,system-power-controller;
> +
> +				/include/ "x-powers-axp209.dtsi"
> +			};
>  		};
>  
>  		i2c1: i2c@01c2b000 {
> 
