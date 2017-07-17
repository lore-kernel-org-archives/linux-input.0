From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: axp20x-pek: add support for AXP221 PEK
Date: Mon, 17 Jul 2017 13:29:12 +0200
Message-ID: <20170717112912.rsi72f4t74nsp6nr@flea>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wflc6csbu6b2aoke"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47927 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdGQL3Y (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Jul 2017 07:29:24 -0400
Content-Disposition: inline
In-Reply-To: <20170717095307.15986-2-quentin.schulz@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com


--wflc6csbu6b2aoke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2017 at 11:53:06AM +0200, Quentin Schulz wrote:
> The AXP221 has different values for startup time bits from the AXP20X.
>=20
> This patch introduces a different platform_device_id to the driver and
> adds the necessary code to handle the different platform_device_ids.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/input/misc/axp20x-pek.c | 62 ++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 52 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-=
pek.c
> index 38c79ebff033..3efa1de51569 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -32,6 +32,7 @@
>  struct axp20x_pek {
>  	struct axp20x_dev *axp20x;
>  	struct input_dev *input;
> +	struct attribute_group *attribute_group;
>  	int irq_dbr;
>  	int irq_dbf;
>  };
> @@ -41,14 +42,21 @@ struct axp20x_time {
>  	unsigned int idx;
>  };
> =20
> -static const struct axp20x_time startup_time[] =3D {
> +static const struct axp20x_time axp20x_startup_time[] =3D {
>  	{ .time =3D 128,  .idx =3D 0 },
>  	{ .time =3D 1000, .idx =3D 2 },
>  	{ .time =3D 3000, .idx =3D 1 },
>  	{ .time =3D 2000, .idx =3D 3 },
>  };
> =20
> -static const struct axp20x_time shutdown_time[] =3D {
> +static const struct axp20x_time axp221_startup_time[] =3D {
> +	{ .time =3D 128,  .idx =3D 0 },
> +	{ .time =3D 1000, .idx =3D 1 },
> +	{ .time =3D 2000, .idx =3D 2 },
> +	{ .time =3D 3000, .idx =3D 3 },
> +};
> +
> +static const struct axp20x_time axp20x_shutdown_time[] =3D {
>  	{ .time =3D 4000,  .idx =3D 0 },
>  	{ .time =3D 6000,  .idx =3D 1 },
>  	{ .time =3D 8000,  .idx =3D 2 },
> @@ -61,15 +69,20 @@ struct axp20x_pek_ext_attr {
>  };
> =20
>  static struct axp20x_pek_ext_attr axp20x_pek_startup_ext_attr =3D {
> -	.p_time	=3D startup_time,
> +	.p_time	=3D axp20x_startup_time,
>  	.mask	=3D AXP20X_PEK_STARTUP_MASK,
>  };
> =20
>  static struct axp20x_pek_ext_attr axp20x_pek_shutdown_ext_attr =3D {
> -	.p_time	=3D shutdown_time,
> +	.p_time	=3D axp20x_shutdown_time,
>  	.mask	=3D AXP20X_PEK_SHUTDOWN_MASK,
>  };
> =20
> +static struct axp20x_pek_ext_attr axp221_pek_startup_ext_attr =3D {
> +	.p_time	=3D axp221_startup_time,
> +	.mask	=3D AXP20X_PEK_STARTUP_MASK,
> +};
> +
>  static struct axp20x_pek_ext_attr *get_axp_ext_attr(struct device_attrib=
ute *attr)
>  {
>  	return container_of(attr, struct dev_ext_attribute, attr)->var;
> @@ -148,6 +161,11 @@ static struct dev_ext_attribute axp20x_dev_attr_star=
tup =3D {
>  	.var	=3D &axp20x_pek_startup_ext_attr,
>  };
> =20
> +static struct dev_ext_attribute axp221_dev_attr_startup =3D {
> +	.attr	=3D __ATTR(startup, 0644, axp20x_show_ext_attr, axp20x_store_ext_=
attr),
> +	.var	=3D &axp221_pek_startup_ext_attr,
> +};
> +
>  static struct dev_ext_attribute axp20x_dev_attr_shutdown =3D {
>  	.attr	=3D __ATTR(shutdown, 0644, axp20x_show_ext_attr, axp20x_store_ext=
_attr),
>  	.var	=3D &axp20x_pek_shutdown_ext_attr,
> @@ -159,10 +177,20 @@ static struct attribute *axp20x_attributes[] =3D {
>  	NULL,
>  };
> =20
> +static struct attribute *axp221_attributes[] =3D {
> +	&axp221_dev_attr_startup.attr.attr,
> +	&axp20x_dev_attr_shutdown.attr.attr,
> +	NULL,
> +};
> +
>  static const struct attribute_group axp20x_attribute_group =3D {
>  	.attrs =3D axp20x_attributes,
>  };
> =20
> +static const struct attribute_group axp221_attribute_group =3D {
> +	.attrs =3D axp221_attributes,
> +};
> +
>  static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
>  {
>  	struct input_dev *idev =3D pwr;
> @@ -184,9 +212,10 @@ static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
> =20
>  static void axp20x_remove_sysfs_group(void *_data)
>  {
> -	struct device *dev =3D _data;
> +	struct platform_device *pdev =3D _data;
> +	struct axp20x_pek *axp_pek =3D platform_get_drvdata(pdev);
> =20
> -	sysfs_remove_group(&dev->kobj, &axp20x_attribute_group);
> +	sysfs_remove_group(&pdev->dev.kobj, axp_pek->attribute_group);
>  }
> =20
>  static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
> @@ -313,17 +342,19 @@ static int axp20x_pek_probe(struct platform_device =
*pdev)
>  			return error;
>  	}
> =20
> -	error =3D sysfs_create_group(&pdev->dev.kobj, &axp20x_attribute_group);
> +	axp20x_pek->attribute_group =3D (struct attribute_group *)platform_get_=
device_id(pdev)->driver_data;

That line is too long, and you don't check the returned pointer of
platform_get_device_id. You should split it and check for the pointer.

> +
> +	error =3D sysfs_create_group(&pdev->dev.kobj,
> +				   axp20x_pek->attribute_group);

Wouldn't it make more sense to just store the startup_time structure
in the axp20x_pek structure, rather than duplicating all this?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--wflc6csbu6b2aoke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZbJ+IAAoJEBx+YmzsjxAgIB4P/38dJPmwVBsqyVTb2lpQjSmv
pweJg97gXekKHR4YP0KTKeQ5Ux9A0EIVJofLRyMhLjT+f+FqLTHjbW/oxPv0Vv/u
CIc+ISlcDwPK50rr/aC4dewrzDipNMDjhVcm2TjNgx2rSTD+QbLv1t7zG4xOWett
2BAk7YiNWd/mJINGTRnxErsdh8AulN9lIv4+5KePXhpNh5e6kfX2sTMoL5tgNYVM
pIsCOEtO0IYVALXdpAsdvMG0lFv9hbFxK9oyHVmIiBIXzXrh6fRx4dv/GExWaI4Y
2PzsAaIiwIvZb7wKQTBPGL9ijXrJgQchW46OeNxFmtntPXozsINfQ++ZBXjNGbEW
akGeb7dtTKa7QsJataDfmUa9077kK0aq1VRLlvt6MxeNiZ5criomuGs6CLFfPzKH
9jNCk4Rj53LkG/I9DWmA4OHXnOHn4KuSCfC8uRadwRiODjeTorPMTPR5ohtW1+0V
2i5wBiIhOn4lNjkf6HrfgyGQUmE6sVmoUd0RPar3SqByZFTygc0BPh2p7PV2XYu5
l+RPySiK7+LCVBdo2m+p7iqo470ILatlgbkrpDTgpgIKdNuE7hepNGiWnjj5EA39
/1BaoI5YZHWd8YBw7ymFEL3vOGYQCYfQKhOByhrFKOOUMwHs1lTikDmAQmlydJ8N
dOec3xO3rm3X4tZ4Kdci
=QNjk
-----END PGP SIGNATURE-----

--wflc6csbu6b2aoke--
