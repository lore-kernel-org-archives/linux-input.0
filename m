From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] mfd: sunxi-gpadc-mfd: probe sunxi-gpadc-ts driver
Date: Mon, 25 Jul 2016 11:21:58 +0100
Message-ID: <20160725102158.GJ14925@dell>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-6-git-send-email-quentin.schulz@free-electrons.com>
 <20160721060812.GA5993@lukather>
 <11247e4f-d04d-d5bc-6ebf-a637820c011d@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <11247e4f-d04d-d5bc-6ebf-a637820c011d-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 24 Jul 2016, Jonathan Cameron wrote:

> On 21/07/16 07:08, Maxime Ripard wrote:
> > Hi Quentin,
> >=20
> > On Wed, Jul 20, 2016 at 10:29:11AM +0200, Quentin Schulz wrote:
> >> This probes the touchscreen driver for Allwinner SoCs (A10, A13 an=
d A31)
> >> when the property "allwinner,ts-attached" is set in the GPADC (rtp=
) node of
> >> the DT.
> >>
> >> Some comestic modifications done to shorten and increase readabili=
ty of the
> >> code.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> ---
> >>  drivers/mfd/sunxi-gpadc-mfd.c | 115 ++++++++++++++++++++++++++++-=
-------------
> >>  1 file changed, 77 insertions(+), 38 deletions(-)
> >>
> >> diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpa=
dc-mfd.c
> >> index 05a000b..9b9ed0b 100644
> >> --- a/drivers/mfd/sunxi-gpadc-mfd.c
> >> +++ b/drivers/mfd/sunxi-gpadc-mfd.c
> >> @@ -21,6 +21,11 @@
> >>  #define SUNXI_IRQ_TEMP_DATA	1
> >>  #define SUNXI_IRQ_TP_UP		2
> >> =20
> >> +#define SUNXI_GPADC_MFD_CELL(_name, _resources, _num_resources) {=
	\
