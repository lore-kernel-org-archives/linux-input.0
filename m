From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v10 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Date: Mon, 11 Jan 2016 07:29:21 +0000
Message-ID: <20160111072921.GX3331@x1>
References: <1450101234-2191-1-git-send-email-mpa@pengutronix.de>
 <1450101234-2191-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34266 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbcAKH30 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jan 2016 02:29:26 -0500
Received: by mail-wm0-f50.google.com with SMTP id u188so202615844wmu.1
        for <linux-input@vger.kernel.org>; Sun, 10 Jan 2016 23:29:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1450101234-2191-2-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>

On Mon, 14 Dec 2015, Markus Pargmann wrote:

> This documentation describes the devicetree bindings for the
> ADC/Touchscreen unit of the i.MX25 SoC.
>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>=20
> Notes:
>     Changes in v9:
>      - Fixed some style things.
>    =20
>     Changes in v6:
>      - Removed adc-ref property and replaced it with refp and refn fo=
r positive and
>        negative references. The properties are optional now as the de=
fault
>        behaviour is a positive internal reference voltage and ADC GND=
 as negative
>        reference.
>=20
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    | 47 ++++++++++++=
++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-t=
sadc.txt

Binding looks fine, but you need to change the subject line of the
patch, for is it not an ARM, but MFD patch.

> diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.tx=
t b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> new file mode 100644
> index 000000000000..b03505286997
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> @@ -0,0 +1,47 @@
> +Freescale MX25 ADC/TSC MultiFunction Device (MFD)
> +
> +This device combines two general purpose conversion queues one used =
for general
> +ADC and the other used for touchscreens.
> +
> +Required properties:
> + - compatible:			Should be "fsl,imx25-tsadc".
> + - reg:				Start address and size of the memory area of
> + 					the device
> + - interrupts:			Interrupt for this device
> +					(See: ../interrupt-controller/interrupts.txt)
> + - clocks:			An 'ipg' clock (See: ../clock/clock-bindings.txt)
> + - interrupt-controller:	This device is an interrupt controller. It
> +   					controls the interrupts of both
> +					conversion queues.
> + - #interrupt-cells:		Should be '<1>'.
> + - #address-cells:		Should be '<1>'.
> + - #size-cells:			Should be '<1>'.
> +
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
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
