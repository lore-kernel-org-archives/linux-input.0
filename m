From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v3 09/11] Input: alps - remove unlikely() from IS_ERR*()
 condition
Date: Sat, 31 Aug 2019 17:25:00 +0200
Message-ID: <20190831152500.eg7xqo5ace6wu427@pali>
References: <20190829165025.15750-1-efremov@linux.com>
 <20190829165025.15750-9-efremov@linux.com>
 <20190829175039.GA187474@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p6pa6tjr5e2zkulj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190829175039.GA187474@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Denis Efremov <efremov@linux.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--p6pa6tjr5e2zkulj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 29 August 2019 10:50:39 Dmitry Torokhov wrote:
> On Thu, Aug 29, 2019 at 07:50:23PM +0300, Denis Efremov wrote:
> > "unlikely(IS_ERR_OR_NULL(x))" is excessive. IS_ERR_OR_NULL() already us=
es
> > unlikely() internally.
>=20
> The keyword here is _internally_.
>=20
> https://lore.kernel.org/lkml/20190821174857.GD76194@dtor-ws/
>=20
> So please no.

Dmitry and I already rejected this patch, see also linked-list:
https://lore.kernel.org/lkml/20190820111719.7blyk5jstgwde2ae@pali/

> >=20
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > Cc: "Pali Roh=C3=A1r" <pali.rohar@gmail.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-input@vger.kernel.org
> > ---
> >  drivers/input/mouse/alps.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> > index 34700eda0429..ed1661434899 100644
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -1476,7 +1476,7 @@ static void alps_report_bare_ps2_packet(struct ps=
mouse *psmouse,
> >  		/* On V2 devices the DualPoint Stick reports bare packets */
> >  		dev =3D priv->dev2;
> >  		dev2 =3D psmouse->dev;
> > -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> > +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
> >  		/* Register dev3 mouse if we received PS/2 packet first time */
> >  		if (!IS_ERR(priv->dev3))
> >  			psmouse_queue_work(psmouse, &priv->dev3_register_work,
> > --=20
> > 2.21.0
> >=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--p6pa6tjr5e2zkulj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXWqRSgAKCRCL8Mk9A+RD
Umu+AKChsaP4CSHyL95PY6h8qfvy9VLlVgCgsJJM0b0+JaCmO8UiIbZc/5SHjz4=
=btDG
-----END PGP SIGNATURE-----

--p6pa6tjr5e2zkulj--
