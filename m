From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH 6/6 V4] input: STMPE touch controller support
Date: Thu, 24 Jun 2010 15:11:41 +0200
Message-ID: <20100624131141.GE3988@pengutronix.de>
References: <20100622135635.GA30720@bnru02.bnr.st.com>
 <1277378021-16802-7-git-send-email-l.fu@pengutronix.de>
 <20100624123153.GB26189@bnru02.bnr.st.com>
 <20100624124210.GC3988@pengutronix.de>
 <20100624130108.GE26189@bnru02.bnr.st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100624130108.GE26189@bnru02.bnr.st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rabin VINCENT <rabin.vincent@stericsson.com>
Cc: Luotao Fu <l.fu@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-input@vger.kernel.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 24, 2010 at 06:31:09PM +0530, Rabin VINCENT wrote:
> On Thu, Jun 24, 2010 at 14:42:10 +0200, Luotao Fu wrote:
> > On Thu, Jun 24, 2010 at 06:01:53PM +0530, Rabin VINCENT wrote:
> > > On Thu, Jun 24, 2010 at 13:13:41 +0200, Luotao Fu wrote:
> > > > +       ret =3D stmpe_set_bits(stmpe, STMPE_REG_TSC_FRACTION_Z,
> > > > +                       FRACTION_Z(ts->fraction_z),
> > > > +                       FRACTION_Z(ts->fraction_z));
> > >=20
> > > I think your earlier revisions had this same behaviour, but this only
> > > writes the bits you are trying to set, and it may be a problem if the=
re
> > > are other bits already set in this field.  I don't know if this is a
> > > concern with this block, but if it is, you can do something like the
> > > following to clear out the field before writing:
> > >=20
> >=20
> > This is done intentionally to leave the bits alone which I don't want.
> > Most of the registers here are used exclusively for the touchscreen.
> > Some others are shared with the ADC. The ADC however doesn't have any
> > own configuration and has to go with the configuration of the touch
> > screen. Hence it's OK, even probably better not to touch the bits we
> > don't need.
>=20
> I meant something like: let's say you want to change the "count of the
> fractional part" (I quote from your platdata).  It (the FRACTION_Z
> field, I assume) has a default value of (say) 2.  Say you want to change
> the count to 1.  The above write will change it to 3 instead.  If this
> is really the behaviour you need, it should be OK then.

hmm, good catch. I didn't think about this. Actually nobody else should
touch these registers and they are only written while doing probe,
directly after the chip get resetted. However, it is still theoretically
troublesome, if one of them get written previously by accident. I'll
fix it. Thanks for the catch.

cheers
Luotao Fu
--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwjWY0ACgkQkLuxfMCkDTbXfwCfWcUn92yi76J8y/rg1PLtnggf
lgwAn0VIRL1Bbmg/+HAiMS/+XmRQP8XX
=V1Gr
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
