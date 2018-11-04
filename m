From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 8/8] Input: olpc_apsp: allocate the GPIOs used
Date: Sun, 4 Nov 2018 12:55:30 +0100
Message-ID: <20181104115530.GL23864@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-9-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NZiXfHLGvOGtDZMn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-9-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--NZiXfHLGvOGtDZMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 16:25:04, Lubomir Rintel wrote:
> Take the GPIO lines are used by the SP. The driver doesn't touch the
> lines -- this is done to disallow anything else from fiddling with
> them because that would confuse the SP firmware.
>=20
> Also, the lines are now nicely visible in /sys/kernel/debug/gpio.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NZiXfHLGvOGtDZMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve3jIACgkQMOfwapXb+vIHIgCeN8jA2Mf/S5oOIubEcIBwPS3i
D4oAoKeA+AjE/NGvKL46jU5o8LO/85EH
=RE3U
-----END PGP SIGNATURE-----

--NZiXfHLGvOGtDZMn--
