From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 07/11] power: supply: max77650: add support for
 battery charger
Date: Tue, 12 Feb 2019 13:07:42 +0100
Message-ID: <20190212120742.GA25613@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-8-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201094736.32057-8-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +#define MAX77650_CHARGER_ENABLED		BIT(0)
> +#define MAX77650_CHARGER_DISABLED		0x00
> +#define MAX77650_CHARGER_CHG_EN_MASK		BIT(0)
> +
> +#define MAX77650_CHARGER_CHG_DTLS_MASK		GENMASK(7, 4)
> +#define MAX77650_CHARGER_CHG_DTLS_BITS(_reg) \
> +		(((_reg) & MAX77650_CHARGER_CHG_DTLS_MASK) >> 4)
> +
> +#define MAX77650_CHARGER_CHG_OFF		0x00
> +#define MAX77650_CHARGER_CHG_PREQ		0x01
> +#define MAX77650_CHARGER_CHG_ON_CURR		0x02
> +#define MAX77650_CHARGER_CHG_ON_JCURR		0x03
> +#define MAX77650_CHARGER_CHG_ON_VOLT		0x04
> +#define MAX77650_CHARGER_CHG_ON_JVOLT		0x05
> +#define MAX77650_CHARGER_CHG_ON_TOPOFF		0x06
> +#define MAX77650_CHARGER_CHG_ON_JTOPOFF		0x07
> +#define MAX77650_CHARGER_CHG_DONE		0x08
> +#define MAX77650_CHARGER_CHG_JDONE		0x09
> +#define MAX77650_CHARGER_CHG_SUSP_PF		0x0a
> +#define MAX77650_CHARGER_CHG_SUSP_FCF		0x0b
> +#define MAX77650_CHARGER_CHG_SUSP_BTF		0x0c

These are really bad define names. We are in charger driver, so
MAX77650_CHARGER_ really should be shortened/ommited. OTOH
more space should be given to "CHG_SUSP_BTF" as it is impossible to deciphe=
r.

> +#define MAX77650_CHARGER_CHGIN_DTLS_MASK	GENMASK(3, 2)
> +#define MAX77650_CHARGER_CHGIN_DTLS_BITS(_reg) \
> +		(((_reg) & MAX77650_CHARGER_CHGIN_DTLS_MASK) >> 2)
> +
> +#define MAX77650_CHARGER_CHGIN_UVL		0x00
> +#define MAX77650_CHARGER_CHGIN_OVL		0x01
> +#define MAX77650_CHARGER_CHGIN_OKAY		0x11

UVL -> UNDERVOLTAGE, OVL -> OVERVOLTAGE?


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxitw4ACgkQMOfwapXb+vJeWACgsckI6u+OjVG14U//9pRVbij1
yksAn1012uzNOYXdBfQzs1yA66em9hGj
=fkry
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
