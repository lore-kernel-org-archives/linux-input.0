From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/8] dt-bindings: olpc,ap-sp: add GPIO lines
Date: Sun, 4 Nov 2018 12:49:20 +0100
Message-ID: <20181104114919.GI23864@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 16:24:58, Lubomir Rintel wrote:
> Add properties describing the GPIO lines used by the keyboard controller.
> The olpc-apsp driver will do happily without them, but they are still part
> of the hardware description. The driver could still reserve the lines,
> so that nothing else touches them.
>=20
> This makes the device node almost compatible with "ps2-gpio". I'm not
> adding a compatible property, because ps2-gpio would use a different
> interrupt, so that we'd need to name it. And I haven't actually tried it.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

Again, Rob, could you apply this one?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve3L8ACgkQMOfwapXb+vIBPACgspouzSO5DVpq42MMgmIM7ibz
fJwAoLJJh1uKm0uBnr4bEN/aji9pQyGI
=DDMT
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
