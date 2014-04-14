From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Mon, 14 Apr 2014 11:52:56 +0200
Message-ID: <20140414095256.GA28585@lukather>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-8-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mFM6r0jQWo48NPCK"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB6HAV2NAKGQEZUOZGJA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397209093-10077-8-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--mFM6r0jQWo48NPCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Fri, Apr 11, 2014 at 11:38:11AM +0200, Carlo Caione wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>=20
> In all the DTs the min and max microvolt allowed for each regulator are a=
ctually
> the min and max voltage possible for the regulator itself. This is not sa=
fe but
> we do not have the ranges allowed for each board and the original Allwinn=
er=20
> driver does exactly this way.
>=20
> AXP20x has the so called Power Path Management (IPS) that can select the =
proper
> power supply according to the status of the external power and the Li-bat=
tery
> status. The output of the IPS block is usually a 5V fixed voltage used as=
=20
> input supply for all the other regulators. This fixed voltage is represen=
ted
> in the DT as a fixed voltage regulator in the "regulator" subnode.
>=20
>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 69 +++++++++++++++++++=
++++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 69 +++++++++++++++++++=
++++
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 75 +++++++++++++++++++=
++++++
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 69 +++++++++++++++++++=
++++
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 75 +++++++++++++++++++=
++++++
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 75 +++++++++++++++++++=
++++++
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 69 +++++++++++++++++++=
++++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 70 +++++++++++++++++++=
++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 70 +++++++++++++++++++=
++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 70 +++++++++++++++++++=
++++

That looks like a lot of them. Did you test all of them?
Are all those regulators you define used on all these boards?

>  10 files changed, 711 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/su=
n4i-a10-a1000.dts
> index fa746aea..029a880 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -88,6 +88,75 @@
>  			pinctrl-names =3D "default";
>  			pinctrl-0 =3D <&i2c0_pins_a>;
>  			status =3D "okay";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;

That should be in the DTSI.

