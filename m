From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 08/10] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Fri, 28 Mar 2014 11:11:46 +0100
Message-ID: <20140328101146.GP6120@lukather>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-9-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ga5bsqHr1s/xcZEm"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBYUX2WMQKGQE5X7SL6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395955764-18103-9-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--ga5bsqHr1s/xcZEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 10:29:22PM +0100, Carlo Caione wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 13 +++++++++++++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 13 +++++++++++++
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 19 +++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 13 +++++++++++++
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 19 +++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 19 +++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 13 +++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 14 ++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 15 +++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 14 ++++++++++++++
>  10 files changed, 152 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/su=
n4i-a10-a1000.dts
> index fa746aea..cf18c4d 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -88,6 +88,19 @@
>  			pinctrl-names =3D "default";
>  			pinctrl-0 =3D <&i2c0_pins_a>;
>  			status =3D "okay";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			axp: axp20x@34 {
> +				reg =3D <0x34>;
> +				interrupts =3D <0>;
> +
> +				compatible =3D "x-powers,axp209";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +
> +				/include/ "x-powers-axp209.dtsi"
> +			};
>  		};
>  	};

Actually, you can make the whole thing much more robust by using the
&label syntax.

Here, you would just include the dtsi at the top of the file, and in
the DTSI, you would have something like:

&axp209 {
   regulators {
      ...
   }
}

(Given that the node in your DTS is axp209: pmic@something like
Chen-Yu suggested)

You don't rely any more on the position of the include, and you use a
standard DT syntax.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ga5bsqHr1s/xcZEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTNUriAAoJEBx+YmzsjxAg7d0QALVYgSEyD/8fXM1da+ZYWSBE
o79mt16FA4I9DgHz7P07fTU7xVkVQuoImQRdt8GZjkwaciBJEMUGEvprAS3w1uFJ
v9lFQFb5yPmhIoXbiQmYn4aPwtjJRA3oP5Rozx8uFIUY9x7qhj5+K6lCKcrW7XU/
sLctVZw/KnK4/Iw+JImnloDOHbWK3LjW+lk4MH26o9lr2nRHJ1mojJqYoA5ZsMqP
jl8wA4ozjjqKXn23L+581/a0x8h5t+Dt49jwiiBAzhJfLAG3NQn7z4N0YVXaf7zF
CTiOCO4XMKxQOCsiTEBkEtF3Wfo/SzThmEfOr7EqNJYNAEyJHhUpATRbaTZ6555k
Uvxpp8vGdgX6olE/gQHxstpCPxjn7nncyvLvUxYLreQhjSH8QbzTU+WOItrpDf/q
Krpo+HTHs8s6zT4PYRqg7AS/jxzbE6TzMzHdrCyjavqusBdzxAAH6yIWkMkAFcMU
aSY3ohUiCBMXCy9Vj938MG74Q+pADR5P6e5ryX+Zr/dnyGtNNQgORToU6175HbAH
T0TNz2vyZQ+xXSVLDBNyVReq57dXLdKlDGVkZ2mXp7zESAkP3/KQhXw2RhNHBNIP
AmkDaB+RqrFggjpCNP8m+wpAYlNW01kXBkGJ9ozB7JmlxzuhG5iPw4siKi2WIPuL
NpfaHVtkhl6LUui/sLAi
=qg72
-----END PGP SIGNATURE-----

--ga5bsqHr1s/xcZEm--
