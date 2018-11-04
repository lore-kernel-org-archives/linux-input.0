From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/8] dt-bindings: olpc,ap-sp: add clock
Date: Sun, 4 Nov 2018 12:41:38 +0100
Message-ID: <20181104114138.GF23864@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-2-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 16:24:57, Lubomir Rintel wrote:
> The clock is necessary for the device operation, hence it's required.
> Its name, "sp", stands for "Security Processor". It is one of several
> names that are used for the processor that serves as the keyboard
> controller on an OLPC and is consistent with the node name.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

One thing that surprise me... Rob maintains these files, so he should
apply it?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve2vIACgkQMOfwapXb+vKaSwCgoIexpxamGbgtutL4EZb0oKEl
IT0AnRb2HwFu+BYUxGiX2IgmU0hzm2jK
=E5QZ
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
