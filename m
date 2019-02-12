From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 09/11] leds: max77650: add LEDs support
Date: Tue, 12 Feb 2019 13:12:36 +0100
Message-ID: <20190212121236.GD25613@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-10-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201094736.32057-10-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a72f97fca57b..6e7a8f51eccc 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -608,6 +608,12 @@ config LEDS_TLC591XX
>  	  This option enables support for Texas Instruments TLC59108
>  	  and TLC59116 LED controllers.
> =20
> +config LEDS_MAX77650
> +	tristate "LED support for Maxim MAX77650 PMIC"
> +	depends on MFD_MAX77650
> +	help
> +	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated."
> +

List the chips? Remove extra "?
									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxiuDQACgkQMOfwapXb+vLLTwCgiYimCo/93UUXIloj1n7uT0ZD
8twAnRSgFz7OebK5xg0fuyTZMqiG4qtG
=8HwK
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
