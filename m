From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: drivers/input/touchscreen/ads7846.c:959: error: 'GPIOF_DIR_IN'
 undeclared
Date: Tue, 8 Feb 2011 22:20:46 +0100
Message-ID: <20110208212046.GA29410@pengutronix.de>
References: <AANLkTim2706Negrvd-ektbNMLwucM9M0icphb_uFY_9D@mail.gmail.com>
 <20110208211035.GC16527@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110208211035.GC16527@core.coreip.homeip.net>
Sender: linux-next-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Sourav Poddar <sourav.poddar@ti.com>, Linux-Next <linux-next@vger.kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 08, 2011 at 01:10:36PM -0800, Dmitry Torokhov wrote:

> Crap, sorry about that, I'll fix it up tonight.

I had the same issue while working on some other gpio-cleanup.
I am just about to finish a patch.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1Rs64ACgkQD27XaX1/VRviUQCfft151XDHdTwdby8L39uMwkuZ
0VsAoIQZKwV83uRaGRLTQR9lyLX1YtQs
=FSnh
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
