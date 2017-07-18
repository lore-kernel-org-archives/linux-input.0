From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: axp20x-pek: add support for AXP221 PEK
Date: Tue, 18 Jul 2017 09:36:04 +0200
Message-ID: <522ebac5-49ba-fb18-4d9a-b8e50c9d55c3@free-electrons.com>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-2-quentin.schulz@free-electrons.com>
 <20170717112912.rsi72f4t74nsp6nr@flea>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QHi3m5NPULbSAB0CbeaUBldNuscchdkH8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46235 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdGRHgU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Jul 2017 03:36:20 -0400
In-Reply-To: <20170717112912.rsi72f4t74nsp6nr@flea>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QHi3m5NPULbSAB0CbeaUBldNuscchdkH8
Content-Type: multipart/mixed; boundary="pm6FSmD012Oe7wcmO95g5iu2Ct08ui0uF";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org,
 hdegoede@redhat.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com
Message-ID: <522ebac5-49ba-fb18-4d9a-b8e50c9d55c3@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: axp20x-pek: add support for AXP221 PEK
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-2-quentin.schulz@free-electrons.com>
 <20170717112912.rsi72f4t74nsp6nr@flea>
In-Reply-To: <20170717112912.rsi72f4t74nsp6nr@flea>

--pm6FSmD012Oe7wcmO95g5iu2Ct08ui0uF
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On 17/07/2017 13:29, Maxime Ripard wrote:
> Hi,
>=20
> On Mon, Jul 17, 2017 at 11:53:06AM +0200, Quentin Schulz wrote:
>> The AXP221 has different values for startup time bits from the AXP20X.=

>>
>> This patch introduces a different platform_device_id to the driver and=