> >> +	.name =3D _name,							\
> >> +	.resources =3D _resources,					\
> >> +	.num_resources =3D _num_resources					\
> >> +}
> >> =20
> >>  static struct resource adc_resources[] =3D {
> >>  	{
> >> @@ -64,33 +69,45 @@ static const struct regmap_irq_chip sunxi_gpad=
c_mfd_regmap_irq_chip =3D {
> >>  };
> >> =20
> >>  static struct mfd_cell sun4i_gpadc_mfd_cells[] =3D {
> >> -	{
> >> -		.name	=3D "sun4i-a10-gpadc-iio",
> >> -		.resources =3D adc_resources,
> >> -		.num_resources =3D ARRAY_SIZE(adc_resources),
> >> -	}, {
> >> -		.name =3D "iio_hwmon",
> >> -	}
> >> +	SUNXI_GPADC_MFD_CELL("sun4i-a10-gpadc-iio", adc_resources,
> >> +			     ARRAY_SIZE(adc_resources)),
> >> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> >>  };
> >> =20
> >>  static struct mfd_cell sun5i_gpadc_mfd_cells[] =3D {
> >> -	{
> >> -		.name	=3D "sun5i-a13-gpadc-iio",
> >> -		.resources =3D adc_resources,
> >> -		.num_resources =3D ARRAY_SIZE(adc_resources),
> >> -	}, {
> >> -		.name =3D "iio_hwmon",
> >> -	},
> >> +	SUNXI_GPADC_MFD_CELL("sun5i-a13-gpadc-iio", adc_resources,
> >> +			     ARRAY_SIZE(adc_resources)),
> >> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> >>  };
> >> =20
> >>  static struct mfd_cell sun6i_gpadc_mfd_cells[] =3D {
> >> -	{
> >> -		.name	=3D "sun6i-a31-gpadc-iio",
> >> -		.resources =3D adc_resources,
> >> -		.num_resources =3D ARRAY_SIZE(adc_resources),
> >> -	}, {
> >> -		.name =3D "iio_hwmon",
> >> -	},
> >> +	SUNXI_GPADC_MFD_CELL("sun6i-a31-gpadc-iio", adc_resources,
> >> +			     ARRAY_SIZE(adc_resources)),
> >> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> >> +};
> >=20
> > This should be part of a separate patch.
> >=20
> >> +
> >> +static struct mfd_cell sun4i_gpadc_mfd_cells_ts[] =3D {
> >> +	SUNXI_GPADC_MFD_CELL("sun6i-a31-gpadc-iio", adc_resources,
> >> +			     ARRAY_SIZE(adc_resources)),
> >> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> >> +	SUNXI_GPADC_MFD_CELL("sunxi-gpadc-ts", ts_resources,
> >> +			     ARRAY_SIZE(ts_resources)),
> >> +};
> >> +
> >> +static struct mfd_cell sun5i_gpadc_mfd_cells_ts[] =3D {
> >> +	SUNXI_GPADC_MFD_CELL("sun5i-a13-gpadc-iio", adc_resources,
> >> +			     ARRAY_SIZE(adc_resources)),
> >> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> >> +	SUNXI_GPADC_MFD_CELL("sunxi-gpadc-ts", ts_resources,
> >> +			     ARRAY_SIZE(ts_resources)),
> >> +};
> >> +
> >> +static struct mfd_cell sun6i_gpadc_mfd_cells_ts[] =3D {
> >> +	SUNXI_GPADC_MFD_CELL("sun6i-a31-gpadc-iio", adc_resources,
> >> +			     ARRAY_SIZE(adc_resources)),
> >> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
> >> +	SUNXI_GPADC_MFD_CELL("sunxi-gpadc-ts", ts_resources,
> >> +			     ARRAY_SIZE(ts_resources)),
> >>  };
> >> =20
> >>  static const struct regmap_config sunxi_gpadc_mfd_regmap_config =3D=
 {
> >> @@ -142,23 +159,45 @@ static int sunxi_gpadc_mfd_probe(struct plat=
form_device *pdev)
> >>  	}
> >> =20
> >>  	if (of_device_is_compatible(pdev->dev.of_node,
> >> -				    "allwinner,sun4i-a10-ts"))
> >> -		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> -				      sun4i_gpadc_mfd_cells,
> >> -				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
> >> -				      0, NULL);
> >> -	else if (of_device_is_compatible(pdev->dev.of_node,
> >> -					 "allwinner,sun5i-a13-ts"))
> >> -		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> -				      sun5i_gpadc_mfd_cells,
> >> -				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
> >> -				      0, NULL);
> >> -	else if (of_device_is_compatible(pdev->dev.of_node,
> >> -					 "allwinner,sun6i-a31-ts"))
> >> -		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> -				      sun6i_gpadc_mfd_cells,
> >> -				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
> >> -				      0, NULL);
> >> +				    "allwinner,sun4i-a10-ts")) {
> >> +		if (of_property_read_bool(pdev->dev.of_node,
> >> +					  "allwinner,ts-attached"))
> >> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun4i_gpadc_mfd_cells_ts,
> >> +					      ARRAY_SIZE(sun4i_gpadc_mfd_cells_ts),
> >> +					      NULL, 0, NULL);
> >> +		else
> >> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun4i_gpadc_mfd_cells,
> >> +					      ARRAY_SIZE(sun4i_gpadc_mfd_cells),
> >> +					      NULL, 0, NULL);
> >> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> >> +					 "allwinner,sun5i-a13-ts")) {
> >> +		if (of_property_read_bool(pdev->dev.of_node,
> >> +					  "allwinner,ts-attached"))
> >> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun5i_gpadc_mfd_cells_ts,
> >> +					      ARRAY_SIZE(sun5i_gpadc_mfd_cells_ts),
> >> +					      NULL, 0, NULL);
> >> +		else
> >> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun5i_gpadc_mfd_cells,
> >> +					      ARRAY_SIZE(sun5i_gpadc_mfd_cells),
> >> +					      NULL, 0, NULL);
> >> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> >> +					 "allwinner,sun6i-a31-ts")) {
> >> +		if (of_property_read_bool(pdev->dev.of_node,
> >> +					  "allwinner,ts-attached"))
> >> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun6i_gpadc_mfd_cells_ts,
> >> +					      ARRAY_SIZE(sun6i_gpadc_mfd_cells_ts),
> >> +					      NULL, 0, NULL);
> >> +		else
> >> +			ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun6i_gpadc_mfd_cells,
> >> +					      ARRAY_SIZE(sun6i_gpadc_mfd_cells),
> >> +					      NULL, 0, NULL);
> >> +	}
> >=20
> > Please don't use any of_device_is_compatible.
> Hi Maxime,
>=20
> Why?  (Just curious...)

'cos they make for ugly code.

Use of_match_device() instead.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
