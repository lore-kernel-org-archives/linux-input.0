From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RESEND PATCH v6 03/11] dt-bindings: leds: add DT bindings for
 max77650
Date: Fri, 22 Mar 2019 10:02:09 +0100
Message-ID: <20190322090208.GF27015@amd>
References: <20190318174040.17899-1-brgl@bgdev.pl>
 <20190318174040.17899-4-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190318174040.17899-4-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-18 18:40:32, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add the DT binding document for the LEDs module of max77650.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +		led@0 {
> +			reg =3D <0>;
> +			label =3D "blue:usr0";
> +		};

I'd rather not see these "usrX" things... Does it have some kind of
real function?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUpJAACgkQMOfwapXb+vKDNACeNJqMgPx8GGv3sxEzok7QIZW0
W1cAoI/kzBWIF4PObkvTiq9NUIiOu90c
=8ecR
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--
