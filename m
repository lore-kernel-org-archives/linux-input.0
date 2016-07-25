From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 5/5] mfd: sunxi-gpadc-mfd: probe sunxi-gpadc-ts driver
Date: Mon, 25 Jul 2016 11:51:13 +0200
Message-ID: <20160725095113.GJ7419@lukather>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-6-git-send-email-quentin.schulz@free-electrons.com>
 <20160721060812.GA5993@lukather>
 <11247e4f-d04d-d5bc-6ebf-a637820c011d@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="utPK4TBebyzZxMrE"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57011 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752481AbcGYJvQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 05:51:16 -0400
Content-Disposition: inline
In-Reply-To: <11247e4f-d04d-d5bc-6ebf-a637820c011d@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org


--utPK4TBebyzZxMrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Jul 24, 2016 at 12:26:56PM +0100, Jonathan Cameron wrote:
> >> @@ -142,23 +159,45 @@ static int sunxi_gpadc_mfd_probe(struct platform=
_device *pdev)
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

This is completely redundant. The compatible has already been looked
up once to match the driver, and you can associate a void * pointer to
any compatible you register in the of_device_id array.

So you can just retrieve the compatible that probed you in the first
place, and use it's private data pointer to store whatever you want,
without the numerous (and expensive) calls to of_device_is_compatible.

It's also easier to maintain in the long term, since you can simply
add a new field to the structure you would register there, instead of
keeping adding more conditions.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--utPK4TBebyzZxMrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXleERAAoJEBx+YmzsjxAgX7kQAJoEupOox4ImwUSSmWxDYYJy
qHR7T+BXL8+5J9VoqPRvNgbq5DeF0boxFk8OO22VQsrUtLf73GWh6RzSGTqSOMuF
zd1VXivDVR/sYz3otsfmex+KBF+mN7dk423BzRRg5PaHOJxYpoyO5KOnWIedwwA0
51Ar0+IfKI+s7i2PXKJNvjklP7/r/kE6SyaL8i7UK/gLk4mmCwxP/E4qj1bO8+LW
aUXsuxMw755uwp7CLz0tble3qsgoov3d6pSBXJs/Mh1fCemWUey4m2lOjhs0zLyr
8QiadVTHbITF1YR6K6Av9eqt2RLx9cXpsBdGbVZl6VDZqBSRdmEqaALx6LIdUHx6
4f/9M+xm9VLU9lftj2F8U2dPhoOsmdHLU9Qwa4MS0ClrBJ+GzBneNlkNGQXa0sWO
AG9OTp8Fap/AnxCJh7ZQNSnF5J/KVXr/y+dYrStFMmfnvIZpwuQ/djuN0mv+0d/z
XJchrjJfMs6nH/cVkNXYoOfrpRrJUzGjzChz6DMb6YhnYNDxMi0N3/VUcV13f0DR
iAU57+Nq9Oasv7qVbbm7LUF4eyhUXzIPaUpkkra0SJHtk8TmESF1GUSjZlhwzHNG
lX9+Zedi/53j6YdB0xDF+nXCslRwQwDmyWodCv1pMc4vy4LQi6qti1THPwawQ8e1
GEPnyECFdqb25aeFy2Oy
=OLBG
-----END PGP SIGNATURE-----

--utPK4TBebyzZxMrE--
