From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 07/17] ARM: dts: sun7i: Add cpu thermal zones to dtsi
Date: Tue, 6 Jan 2015 11:28:15 -0400
Message-ID: <20150106152813.GC6276@developer>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-8-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420511727-8242-8-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:17AM +0800, Chen-Yu Tsai wrote:
> The core temperature sensor now supports thermal zones. Add a thermal
> zone mapping for the cpus with passive cooling (cpufreq throttling).
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a=
20.dtsi
> index 887b0521bbfb..951e99ed3aa9 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -111,6 +111,38 @@
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

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq/8FAAoJEMLUO4d9pOJWxx4IAJK6FnokisVdV1Ft4ZCUB/he
D6d2mIvIQORrVBQE/0nhDlVSvWFE/3m286t3/3j/V0Lm7G3NPfbEJDKDdi/9jfLu
SxdH+gGvvT3f72KKiDz4wDNwj3Ut/eEPUYY8/9V9ujRe51ub0WSC7Qop/RSC58XN
bsISSGKjvkL8WjJvWl0v8zIMbosh/S5thwDjblzUktr/hSyNvzJ7qcWs3oRAsejK
hXTSEsC5gkM8xFb10rEv8TP0ZRKGhssM8ckOKG3xK7JTrFKJHsUrD7Y2oLcDV8ow
TJaw+U42ext2if7UTwybV4v1D/S+41SbaGeEhhjOVMbLWaG80ENUrbWVHtOzFRM=
=L91/
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
