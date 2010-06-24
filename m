From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH 5/6] mfd/stmpexxx: fix stmpe811 enable hook
Date: Thu, 24 Jun 2010 14:32:11 +0200
Message-ID: <20100624123211.GB3988@pengutronix.de>
References: <20100622135635.GA30720@bnru02.bnr.st.com>
 <1277378021-16802-6-git-send-email-l.fu@pengutronix.de>
 <20100624121059.GA26189@bnru02.bnr.st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48268 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336Ab0FXMcR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jun 2010 08:32:17 -0400
Content-Disposition: inline
In-Reply-To: <20100624121059.GA26189@bnru02.bnr.st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rabin VINCENT <rabin.vincent@stericsson.com>
Cc: Luotao Fu <l.fu@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 24, 2010 at 05:41:00PM +0530, Rabin VINCENT wrote:
> On Thu, Jun 24, 2010 at 13:13:40 +0200, Luotao Fu wrote:
> > Fix the stmpe811 enable hook so that we can activate the needed clocks =
for the
> > touchscreen controller.
> >=20
> > Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
> > ---
> >  drivers/mfd/stmpe-devices.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/mfd/stmpe-devices.c b/drivers/mfd/stmpe-devices.c
> > index 3e21c26..25941ea 100644
> > --- a/drivers/mfd/stmpe-devices.c
> > +++ b/drivers/mfd/stmpe-devices.c
> > @@ -117,8 +117,9 @@ static int stmpe811_enable(struct stmpe *stmpe, uns=
igned int blocks,
> >  	if (blocks & STMPE_BLOCK_ADC)
> >  		mask |=3D STMPE811_SYS_CTRL2_ADC_OFF;
> > =20
> > -	if (blocks & STMPE_BLOCK_KEYPAD)
> > -		mask |=3D STMPE811_SYS_CTRL2_TSC_OFF;
> > +	if (blocks & STMPE_BLOCK_TOUCHSCREEN)
> > +		mask |=3D STMPE811_SYS_CTRL2_ADC_OFF
> > +			| STMPE811_SYS_CTRL2_TSC_OFF;
>=20
> The KEYPAD -> TOUCHSCREEN fix is fine, but for the ADC, wouldn't it be
> better to pass in STMPE_BLOCK_ADC in your stmpe_enable() call instead?
> You wouldn't need to add another call, you can just pass in
> (STMPE_BLOCK_TOUCHSCREEN | STMPE_BLOCK_ADC) as the argument.

agreed, this would be more clear. Just sent the V2 of this fix and V5 of
the ts driver. I Btw mixed message IDs up and the V2 of the enable hook fix
went out with the same "reply to" ID as the ts driver. doh! sorry for the
confusion.

cheers
Luotao Fu
--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwjUEsACgkQkLuxfMCkDTbvEgCfcTUhMFQ3EBp7g8Kokp77Vjla
X7oAn02K4JM0gOoV6idORnAuPvBT0KWr
=P9fT
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
