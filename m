From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RESEND PATCH v6 04/11] dt-bindings: input: add DT bindings for
 max77650
Date: Fri, 22 Mar 2019 10:09:28 +0100
Message-ID: <20190322090927.GG27015@amd>
References: <20190318174228.18194-1-brgl@bgdev.pl>
 <20190318174228.18194-5-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190318174228.18194-5-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-18 18:42:21, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add the DT binding document for the onkey module of max77650.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

> +	onkey {
> +		compatible =3D "maxim,max77650-onkey";
> +		linux,code =3D <KEY_END>;
> +		maxim,onkey-slide;
> +	};

This is certainly wrong.

"End" key is normal key on a keyboard, certainly not some kind of
slider.

And this controller is likely to be used for power key, not end key,
right?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUpkcACgkQMOfwapXb+vI7+gCgtR9qsW4+U0xJMEpMLoLxGKYu
itwAoKrO/g0S5nETSLnuZcIK4ohzqZ3i
=INOr
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--
