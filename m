From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v10 02/11] dt-bindings: power: supply: add DT bindings
 for max77650
Date: Wed, 24 Apr 2019 13:31:02 +0200
Message-ID: <20190424113102.pej37jnlidwfzjhk@earth.universe>
References: <20190423090451.23711-1-brgl@bgdev.pl>
 <20190423090451.23711-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tzyyotohclek3npg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423090451.23711-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--tzyyotohclek3npg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2019 at 11:04:42AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add the DT binding document for the battery charger module of max77650.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../power/supply/max77650-charger.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max776=
50-charger.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-char=
ger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> new file mode 100644
> index 000000000000..e6d0fb6ff94e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -0,0 +1,28 @@
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
> +- input-voltage-min-microvolt:	Minimum CHGIN regulation voltage. Must be=
 one
> +				of: 4000000, 4100000, 4200000, 4300000,
> +				4400000, 4500000, 4600000, 4700000.
> +- input-current-limit-microamp:	CHGIN input current limit (in microamps)=
=2E Must
> +				be one of: 95000, 190000, 285000, 380000,
> +				475000.
> +
> +Example:
> +--------
> +
> +	charger {
> +		compatible =3D "maxim,max77650-charger";
> +		input-voltage-min-microvolt =3D <4200000>;
> +		input-current-limit-microamp =3D <285000>;
> +	};
> --=20
> 2.21.0
>=20

--tzyyotohclek3npg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzASPEACgkQ2O7X88g7
+pr0JRAApxsn5uxXytg/SEvhNBb/SxefIg95+EkMbpo96sFxk5ZP5xwaRdheUUzC
0sBN3TDPfn0IQsksQtLaZBqQ+RmQEA/K+PS7reoMNx0he1Xgetd33E6R1dBUR1XX
zi0thWOgS08u0TIX4tnogtitjVtXrY5tXJGDAqu0lQAhVjMuX8n81XQZ2zgZo4nG
42I+WP00S6JNI6kWBjHt8enj0ZzXUQc8bfcBm9uGkPpeO0u4DPHAysNeVQQBR0Ef
x4GoTX26tKiJoNrcV+V7wWDDpnpLV9c8QP0jyJCjCZPGpPtJNNieF79zhfLpgrVN
lkCamB9WLfigpnZBYgkm8dR7f1ZTFle1haYdGBfj/G/CL+rOPnrBcnQV4mv4VeNZ
vx5pM+H7EKRNDQASERSDXFejrtMi/VOj+pKxpUZqhyT63SgfVA0kHkTDt7xm+Ovc
ecvpRgx4FMWCj+FFpMVqIqcLrcdYmlnrOgJQvrkXMADuLW7xkPptQkuPnCUmugDq
uqZI4uIs7PVD/guIVM6UZhFP+4gsLFkRg8VW4T+I73NIJkN9AbKAp6L7vu2xMeYl
V3NVfGSp4f8lJNvlNV5auM2b+8vTGX+W7Ef+xUrxHj2Nh6zOR27wmVeDRcsofbmF
bH6mOSfxHrgnc9LG0LIahlxhIbfcmMr4XCu31xYozmL1GgwuWPM=
=usHc
-----END PGP SIGNATURE-----

--tzyyotohclek3npg--
