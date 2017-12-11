From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: dts: sun8i: a83t: a711: Add touchscreen node
Date: Mon, 11 Dec 2017 08:16:35 +0100
Message-ID: <20171211071635.4ntdksmjino4uh2i@flea.lan>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
 <20171208215419.30396-6-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wiz72sqo6qhqdtvk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171208215419.30396-6-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, simon.budig-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--wiz72sqo6qhqdtvk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 08, 2017 at 10:54:19PM +0100, Myl=E8ne Josserand wrote:
> Tha A711 tablet has a FocalTech EDT-FT5x06 Polytouch touchscreen.
> It is connected via I2C0 so add his node in i2c0's node.
>=20
> The reset line is PD5, the interrupt line is PL7 and the power
> supply is the ldo_io0 regulator.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dt=
s/sun8i-a83t-tbs-a711.dts
> index 84cca1a48cea..738359917a34 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -110,6 +110,17 @@
>  	pinctrl-0 =3D <&i2c0_pins>;
>  	clock-frequency =3D <400000>;
>  	status =3D "okay";
> +
> +	polytouch: edt-ft5x06@38 {

You're not using that label anywhere, so you can drop it, and the node
name must be the class of the device.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--wiz72sqo6qhqdtvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlouMM8ACgkQ0rTAlCFN
r3R1zw//aRFpquavLrgR9AuPEmGk7PvCAvv+jUsoFmg/La2tOYZBWoUCht9l7kzc
U064V8gnUHv/Ux5rXedlDjD+mJN4BUnWlZCOWXVYzv1jqSLkNd2jKpBHzhQpKNZf
890QSGi871/KxkwghDplpfAeVCZe4M5QxYfSFotOuAlYqER1YJ6ize+FqAfilieD
cxJvYjVs1OuKP1Z/tEGR8Y+dS9JhFkNMkcS7VDNgpKW13Ksm6ZUtLCOCYBztfO6D
bx7y2a6duFzMPiJVDWvWeXVw4pQe7GKLF47LXJmr69S74ETeOWYws29wP3uhirUv
lhNuwZ+d79kYfsO8XZZ/+XshcgnpwQ5C8EDC30YkAJwJztN2U6ytZkpMakTTUDyu
tH0MQ6aVzM3oYrAOa2XCXZBIoBAWuv2gHOyphp38yM/VriFOFQBW4+2AYM6Hvn+P
IhJLiN23KrfJ1x7em4VCGgAsVkYcYXt0DST6ivmBc2v90M9xwuFi47flaGSLYuUd
Y91kxxmoQ0NUK9ljq6tK0CBb7Ydv4Ol3iwwiXszV/IZFoKnzjOkxxnSXLMZ/S2QY
+P6GIuXnYx0Gm/hi0NVDDOwiuIOLKgifhk3W2FNmLnrg6pMlzLFNQogP5KvbQ/tI
oo3xTcyoVXQBuq3NmNT9XRuj7lUtITOJgAjpJhfoaAJeYbGp2Ww=
=1zuM
-----END PGP SIGNATURE-----

--wiz72sqo6qhqdtvk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
