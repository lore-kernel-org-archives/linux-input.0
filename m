From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Fri, 2 May 2014 18:09:36 -0700
Message-ID: <20140503010936.GF4090@lukather>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-9-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBFMESGNQKGQEK5VO42Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398947374-3115-9-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 01, 2014 at 02:29:34PM +0200, Carlo Caione wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 58 +++++++++++++++++++=
+++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 58 +++++++++++++++++++=
+++
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 64 +++++++++++++++++++=
+++++
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 58 +++++++++++++++++++=
+++
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 65 +++++++++++++++++++=
++++++
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 64 +++++++++++++++++++=
+++++
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 58 +++++++++++++++++++=
+++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 59 +++++++++++++++++++=
+++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 59 +++++++++++++++++++=
+++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 59 +++++++++++++++++++=
+++
>  10 files changed, 602 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/su=
n4i-a10-a1000.dts
> index fa746aea..57d3fb4 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -88,6 +88,56 @@
>  			pinctrl-names =3D "default";
>  			pinctrl-0 =3D <&i2c0_pins_a>;
>  			status =3D "okay";
> +
> +			axp209: pmic@34 {
> +				compatible =3D "x-powers,axp209";
> +				reg =3D <0x34>;
> +				interrupts =3D <0>;
> +
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +
> +				acin-supply =3D <&reg_axp_ipsout>;
> +				vin2-supply =3D <&reg_axp_ipsout>;
> +				vin3-supply =3D <&reg_axp_ipsout>;
> +				ldo24in-supply =3D <&reg_axp_ipsout>;
> +				ldo3in-supply =3D <&reg_axp_ipsout>;
> +				ldo5in-supply =3D <&reg_axp_ipsout>;
> +
> +				regulators {
> +					x-powers,dcdc-freq =3D <1500>;
> +
> +					axp_vcore_reg: dcdc2 {
> +						regulator-min-microvolt =3D <700000>;
> +						regulator-max-microvolt =3D <2275000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_ddr_reg: dcdc3 {
> +						regulator-always-on;
> +					};
> +
> +					axp_rtc_reg: ldo1 {
> +						regulator-always-on;
> +					};
> +
> +					axp_analog_reg: ldo2 {
> +						regulator-always-on;
> +					};
> +
> +					axp_pll_reg: ldo3 {
> +						regulator-always-on;
> +					};
> +
> +					axp_hdmi_reg: ldo4 {
> +						regulator-always-on;
> +					};
> +
> +					axp_mic_reg: ldo5 {
> +						regulator-always-on;

Do all these regulators need to be always on? It makes sense for the
pll and vcore, but I don't get why the mic and hdmi regulators need
this.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTZEHQAAoJEBx+YmzsjxAgDiwP/jyptroqnCqV49v1R1+eMSde
6spCF+wmEAQHGATSEKMLSVvcGkiBLK+0dIhBXSQ72lUtw0qGc02YVaqCpERj6WrE
Awdz86aVnyAQxl8LT8/W/KQLFzECKpt8hvzfSu5cfacyW/mJzkP6WZ42YkqBIEo1
kYYvN7o4B3zo3Q3MJMEARmTGjWOAVUhUnTQ+ePT57wZZwS1s420MX+M2myPWDF5V
v2vwYPMpe5u7A9sF3rW79M3OdEnTG8LQu+gEaBrsCFyI992f1rzHKKO54dJeZKMB
Nelh6nUpP3v14CqdoFslqHg7UxSUOfyGdxaAdFA+Ppf/J4M8oNd8Mnt/GKbce850
GLrV7Z8Iv5EkjER8EHcEnfx8PpvSBTxEvNhnvOQyIUmlWHo4iYlVak4T4GZYivjX
F1uuq03W0sic4JeZYM0Z4xevhTZb7OKgFWg80wRRWJF25V0T3nrNWdwQegrtYcEd
IryvyFdX8zvxprnWGWcRb7ZLOTTziSYSeXt5340yvr69yslt/OnwIk7eXSFE4MyT
jkAduV9dtpEFZ0PTfJ/ya5GRzVGlGxTWjShSsSsSRX0N5by/xK6azmMb9rpEkIAI
H2KOVpheJGKIRr6PUHiBid6/B/arH2NauEitef5RaB83Doqn3nHsw6bdbotyZZvU
O0xYBEdPkjg7Z4JxDk6w
=o4j/
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
