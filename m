From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] Input: stmpe-ts - return -ENOMEM if memory
	allocation fail
Date: Sat, 4 Sep 2010 07:45:11 +0200
Message-ID: <20100904054511.GA12920@pengutronix.de>
References: <1283477451.5439.6.camel@mola> <1283477533.5439.8.camel@mola> <20100903213524.GA32515@pengutronix.de> <20100903214540.GB6412@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100903214540.GB6412@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Luotao Fu <l.fu@pengutronix.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 03, 2010 at 02:45:40PM -0700, Dmitry Torokhov wrote:
> On Fri, Sep 03, 2010 at 11:35:24PM +0200, Wolfram Sang wrote:
> > On Fri, Sep 03, 2010 at 09:32:13AM +0800, Axel Lin wrote:
> > > Signed-off-by: Axel Lin <axel.lin@gmail.com>
> >=20
> > Basically correct. Should be simpler to just use
> >=20
> > 	int ret =3D -ENOMEM;
> >=20
> > though.
> >=20
>=20
> No! I hate when people initialize error values like that, because it is

Might be a mileage; I don't insist, though :)

> so easy to miss the case and end up with wrong value. If the original
> version of the driver did not initialize it to 0 compiler would warn
> the author and the error would not make it into the mainline to begin
> with.

So, the initialization to 0 could be removed, at least.

> Please explicitly assign error codes in error handling path.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyB3OcACgkQD27XaX1/VRtpKQCfbu86CKuVRN4rvjQmML8ZU/al
ItUAn1//3wqmDfB2ysWyAMXRfcvWFpQg
=VmEa
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
