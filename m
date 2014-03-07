From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/7] mfd: AXP20x: Add bindings documentation
Date: Fri, 7 Mar 2014 19:13:00 +0100
Message-ID: <20140307181300.GZ607@lukather>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-3-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SuZWD+5recMkC1v4"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBJ4Z5CMAKGQE35QFQJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393692352-10839-3-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--SuZWD+5recMkC1v4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2014 at 05:45:47PM +0100, Carlo Caione wrote:
> Bindings documentation for the AXP20x driver. In this file also two
> sub-nodes (PEK and regulators) are documented.
>=20
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 93 ++++++++++++++++++=
++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documenta=
tion/devicetree/bindings/mfd/axp20x.txt
> new file mode 100644
> index 0000000..ae3e3c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -0,0 +1,93 @@
> +* axp20x device tree bindings
> +
> +The axp20x family current members :-
> +axp202 (X-Powers)
> +axp209 (X-Powers)
> +
> +Required properties:
> +- compatible 			: Should be "x-powers,axp202" or "x-powers,axp209"
> +- interrupt-controller 		: axp20x has its own internal IRQs
> +- #interrupt-cells 		: Should be set to 1
> +- interrupt-parent 		: The parent interrupt controller
> +- interrupts 			: Interrupt specifiers for interrupt sources
> +- reg 				: The I2C slave address for the AXP chip
> +- axp,system-power-controller	: Telling whether or not this pmic is
> +				  controlling the system power
> +
> +Sub-nodes:
> +* regulators : Contain the regulator nodes. The regulators are bound usi=
ng
> +	       their name as listed here: dcdc2, dcdc3, ldo1, ldo2, ldo3,
> +	       ldo4, ldo5.
> +	       The bindings details of individual regulator device can be found=
 in:
> +	       Documentation/devicetree/bindings/regulator/regulator.txt with t=
he
> +	       exception of:
> +
> +	- dcdc-freq		: defines the work frequency of DC-DC in KHz
> +				  (range: 750-1875)
> +	- dcdc-workmode		: 1 for PWM mode, 0 for AUTO mode

You don't seem to always set this. You should mention that it is
optional, and which default value it has.

> +
> +* axp20x-pek : Power Enable Key
> +	- compatible		: should be "x-powers,axp20x-pek"

Why is this needed for?

Plus, please don't use any generic, or pattern matching compatibles,
but rather precise ones, so that if it is needed, we can add any quirk
we want.


> +Example:
> +
> +axp: axp20x@34 {
> +	reg =3D <0x34>;
> +	interrupt-parent =3D <&nmi_intc>;
> +	interrupts =3D <0 8>;
> +
> +	axp,system-power-controller;
> +
> +	compatible =3D "x-powers,axp209";
> +	interrupt-controller;
> +	#interrupt-cells =3D <1>;
> +
> +	axp20x-pek {
> +		compatible =3D "x-powers,axp20x-pek";
> +	};
> +
> +	regulators {
> +		dcdc-freq =3D "8";
> +
> +		axp_dcdc2: dcdc2 {
> +			regulator-min-microvolt =3D <700000>;
> +			regulator-max-microvolt =3D <2275000>;
> +			dcdc-workmode =3D <0>;
> +			regulator-always-on;
> +		};
> +
> +		axp_dcdc3: dcdc3 {
> +			regulator-min-microvolt =3D <700000>;
> +			regulator-max-microvolt =3D <3500000>;
> +			dcdc-workmode =3D <0>;
> +			regulator-always-on;
> +		};
> +
> +		axp_ldo1: ldo1 {
> +			regulator-min-microvolt =3D <1300000>;
> +			regulator-max-microvolt =3D <1300000>;
> +		};
> +
> +		axp_ldo2: ldo2 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		axp_ldo3: ldo3 {
> +			regulator-min-microvolt =3D <700000>;
> +			regulator-max-microvolt =3D <3500000>;
> +		};
> +
> +		axp_ldo4: ldo4 {
> +			regulator-min-microvolt =3D <1250000>;
> +			regulator-max-microvolt =3D <3300000>;
> +		};
> +
> +		axp_ldo5: ldo5 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <3300000>;
> +		};
> +	};
> +};
> +
> --=20
> 1.8.3.2
>=20

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--SuZWD+5recMkC1v4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTGgwrAAoJEBx+YmzsjxAg7SsP/1R+5hSQI6pSVPKesfWb1iFp
/2wTh2rQkDR0C6nRyZoPcTrIfRDhl/iXV2cCTmW2pOC6yEW5uDkvdvpn2lEsyHOP
I3ONO6o7yJtd+PfCttqAgWaR5hMtGjQJKpN6brkHbF9WhwYAEWlMBL+4m42/TQi5
qTNsgOxUmJpVWkf68g3s1Cv0Asp2QsjvQvhgQsFuE65uZuJsQeHi5ekUSswNtbpo
qGsw/tUEXXcIQquxMZAIhDsU1tiV/06SBkKcDULNcrpsMl4CB6Q7oBBbv9hRjOcL
7p64XB8dgxkrZmTRWe0nWv1r2L5zr4fWwPTP/n0I5qv90vY0KYYqrpOeMA+s1wVV
ekDwFrTCf9o5t5HQy3YbIewMUTFHpbPku13nTOT+dEiEnoC0qHFHnNDW+kY+b6Ru
dZQnmX3dZpHCFidlpDwu3IhoeGldkosgPI+Q4UVpxYWqNp9i1byYYt4echPO54UZ
mbhIUs/j2IzrMgRvyTsps1lgzYHNRJAOuP07cfez3kHBAt89FBhziP0/kM0zRnFZ
K6Lbi9xqKp0cctGLUVoxjIdiYZcxieOtfmUDhYNm4evA7NiCvvJXcCzRpnknZ7n3
K6u6Dl4w9XDTXET5gsf9afGpcl80ZkoTd0qxjioNYTRBP+0JNBSoyChAyiDGSKFd
LivOhB9jSU2/VaY6DA8m
=ee+l
-----END PGP SIGNATURE-----

--SuZWD+5recMkC1v4--
