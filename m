From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 5/8] Input: olpc_apsp: depend on CONFIG_OF
Date: Sun, 4 Nov 2018 12:50:23 +0100
Message-ID: <20181104115023.GJ23864@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-6-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-6-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 16:25:01, Lubomir Rintel wrote:
> This is a device-tree enabled driver. Moreover CONFIG_OLPC is specific
> to the x86 platform code, while the driver is for an ARM-based laptop.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/input/serio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index d90d9f1098ff..a4f70021b53e 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -254,7 +254,7 @@ config SERIO_APBPS2
> =20
>  config SERIO_OLPC_APSP
>  	tristate "OLPC AP-SP input support"
> -	depends on OLPC || COMPILE_TEST
> +	depends on OF

I'd keep "|| COMPILE_TEST".

Otherwise

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve3P8ACgkQMOfwapXb+vKT0gCfT8Pch4W0XPavm2ciaCnum+bE
oT4AmQFBtD02YCRcdIkkO7KPoqPrgKNb
=NMGF
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
