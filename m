From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/7] ARM: dts: cubieboard2: Add AXP209 support
Date: Fri, 7 Mar 2014 19:13:48 +0100
Message-ID: <20140307181348.GA607@lukather>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-4-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ehgLApe97pcc1Rh5"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBJ4Z5CMAKGQE35QFQJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393692352-10839-4-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--ehgLApe97pcc1Rh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2014 at 05:45:48PM +0100, Carlo Caione wrote:
> AXP209 is the PMU used by Cubieboard2. This patch enable the core
> support in the dts file.
> This patch requires: "ARM: sun7i/sun6i: irqchip: Add irqchip driver for
> NMI controller"

That shouldn't be in the commit log itself.

>=20
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/=
dts/sun7i-a20-cubieboard2.dts
> index 5c51cb8..234b14b 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -53,6 +53,20 @@
>  			pinctrl-names =3D "default";
>  			pinctrl-0 =3D <&i2c0_pins_a>;
>  			status =3D "okay";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			axp: axp20x@34 {
> +				reg =3D <0x34>;
> +				interrupt-parent =3D <&nmi_intc>;
> +				interrupts =3D <0 8>;
> +
> +				axp,system-power-controller;
> +
> +				compatible =3D "x-powers,axp209";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
>  		};
> =20
>  		i2c1: i2c@01c2b000 {
> --=20
> 1.8.3.2
>=20

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ehgLApe97pcc1Rh5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTGgxbAAoJEBx+YmzsjxAgxrQQAIL4l8nex3sauANX8/UpCF2Z
u18JwTmyj+RrfrFZ3ZXoF9Rx+92PxBVRLV8BS2rfSklYS47uydQefybApKEtP4Yu
THkjOIM08TKMNHho4aJvuaBzfygMwRDFUuebulPjx8RFyTLsBKk7YC3YuOvBpEGf
33OZWaO7J5S3+leW8IKrDghHsWZDFqhHjPjDKhPOyZBkEloNO5OsrT1Cb8o2VrSN
QPEZe+haBAEX52ss1w6/ivnBhyZT9kG7jwrBIlkcM3Aei/hH1liFtVHrIdhUYgzD
9zjHqlkd0ByleAISnCDbWaM5h4z75c0Xs0t4Tu3tEdn0YBKnQxwF3xndnK6AFfRv
TF6qWph7OA6xUaU/rMzT4OxtcgWJcBhwyBglLbtgUppghgzzRLGIQdivl07unUBi
ApH4HLeud0qyr0V2otXwGBRltOXvThl5TT+5SeoHAbRTCqnIEovNqGJ21zU5ibwa
pJVKYALu8WQ/wOuMkqwXXhLW1TsOy5QgOmbU13SdKgc3qOoqHPXQ3VJB6tm0AbOD
0Fch29RElp6SwX/2Mbnm0xnfYca2PELSr0DOmh2jjHEvzfHZ+vOtQJAzAa502awL
EQ0ut1m5fpIa5x25e0E/3i6MvSoGq+EW8DLj+WCrjrfwMSubx0VoNZ1gvsGvzy2b
zrS4vyflamIcRcwG8G+c
=+Vc+
-----END PGP SIGNATURE-----

--ehgLApe97pcc1Rh5--
