From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Wed, 7 May 2014 21:53:37 -0500
Message-ID: <20140508025337.GI7047@lukather>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-9-git-send-email-carlo@caione.org>
 <20140503010936.GF4090@lukather>
 <CAOQ7t2Z6rLAMGXocPNcKgOUp9iy6XZkh4O6jThPkdm5M6UMGtw@mail.gmail.com>
 <20140505225139.GD9464@lukather>
 <CAOQ7t2bg5jkeruVnO+9cXMxxh+SL+ANGz3R0ssSMwrHewRKyYQ@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6lCXDTVICvIQMz0h"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBSPNVONQKGQEQ4BI5RI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOQ7t2bg5jkeruVnO+9cXMxxh+SL+ANGz3R0ssSMwrHewRKyYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, wens Tsai <wens-jdAy2FN1RRM@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org


--6lCXDTVICvIQMz0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2014 at 09:38:23AM +0200, Carlo Caione wrote:
> On Tue, May 6, 2014 at 12:51 AM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Sat, May 03, 2014 at 02:21:06PM +0200, Carlo Caione wrote:
> >> On Sat, May 3, 2014 at 3:09 AM, Maxime Ripard
> >> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >> > Hi,
> >> >
> >> > On Thu, May 01, 2014 at 02:29:34PM +0200, Carlo Caione wrote:
> >> >> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> >> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> >> >> ---
> >> >>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 58 +++++++++++++=
+++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 58 +++++++++++++=
+++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 64 +++++++++++++=
+++++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 58 +++++++++++++=
+++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 65 +++++++++++++=
++++++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 64 +++++++++++++=
+++++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 58 +++++++++++++=
+++++++++
> >> >>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 59 +++++++++++++=
+++++++++
> >> >>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 59 +++++++++++++=
+++++++++
> >> >>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 59 +++++++++++++=
+++++++++
> >> >>  10 files changed, 602 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/=
dts/sun4i-a10-a1000.dts
> >> >> index fa746aea..57d3fb4 100644
> >> >> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >> >> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >> >> @@ -88,6 +88,56 @@
> >> >>                       pinctrl-names =3D "default";
> >> >>                       pinctrl-0 =3D <&i2c0_pins_a>;
> >> >>                       status =3D "okay";
> >> >> +
> >> >> +                     axp209: pmic@34 {
> >> >> +                             compatible =3D "x-powers,axp209";
> >> >> +                             reg =3D <0x34>;
> >> >> +                             interrupts =3D <0>;
> >> >> +
> >> >> +                             interrupt-controller;
> >> >> +                             #interrupt-cells =3D <1>;
> >> >> +
> >> >> +                             acin-supply =3D <&reg_axp_ipsout>;
> >> >> +                             vin2-supply =3D <&reg_axp_ipsout>;
> >> >> +                             vin3-supply =3D <&reg_axp_ipsout>;
> >> >> +                             ldo24in-supply =3D <&reg_axp_ipsout>;
> >> >> +                             ldo3in-supply =3D <&reg_axp_ipsout>;
> >> >> +                             ldo5in-supply =3D <&reg_axp_ipsout>;
> >> >> +
> >> >> +                             regulators {
> >> >> +                                     x-powers,dcdc-freq =3D <1500>;
> >> >> +
> >> >> +                                     axp_vcore_reg: dcdc2 {
> >> >> +                                             regulator-min-microvo=
lt =3D <700000>;
> >> >> +                                             regulator-max-microvo=
lt =3D <2275000>;
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_ddr_reg: dcdc3 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_rtc_reg: ldo1 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_analog_reg: ldo2 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_pll_reg: ldo3 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_hdmi_reg: ldo4 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_mic_reg: ldo5 {
> >> >> +                                             regulator-always-on;
> >> >
> >> > Do all these regulators need to be always on? It makes sense for the
> >> > pll and vcore, but I don't get why the mic and hdmi regulators need
> >> > this.
> >>
> >> I did this way because I don't have the schematics for all the board
> >> so I thought it was safer to leave all the regulators enabled
> >
> > Well, we have the schematics for most of these boards (at least all
> > the cubie and olinuxinos).
> >
> > As far as the other boards are concerned, if we don't have that
> > information, I'd say leave them alone until someone has access to
> > these informations.
>=20
> What do you mean exactly with "leave them alone". The problem is that
> if the regulator is not explicitly marked as always-on, it is disabled
> at boot time, so I think that the most safe thing to do is leave them
> on to avoid turning off something at boot time that could be
> important.

What I mean is that no information is still better than wrong
informations. If you don't have the schematics, then don't do anything
on this boards. Hopefully, someone with more infos on this will know
what to do.

Moreover, I have the feeling that you just copy pasted all the
informations on this patch. The first example I'm seeing is the
cubieboard, for which we do have the schematics, and this patch says
that ldo4 is used for HDMI, and that is required to stays always on,
while LDO4 doesn't seem to be used at all, and that HDMI takes
directly its input source from DC-5V.

I guess you need some more refining on this patch.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--6lCXDTVICvIQMz0h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTavGwAAoJEBx+YmzsjxAg+T4QAJj0HHxeGSQPG01bpXsAUqRc
6AE44IKe0HkDQJnoMCxdorm9oCZQVsljwY4gVC56mjiCY/KXjdhTyLqb2BWh5arw
UGezRr16YOKPWNUJvjcTNJUdO1+85j/0hkc0+sLHuQFL6HhLCcm7c5Yn3/9nYmlJ
Ew07UgpTYU3Mgt3QT8gp99QEOKaumSe1QP/DsrmPlinkI3fqtZDUzhrjLegpQJHS
n3YFch5XZsf1R5addd2R2H2SKR2H/QmRHn90uPjNUu80r7qPgt22N7xV/luFWLfD
TnWgMQ8TQ01A1PSIv9QuRnfMY/32nhwmfnn/nFvIzvfyqVH5ghAaIFoBVyzXn7Q/
HXVS3txzl/UwSrMwt/A/YfHK3TuqP54oxJX/4A4mFJlOt0ZiIn9nWJOIgjG4VK1n
lzKELwh+VieKD0cKpsu9Ve0V22ngjwSEne9Zv+Qa07C3OBhWczx+bnArKkcp8/GM
+KuHwkWv+9a1bRLav9Ibzmhg9vTo4HNCTpfYOluhe6ih7bjLl0OqfDSy8S6ClbWl
KUFdqrF72Be6Y2dtMIaZr/1rJal5+msc4NS7GXC5cqf4BwdHEiXPUbJJA1qOek+M
1tBJNHH3JdNG+sIn4h20dcAw0hHsLQgyVhmZZENHB3YSDtbtj4VN6HqdJltj9xDH
wEpajaFKNi+xKyuHGITV
=fsMP
-----END PGP SIGNATURE-----

--6lCXDTVICvIQMz0h--
