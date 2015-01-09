From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 3/9] ARM: dts: sun7i: Add cpu thermal zones to dtsi
Date: Fri, 9 Jan 2015 14:10:18 -0400
Message-ID: <20150109181016.GC9510@developer>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
 <1420798676-22856-4-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:45523 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbbAISK2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2015 13:10:28 -0500
Content-Disposition: inline
In-Reply-To: <1420798676-22856-4-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 06:17:50PM +0800, Chen-Yu Tsai wrote:
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
>  arch/arm/boot/dts/sun7i-a20.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a=
20.dtsi
> index c2e964939991..61780b144745 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -50,6 +50,7 @@
>  #include "skeleton.dtsi"
> =20
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
> =20
>  #include <dt-bindings/dma/sun4i-a10.h>
>  #include <dt-bindings/pinctrl/sun4i-a10.h>
> @@ -116,6 +117,38 @@
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
> +					temperature =3D <75000>;
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
>  		reg =3D <0x40000000 0x80000000>;
>  	};
> --=20
> 2.1.4
>=20

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsBmAAAoJEMLUO4d9pOJWd0sH/jKrls+Fo40dT7I8HcfeAEPO
xoPHByJJqtBZilHUuJxa4aGjdWEh3JnEOC5N2rLNKRVj3+TwmirMpr5b+Ulyo4ZF
ZjLIuoCrwi8b0xHeGnC2oVGNoP1N20hRzReeDTmhbHLrkMtXWKq1H3uSFgsZFc7p
X2OoarLacxxVdVddT8LapyCG5BwK9z2K9JDVNzo+C2SDQrnFUICrk1mGn7dv2czi
+8Yxum3O7CsI8Jv8n3B97xcw2btTTYTJ9+10aBqbwe1r/hUPgysfx42h13g9hzqT
pxeNEfXAh65uKTye6sCsIrewC7PrgnbuvgTfK8AY9G/J2d92TirIJNt5blaiYqg=
=Te12
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
