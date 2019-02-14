From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 07/11] power: supply: max77650: add support for
 battery charger
Date: Thu, 14 Feb 2019 11:39:44 +0100
Message-ID: <20190214103944.GC6132@amd>
References: <20190213134335.10838-1-brgl@bgdev.pl>
 <20190213134335.10838-8-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213134335.10838-8-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +#define MAX77650_CHG_OFF			0x00
> +#define MAX77650_CHG_PREQ			0x01
> +
> +#define MAX77650_CHGIN_UNDERVOLTAGE_LOCKOUT	0x00
> +#define MAX77650_CHGIN_OVERVOLTAGE_LOCKOUT	0x01
> +#define MAX77650_CHGIN_OKAY			0x11

Thanks for doing this.

> +#define MAX77650_CHG_ON_CURR			0x02
> +#define MAX77650_CHG_ON_CURR_JEITA		0x03
> +#define MAX77650_CHG_ON_VOLT			0x04
> +#define MAX77650_CHG_ON_VOLT_JEITA		0x05
> +#define MAX77650_CHG_ON_TOPOFF			0x06
> +#define MAX77650_CHG_ON_TOPOFF_JEITA		0x07
> +#define MAX77650_CHG_DONE			0x08
> +#define MAX77650_CHG_DONE_JEITA			0x09
> +#define MAX77650_CHG_SUSP_PREQ_TIM_FAULT	0x0a
> +#define MAX77650_CHG_SUSP_FAST_CHG_TIM_FAULT	0x0b
> +#define MAX77650_CHG_SUSP_BATT_TEMP_FAULT	0x0c
> +
> +#define MAX77650_CHARGER_CHGIN_DTLS_MASK	GENMASK(3, 2)
> +#define MAX77650_CHARGER_CHGIN_DTLS_BITS(_reg) \
> +		(((_reg) & MAX77650_CHARGER_CHGIN_DTLS_MASK) >> 2)

But I guess these could use similar treatment?
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxlRXAACgkQMOfwapXb+vKeNACeKRfN7OVB4oFp8dOR9nRaQtxt
RXEAni5CG3ToOk2cF9pUwPoHKM4lMFqB
=61KM
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
