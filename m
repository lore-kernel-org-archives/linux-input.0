From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Date: Mon, 16 Nov 2015 08:01:19 -0600
Message-ID: <20151116140119.GA30407@rob-hp-laptop>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
 <1447675269-8831-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447675269-8831-2-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 16, 2015 at 01:01:02PM +0100, Markus Pargmann wrote:
> This documentation describes the devicetree bindings for the
> ADC/Touchscreen unit of the i.MX25 SoC.
> 
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
> 
> Notes:
>     Changes in v6:
>      - Removed adc-ref property and replaced it with refp and refn for positive and
>        negative references. The properties are optional now as the default
>        behaviour is a positive internal reference voltage and ADC GND as negative
>        reference.
> 
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> new file mode 100644
> index 000000000000..a857af0eb68c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> @@ -0,0 +1,46 @@
> +Freescale mx25 ADC/TSC multifunction device
> +
> +This device combines two general purpose conversion queues one used for general
> +ADC and the other used for touchscreens.
> +
> +Required properties:
> + - compatible: Should be "fsl,imx25-tsadc".
> + - reg: Memory range of the device.
> + - interrupts: Interrupt for this device as described in
> +   interrupts/interrupts.txt
> + - clocks: An 'ipg' clock defined as described in clocks/clock.txt
> + - interrupt-controller: This device is an interrupt controller. It controls
> +   the interrupts of both conversion queues.
> + - #interrupt-cells: Should be '<1>'.
> + - #address-cells: Should be '<1>'.
> + - #size-cells: Should be '<1>'.
> + - ranges
> +
> +This device includes two conversion queues which can be added as subnodes.
> +The first queue is for the touchscreen, the second for general purpose ADC.
> +
> +Example:
> +	tscadc: tscadc@50030000 {
> +		compatible = "fsl,imx25-tsadc";
> +		reg = <0x50030000 0xc>;
> +		interrupts = <46>;
> +		clocks = <&clks 119>;
> +		clock-names = "ipg";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		tsc: tcq@50030400 {
> +			compatible = "fsl,imx25-tcq";
> +			reg = <0x50030400 0x60>;
> +			...
> +		};
> +
> +		adc: gcq@50030800 {
> +			compatible = "fsl,imx25-gcq";
> +			reg = <0x50030800 0x60>;
> +			...
> +		};
> +	};
> -- 
> 2.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
