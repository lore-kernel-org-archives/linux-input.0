From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 05/17] ARM: dts: sunxi: Enable thermal sensor support for
 RTP on sun[457]i
Date: Tue, 6 Jan 2015 11:25:33 -0400
Message-ID: <20150106152531.GB6276@developer>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-6-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420511727-8242-6-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:15AM +0800, Chen-Yu Tsai wrote:
> Now that the resistive touchpanel driver supports thermal sensors,
> add the "#thermal-sensor-cells" property as required by the thermal
> framework.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi  | 1 +
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 1 +
>  arch/arm/boot/dts/sun5i-a13.dtsi  | 1 +
>  arch/arm/boot/dts/sun7i-a20.dtsi  | 1 +
>  4 files changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index 847d5e09fcfb..f92635ecb937 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -712,6 +712,7 @@
>  			compatible =3D "allwinner,sun4i-a10-ts";
>  			reg =3D <0x01c25000 0x100>;
>  			interrupts =3D <29>;
> +			#thermal-sensor-cells =3D <0>;
>  		};
> =20
>  		uart0: serial@01c28000 {
> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-=
a10s.dtsi
> index 3c3c1920788a..8d324ef7e46e 100644
> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> @@ -535,6 +535,7 @@
>  			compatible =3D "allwinner,sun4i-a10-ts";
>  			reg =3D <0x01c25000 0x100>;
>  			interrupts =3D <29>;
> +			#thermal-sensor-cells =3D <0>;
>  		};
> =20
>  		uart0: serial@01c28000 {
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a=
13.dtsi
> index 2448d7f38d6b..4fe0bd192e29 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -469,6 +469,7 @@
>  			compatible =3D "allwinner,sun4i-a10-ts";
>  			reg =3D <0x01c25000 0x100>;
>  			interrupts =3D <29>;
> +			#thermal-sensor-cells =3D <0>;
>  		};
> =20
>  		uart1: serial@01c28400 {
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a=
20.dtsi
> index e21ce5992d56..01c7133e699c 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -926,6 +926,7 @@
>  			compatible =3D "allwinner,sun4i-a10-ts";
>  			reg =3D <0x01c25000 0x100>;
>  			interrupts =3D <0 29 4>;
> +			#thermal-sensor-cells =3D <0>;
>  		};
> =20
>  		uart0: serial@01c28000 {
> --=20
> 2.1.4
>=20

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq/5jAAoJEMLUO4d9pOJWE+oH/1x/0HG+QSPS8G/cNB+sDoFi
NVCgO1BKfbLW7zFfiyJWoi9Li/RJUPCXp5jdsEMSwpMzU/orEPqeKKX/tKBsKwFG
5eznGgqlBeDua/WEFHxTtOY8TSFS+5MEq3z9G0OlUwK1FLmVV/AEqpZid5NGDsah
TXb8g4yIebKsbp5OhTJDdrH9SNSlO02cFU3cp9mnBzqg53yM9MEZR3W1efezDffz
dZTvYuB6hNqYHMW/Uywfh/sQS45erjA2fFO8u9/xwROoC81FwJfqSnk6rXucnllF
bPtCX3i52Vp/tGAKNVZ0hJajukbvB3IsHCjSHGgOhpQyhpYAxmb1BD+45CnjPW0=
=czYR
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
