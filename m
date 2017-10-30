From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: input: Add Atmel PTC subsystem
 bindings
Date: Mon, 30 Oct 2017 16:06:58 -0700
Message-ID: <20171030230658.csl2sxfrmdcdx3lj@dtor-ws>
References: <20171020133121.7992-1-ludovic.desroches@microchip.com>
 <20171020133121.7992-2-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171020133121.7992-2-ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Ludovic,

On Fri, Oct 20, 2017 at 03:31:17PM +0200, Ludovic Desroches wrote:
> Add description of the Atmel PTC subsystem bindings.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/input/atmel,ptc.txt        | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/atmel,ptc.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/atmel,ptc.txt b/Documentation/devicetree/bindings/input/atmel,ptc.txt
> new file mode 100644
> index 000000000000..a183fd511e04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/atmel,ptc.txt
> @@ -0,0 +1,67 @@
> +Atmel PTC Subsystem
> +
> +The Atmel Peripheral Touch Controller subsystem offers built-in hardware
> +for capacitive touch measurement on sensors that function as buttons, sliders
> +and wheels.
> +
> +1) PTC Subsystem node
> +
> +Required properties:
> +- compatible: 		Must be "atmel,sama5d2-ptc"
> +- reg: 			Address, length of the shared memory and ppp registers location
> +			and length.
> +- clocks: 		Phandlers to the clocks.
> +- clock-names: 		Must be "ptc_clk", "ptc_int_osc", "slow_clk".
> +- #address-cells:	Must be one. The cell is the button or scroller id.
> +- #size-cells: 		Must be zero.
> +
> +Example:
> +	ptc@fc060000 {
> +		compatible = "atmel,sama5d2-ptc";
> +		reg = <0x00800000 0x10000
> +		       0xfc060000 0xcf>;
> +		interrupts = <58 IRQ_TYPE_LEVEL_HIGH 7>;
> +		clocks = <&ptc_clk>, <&main>, <&clk32k>;
> +		clock-names = "ptc_clk", "ptc_int_osc", "slow_clk";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		[ child node definitions... ]
> +	};
> +
> +2) Scroller / buttons subnodes
> +
> +Subnodes describe the kind of sensors the customer want to use. They have to be
> +named according to their function: button, slider or wheel.

I wonder do we really need this? Or we can have a generic:

	slider@0 {
		reg = <0>;
		linux,type = <EV_ABS>;
		linux,code = <ABS_X>;
	},
	vertical-slider@1 {
		reg = <1>;
		linux,type = <EV_ABS>;
		linux,code = <ABS_Y>;
	},
	wheel@2 {
		reg = <2>;
		linux,type = <EV_ABS>;
		linux,code = <ABS_WHEEL>;
	},
	button@3 {
		reg = <3>;
		linux,type = <EV_KEY>;
		linux,code = <KEY_A>;
	},
	...

I.e. you specify type/code in a generic way.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
