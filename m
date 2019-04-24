From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v10 00/11] mfd: add support for max77650 PMIC
Date: Wed, 24 Apr 2019 10:31:27 +0200
Message-ID: <20190424083127.GB6699@amd>
References: <20190423090451.23711-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423090451.23711-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-23 11:04:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> This series adds support for max77650 ultra low-power PMIC. It provides
> the core mfd driver and a set of five sub-drivers for the regulator,
> power supply, gpio, leds and input subsystems.
>=20
> Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_devic=
es().
> Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for this
> device.
>=20
> The regulator part is already upstream.

I see v10 in my inbox... and acks from all over the place, but patches
not going in. Who takes these? I don't think I need another 10
versions in my inbox...
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAHt8ACgkQMOfwapXb+vL/mgCeOCQVfRMEFE1+NFcHmsDoDLMo
MjsAoI/6BvVLuAazM6fSVjSB60dlhrmA
=BJ96
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
