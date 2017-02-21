From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] Input: tsc2007 - correctly report pressure and not
 resistance to user space
Date: Tue, 21 Feb 2017 18:13:32 +0100
Message-ID: <20170221171332.w6dh7ccd2eyg5dgu@earth>
References: <cover.1487609795.git.hns@goldelico.com>
 <9e249276be9e20aab1a74617373bf6587f1acd4b.1487609795.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrj3fvfo5r3wuigf"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9e249276be9e20aab1a74617373bf6587f1acd4b.1487609795.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--jrj3fvfo5r3wuigf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 20, 2017 at 05:56:35PM +0100, H. Nikolaus Schaller wrote:
> previously, tsc2007 will report as ABS_PRESSURE:
> 0              for no pressure (resistance infinite)
> high value     for soft pressure (high resistance)
> low value      for firm pressure (lower resistance)
>=20
> This does not matter for most applications (e.g. GUI, Menu, Scrolling
> etc.) where the ABS_PRESSURE is ignored and only BTN_TOUCH is processed
> to detect screen taps.
>=20
> Only some special graphics applications read the pressure channel and
> they will be mixed up by this non-monotonic relation.
>=20
> So we fix it to become:
> 0              for no pressure (resistance infinite)
> low value      for soft pressure (high resistance)
> high value     for firm pressure (lower resistance)
>=20
> While this patch changes the values reported to userspace,
> ABS_PRESSURE is used rarely by userspace. Most software only
> relies on BTN_TOUCH (boolean), which is not affected by this
> patch. Some graphics software makes use of the interface and
> does not work correctly with the currently used inverted
> behaviour.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  drivers/input/touchscreen/tsc2007_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/tou=
chscreen/tsc2007_core.c
> index 30b53ca..fc73849 100644
> --- a/drivers/input/touchscreen/tsc2007_core.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c
> @@ -141,6 +141,8 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *ha=
ndle)
>  				"DOWN point(%4d,%4d), resistance (%4u)\n",
>  				tc.x, tc.y, rt);
> =20
> +			rt =3D ts->max_rt - rt;
> +
>  			input_report_key(input, BTN_TOUCH, 1);
>  			input_report_abs(input, ABS_X, tc.x);
>  			input_report_abs(input, ABS_Y, tc.y);

Reviewed-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

We should add the same to ts200x-core.

-- Sebastian

--jrj3fvfo5r3wuigf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlisdToACgkQ2O7X88g7
+prGIhAAiqzs41a0/KNleApeI2E+A65QhQhHhrDCfYdMUnMZhZPGNWUB+VbXHg4T
syFtB4xox1qRoGihsFCG+O1RiMTZA3JliXSg+yxyBc2apYkAUH4dOV1KTrnn98gQ
h1LiMKnXZRw5lrhocOciZ+KgvGIHCIAr6AKTthK1y15KutZgbqCokIK+M2x3krDZ
8AxmR9shSCOIfxk8oxJZNg+NUqWFaUGnTxoM8m2E+m4uajfjY999fD82i7CBYgxS
AaGYfo565KN1azjsWEQXzV85gBkhUSDzF8rxWzEJZsMBfwvFl7BCnjxoOh60oNqs
XgyAC1CQsdK3RcVdyDhTkOcbJbs5NPGqYevqHLP6VmjYBSeMfTIUIAwn6YqQXAqV
cdx4vLIRwBZSpKSvLDZb40eXp7X6Uwf5y07zbX0+tfLz8r3QdA7JA1cYXnX42T0h
rFD81aWhPGQhs81o82x7WPp9v/g0fumhFTg/uWtPZesGVLkwSc9woMrIO+jXHNOP
a4mRP3MWOzelbS6Eulbr+Wh23xHhOWtnZyRS0A501JfW9XXR7ligIKMe4ArwRKY4
tZvvDfDHj2Uz7CF0ALQK2SFv7SNqwlqYzgBBgjDKvquW9jV2xtzrJva0wl3knD/K
S5kBhD0GbZ/OX7DWqCo2S6GLgim7X3geTBZEnl8I5zhwm3q2j/Y=
=pttn
-----END PGP SIGNATURE-----

--jrj3fvfo5r3wuigf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
