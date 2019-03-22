From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RESEND PATCH v6 09/11] leds: max77650: add LEDs support
Date: Fri, 22 Mar 2019 10:21:24 +0100
Message-ID: <20190322092124.GK27015@amd>
References: <20190318174228.18194-1-brgl@bgdev.pl>
 <20190318174228.18194-10-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x1F0m3RQhDZyj8sd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190318174228.18194-10-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--x1F0m3RQhDZyj8sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-18 18:42:26, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> This adds basic support for LEDs for the max77650 PMIC. The device has
> three current sinks for driving LEDs.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +		label =3D of_get_property(child, "label", NULL);
> +		if (!label) {
> +			led->cdev.name =3D "max77650::";
> +		} else {
> +			led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL,
> +							"max77650:%s", label);
> +			if (!led->cdev.name)
> +				return -ENOMEM;
> +		}

I'd rather not have the "max77650:" prefix in the LED name (as it is
useless).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x1F0m3RQhDZyj8sd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUqRQACgkQMOfwapXb+vIDYACfdHFyUAEXnr0Ae0z0fmA88+W4
26sAn19tEhhew24H1UFKk8OP7jUTSKNn
=iE3E
-----END PGP SIGNATURE-----

--x1F0m3RQhDZyj8sd--
