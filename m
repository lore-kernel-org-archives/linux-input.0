From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2] Input: atmel_mxt_ts - fix reset-gpio for level based
 irqs
Date: Wed, 9 May 2018 16:25:45 +0200
Message-ID: <20180509142545.GC25131@amd>
References: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
 <20180423115844.26281-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180423115844.26281-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
List-Id: linux-input@vger.kernel.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-23 13:58:44, Sebastian Reichel wrote:
> The current reset-gpio support triggers an interrupt storm on platforms
> using the maxtouch with level based interrupt. The Motorola Droid 4,
> which I used for some of the tests is not affected, since it uses a edge
> based interrupt.
>=20
> This change avoids the interrupt storm by enabling the device while its
> interrupt is disabled. Afterwards we wait 100ms. This is important for
> two reasons: The device is unresponsive for some time (~22ms for
> mxt224E) and the CHG (interrupt) line is not working properly for 100ms.
> We don't need to wait for any following interrupts, since the following
> mxt_initialize() checks for bootloader mode anyways.
>=20
> This fixes a boot issue on GE PPD (watchdog kills device due to
> interrupt storm) and does not cause regression on Motorola Droid 4.

Out of curiosity, what is "GE PPD"?

> Fixes: f657b00df22e ("Input: atmel_mxt_ts - add support for reset line")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrzBOkACgkQMOfwapXb+vIXWACfVtXLAzqzOfQ6qc7egfLguSG4
6SkAn05YpM1JDPfHM3vPhPg4CMw8vbqr
=9fji
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
