From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Split I2C_M_NOSTART support out of
 I2C_FUNC_PROTOCOL_MANGLING
Date: Thu, 3 May 2012 11:52:11 +0200
Message-ID: <20120503095211.GC9574@pengutronix.de>
References: <1335443839-22872-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1335443839-22872-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2012 at 01:37:19PM +0100, Mark Brown wrote:
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

In general, I like it. One thing below:

> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -540,7 +540,7 @@ struct i2c_msg {
>  	__u16 flags;
>  #define I2C_M_TEN		0x0010	/* this is a ten bit chip address */
>  #define I2C_M_RD		0x0001	/* read data, from slave to master */
> -#define I2C_M_NOSTART		0x4000	/* if I2C_FUNC_PROTOCOL_MANGLING */
> +#define I2C_M_NOSTART		0x4000	/* if I2C_FUNC_NOSTART */
>  #define I2C_M_REV_DIR_ADDR	0x2000	/* if I2C_FUNC_PROTOCOL_MANGLING */
>  #define I2C_M_IGNORE_NAK	0x1000	/* if I2C_FUNC_PROTOCOL_MANGLING */
>  #define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
> @@ -568,6 +568,7 @@ struct i2c_msg {
>  #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000
>  #define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer =
 */
>  #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr=
=2E */
> +#define I2C_FUNC_NOSTART		0x10000000 /* I2C_M_NOSTART */

In this file, the comment for MANGLING should be adapted, too. It says
currently:

#define I2C_FUNC_PROTOCOL_MANGLING      0x00000004 /* I2C_M_NOSTART etc. */

NOSTART is now out of MANGLING.

Also, I'd think the FUNC_NOSTART bit should be 0x08 and SMBUS_PEC 0x4000. T=
his
will be more intuitive, probably?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+iVUsACgkQD27XaX1/VRtKMACgmNGby5ewTZutRdjHFErkyrjJ
tRgAoKswXneoehSwhotTGcXCdcygsy45
=8ba9
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
