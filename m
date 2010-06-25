From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH 5/5 V7] input: STMPE touch controller support
Date: Fri, 25 Jun 2010 11:32:41 +0200
Message-ID: <20100625093240.GB27553@pengutronix.de>
References: <20100624162407.GA18899@core.coreip.homeip.net> <1277455071-8572-1-git-send-email-l.fu@pengutronix.de> <20100625091116.GE8546@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38372 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab0FYJcp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jun 2010 05:32:45 -0400
Content-Disposition: inline
In-Reply-To: <20100625091116.GE8546@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Luotao Fu <l.fu@pengutronix.de>, Rabin VINCENT <rabin.vincent@stericsson.com>, Samuel Ortiz <sameo@linux.intel.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 25, 2010 at 02:11:16AM -0700, Dmitry Torokhov wrote:
> On Fri, Jun 25, 2010 at 10:37:51AM +0200, Luotao Fu wrote:
> > +
> > +	/*=20
>=20
> Trailing whitespace.
>=20
> > +	 * touch_det sometimes get desasserted or just get stuck. This appears
> > +	 * to be a silicon bug, We still have to clearify this with the
> > +	 * manufacture. As a workaround We release the key anyway if the
> > +	 * touch_det keeps coming in after 4ms, while the FIFO contains no va=
lue
> > +	 * during the whole time.=20
>=20
> Trailing whitespace.
>=20
> > +
> > +static int stmpe_init_hw(struct stmpe_touch *ts)
>=20
> __devinit.
>=20

doh! Note to myself: never forget checkpatch.pl

> Otherwise:
>=20
> 	Acked-by: Dmitry Torokhov <dtor@mail.ru>
>=20

thx

> I assume it will be merged through MFD tree?
>=20

to be very honest: no idea... ;-) Samuel once asked Rabin and me to
merge the stmpe stuffs since I once posted a serie exclusively for
stmpe811, now it's so far done(V8 with white space fixes is coming).
Rabin's patch series also contains input stuffs like keypad etc. I don't
know whether Rabin is going to rebase the serie to merge some other
fixes or one of you (Samuel and you) would prefer the patch serie
"as it is".

Rabin, what do you think?

Cheers
Luotao Fu
--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwkd7gACgkQkLuxfMCkDTazlQCfW2YnS/zEdMvfTEtCgQZhfqTt
sc8AniBmopAOftXWJ4YYq/DHPywzQM+I
=20u/
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
