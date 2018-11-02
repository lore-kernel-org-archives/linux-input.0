From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/8] Input: olpc_apsp: check FIFO status on open(), not
 probe()
Date: Fri, 2 Nov 2018 23:16:09 +0100
Message-ID: <20181102221609.GA5322@amd>
References: <20180910112654.42061-1-lkundrak@v3.sk>
 <20180910112654.42061-7-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180910112654.42061-7-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-input@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-10 13:26:52, Lubomir Rintel wrote:
> Let's defer the FIFO status checking until open().
>=20
> When we'll get a clk handle, this will allow us to defer clock enablement
> until the device is actually used.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvczKkACgkQMOfwapXb+vITPwCggk6ezBBtegkYFh2J6ErUWagC
FbwAn2iRysWVzLxqHqsq3oCGgSpUk8lR
=11n9
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
