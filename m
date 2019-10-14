From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: power: max77650: convert the binding
 document to yaml
Date: Mon, 14 Oct 2019 06:32:25 +0200
Message-ID: <20191014043225.ejpyccvo3jpkvz2r@earth.universe>
References: <20190930130246.4860-1-brgl@bgdev.pl>
 <20190930130246.4860-5-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lvytl443p4a5vq52"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190930130246.4860-5-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--lvytl443p4a5vq52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 30, 2019 at 03:02:44PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Convert the binding document for max77650 charger module to yaml.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Assuming, that Rob will merge the series:

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  .../power/supply/max77650-charger.txt         | 29 +------------
>  .../power/supply/max77650-charger.yaml        | 42 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max776=
50-charger.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-char=
ger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> index e6d0fb6ff94e..fbab7d3ac8e3 100644
> --- a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -1,28 +1 @@
> -Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> -
> -This module is part of the MAX77650 MFD device. For more details
> -see Documentation/devicetree/bindings/mfd/max77650.txt.
> -
> -The charger is represented as a sub-node of the PMIC node on the device =
tree.
> -
> -Required properties:
> ---------------------
> -- compatible:		Must be "maxim,max77650-charger"
> -
> -Optional properties:
> ---------------------
> -- input-voltage-min-microvolt:	Minimum CHGIN regulation voltage. Must be=
 one
> -				of: 4000000, 4100000, 4200000, 4300000,
> -				4400000, 4500000, 4600000, 4700000.
> -- input-current-limit-microamp:	CHGIN input current limit (in microamps)=
=2E Must
> -				be one of: 95000, 190000, 285000, 380000,
> -				475000.
> -
> -Example:
> ---------
> -
> -	charger {
> -		compatible =3D "maxim,max77650-charger";
> -		input-voltage-min-microvolt =3D <4200000>;
> -		input-current-limit-microamp =3D <285000>;
> -	};
> +This file was moved to max77650-charger.yaml.
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-char=
ger.yaml b/Documentation/devicetree/bindings/power/supply/max77650-charger.=
yaml
> new file mode 100644
> index 000000000000..9dd0dad0f948
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/max77650-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> +
> +maintainers:
> +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +
> +description: |
> +  This module is part of the MAX77650 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +  The charger is represented as a sub-node of the PMIC node on the devic=
e tree.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77650-charger
> +
> +  input-voltage-min-microvolt:
> +    description:
> +      Minimum CHGIN regulation voltage.
> +    enum: [ 4000000, 4100000, 4200000, 4300000,
> +            4400000, 4500000, 4600000, 4700000 ]
> +
> +  input-current-limit-microamp:
> +    description:
> +      CHGIN input current limit (in microamps).
> +    enum: [ 95000, 190000, 285000, 380000, 475000 ]
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    charger {
> +        compatible =3D "maxim,max77650-charger";
> +        input-voltage-min-microvolt =3D <4200000>;
> +        input-current-limit-microamp =3D <285000>;
> +    };
> --=20
> 2.23.0
>=20

--lvytl443p4a5vq52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2j+lkACgkQ2O7X88g7
+pomCA/7BKT68Dw2GbwGBoG4yadDJGw3mu+fWzAQF5R76k+9J5ic2r+Q/Gr1M3rZ
zbwH0Isgl1RCAa/usmx1lDMG/CWPivdz4ofnr2sX1SLYNNz/fmtcrt3TtlyXwhxs
3DR5eQQz9lOjcF5EVMptxaYNaoQtRV6Ptu7KFf5+graYuJ9U8Zvcb7P/gfzEKMTW
tImGYv3ZqvQye1u5OaqgZrYgnULyB1Pibjz9FFTM6EjPomJP++9+T8MSLHV3wZEA
bhy+e6cqIrEVfCy9f9t6a9y5PyvhuAVb59AKo3e6atYa4WwKObr47iCdI2GTcg+G
5hLD80c3tS28T0LbKgtrHrOsA3V/0qY14tlWZvnrFpoDwKy5+hGTDVsXSXAE5whj
hpyqYEQNWy8zYsZ+F73xGGqzGPWv/MoA4mBpvTLe9fuf+TN0M35p2nbycKReW4+a
k0pnlPDfzwmfNiEmdl3UYJkMfLZk488ljkJe1tww0d4+LKQqtVb9w9bKVxxARVtg
F3KXegzxNjnNNl584ucPZLZwGhJzNSJ9zwMbE6GDRJFCmH4MEkrWLnaTqesk9xLn
3+M1A3PL9Cehdt0aAqU5bzFKYbPBLgk2b4UCxl1UL6nTLgM9KS8bd05zMMDYJJfs
+GS5YKf1vPTceX6j0kDzV/kmJTQhESPw00rZ3b4jwNpETP7GMkw=
=MbIN
-----END PGP SIGNATURE-----

--lvytl443p4a5vq52--
