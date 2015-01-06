From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 14/17] ARM: dts: sun4i: Add cpu thermal zones to dtsi
Date: Tue, 6 Jan 2015 11:29:01 -0400
Message-ID: <20150106152858.GD6276@developer>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-15-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420511727-8242-15-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:24AM +0800, Chen-Yu Tsai wrote:
> The core temperature sensor now supports thermal zones. Add a thermal
> zone mapping for the cpus with passive cooling (cpufreq throttling).
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index ce3af83dd80b..eb626833ac86 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -64,6 +64,38 @@
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
>  		reg =3D <0x40000000 0x80000000>;
>  	};
> --=20
> 2.1.4
>=20

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq/8yAAoJEMLUO4d9pOJWNf4H/1zSgZQ78BR/s4jq/V9kvyq/
rnnuXUM2PjN9LKB0SYxHbDmlYv9CFZHJ7OM1kbVDT0nhY9V+zB8uxzWcAbmAq2wa
I0xLeSM1L0nJf18rgVUZJU6rEJk2lPygwB66mAv9XZrN3QyzmdB92ROjT9nAEt5q
ixus5HP1wY0QLHqKzcAdFFrjGGXJluBw0qPq1BK+Ff13DWDNmh+1msdfL7win1ec
0I+IKR/fpD9G6oh0oLOOCRk6FfMW3wIC3UoPmc/rsCtwZWqcxsChdI2/QLq9RwgW
1gqUdpJ2qkowaYDpvvXFSa1GZKLj7sXr2663P6EwwbIl8cH0DycoTa2Ts3tyw1w=
=JF9h
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
