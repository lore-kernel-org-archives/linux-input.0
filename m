From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RESEND PATCH v6 02/11] dt-bindings: power: supply: add DT
 bindings for max77650
Date: Fri, 22 Mar 2019 10:00:38 +0100
Message-ID: <20190322090038.GE27015@amd>
References: <20190318174040.17899-1-brgl@bgdev.pl>
 <20190318174040.17899-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190318174040.17899-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-18 18:40:31, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add the DT binding document for the battery charger module of max77650.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max776=
50-charger.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-char=
ger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> new file mode 100644
> index 000000000000..d25c95369616
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -0,0 +1,27 @@
> +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The charger is represented as a sub-node of the PMIC node on the device =
tree.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-charger"
> +
> +Optional properties:
> +--------------------
> +- min-microvolt:	Minimum CHGIN regulation voltage (in microvolts). Must =
be
> +			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
> +			4500000, 4600000, 4700000.

Probably needs "max," prefix. And .. what does this mean? Will charger
shutdown if input is less than this?

> +- curr-lim-microamp:	CHGIN input current limit (in microamps). Must be o=
ne of:
> +			95000, 190000, 285000, 380000, 475000.

"current-limit-microamp", I guess. And probably "max,current-limit-microamp=
".

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUpDYACgkQMOfwapXb+vIY0QCfbYMaCaIRAIPQST9ZtnsrBIG3
cCQAmwRQDdMkMze5VjKunCXayPVw/2Zx
=6G1s
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