> +			axp209: pmic@34 {
> +				compatible =3D "x-powers,axp209";
> +				reg =3D <0x34>;
> +				interrupts =3D <0>;
> +
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +
> +				acin-supply =3D <&axp_ipsout_reg>;
> +				vin2-supply =3D <&axp_ipsout_reg>;
> +				vin3-supply =3D <&axp_ipsout_reg>;
> +				ldo24in-supply =3D <&axp_ipsout_reg>;
> +				ldo3in-supply =3D <&axp_ipsout_reg>;
> +				ldo5in-supply =3D <&axp_ipsout_reg>;
> +
> +				regulators {
> +					compatible =3D "x-powers,axp20x-reg";

I told you a few times already, but don't introduce pattern-matching
compatibles.

> +
> +					x-powers,dcdc-freq =3D <1500>;
> +
> +					axp_ipsout_reg: axp_ipsout {
> +						compatible =3D "regulator-fixed";
> +						regulator-name =3D "axp-ipsout";
> +						regulator-min-microvolt =3D <5000000>;
> +						regulator-max-microvolt =3D <5000000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_vcore_reg: dcdc2 {
> +						regulator-min-microvolt =3D <700000>;
> +						regulator-max-microvolt =3D <2275000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_ddr_reg: dcdc3 {
> +						regulator-min-microvolt =3D <700000>;
> +						regulator-max-microvolt =3D <3500000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_rtc_reg: ldo1 {
> +						regulator-always-on;
> +					};
> +
> +					axp_analog_reg: ldo2 {
> +						regulator-min-microvolt =3D <1800000>;
> +						regulator-max-microvolt =3D <3300000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_pll_reg: ldo3 {
> +						regulator-min-microvolt =3D <700000>;
> +						regulator-max-microvolt =3D <3500000>;
> +					};
> +
> +					axp_hdmi_reg: ldo4 {
> +						regulator-min-microvolt =3D <1250000>;
> +						regulator-max-microvolt =3D <3300000>;
> +					};
> +
> +					axp_mic_reg: ldo5 {
> +						regulator-min-microvolt =3D <1800000>;
> +						regulator-max-microvolt =3D <3300000>;
> +					};
> +				};
> +			};
>  		};
>  	};
> =20
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/d=
ts/sun4i-a10-cubieboard.dts
> index 4684cbe..635fd4b 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -80,6 +80,75 @@
>  			pinctrl-names =3D "default";
>  			pinctrl-0 =3D <&i2c0_pins_a>;
>  			status =3D "okay";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			axp209: pmic@34 {
> +				compatible =3D "x-powers,axp209";
> +				reg =3D <0x34>;
> +				interrupts =3D <0>;
> +
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +
> +				acin-supply =3D <&axp_ipsout_reg>;
> +				vin2-supply =3D <&axp_ipsout_reg>;
> +				vin3-supply =3D <&axp_ipsout_reg>;
> +				ldo24in-supply =3D <&axp_ipsout_reg>;
> +				ldo3in-supply =3D <&axp_ipsout_reg>;
> +				ldo5in-supply =3D <&axp_ipsout_reg>;
> +
> +				regulators {
> +					compatible =3D "x-powers,axp20x-reg";
> +
> +					x-powers,dcdc-freq =3D <1500>;
> +
> +					axp_ipsout_reg: axp_ipsout {
> +						compatible =3D "regulator-fixed";
> +						regulator-name =3D "axp-ipsout";
> +						regulator-min-microvolt =3D <5000000>;
> +						regulator-max-microvolt =3D <5000000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_vcore_reg: dcdc2 {
> +						regulator-min-microvolt =3D <700000>;
> +						regulator-max-microvolt =3D <2275000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_ddr_reg: dcdc3 {
> +						regulator-min-microvolt =3D <700000>;
> +						regulator-max-microvolt =3D <3500000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_rtc_reg: ldo1 {
> +						regulator-always-on;
> +					};
> +
> +					axp_analog_reg: ldo2 {
> +						regulator-min-microvolt =3D <1800000>;
> +						regulator-max-microvolt =3D <3300000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_pll_reg: ldo3 {
> +						regulator-min-microvolt =3D <700000>;
> +						regulator-max-microvolt =3D <3500000>;
> +					};
> +
> +					axp_hdmi_reg: ldo4 {
> +						regulator-min-microvolt =3D <1250000>;
> +						regulator-max-microvolt =3D <3300000>;
> +					};
> +
> +					axp_mic_reg: ldo5 {
> +						regulator-min-microvolt =3D <1800000>;
> +						regulator-max-microvolt =3D <3300000>;
> +					};
> +				};
> +			};
>  		};
> =20
>  		i2c1: i2c@01c2b000 {
> diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dt=
s/sun4i-a10-hackberry.dts
> index d7c17e4..8f2db9c 100644
> --- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> @@ -82,6 +82,81 @@
>  			pinctrl-0 =3D <&uart0_pins_a>;
>  			status =3D "okay";
>  		};
> +
> +		i2c0: i2c@01c2ac00 {
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&i2c0_pins_a>;
> +			status =3D "okay";

That should be in a separate patch.

These comments apply to most of the changes here. Make sure you edit
all of them.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--mFM6r0jQWo48NPCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTS6/4AAoJEBx+YmzsjxAgmhAP/RH/Es6jeZA+Py6eEOzIcHwL
3sHKOe3GtYoK0ks4xslGEFtYsnf9yinQMAhmvJG5fEJRD6xnzraNIaSjnAUaCV/H
nlzbARaUx92ILT4DwBWPkhs6F88IsgmXs62B+MejFdzAuuIyc33IQiXr1DP1cHSm
E8xDI9bxNMb1Y6gn4Nwkh4o+tdO7GFLtEceAbNEzDFMHpuuMYLO/WDRnAykYUnl/
hy2T/qLZnpIj0ddBd2ITQRP05ogzFwDms4dJXWo6T14p3oCpwnUmELQ/CgbvUl4K
B3i821Yw3auoiXJ5ThPdii+ZJcTe6WHpckv/r163+vCVz+TlZnB0MDVQsIXMwq4c
5helU0r4BNCOoiwuNBcKVeCJCKp9NtAsKdDfs5aLO7Doj1mecjLO5Eh8LuknAI2S
loL+hQ0L4Ewrnn5PWBKTZjsglWX23ex8uW/Gw7HPHgju0GPNIr17di9ExqDbf4fZ
IYBRYUtONpakeRE5i95MBt2WGoFsYkzX7kYMSd+dfoB50Sg5T1imvqZZFzilKR5/
6l3A1NWd2I66x8g/XOqdjDZJM4maejogJTRJyuogA5moqKZCDzlTlihfouom0tzZ
HdLNa7iYypZGUAWqGrEcf6rP5YpDLWH2bhvdGo44t4m72L1Y1uh1ZYgdJqbga0/l
j58D+6kv0kCcc2Il/sbj
=aGrc
-----END PGP SIGNATURE-----

--mFM6r0jQWo48NPCK--
