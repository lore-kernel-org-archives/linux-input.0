From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 5/5] mfd: sunxi-gpadc-mfd: probe sunxi-gpadc-ts driver
Date: Thu, 21 Jul 2016 08:08:12 +0200
Message-ID: <20160721060812.GA5993@lukather>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-6-git-send-email-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469003351-15263-6-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

On Wed, Jul 20, 2016 at 10:29:11AM +0200, Quentin Schulz wrote:
> This probes the touchscreen driver for Allwinner SoCs (A10, A13 and A31)
> when the property "allwinner,ts-attached" is set in the GPADC (rtp) node =
of
> the DT.
>=20
> Some comestic modifications done to shorten and increase readability of t=
he
> code.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/sunxi-gpadc-mfd.c | 115 ++++++++++++++++++++++++++++--------=
------
>  1 file changed, 77 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
> index 05a000b..9b9ed0b 100644
> --- a/drivers/mfd/sunxi-gpadc-mfd.c
> +++ b/drivers/mfd/sunxi-gpadc-mfd.c
> @@ -21,6 +21,11 @@
>  #define SUNXI_IRQ_TEMP_DATA	1
>  #define SUNXI_IRQ_TP_UP		2
> =20
> +#define SUNXI_GPADC_MFD_CELL(_name, _resources, _num_resources) {	\
> +	.name =3D _name,							\
> +	.resources =3D _resources,					\
> +	.num_resources =3D _num_resources					\
> +}
> =20
>  static struct resource adc_resources[] =3D {
>  	{
> @@ -64,33 +69,45 @@ static const struct regmap_irq_chip sunxi_gpadc_mfd_r=
egmap_irq_chip =3D {
>  };
> =20
>  static struct mfd_cell sun4i_gpadc_mfd_cells[] =3D {
> -	{
> -		.name	=3D "sun4i-a10-gpadc-iio",
> -		.resources =3D adc_resources,
> -		.num_resources =3D ARRAY_SIZE(adc_resources),
> -	}, {
> -		.name =3D "iio_hwmon",
> -	}
> +	SUNXI_GPADC_MFD_CELL("sun4i-a10-gpadc-iio", adc_resources,
> +			     ARRAY_SIZE(adc_resources)),
> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
>  };
> =20
>  static struct mfd_cell sun5i_gpadc_mfd_cells[] =3D {
> -	{
> -		.name	=3D "sun5i-a13-gpadc-iio",
> -		.resources =3D adc_resources,
> -		.num_resources =3D ARRAY_SIZE(adc_resources),
> -	}, {
> -		.name =3D "iio_hwmon",
> -	},
> +	SUNXI_GPADC_MFD_CELL("sun5i-a13-gpadc-iio", adc_resources,
> +			     ARRAY_SIZE(adc_resources)),
> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
>  };
> =20
>  static struct mfd_cell sun6i_gpadc_mfd_cells[] =3D {
> -	{
> -		.name	=3D "sun6i-a31-gpadc-iio",
> -		.resources =3D adc_resources,
> -		.num_resources =3D ARRAY_SIZE(adc_resources),
> -	}, {
> -		.name =3D "iio_hwmon",
> -	},
> +	SUNXI_GPADC_MFD_CELL("sun6i-a31-gpadc-iio", adc_resources,
> +			     ARRAY_SIZE(adc_resources)),
> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> +};

This should be part of a separate patch.

> +
> +static struct mfd_cell sun4i_gpadc_mfd_cells_ts[] =3D {
> +	SUNXI_GPADC_MFD_CELL("sun6i-a31-gpadc-iio", adc_resources,
> +			     ARRAY_SIZE(adc_resources)),
> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> +	SUNXI_GPADC_MFD_CELL("sunxi-gpadc-ts", ts_resources,
> +			     ARRAY_SIZE(ts_resources)),
> +};
> +
> +static struct mfd_cell sun5i_gpadc_mfd_cells_ts[] =3D {
> +	SUNXI_GPADC_MFD_CELL("sun5i-a13-gpadc-iio", adc_resources,
> +			     ARRAY_SIZE(adc_resources)),
> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> +	SUNXI_GPADC_MFD_CELL("sunxi-gpadc-ts", ts_resources,
> +			     ARRAY_SIZE(ts_resources)),
> +};
> +
> +static struct mfd_cell sun6i_gpadc_mfd_cells_ts[] =3D {
> +	SUNXI_GPADC_MFD_CELL("sun6i-a31-gpadc-iio", adc_resources,
> +			     ARRAY_SIZE(adc_resources)),
> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> +	SUNXI_GPADC_MFD_CELL("sunxi-gpadc-ts", ts_resources,
> +			     ARRAY_SIZE(ts_resources)),
>  };
> =20
>  static const struct regmap_config sunxi_gpadc_mfd_regmap_config =3D {
> @@ -142,23 +159,45 @@ static int sunxi_gpadc_mfd_probe(struct platform_de=
vice *pdev)
>  	}
> =20
>  	if (of_device_is_compatible(pdev->dev.of_node,
> -				    "allwinner,sun4i-a10-ts"))
> -		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> -				      sun4i_gpadc_mfd_cells,
> -				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
> -				      0, NULL);
> -	else if (of_device_is_compatible(pdev->dev.of_node,
> -					 "allwinner,sun5i-a13-ts"))
> -		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> -				      sun5i_gpadc_mfd_cells,
> -				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
> -				      0, NULL);
> -	else if (of_device_is_compatible(pdev->dev.of_node,
> -					 "allwinner,sun6i-a31-ts"))
> -		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> -				      sun6i_gpadc_mfd_cells,
> -				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
> -				      0, NULL);
> +				    "allwinner,sun4i-a10-ts")) {
> +		if (of_property_read_bool(pdev->dev.of_node,
> +					  "allwinner,ts-attached"))
> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +					      sun4i_gpadc_mfd_cells_ts,
> +					      ARRAY_SIZE(sun4i_gpadc_mfd_cells_ts),
> +					      NULL, 0, NULL);
> +		else
> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +					      sun4i_gpadc_mfd_cells,
> +					      ARRAY_SIZE(sun4i_gpadc_mfd_cells),
> +					      NULL, 0, NULL);
> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> +					 "allwinner,sun5i-a13-ts")) {
> +		if (of_property_read_bool(pdev->dev.of_node,
> +					  "allwinner,ts-attached"))
> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +					      sun5i_gpadc_mfd_cells_ts,
> +					      ARRAY_SIZE(sun5i_gpadc_mfd_cells_ts),
> +					      NULL, 0, NULL);
> +		else
> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +					      sun5i_gpadc_mfd_cells,
> +					      ARRAY_SIZE(sun5i_gpadc_mfd_cells),
> +					      NULL, 0, NULL);
> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> +					 "allwinner,sun6i-a31-ts")) {
> +		if (of_property_read_bool(pdev->dev.of_node,
> +					  "allwinner,ts-attached"))
> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +					      sun6i_gpadc_mfd_cells_ts,
> +					      ARRAY_SIZE(sun6i_gpadc_mfd_cells_ts),
> +					      NULL, 0, NULL);
> +		else
> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +					      sun6i_gpadc_mfd_cells,
> +					      ARRAY_SIZE(sun6i_gpadc_mfd_cells),
> +					      NULL, 0, NULL);
> +	}

