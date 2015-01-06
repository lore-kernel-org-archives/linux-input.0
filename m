From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 11/17] ARM: dts: sun5i: Add cpu thermal zones to dtsi
Date: Tue, 6 Jan 2015 11:30:04 -0400
Message-ID: <20150106153002.GE6276@developer>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-12-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420511727-8242-12-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:21AM +0800, Chen-Yu Tsai wrote:
> The core temperature sensor now supports thermal zones. Add a thermal
> zone mapping for the cpus with passive cooling (cpufreq throttling).
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun5i-a13.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a=
13.dtsi
> index dd93d227865e..9140cc7c8944 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -47,6 +47,38 @@
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
> +					cooling-device =3D <&cpu0 (-1) (-1)>;

same


Could you please:
+#include <dt-bindings/thermal/thermal.h>

and

+					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

?

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

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq/9yAAoJEMLUO4d9pOJWBKQIAInMs2U/Vpwj/rFYFO5zjr5y
TA7oUrQbilH5oAdWQyxMFer/8k0IpaO/dG8x2cbmmHZeMbcv1Q8ee4E6tmwvCJ3K
eXxr2CkxFKNCZki4kT17wnBkvSKcXgtB77UM9CBDu+/bSa0XwqxYSiEpsY/kn0Tc
wbE1J7RcbWrQzb3wlK5KppQu7FXt616Z4HrktlaYXkFwrkTQ+O0fP60pt0kiyppZ
qFc7xrNEmr5xzgePYGvctYWGpgp+i6WSJHb7lcXYmAGJi6paCie+JiLHPGXVf3Uo
sAokJ1AXbzpBhxuU+Eaa9Ow0mpbn3C+5Sk5M0Fpg8GAw7SElBAs2vNnosP1M4z8=
=4gV+
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