>> adds the necessary code to handle the different platform_device_ids.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  drivers/input/misc/axp20x-pek.c | 62 ++++++++++++++++++++++++++++++++=
++-------
>>  1 file changed, 52 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp2=
0x-pek.c
>> index 38c79ebff033..3efa1de51569 100644
>> --- a/drivers/input/misc/axp20x-pek.c
>> +++ b/drivers/input/misc/axp20x-pek.c
>> @@ -32,6 +32,7 @@
>>  struct axp20x_pek {
>>  	struct axp20x_dev *axp20x;
>>  	struct input_dev *input;
>> +	struct attribute_group *attribute_group;
>>  	int irq_dbr;
>>  	int irq_dbf;
>>  };
>> @@ -41,14 +42,21 @@ struct axp20x_time {
>>  	unsigned int idx;
>>  };
>> =20
>> -static const struct axp20x_time startup_time[] =3D {
>> +static const struct axp20x_time axp20x_startup_time[] =3D {
>>  	{ .time =3D 128,  .idx =3D 0 },
>>  	{ .time =3D 1000, .idx =3D 2 },
>>  	{ .time =3D 3000, .idx =3D 1 },
>>  	{ .time =3D 2000, .idx =3D 3 },
>>  };
>> =20
>> -static const struct axp20x_time shutdown_time[] =3D {
>> +static const struct axp20x_time axp221_startup_time[] =3D {
>> +	{ .time =3D 128,  .idx =3D 0 },
>> +	{ .time =3D 1000, .idx =3D 1 },
>> +	{ .time =3D 2000, .idx =3D 2 },
>> +	{ .time =3D 3000, .idx =3D 3 },
>> +};
>> +
>> +static const struct axp20x_time axp20x_shutdown_time[] =3D {
>>  	{ .time =3D 4000,  .idx =3D 0 },
>>  	{ .time =3D 6000,  .idx =3D 1 },
>>  	{ .time =3D 8000,  .idx =3D 2 },
>> @@ -61,15 +69,20 @@ struct axp20x_pek_ext_attr {
>>  };
>> =20
>>  static struct axp20x_pek_ext_attr axp20x_pek_startup_ext_attr =3D {
>> -	.p_time	=3D startup_time,
>> +	.p_time	=3D axp20x_startup_time,
>>  	.mask	=3D AXP20X_PEK_STARTUP_MASK,
>>  };
>> =20
>>  static struct axp20x_pek_ext_attr axp20x_pek_shutdown_ext_attr =3D {
>> -	.p_time	=3D shutdown_time,
>> +	.p_time	=3D axp20x_shutdown_time,
>>  	.mask	=3D AXP20X_PEK_SHUTDOWN_MASK,
>>  };
>> =20
>> +static struct axp20x_pek_ext_attr axp221_pek_startup_ext_attr =3D {
>> +	.p_time	=3D axp221_startup_time,
>> +	.mask	=3D AXP20X_PEK_STARTUP_MASK,
>> +};
>> +
>>  static struct axp20x_pek_ext_attr *get_axp_ext_attr(struct device_att=
ribute *attr)
>>  {
>>  	return container_of(attr, struct dev_ext_attribute, attr)->var;
>> @@ -148,6 +161,11 @@ static struct dev_ext_attribute axp20x_dev_attr_s=
tartup =3D {
>>  	.var	=3D &axp20x_pek_startup_ext_attr,
>>  };
>> =20
>> +static struct dev_ext_attribute axp221_dev_attr_startup =3D {
>> +	.attr	=3D __ATTR(startup, 0644, axp20x_show_ext_attr, axp20x_store_e=
xt_attr),
>> +	.var	=3D &axp221_pek_startup_ext_attr,
>> +};
>> +
>>  static struct dev_ext_attribute axp20x_dev_attr_shutdown =3D {
>>  	.attr	=3D __ATTR(shutdown, 0644, axp20x_show_ext_attr, axp20x_store_=
ext_attr),
>>  	.var	=3D &axp20x_pek_shutdown_ext_attr,
>> @@ -159,10 +177,20 @@ static struct attribute *axp20x_attributes[] =3D=
 {
>>  	NULL,
>>  };
>> =20
>> +static struct attribute *axp221_attributes[] =3D {
>> +	&axp221_dev_attr_startup.attr.attr,
>> +	&axp20x_dev_attr_shutdown.attr.attr,
>> +	NULL,
>> +};
>> +
>>  static const struct attribute_group axp20x_attribute_group =3D {
>>  	.attrs =3D axp20x_attributes,
>>  };
>> =20
>> +static const struct attribute_group axp221_attribute_group =3D {
>> +	.attrs =3D axp221_attributes,
>> +};
>> +
>>  static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
>>  {
>>  	struct input_dev *idev =3D pwr;
>> @@ -184,9 +212,10 @@ static irqreturn_t axp20x_pek_irq(int irq, void *=
pwr)
>> =20
>>  static void axp20x_remove_sysfs_group(void *_data)
>>  {
>> -	struct device *dev =3D _data;
>> +	struct platform_device *pdev =3D _data;
>> +	struct axp20x_pek *axp_pek =3D platform_get_drvdata(pdev);
>> =20
>> -	sysfs_remove_group(&dev->kobj, &axp20x_attribute_group);
>> +	sysfs_remove_group(&pdev->dev.kobj, axp_pek->attribute_group);
>>  }
>> =20
>>  static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pe=
k,
>> @@ -313,17 +342,19 @@ static int axp20x_pek_probe(struct platform_devi=
ce *pdev)
>>  			return error;
>>  	}
>> =20
>> -	error =3D sysfs_create_group(&pdev->dev.kobj, &axp20x_attribute_grou=
p);
>> +	axp20x_pek->attribute_group =3D (struct attribute_group *)platform_g=
et_device_id(pdev)->driver_data;
>=20
> That line is too long, and you don't check the returned pointer of
> platform_get_device_id. You should split it and check for the pointer.
>=20

That's what I've done in a previous driver:
http://elixir.free-electrons.com/linux/latest/source/drivers/iio/adc/axp2=
0x_adc.c#L543

I'll do what you said anyway.

>> +
>> +	error =3D sysfs_create_group(&pdev->dev.kobj,
>> +				   axp20x_pek->attribute_group);
>=20
> Wouldn't it make more sense to just store the startup_time structure
> in the axp20x_pek structure, rather than duplicating all this?
>=20

I don't know. Basically, you would need to recreate manually all the
structures in the probe function, but why not.

Thanks,
Quentin

--=20
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com


--pm6FSmD012Oe7wcmO95g5iu2Ct08ui0uF--

--QHi3m5NPULbSAB0CbeaUBldNuscchdkH8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZbbpoAAoJEIS4mnU+4PGj7HQP/RZqUQVrnBNByzakGAysGdYR
fOO/1bgZ80X5CAqPqQ6ZZ60uPrPEzzdEAA6qmxeOtzPWe04Myhw+M88iWrug75QV
OFXkUA5DlTcJNaXKkH2uY2VGHElju2FNiZjBcKYxnbDdIEXSvTAGZLi6fiLG61Ti
fg2XzHX5zeBXBXZsvbbXtTm5mBu6aP1+8VH1aUvkXZMNLrSVuwtwm+N29MtCFOPd
pkBF3PTvJiJDUw+kzfGKkEm7dGofhloAuoK+/IjZVPdZVvw5l91Cq4hbH4xkX+fx
3Zhf92c2B8+Q2iCF7I/vOfXq4A1G90LIDChakOY+m9JY4VNH0OHGIIT4qFH4XIzz
PfIpvcN/YrROVqu9t56JJXOFmmDvWW3KvBUgVdJ0MueCXYhgODveNj8BY4ryyLJS
Z2cujVAOyQTPVtA/oEsQtCtroLwZq1MgAIfI4KGmYW33DmTn5s2LVm8B41A8oL+j
tXAISWzCmk+AfAQ0ejznP94VQ3c6gcXHUopKVbvzAA/SOsccBs7ZB1agTFYHlyc6
n/wqgUMeDOozAVXp5yjsGfaGyAfSXGswreUPwua8J/nIq4Yldew8Yp9GbRw8QIrY
iNh9TRaLQcLhz7QgRNDGQ+OAzmggLJlATPReBvNACN46UvARn+dyjaZE29a9YUpz
icOir+BkvQbrimWxwl9r
=OcV/
-----END PGP SIGNATURE-----

--QHi3m5NPULbSAB0CbeaUBldNuscchdkH8--
