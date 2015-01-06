From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 08/17] ARM: dts: sun7i: cubieboard2: add axp209 regulator
 nodes
Date: Tue, 6 Jan 2015 17:11:02 +0100
Message-ID: <20150106161102.GV7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-9-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VpY0yS1BYpNZumir"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420511727-8242-9-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--VpY0yS1BYpNZumir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 06, 2015 at 10:35:18AM +0800, Chen-Yu Tsai wrote:
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
>  arch/arm/boot/dts/axp209.dtsi               |  4 ++++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 35 +++++++++++++++++++++++=
++----
>  2 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> index 3c38cbafe285..fec3364b2110 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -54,6 +54,10 @@
>   */
> =20
>  &axp209 {
> +	compatible =3D "x-powers,axp209";
> +	interrupt-controller;
> +	#interrupt-cells =3D <1>;
> +

This should be in your patch adding the AXP DTSI.

>  	regulators {
>  		/* Default work frequency for buck regulators */
>  		x-powers,dcdc-freq =3D <1500>;
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/=
dts/sun7i-a20-cubieboard2.dts
> index 53680983461a..61e61c0eb829 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -84,13 +84,9 @@
>  			status =3D "okay";
> =20
>  			axp209: pmic@34 {
> -				compatible =3D "x-powers,axp209";
>  				reg =3D <0x34>;
>  				interrupt-parent =3D <&nmi_intc>;
>  				interrupts =3D <0 8>;
> -
> -				interrupt-controller;
> -				#interrupt-cells =3D <1>;
>  			};
>  		};
> =20
> @@ -141,3 +137,34 @@
>  		status =3D "okay";
>  	};
>  };
> +
> +/include/ "axp209.dtsi"

We've switched to preprocessor includes, please use them instead.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--VpY0yS1BYpNZumir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrAkVAAoJEBx+YmzsjxAgoVUP/AymILRckSCBndImF+h5/tg4
QWHRZvyxbQ/WzG3S4II6T979M7rxlMx4n8DC/ITB8pi01607tadziwyJAUE+2RBN
ZEpLQD0yaxA4GQzAd4bTLrnTU4j96qE7uwNbyP/pX38FvzYYOfY5XfrcACpri5Ku
ayCHEBQF5HilzwGcuRNp8jaG2P8wJdxuSjgYZFH2bbvkpPikSFKz7FIpnEjFPx84
qKrlLXKKFBmhhcxLyUkteeMOOsd5vDG6jzht/MIsi4xXmeJ/GM6xQygz/cFi3/k8
7eLtmzS9mQUS3F4L5ib6HDzO60tybAo60TsUmZzywT9Tyv/Pi+TXEAndEdcLMZM+
dz3B68pPrNpI4z3Usnf4w9bzLMD3Ztwq0C21pO9yUpxA2a1tICAs0vNmRwdQS978
wzjJG3iTwVjplrMIuAoWLXcz7Uz3oWHJktRc/K7RM8ITuThSq5XATfsQ8cQpBJko
WbpAy4xGA30I5z1N2xYgioXZ95ST1zRmHaQsHnY1pj2K4wYdoWtXRTIie15YsR2K
kaPngy7V/QjZUPB2GBNpDw4gvnagLpkSaP4SEa2aaDYNNyleq/ejqZiIYlr4V9Q7
A7UD3KQm+7Q4wJjCtfrVfm4vT6UJJtdsoa2vwsgyeVFa3TZZMLRTEikW6AqGbszb
eiZvhXVuDoRTs8uzLgoJ
=B8yd
-----END PGP SIGNATURE-----

--VpY0yS1BYpNZumir--
