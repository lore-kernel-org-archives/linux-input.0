From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - fix memory leak when detection fails
Date: Sat, 28 Feb 2015 12:04:25 +0100
Message-ID: <201502281204.25691@pali>
References: <20150227235357.GA13166@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1669964.y9WfNrXb74";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150227235357.GA13166@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart1669964.y9WfNrXb74
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 February 2015 00:53:57 Dmitry Torokhov wrote:
> This fixes memory leak introduced by commit
> a09221e83e13e09a33109b9b037484eade901cea
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/mouse/alps.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/mouse/alps.c
> b/drivers/input/mouse/alps.c index d28726a..1bd15eb 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2605,8 +2605,10 @@ int alps_detect(struct psmouse
> *psmouse, bool set_properties) return -ENOMEM;
>=20
>  	error =3D alps_identify(psmouse, priv);
> -	if (error)
> +	if (error) {
> +		kfree(priv);
>  		return error;
> +	}
>=20
>  	if (set_properties) {
>  		psmouse->vendor =3D "ALPS";

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1669964.y9WfNrXb74
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTxoLkACgkQi/DJPQPkQ1INiACfaNkLoz/s3AO0bugRHnvzT88G
o7YAn3KP/5EU6OOfsGeyIL6FcFaRLusY
=xxPH
-----END PGP SIGNATURE-----

--nextPart1669964.y9WfNrXb74--
