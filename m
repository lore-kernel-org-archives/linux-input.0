From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: tsc200x - Report proper input_dev name
Date: Wed, 20 Jul 2016 22:37:25 +0200
Message-ID: <201607202237.26015@pali>
References: <20160720014424.GI19250@dtor-ws> <20160720170412.GC25655@dtor-ws> <20160720171449.GD25655@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1548039.QGCi632Zcd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160720171449.GD25655@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, sre@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-input@vger.kernel.org

--nextPart1548039.QGCi632Zcd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 20 July 2016 19:14:49 Dmitry Torokhov wrote:
> Input: tsc200x - report proper input_dev name
>=20
> From: Michael Welling <mwelling@ieee.org>
>=20
> Passes input_id struct to the common probe function for the tsc200x
> drivers instead of just the bustype.
>=20
> This allows for the use of the product variable to set the
> input_dev->name variable according to the type of touchscreen used.
> Note that when we introduced support for TSC2004 we started calling
> everything TSC200X, so let's keep this quirk.
>=20
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1548039.QGCi632Zcd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAleP4QYACgkQi/DJPQPkQ1LrngCeJldvwPnXXa+5idcrijovpS3n
Vv8AnRYksSHs/j2D8ZkVRM1/IzhnBPsN
=Ie2i
-----END PGP SIGNATURE-----

--nextPart1548039.QGCi632Zcd--
