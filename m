From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Split I2C_M_NOSTART support out of
 I2C_FUNC_PROTOCOL_MANGLING
Date: Thu, 3 May 2012 13:13:48 +0200
Message-ID: <20120503111348.GE9574@pengutronix.de>
References: <1335443839-22872-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120503095211.GC9574@pengutronix.de>
 <20120503095814.GA3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120503095814.GA3955-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2012 at 10:58:15AM +0100, Mark Brown wrote:
> On Thu, May 03, 2012 at 11:52:11AM +0200, Wolfram Sang wrote:
>=20
> > Also, I'd think the FUNC_NOSTART bit should be 0x08 and SMBUS_PEC 0x400=
0. This
> > will be more intuitive, probably?
>=20
> What is the value in renumbering everything?  It just seems like it
> makes the diff less clear and has no practical value.

Not everything, only those 2. The result would be having one block dealing
with I2C and one block with SMBUS. But Jean's comment is an ultimate
"no" anyway.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+iaGwACgkQD27XaX1/VRvc2gCdFFMTDudSC0eamh0jW+XcbbT1
nSsAn2zj27CEC6RQpYB25KoXfPF5CLoZ
=XpFB
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
