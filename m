From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 07/11] power: supply: max77650: add support for
 battery charger
Date: Tue, 12 Feb 2019 13:08:23 +0100
Message-ID: <20190212120823.GB25613@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-8-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201094736.32057-8-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-02-01 10:47:32, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add basic support for the battery charger for max77650 PMIC.
>=20
> diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supp=
ly/max77650-charger.c
> new file mode 100644
> index 000000000000..7055c9b5ee24
> --- /dev/null
> +++ b/drivers/power/supply/max77650-charger.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 BayLibre SAS
> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +//
> +// Battery charger driver for MAXIM 77650/77651 charger/power-supply.
> +

If available, pointer to a datasheet would be welcome here.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxitzcACgkQMOfwapXb+vJ2GwCggYuFUAUJLqpZI1xCLDlLxdLg
J2EAnA/W8O2GDKK9ViEchoqBWA5eZDnD
=Wybx
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
