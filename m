From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 2/5] Documentation: Detail permitted DT properties for
 the imx6ul_tsc
Date: Wed, 19 Aug 2015 07:54:34 +0200
Message-ID: <20150819055434.GF11161@pengutronix.de>
References: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
 <1438077521-12857-3-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438077521-12857-3-git-send-email-haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 28, 2015 at 05:58:38PM +0800, Haibo Chen wrote:
> Here we apply required documentation for the imx6ul touch screen
> controller driver which describe available properties and how to
> use them.
>=20
> Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/imx6ul_tsc.txt      | 36 ++++++++++++++++=
++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/i=
mx6ul_tsc.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_t=
sc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> new file mode 100644
> index 0000000..ac41c32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> @@ -0,0 +1,36 @@
> +* Freescale i.MX6UL Touch Controller
> +
> +Required properties:
> +- compatible: must be "fsl,imx6ul-tsc".
> +- reg: this touch controller address and the ADC2 address.

This suggests that this driver is using a unit ADC2. Which also means
that there are more than one ADC which are probably identical?

Shouldn't these ADCs be properly described by their own device nodes
instead of these two register ranges, two interrupts and two clocks?

Is 'ADC2' usable without tsc? Then ADC1/ADC2 should perhaps get a proper
IIO driver.

Unfortunately I don't have the reference manual to have a look how this
all works.

Best regards,

Markus

> +- interrupts: the interrupt of this touch controller and ADC2.
> +- clocks: the root clock of touch controller and ADC2.
> +- clock-names; must be "tsc" and "adc".
> +- xnur-gpio: the X- gpio this controller connect to.
> +  This xnur-gpio returns to high once the finger leave the touch screen =
(The
> +  last touch event the touch controller capture).
> +
> +Optional properties:
> +- measure-delay-time: the value of measure delay time.
> +  Before X-axis or Y-axis measurement, the screen need some time before
> +  even potential distribution ready.
> +  This value depends on the touch screen.
> +- pre-charge-time: the touch screen need some time to precharge.
> +  This value depends on the touch screen.
> +
> +Example:
> +	tsc: tsc@02040000 {
> +		compatible =3D "fsl,imx6ul-tsc";
> +		reg =3D <0x02040000 0x4000>, <0x0219c000 0x4000>;
> +		interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&clks IMX6UL_CLK_IPG>,
> +			 <&clks IMX6UL_CLK_ADC2>;
> +		clock-names =3D "tsc", "adc";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_tsc>;
> +		xnur-gpio =3D <&gpio1 3 GPIO_ACTIVE_HIGH>;
> +		measure-delay-time =3D <0xfff>;
> +		pre-charge-time =3D <0xffff>;
> +		status =3D "okay";
> +	};
> --=20
> 1.9.1
>=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1BoZAAoJEEpcgKtcEGQQ2CgP/3v+N1qurHoncjH6qIV17YH2
ej9gTbV99lQklkiUDUvYNeyz94CvCv53rSztCluoNxbyRZbj4/FaOJwvrZFyKJLB
RqY/H4Ja4UwzlMo0ZQATJ446RCWThT7zhgqWhUwOcqWZtvw0ostD+FxIRDthC6uo
P7sTidVjZrogbmVeMTFFGz/7MUqNhXBPqVZkZPCuFVAFec3GJR6Ytx3KEEjHg5jS
x8xqnZ+bA0Zau1YWi8WkJjXUJUSiLOghzSz62nR5dNATqGFnwZhsV8BBzm1MDQs8
QuWASogMboocW3BrpTX0eC2JD8HbzbPdcmfKcHJsubGCwrDdMbERACU5h0gD4sP/
Qx9+R9JyUEV9yQhQlQDSsgS//JYZp3sPhichyRvfUM0WvxE/h54vtAY1AnUwzL5H
Hk6lG/fMnWfrGIUX8zk505xT0m0C3B06tNeGQpCeK4QRgA52C4EqgDswypeTcmng
QwoD9PgMZD4t/kyGnwurTjWvB34PYqU4AiThxerw8DciK2CrShGVAhBxEhqR8bbP
ATJKyzgJQxWBY9l2cxQPdsDuE6FQbhGUs+YYI5mYKhUZHg5e+MGYR+motobEMFaK
IcLJXfTxaH51AT7Z6r6aLOGgKJctUCVu7n2UJgmzHW+/oSgWUuFIRY5MaYzmMgm8
HrIEyAXHe+X8tK7Bk6X6
=CuhO
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
