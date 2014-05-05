From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [linux-sunxi] Re: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add
 AXP209 support to various boards
Date: Mon, 5 May 2014 17:51:39 -0500
Message-ID: <20140505225139.GD9464@lukather>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-9-git-send-email-carlo@caione.org>
 <20140503010936.GF4090@lukather>
 <CAOQ7t2Z6rLAMGXocPNcKgOUp9iy6XZkh4O6jThPkdm5M6UMGtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41398 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757017AbaEFANs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 May 2014 20:13:48 -0400
Content-Disposition: inline
In-Reply-To: <CAOQ7t2Z6rLAMGXocPNcKgOUp9iy6XZkh4O6jThPkdm5M6UMGtw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org, boris.brezillon@free-electrons.com, linux-sunxi@googlegroups.com


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 03, 2014 at 02:21:06PM +0200, Carlo Caione wrote:
> On Sat, May 3, 2014 at 3:09 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Thu, May 01, 2014 at 02:29:34PM +0200, Carlo Caione wrote:
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> Signed-off-by: Carlo Caione <carlo@caione.org>
> >> ---
> >>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 58 ++++++++++++++++=
++++++
> >>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 58 ++++++++++++++++=
++++++
> >>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 64 ++++++++++++++++=
++++++++
> >>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 58 ++++++++++++++++=
++++++
> >>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 65 ++++++++++++++++=
+++++++++
> >>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 64 ++++++++++++++++=
++++++++
> >>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 58 ++++++++++++++++=
++++++
> >>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 59 ++++++++++++++++=
++++++
> >>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 59 ++++++++++++++++=
++++++
> >>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 59 ++++++++++++++++=
++++++
> >>  10 files changed, 602 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts=
/sun4i-a10-a1000.dts
> >> index fa746aea..57d3fb4 100644
> >> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >> @@ -88,6 +88,56 @@
> >>                       pinctrl-names =3D "default";
> >>                       pinctrl-0 =3D <&i2c0_pins_a>;
> >>                       status =3D "okay";
> >> +
> >> +                     axp209: pmic@34 {
> >> +                             compatible =3D "x-powers,axp209";
> >> +                             reg =3D <0x34>;
> >> +                             interrupts =3D <0>;
> >> +
> >> +                             interrupt-controller;
> >> +                             #interrupt-cells =3D <1>;
> >> +
> >> +                             acin-supply =3D <&reg_axp_ipsout>;
> >> +                             vin2-supply =3D <&reg_axp_ipsout>;
> >> +                             vin3-supply =3D <&reg_axp_ipsout>;
> >> +                             ldo24in-supply =3D <&reg_axp_ipsout>;
> >> +                             ldo3in-supply =3D <&reg_axp_ipsout>;
> >> +                             ldo5in-supply =3D <&reg_axp_ipsout>;
> >> +
> >> +                             regulators {
> >> +                                     x-powers,dcdc-freq =3D <1500>;
> >> +
> >> +                                     axp_vcore_reg: dcdc2 {
> >> +                                             regulator-min-microvolt =
=3D <700000>;
> >> +                                             regulator-max-microvolt =
=3D <2275000>;
> >> +                                             regulator-always-on;
> >> +                                     };
> >> +
> >> +                                     axp_ddr_reg: dcdc3 {
> >> +                                             regulator-always-on;
> >> +                                     };
> >> +
> >> +                                     axp_rtc_reg: ldo1 {
> >> +                                             regulator-always-on;
> >> +                                     };
> >> +
> >> +                                     axp_analog_reg: ldo2 {
> >> +                                             regulator-always-on;
> >> +                                     };
> >> +
> >> +                                     axp_pll_reg: ldo3 {
> >> +                                             regulator-always-on;
> >> +                                     };
> >> +
> >> +                                     axp_hdmi_reg: ldo4 {
> >> +                                             regulator-always-on;
> >> +                                     };
> >> +
> >> +                                     axp_mic_reg: ldo5 {
> >> +                                             regulator-always-on;
> >
> > Do all these regulators need to be always on? It makes sense for the
> > pll and vcore, but I don't get why the mic and hdmi regulators need
> > this.
>=20
> I did this way because I don't have the schematics for all the board
> so I thought it was safer to leave all the regulators enabled

Well, we have the schematics for most of these boards (at least all
the cubie and olinuxinos).

As far as the other boards are concerned, if we don't have that
information, I'd say leave them alone until someone has access to
these informations.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTaBX7AAoJEBx+YmzsjxAg4FwQAIvJHPghBDLksbtCdWUXIJjY
y9rCtouiwbEX2XPcFCiHac/ABSF8gfU2R3N0j6koG9RyekjgYVINhSmjc8+iWmgE
HtJuuD2g61OxEOE6umhpAd0eOwf0M0DXUPkYGW5IQAsowoAae7Fq036d5lwbWySs
3fY4y0JBSiU8vAAPpzqBkv8IAxDVSweu69A1bz/jU+pmQW8mCRlUsCfX9N1+zyyK
Jr7mbHfSMlqb1Yq9iZg8wpw+fYsbnZCFnXANG3NwXl9jvCcrmRPC2oSXt6Szzydy
JrEUhJMZTH6XclEF/Pg71kOf/BILeldIv+XpNJK/q7/TRY9fJwXyrnK5seots6Xt
5c7ymWoFD5OAuT8a82IOyhAKzckmtPApkeTCTr8nkaKyBoQsxA/rzGpEBMAJ5sya
GdEfyts3KDlyrh+qxQsomXjGWzLk443mWxxyRzlA2SlXOeY2kq6Y/pOAO/wkdcYX
k+f2N9WMZLMD26yUNfjXIb/xdc9n7MhM4UoxToNJq5nlIcLvdYC4OKXZCLhGLjp9
GMggkWG8dz2a42g31/jQijh/X2EVckqeff/y7Rifh5JzOg9kA8SCQrNaVobrpkkz
+ocj9IeS1rNcqhTOYZBVa/emVoY8DnZmNbMcrWdT55tJr7nuYdHPjD74hiRzMv3v
BDN415bS0bdaIFQgSvFd
=V0cq
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
