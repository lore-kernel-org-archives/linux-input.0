From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH 5/6 V2] mfd/stmpexxx: fix stmpe811 enable hook
Date: Thu, 24 Jun 2010 14:46:16 +0200
Message-ID: <20100624124616.GD3988@pengutronix.de>
References: <1277378021-16802-7-git-send-email-l.fu@pengutronix.de>
 <1277382466-23603-1-git-send-email-l.fu@pengutronix.de>
 <20100624123542.GC26189@bnru02.bnr.st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100624123542.GC26189@bnru02.bnr.st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rabin VINCENT <rabin.vincent@stericsson.com>
Cc: Luotao Fu <l.fu@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-input@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 24, 2010 at 06:05:42PM +0530, Rabin VINCENT wrote:
> On Thu, Jun 24, 2010 at 14:27:46 +0200, Luotao Fu wrote:
> > diff --git a/drivers/mfd/stmpe-devices.c b/drivers/mfd/stmpe-devices.c
> > index 3e21c26..ded9dcb 100644
> > --- a/drivers/mfd/stmpe-devices.c
> > +++ b/drivers/mfd/stmpe-devices.c
> > @@ -117,8 +117,8 @@ static int stmpe811_enable(struct stmpe *stmpe, uns=
igned int blocks,
> >  	if (blocks & STMPE_BLOCK_ADC)
> >  		mask |=3D STMPE811_SYS_CTRL2_ADC_OFF;
> > =20
> > -	if (blocks & STMPE_BLOCK_KEYPAD)
> > -		mask |=3D STMPE811_SYS_CTRL2_TSC_OFF;
> > +	if (blocks & STMPE_BLOCK_TOUCHSCREEN)
> > +		mask |=3D STMPE811_SYS_CTRL2_ADC_OFF;
> > =20
>=20
> You shouldn't be changing TSC_OFF to ADC_OFF, since you're making this
> for the touchscreen.
>=20

doh! I need more coffee. This is truly embarassing. :-) Proper fix in
following.

cheers
Luotao Fu

--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwjU5gACgkQkLuxfMCkDTYUWQCaA9nM779/kDgde+gatHBMZr4o
N6YAniZ0ci/UEhSBhjQYCJM1kUQaiSbF
=Lugm
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