Please don't use any of_device_is_compatible.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkGbMAAoJEBx+YmzsjxAgCLMP/199eYL/z9vd78mnDMOJMyKp
nhfL69OivB/oZAanEylqV0VY2U48jFGvJM3247z4M0YALd0BMO7OsrV/Qk67Ji7k
DF0PlLnpWdoZvyDaNqInKSq95dXRh6hv/PULwuiKLbxfiXjotsOtJGq16tp6kuGZ
8Su4Mlr5IV2i5sJjrA2nCwMwIgARLfKdwiAFByy8ISmL1xBvRchUc0fONg41TM7G
7z77U0oIsu39x7v08pmGA06ihiWK96yJF+/+rLPd+bVGMmGORQAIaOfOxvs5shFP
1CfEraJH7s/PJQD3z9hLURTaORj5QO1VRuuhu9GPs3j14TsK7wYiFEoBM70NT2e1
Fw+BvPN+AETPK2KZQ2fuPowpyuBg7NokUv5c1FnKL2xF7FV9UM0m75sSem+x4B5P
jNYKEqPFgboASNZ1PQ8vCXV6wvQxoClPBf9CxRI8sBn5IQqF3q732J3/7z0yw3Ma
8jcHMkhlK7+t64OCPQtf7w6l+WHsw4FyprLN0Dtx1YdMrxEtmCICHlBkU33oj0cL
GLFSEI6PdjKx9V+N/6GB66z2gzHCO1uqj/NaZfN+SFtu9qVE7z2k7Hn5J4fP7apL
eXRehjepDjff9U31IdJ6iZg6dvYQrALirI16oi3brIvv6YiH8rpAbbal0NLx2Ue9
zFKcxKIR+9gtf1c4mSmm
=enbF
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
