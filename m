From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 3/5] arm: dts: sun8i: a83t: a711: Enable I2C0
Date: Mon, 11 Dec 2017 08:18:01 +0100
Message-ID: <20171211071801.ekdzbimk5nvlvekr@flea.lan>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
 <20171208215419.30396-4-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pwxi2hi2goctnmj4"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51939 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbdLKHSC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Dec 2017 02:18:02 -0500
Content-Disposition: inline
In-Reply-To: <20171208215419.30396-4-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, simon.budig@kernelconcepts.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com


--pwxi2hi2goctnmj4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 08, 2017 at 10:54:17PM +0100, Myl=E8ne Josserand wrote:
> The A711 has a touchscreen connected by I2C0.
> Enable only I2C0 node for the moment.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dt=
s/sun8i-a83t-tbs-a711.dts
> index a021ee6da396..84cca1a48cea 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -105,6 +105,13 @@
>  	status =3D "okay";
>  };
> =20
> +&i2c0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c0_pins>;

If there's only one set of pins, maybe we should force that muxing in
the DTSI?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--pwxi2hi2goctnmj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlouMSUACgkQ0rTAlCFN
r3Txnw/4os801IV5pqqyfTEKogFmGhysgg7sAyWN0Z0o+v0JNYC7d3nrFXtnHiyr
ZaNYj1lGrF55aP34cdTO5CYbyXIWh5sns2UWKuU594QD8hFcZoNxddSxvpkBLIMY
/726G81jWamwtHynfedAgySCur2kqndax4oboj9fyg1D+n0o3NTupH9rohZtUWB4
jlKpDBQpzFSqA2AgGbvTKX9g9nEUve2s84bvzRDpAEezwYKif/9/KdB5J8JjeQp+
jOo4oEBYszZmmrfBNFl6Go2YB2ly43F/6nSisJGTFGr42SlT3bQ0/lF6Tr9W9yR3
Oo0YewC/7y2LoejMctLg39FT+wEqqvnUT4S5xa82Wq0sRT8X8wuOH/YGLf6buOgw
dNWSMJfZuni+TjHcKMp0Aeyeg+KWq0qB6xpVTRe4tCNJUW8/eX29A3F9C9sRafSk
PuLPYesPMRHgxb1JGEdZC+te/VWAHsGINtX6+9b5Jn9A8Mi45TkpAIIz+093AiOo
nRbylBO2oLHsncLMH6qia4CMdL+eUG0DQxNANU7+YACNaSVQermjmqh3cn2Ygf1v
OW4o5O912mSVOX4Xzze3gtJNS7tePE6imLDgWa1XCScSgVeZwASBEQ8wy91l1cIO
Vl7NAoEWIuhugUhO8teSdJjIA24TSPTAnjzd32bu8XufPFigyw==
=FJUm
-----END PGP SIGNATURE-----

--pwxi2hi2goctnmj4--
