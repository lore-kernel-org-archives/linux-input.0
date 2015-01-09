From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 6/9] ARM: dts: sun5i: Add cpu thermal zones to dtsi
Date: Fri, 9 Jan 2015 14:11:38 -0400
Message-ID: <20150109181137.GE9510@developer>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
 <1420798676-22856-7-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8856284611529167227=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1420798676-22856-7-git-send-email-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


--===============8856284611529167227==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline


--AjmyJqqohANyBN/e
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

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsBnOAAoJEMLUO4d9pOJWfcIH/3yk/ZDtTVnWZXOgVB3tRM+8
amZb6+vyFPZW4Zq22BomTHWJvM0l4ovEEF55KQs81HE+RDtpGnjI9OcuFzfxDZWD
FFCPOyw5opJkDZNXrtpN987O5ynbDiQyFfhLonAwtWH+a49ZBpJXUT5MstVEqi2s
OEV7dDBSdzFSIlPhIkWxGql4qTPo0QjuRXoUABy77FIzEa1y2EQcTsfnnsVSjapw
YiLqHwZlWLTEY/jyPd4+JNHJfNggsS9zD38hnYDX811AOJLxnVLHK3u8MwY0TG1C
/JCXcJS6BEdWyS+amFXUo5g0qCS5wjtKAnsY5jozGlpK0kluyyOqnCdiuBCLSeg=
=isLX
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--


--===============8856284611529167227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8856284611529167227==--
