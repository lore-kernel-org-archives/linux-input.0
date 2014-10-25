From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] Input: vsxxxaa - fix code dropping bytes from queue
Date: Sat, 25 Oct 2014 14:39:40 +0200
Message-ID: <20141025123939.GW28215@lug-owl.de>
References: <20141024223846.GA1914@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V2AZ19bMCakBLong"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lug-owl.de ([195.71.106.12]:33589 "EHLO lug-owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321AbaJYTra (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Oct 2014 15:47:30 -0400
Content-Disposition: inline
In-Reply-To: <20141024223846.GA1914@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--V2AZ19bMCakBLong
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2014-10-24 15:38:46 -0700, Dmitry Torokhov <dmitry.torokhov@gmail.c=
om> wrote:
> I believe the intent of the code was to drop oldest bytes from the queue,
> not the latest if we drop one byte and both latest and some oldest of we
> are dropping more than one.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/mouse/vsxxxaa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
> index 3829823..abd4944 100644
> --- a/drivers/input/mouse/vsxxxaa.c
> +++ b/drivers/input/mouse/vsxxxaa.c
> @@ -128,7 +128,7 @@ static void vsxxxaa_drop_bytes(struct vsxxxaa *mouse,=
 int num)
>  	if (num >=3D mouse->count) {
>  		mouse->count =3D 0;
>  	} else {
> -		memmove(mouse->buf, mouse->buf + num - 1, BUFLEN - num);
> +		memmove(mouse->buf, mouse->buf + num, BUFLEN - num);
>  		mouse->count -=3D num;
>  	}
>  }

Good catch!  I fucked up the error recovery path.

Acked-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                     Eine Freie Meinung in einem Freien Kopf
the second  :                   f=C3=BCr einen Freien Staat voll Freier B=
=C3=BCrger.

--V2AZ19bMCakBLong
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlRLmgsACgkQHb1edYOZ4bsKmgCfaJNOVJd9WnpoPOBiuUPMy3Sa
yOcAnRMTgtDyrKFicBixYs0oyDOKPpC8
=sd+8
-----END PGP SIGNATURE-----

--V2AZ19bMCakBLong--
