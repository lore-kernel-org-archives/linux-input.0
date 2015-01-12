From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 4/9] ARM: dts: sun7i: cubieboard2: add axp209
 regulator nodes
Date: Mon, 12 Jan 2015 10:06:03 +0100
Message-ID: <20150112090603.GE4891@lukather>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
 <1421037249-28461-5-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421037249-28461-5-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu,

On Mon, Jan 12, 2015 at 12:34:04PM +0800, Chen-Yu Tsai wrote:
> This patch adds the regulator nodes for the axp209 by including
> the axp209 dtsi. As the inputs of these regulators are from the
> axp209's PS output, which is basically just a mux over the 2
> inputs, it is considered to be unregulated. Thus we do not provide
> input supply properties for them.
>=20
> The regulator names and constraints are based on the board
> schematics and the SoC datasheet.
>=20
> DCDC2 is used as the cpu power supply. This patch also references
> it from the cpu node.
>=20
> Also get rid of axp209 properties already set in axp209.dtsi.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>=20
> changes since v2
>=20
>     none
>=20
> changes since v1:
>=20
>     - Use preprocessor include for axp209.dtsi
>     - Remove incorrectly squashed axp209.dtsi patch
>=20
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 35 +++++++++++++++++++++++=
++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/=
dts/sun7i-a20-cubieboard2.dts
> index 18fc5db9c976..ec1fc2c8b3e3 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -88,13 +88,9 @@
>  			status =3D "okay";
> =20
>  			axp209: pmic@34 {
> -				compatible =3D "x-powers,axp209";
>  				reg =3D <0x34>;
>  				interrupt-parent =3D <&nmi_intc>;
>  				interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> -
> -				interrupt-controller;
> -				#interrupt-cells =3D <1>;
>  			};
>  		};
> =20
> @@ -145,3 +141,34 @@
>  		status =3D "okay";
>  	};
>  };
> +
> +#include "axp209.dtsi"
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1450000>;
> +	regulator-name =3D "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1400000>;
> +	regulator-name =3D "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name =3D "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3000000>;
> +	regulator-max-microvolt =3D <3000000>;
> +	regulator-name =3D "avcc";
> +};

How do reg_vcc3v3 and the other reg used in this DT (ahci, USB) fit
into that?

Eventually, I think we would be able to remove
sunxi-common-regulators.dtsi, or at least, expose the proper regulator
hierarchy.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUs457AAoJEBx+YmzsjxAgODMQAJO0tIp7Mmqkh3sYcJMZyT98
VK7vXGz+WQIi8H8TGXoS+K4/NBugtPjpA+CNQI0a1nYQoC3fimHGmXRMO4r32fPo
g2YhPwCEoanT/bbg4B8gP7wNKlmYNYrl7s3DpBHI6xGmisfYO4MJ815Ki8utX+yk
sFm19F8qFDu209OaBLoLq7V2rN/OfJJVGTkwbn9JVhMgAjyoNxIlEs29SHVI/3ZA
3d8hh0VTk4lYw1mSB1n89fxG5XcTaqcOigKjDThz0rXpGvNT5sz9Dpy5grQVce12
QaCaHn3T+9BH05DXzNl8dgHMMnx4Xpu5/DlkPws3SGDD/IejZNpZF3hOsVDozg75
S3S9e9CK/c/GeWr/JDK7pBfenhHra+2zDYCqNOs+wJm/Kz+tvgl07IFY9z2r6gJH
5qrDuxbAF5TRlW1xgKHbxx4admIGEoop2yI9g+yG0pr7EmdKlwWA9B2ZlHHrfE+w
6rRkEycXq+X3TURmUt7s9Bqn+xhSYjfLKVLl8Jl+lULxktQNsrMLemGA9KhaEW/7
WXNmNTW9CMJXQFGfcruZe4bQRM3PAkdQvgVIYEBFwIXORYeGWCwLLyRRraLiuleI
3YcpuQHjnISUQY8RdXRnHqlVmjS21RN5C7gT90h0WOm0RuVIBb8shiTtNRp6M2lB
7hFFnEbsBXk2PsgxkUzL
=D1N0
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
