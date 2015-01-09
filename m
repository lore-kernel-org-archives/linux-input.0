From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 6/9] ARM: dts: sun5i: Add cpu thermal zones to dtsi
Date: Fri, 9 Jan 2015 14:10:58 -0400
Message-ID: <20150109181056.GD9510@developer>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
 <1420798676-22856-7-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:35184 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbbAISLJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2015 13:11:09 -0500
Content-Disposition: inline
In-Reply-To: <1420798676-22856-7-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 06:17:53PM +0800, Chen-Yu Tsai wrote:
> The core temperature sensor now supports thermal zones. Add a thermal
> zone mapping for the cpus with passive cooling (cpufreq throttling).
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This patch looks fine to me:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>=20
> changes since v1:
>=20
>     - Use thermal dt bindings macros in cooling-device
>=20
> ---
>  arch/arm/boot/dts/sun5i-a13.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a=
13.dtsi
> index dee2aa5bc9ed..c26f58ea0850 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -13,6 +13,8 @@
> =20
>  #include "skeleton.dtsi"
> =20
> +#include <dt-bindings/thermal/thermal.h>
> +
>  #include <dt-bindings/dma/sun4i-a10.h>
>  #include <dt-bindings/pinctrl/sun4i-a10.h>
> =20
> @@ -50,6 +52,38 @@
>  		};
>  	};
> =20
> +	thermal-zones {
> +		cpu_thermal {
> +			/* milliseconds */
> +			polling-delay-passive =3D <250>;
> +			polling-delay =3D <1000>;
> +			thermal-sensors =3D <&rtp>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu_alert0>;
> +					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +
> +			trips {
> +				cpu_alert0: cpu_alert0 {
> +					/* milliCelsius */
> +					temperature =3D <850000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				cpu_crit: cpu_crit {
> +					/* milliCelsius */
> +					temperature =3D <100000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	memory {
>  		reg =3D <0x40000000 0x20000000>;
>  	};
> --=20
> 2.1.4
>=20

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsBmoAAoJEMLUO4d9pOJWzoYH/iORXnRZsorWvMx2Vkpm8v6m
YFRluv7s6HjyvYEg1iid/ZJIoa+6yPFoNOkfxClYieZgSQhmb/fFU6t74v3Kk8nJ
JXjlRmVfg7TbFq+Y5jrkZYgo90mkpcPNDKVMF6R4lIFJ34EZv88Oor+BhYMP6z0f
LZo9632C0gTgqNkmHTIVexsOb9NfZzjHSrZq4eHSbyRisgoalLAAaChyc8qXd3Y+
YPtb72x75FyvnZzmwd1IIXk60JxP4IZieTE7aEeu1hq6TJaN73cYPTEJVZNOIEd3
ikYNrrRJ++Bo0b8QzxGavxIK7NkVNh+a1K1O3dv+Xd8dlKn7wye2cMmizbD8K/Y=
=pmDD
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
