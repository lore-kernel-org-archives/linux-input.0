From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 1/3] Input: axp20x-pek: use driver_data of
 platform_device_id instead of extended attributes
Date: Wed, 19 Jul 2017 11:33:56 +0200
Message-ID: <20170719093356.eltrdq7eyoxzhsym@flea>
References: <20170719074337.19189-1-quentin.schulz@free-electrons.com>
 <20170719074337.19189-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2pweohluqeaykvkv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170719074337.19189-2-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com
List-Id: linux-input@vger.kernel.org


--2pweohluqeaykvkv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 09:43:35AM +0200, Quentin Schulz wrote:
> To prepare an upcoming patch adding support for another PMIC that has
> different startup and shutdown time, use driver_data of
> platform_device_id instead of a fixed extended device attribute.
>=20
> By doing so, we also remove a lot of nested structures that aren't
> useful.
>=20
> With this patch, a new PMIC can be easily supported by just filling
> correctly its ax20x_info structure and adding a platform_device_id.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/input/misc/axp20x-pek.c | 131 +++++++++++++++++++++++++++-------=
------
>  1 file changed, 88 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-=
pek.c
> index 38c79ebff033..94c89fbeeeaa 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -29,9 +29,17 @@
>  #define AXP20X_PEK_STARTUP_MASK		(0xc0)
>  #define AXP20X_PEK_SHUTDOWN_MASK	(0x03)
> =20
> +struct axp20x_info {
> +	const struct axp20x_time *startup_time;
> +	unsigned int startup_mask;
> +	const struct axp20x_time *shutdown_time;
> +	unsigned int shutdown_mask;
> +};
> +
>  struct axp20x_pek {
>  	struct axp20x_dev *axp20x;
>  	struct input_dev *input;
> +	struct axp20x_info *info;
>  	int irq_dbr;
>  	int irq_dbf;
>  };
> @@ -55,31 +63,18 @@ static const struct axp20x_time shutdown_time[] =3D {
>  	{ .time =3D 10000, .idx =3D 3 },
>  };
> =20
> -struct axp20x_pek_ext_attr {
> -	const struct axp20x_time *p_time;
> -	unsigned int mask;
> -};
> -
> -static struct axp20x_pek_ext_attr axp20x_pek_startup_ext_attr =3D {
> -	.p_time	=3D startup_time,
> -	.mask	=3D AXP20X_PEK_STARTUP_MASK,
> -};
> -
> -static struct axp20x_pek_ext_attr axp20x_pek_shutdown_ext_attr =3D {
> -	.p_time	=3D shutdown_time,
> -	.mask	=3D AXP20X_PEK_SHUTDOWN_MASK,
> +static const struct axp20x_info axp20x_info =3D {
> +	.startup_time =3D startup_time,
> +	.startup_mask =3D AXP20X_PEK_STARTUP_MASK,
> +	.shutdown_time =3D shutdown_time,
> +	.shutdown_mask =3D AXP20X_PEK_SHUTDOWN_MASK,
>  };
> =20
> -static struct axp20x_pek_ext_attr *get_axp_ext_attr(struct device_attrib=
ute *attr)
> -{
> -	return container_of(attr, struct dev_ext_attribute, attr)->var;
> -}
> -
>  static ssize_t axp20x_show_ext_attr(struct device *dev,
> -				    struct device_attribute *attr, char *buf)
> +				    const struct axp20x_time *time,
> +				    unsigned int mask, char *buf)
>  {
>  	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> -	struct axp20x_pek_ext_attr *axp20x_ea =3D get_axp_ext_attr(attr);
>  	unsigned int val;
>  	int ret, i;
> =20
> @@ -87,22 +82,42 @@ static ssize_t axp20x_show_ext_attr(struct device *de=
v,
>  	if (ret !=3D 0)
>  		return ret;
> =20
> -	val &=3D axp20x_ea->mask;
> -	val >>=3D ffs(axp20x_ea->mask) - 1;
> +	val &=3D mask;
> +	val >>=3D ffs(mask) - 1;
> =20
>  	for (i =3D 0; i < 4; i++)
> -		if (val =3D=3D axp20x_ea->p_time[i].idx)
> -			val =3D axp20x_ea->p_time[i].time;
> +		if (val =3D=3D time[i].idx)
> +			val =3D time[i].time;
> =20
>  	return sprintf(buf, "%u\n", val);
>  }
> =20
> +static ssize_t axp20x_show_ext_attr_startup(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> +
> +	return axp20x_show_ext_attr(dev, axp20x_pek->info->startup_time,
> +				    axp20x_pek->info->startup_mask, buf);
> +}
> +
> +static ssize_t axp20x_show_ext_attr_shutdown(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> +
> +	return axp20x_show_ext_attr(dev, axp20x_pek->info->shutdown_time,
> +				    axp20x_pek->info->shutdown_mask, buf);
> +}
> +
>  static ssize_t axp20x_store_ext_attr(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t count)
> +				     const struct axp20x_time *time,
> +				     unsigned int mask, const char *buf,
> +				     size_t count)
>  {
>  	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> -	struct axp20x_pek_ext_attr *axp20x_ea =3D get_axp_ext_attr(attr);
>  	char val_str[20];
>  	size_t len;
>  	int ret, i;
> @@ -123,39 +138,53 @@ static ssize_t axp20x_store_ext_attr(struct device =
*dev,
>  	for (i =3D 3; i >=3D 0; i--) {
>  		unsigned int err;
> =20
> -		err =3D abs(axp20x_ea->p_time[i].time - val);
> +		err =3D abs(time[i].time - val);
>  		if (err < best_err) {
>  			best_err =3D err;
> -			idx =3D axp20x_ea->p_time[i].idx;
> +			idx =3D time[i].idx;
>  		}
> =20
>  		if (!err)
>  			break;
>  	}
> =20
> -	idx <<=3D ffs(axp20x_ea->mask) - 1;
> -	ret =3D regmap_update_bits(axp20x_pek->axp20x->regmap,
> -				 AXP20X_PEK_KEY,
> -				 axp20x_ea->mask, idx);
> +	idx <<=3D ffs(mask) - 1;
> +	ret =3D regmap_update_bits(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY,
> +				 mask, idx);
>  	if (ret !=3D 0)
>  		return -EINVAL;
> =20
>  	return count;
>  }
> =20
> -static struct dev_ext_attribute axp20x_dev_attr_startup =3D {
> -	.attr	=3D __ATTR(startup, 0644, axp20x_show_ext_attr, axp20x_store_ext_=
attr),
> -	.var	=3D &axp20x_pek_startup_ext_attr,
> -};
> +static ssize_t axp20x_store_ext_attr_startup(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t count)
> +{
> +	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> =20
> -static struct dev_ext_attribute axp20x_dev_attr_shutdown =3D {
> -	.attr	=3D __ATTR(shutdown, 0644, axp20x_show_ext_attr, axp20x_store_ext=
_attr),
> -	.var	=3D &axp20x_pek_shutdown_ext_attr,
> -};
> +	return axp20x_store_ext_attr(dev, axp20x_pek->info->startup_time,
> +				     axp20x_pek->info->startup_mask, buf,
> +				     count);
> +}
> +
> +static ssize_t axp20x_store_ext_attr_shutdown(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t count)
> +{
> +	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> +
> +	return axp20x_store_ext_attr(dev, axp20x_pek->info->shutdown_time,
> +				     axp20x_pek->info->shutdown_mask, buf,
> +				     count);
> +}
> +

All these functions should be renamed, they're not extended attributes
anymore.

> +DEVICE_ATTR(startup, 0644, axp20x_show_ext_attr_startup, axp20x_store_ex=
t_attr_startup);
> +DEVICE_ATTR(shutdown, 0644, axp20x_show_ext_attr_shutdown, axp20x_store_=
ext_attr_shutdown);

Both these lines generate a warning under checkpatch for a line too
long. Please wrap them.

Looks good otherwise, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2pweohluqeaykvkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZbyeEAAoJEBx+YmzsjxAgqikQAKCLmnarRIolqhdxtAJVSrHq
sgT7D03lYNGyXnDqlOy9W/HaaM3ARx7NR9Ofy9yvqCj1a09LkILQfoNtBxWuSUkH
m/Sqsndti1fR+S5VOCK68/pfSQXMfWLZIeKy6FMYQdpgddSY7DDocC3xSN/qqf7s
dJQuMEdsbp0jOj9J2cKycJyHI4BCV64UfTVUDlgH6FmaUBZs/958grDzCvoOOE7x
Kor2nz+EVry2+VsRXFR4saSUQUMhLkleCkTj+kBDsga13L//4SfpZ8c073NDwlms
1r/FwXEBE13z4USv8d2e3z6Exx7l+kfbwf0ShhQ+Dx6aWdLJ4P1Mt/kTpsm1H9Fh
J6Qk0Aufr6h6LSUpwk+h0kYjIdQio5Q1J9rYKkcd5E5Tz/AI/5YFipwCWgZiuLLo
MLgS9X29pxXA7sJ7/11VUR5GMcS/rbmIb4yjcuZFBbQFbp0ikHnmcfGBj2MOt5ai
j0W+R6xShyKh5cOvljM8ETI+YtFihKEGa+d+A11WlMm+fB9ronVGOqnZouZCMlTb
Jo44lfN6HlEeQYml7RxC5EU0MUMubGIhHnS+mTXixiNbOS3djP5H/DTD/w177CsA
fihri87cGsKPrbUz24URxOcx2VBAvJiS9Uu/iBKwNiS/uoGTic0lJQbxnqWgaCXd
jVyyhiZ17zx+pNI36tk2
=IO80
-----END PGP SIGNATURE-----

--2pweohluqeaykvkv--
