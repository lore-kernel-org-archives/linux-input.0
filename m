From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 4/8] clk: mmp2: add SP clock
Date: Sun, 4 Nov 2018 12:48:50 +0100
Message-ID: <20181104114850.GH23864@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-5-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-5-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 16:25:00, Lubomir Rintel wrote:
> The "security processor", sometimes referred to as "wireless trusted
> module" or "generic encrypt unit" is a low-power core present on MMP2,
> that has nothing to do with security, wireless, trust or encryption.
>=20
> On an OLPC machine it runs CForth and serves as a keyboard controller:
> http://dev.laptop.org/git/users/wmb/cforth/tree/src/app/arm-xo-1.75/ps2.f=
th
>=20
> The register address was obtained from the OLPC kernel, since the
> datasheet seems to be the Marvell's most important business secret.
>=20
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve3KIACgkQMOfwapXb+vI0eQCfQloAAVjKQSZofPO/UZnoIebe
ZV4AnirIF9w7IEd86O82WRODtS15nhnB
=zOEP
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--
