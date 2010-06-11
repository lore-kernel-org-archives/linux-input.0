From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/3] mfd: add STMPE811 core support
Date: Fri, 11 Jun 2010 15:28:06 +0200
Message-ID: <20100611132806.GA5197@pengutronix.de>
References: <1276251195-22981-1-git-send-email-l.fu@pengutronix.de> <1276251195-22981-2-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50380 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272Ab0FKN2N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jun 2010 09:28:13 -0400
Content-Disposition: inline
In-Reply-To: <1276251195-22981-2-git-send-email-l.fu@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luotao Fu <l.fu@pengutronix.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fu,

> +err_free:
> +	mutex_destroy(&stm->io_lock);
> +	i2c_set_clientdata(client, NULL);

Please drop the clientdata line; the core clears the pointer now.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwSOeYACgkQD27XaX1/VRv0qwCgh6QWsiSjIzrIrYtXk3M5Bp6k
PeQAniaaqE10Br9juShZ4LVA3FEQb0Fx
=obeO
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
