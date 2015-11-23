From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Date: Mon, 23 Nov 2015 14:59:52 +0000
Message-ID: <20151123145952.GC31376@x1>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
 <1447675269-8831-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447675269-8831-2-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 16 Nov 2015, Markus Pargmann wrote:

> This documentation describes the devicetree bindings for the
> ADC/Touchscreen unit of the i.MX25 SoC.
>=20
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>=20
> Notes:
>     Changes in v6:
>      - Removed adc-ref property and replaced it with refp and refn fo=
r positive and
>        negative references. The properties are optional now as the de=
fault
>        behaviour is a positive internal reference voltage and ADC GND=
 as negative
>        reference.
>=20
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    | 46 ++++++++++++=
++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-t=
sadc.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.tx=
t b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> new file mode 100644
> index 000000000000..a857af0eb68c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> @@ -0,0 +1,46 @@
> +Freescale mx25 ADC/TSC multifunction device

Prefer "MX25" and "MultiFunction Device (MFD)"

> +This device combines two general purpose conversion queues one used =
for general
> +ADC and the other used for touchscreens.
> +
> +Required properties:
> + - compatible: Should be "fsl,imx25-tsadc".
> + - reg: Memory range of the device.

Not exactly.  More like start location and size.

> + - interrupts: Interrupt for this device as described in
> +   interrupts/interrupts.txt

No such file.  In any case, I'd prefer:

"(See: ../interrupt-controller/interrupts.txt)".

> + - clocks: An 'ipg' clock defined as described in clocks/clock.txt

Didn't you check any of what you've written?

"(See: ../clock/clock-bindings.txt)"

> + - interrupt-controller: This device is an interrupt controller. It =
controls
> +   the interrupts of both conversion queues.
> + - #interrupt-cells: Should be '<1>'.
> + - #address-cells: Should be '<1>'.
> + - #size-cells: Should be '<1>'.
> + - ranges

?

Also, don't think think that this looks better/easier to read?

> +Required properties:
> + - compatible:		Should be "fsl,imx25-tsadc".
> + - reg:			Memory range of the device.
> + - interrupts:		Interrupt for this device as described in
> +				interrupts/interrupts.txt
> + - clocks:			An 'ipg' clock defined as described in clocks/clock.txt
> + - interrupt-controller:	This device is an interrupt controller. It =
controls
> +   				the interrupts of both conversion queues.
> + - #interrupt-cells:		Should be '<1>'.
> + - #address-cells:		Should be '<1>'.
> + - #size-cells:		Should be '<1>'.

[...]

> +This device includes two conversion queues which can be added as sub=
nodes.
> +The first queue is for the touchscreen, the second for general purpo=
se ADC.
> +
> +Example:
> +	tscadc: tscadc@50030000 {
> +		compatible =3D "fsl,imx25-tsadc";
> +		reg =3D <0x50030000 0xc>;
> +		interrupts =3D <46>;
> +		clocks =3D <&clks 119>;
> +		clock-names =3D "ipg";

I don't think this is required, if you only have a single clock.

> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		tsc: tcq@50030400 {
> +			compatible =3D "fsl,imx25-tcq";
> +			reg =3D <0x50030400 0x60>;
> +			...
> +		};
> +
> +		adc: gcq@50030800 {
> +			compatible =3D "fsl,imx25-gcq";
> +			reg =3D <0x50030800 0x60>;
> +			...
> +		};
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
