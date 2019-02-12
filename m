From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 10/11] input: max77650: add onkey support
Date: Tue, 12 Feb 2019 13:17:46 +0100
Message-ID: <20190212121745.GE25613@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-11-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201094736.32057-11-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +	error =3D device_property_read_string(dev,
> +					    "maxim,onkey-mode", &mode_prop);
> +	if (error)
> +		mode_prop =3D "push";
> +
> +	if (strcmp(mode_prop, "push") =3D=3D 0)
> +		mode =3D MAX77650_ONKEY_MODE_PUSH;
> +	else if (strcmp(mode_prop, "slide") =3D=3D 0)
> +		mode =3D MAX77650_ONKEY_MODE_SLIDE;
> +	else
> +		return -EINVAL;
=2E..
> +	onkey->input->name =3D "max77650_onkey";
> +	onkey->input->phys =3D "max77650_onkey/input0";
> +	onkey->input->id.bustype =3D BUS_I2C;
> +	input_set_capability(onkey->input, EV_KEY, onkey->code);

Is EV_KEY correct for mode=3D=3Dslide?


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxiuWkACgkQMOfwapXb+vL97gCfeIC+c5OV205NgupxrKvuj5CO
0kQAoI+IbZw8GC/aKAaDgtbl6y75BUXl
=skQG
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
