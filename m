From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 6/8] ARM: sunxi: dt: Add
 x-powers-axp209.dtsi file
Date: Tue, 18 Mar 2014 10:04:50 +0100
Message-ID: <20140318090450.GV27873@lukather>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-7-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R9dSeJxMIUBTi9Do"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBQUYUCMQKGQER5Z4DEI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394898225-28452-7-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--R9dSeJxMIUBTi9Do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2014 at 04:43:43PM +0100, Carlo Caione wrote:
> This dtsi describes the axp209 PMIC, and is to be included from inside
> the i2c controller node to which the axp209 is connected.
>=20
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/x-powers-axp209.dtsi | 60 ++++++++++++++++++++++++++++=
++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 arch/arm/boot/dts/x-powers-axp209.dtsi
>=20
> diff --git a/arch/arm/boot/dts/x-powers-axp209.dtsi b/arch/arm/boot/dts/x=
-powers-axp209.dtsi
> new file mode 100644
> index 0000000..d272e67
> --- /dev/null
> +++ b/arch/arm/boot/dts/x-powers-axp209.dtsi
> @@ -0,0 +1,60 @@
> +/*
> + * x-powers,axp209 common code to be include from inside the axp209 node
> + *
> + * Copyright 2014 - Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +

I didn't even know such a thing was possible :)
Nice hack.

> +	compatible =3D "x-powers,axp209";
> +	interrupt-controller;
> +	#interrupt-cells =3D <1>;

However, I'd move this out of it, and in the board file, so that we
actually get an idea by looking at the board DTS of what device we are
actually registering at this given address, and what it's capable of.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--R9dSeJxMIUBTi9Do
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTKAwyAAoJEBx+YmzsjxAgLEIP/jWJ2SOO2JdZki7AHZIx8GFU
Zu9m4rY8t/hWMVLqrDw1ZSLDpCZ0s8uOGJlLqK6vZ9egoSO3Cly74OAOHxWWakTk
En0YFWhM6KRsDly2DuUuFurOsYvvPIsKr6VvVlNcqwSUXZURQF3As1umrzAMBYmr
DzLdUUJz9sPaYLL6PHWTT1RQ6NcntxOZS1qccZPyo7u+nhqqSnRLu8K/sX4ZuV0M
C8L0v5UMCltGnD5+8K4lUZvaawqiL6pM/Go09AMbq3h0w1c0t24a3BmE4aP++94C
8fiDH//5GKJs4nFjQGObmp9cLYFKbihkML44zaeEmqDXkrONo0ufvM0Eg6UHtPx1
4n6Y2YkDP3RBXzhYW1n7o4+sxlC2SJaadJOob+qQ9uDJAZ9wDtWYz4gUX9ckiFL4
TA3PqDvF1zmfPbG0T1lXU6tFs1w8Zvu5Tf2Y22srwIdokxpvE6CbaamGd6/XOy1g
XUFNzmGjQsFmaMuSSZK9vWQHSS/BE0li4cRNi9sA+1QlwokqbYm+6UNTTpkaejnG
Umgobm+JsA7NCQdMWCxMVf79m4C/l2qUOKzNaiamL/L8wcofxVlOQz/4CKHvcKQN
NUJNcUfFj+CqKaoF4jZO8BLbNaZrqKJLc3vzxHLrY7Fygb6yWprBefcRpKxC7um/
ofpelWbv/aPyeR9EV3ME
=d2w4
-----END PGP SIGNATURE-----

--R9dSeJxMIUBTi9Do--
