From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: wm97xx_read_aux_adc() for battery & pen down?
Date: Fri, 24 Jun 2011 18:58:02 +0200
Message-ID: <20110624165802.GB5042@pengutronix.de>
References: <20110624130049.GA9374@pengutronix.de>
 <20110624165204.GB30047@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36016 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab1FXQ6E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 12:58:04 -0400
Content-Disposition: inline
In-Reply-To: <20110624165204.GB30047@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, dp@opensource.wolfsonmicro.com


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2011 at 05:52:04PM +0100, Mark Brown wrote:
> On Fri, Jun 24, 2011 at 03:00:49PM +0200, Wolfram Sang wrote:
>=20
> > battery-status, but I need the following dirty hack for 3.0-rc4 in
> > wm97xx_read_aux_adc():
>=20
> > ...
> > -       if (!(*sample & WM97XX_PEN_DOWN)) {
> > +       /* HACK! Disable check for battery channel on Jaytech PID7901 */
> > +       if ((adcsel !=3D 0x6000) && !(*sample & WM97XX_PEN_DOWN)) {
> >                 wm->pen_probably_down =3D 0;
> >                 return RC_PENUP;
> >         }
>=20
> I don't see this code in that function?

Ahem, sorry, I mixed the function names. wm97xx_read_aux_adc() uses the
poll_sample-pointer which points to wm9712_poll_sample() in my case.
There I need the above code.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4EwhoACgkQD27XaX1/VRuzqQCePYMuf4cYy03bAT1WgM1b6O3d
Ep8AnRmRlRDX2EyULXztkaZOsYHWcOGB
=eM73
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
