From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Split I2C_M_NOSTART support out of
 I2C_FUNC_PROTOCOL_MANGLING
Date: Thu, 3 May 2012 13:35:46 +0200
Message-ID: <20120503113546.GG9574@pengutronix.de>
References: <1336042416-28330-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336042416-28330-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2012 at 11:53:36AM +0100, Mark Brown wrote:
> Since there are uses for I2C_M_NOSTART which are much more sensible and
> standard than most of the protocol mangling functionality (the main one
> being gather writes to devices where something like a register address
> needs to be inserted before a block of data) create a new I2C_FUNC_NOSTART
> for this feature and update all the users to use it.
>=20
> In the case of regmap-i2c we remove the requirement for mangling as
> I2C_M_NOSTART is the only mangling feature which is being used.
>=20
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

Applied to next, thanks! Jean, let me know if you prefer to take it.
Acks from input and fbdev maintainers still appreciated.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+ibZIACgkQD27XaX1/VRvL8ACdEwWPXo+KhKjV+ego2aLPRMxk
liUAn3tolILcgkJREOezGwK4hCv9xEIW
=EHex
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
