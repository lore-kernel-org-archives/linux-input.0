From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Tue, 18 Mar 2014 15:59:19 +0000
Message-ID: <20140318155919.GS25478@lee--X1>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBXG2UGMQKGQEGWREA7I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1394898225-28452-2-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

> This patch introduces the preliminary support for PMICs X-Powers AXP202
> and AXP209. The AXP209 and AXP202 are the PMUs (Power Management Unit)
> used by A10, A13 and A20 SoCs and developed by X-Powers, a sister company
> of Allwinner.
>=20
> The core enables support for two subsystems:
> - PEK (Power Enable Key)
> - Regulators
>=20
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mfd/Kconfig        |  12 +++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/axp20x.c       | 247 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/axp20x.h | 179 ++++++++++++++++++++++++++++++++
>  4 files changed, 439 insertions(+)
>  create mode 100644 drivers/mfd/axp20x.c
>  create mode 100644 include/linux/mfd/axp20x.h

[...]

> +/*
> + * axp20x.c - mfd core driver for the X-Powers AXP202 and AXP209

MFD

[...]

> +static struct resource axp20x_pek_resources[] =3D {
> +	{
> +		.name	=3D "PEK_DBR",
> +		.start	=3D AXP20X_IRQ_PEK_RIS_EDGE,
> +		.end	=3D AXP20X_IRQ_PEK_RIS_EDGE,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +	{
> +		.name	=3D "PEK_DBF",
> +		.start	=3D AXP20X_IRQ_PEK_FAL_EDGE,
> +		.end	=3D AXP20X_IRQ_PEK_FAL_EDGE,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};

[...]=20

> +static struct mfd_cell axp20x_cells[] =3D {
> +	{
> +		.name		=3D "axp20x-pek",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_pek_resources),
> +		.resources	=3D axp20x_pek_resources,
> +	}, {
> +		.name		=3D "axp20x-regulator",
> +	},
> +};

nit: The format of these two structs are inconsistent.

[...]

> +static int axp20x_i2c_probe(struct i2c_client *i2c,
> +			 const struct i2c_device_id *id)
> +{
> +	struct axp20x_dev *axp20x;
> +	const struct of_device_id *of_id;
> +	int ret;
> +
> +	axp20x =3D devm_kzalloc(&i2c->dev, sizeof(*axp20x), GFP_KERNEL);
> +	if (!axp20x)
> +		return -ENOMEM;
> +
> +	of_id =3D of_match_device(axp20x_of_match, &i2c->dev);
> +	if (!of_id) {
> +		dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> +		return -ENODEV;
> +	}
> +	axp20x->variant =3D (int) of_id->data;

No need to cast from void *.

> +	axp20x->i2c_client =3D i2c;
> +	axp20x->dev =3D &i2c->dev;
> +	dev_set_drvdata(axp20x->dev, axp20x);
> +
> +	axp20x->regmap =3D devm_regmap_init_i2c(i2c, &axp20x_regmap_config);
> +	if (IS_ERR(axp20x->regmap)) {
> +		ret =3D PTR_ERR(axp20x->regmap);
> +		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	axp20x->irq =3D i2c->irq;

Do you _really_ need this if you have 'axp20x->i2c_client->irq'?

> +	ret =3D regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
> +				  IRQF_ONESHOT | IRQF_SHARED, -1,
> +				  &axp20x_regmap_irq_chip,
> +				  &axp20x->regmap_irqc);
> +	if (ret) {
> +		dev_err(&i2c->dev, "failed to add irq chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D mfd_add_devices(axp20x->dev, -1, axp20x_cells,
> +			      ARRAY_SIZE(axp20x_cells), NULL, 0, NULL);
> +
> +	if (ret) {
> +		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
> +		goto mfd_err;
> +	}
> +
> +	if (!pm_power_off) {
> +		axp20x_pm_power_off =3D axp20x;
> +		pm_power_off =3D axp20x_power_off;
> +	}
> +
> +	dev_info(&i2c->dev, "AXP20X driver loaded\n");
> +
> +	return 0;
> +
> +mfd_err:
> +	regmap_del_irq_chip(axp20x->irq, axp20x->regmap_irqc);
> +
> +	return ret;

I'd say the goto is pointless if you're only using it once.

Instead move regmap_del_irq_chip() into mfd_add_devices()'s error
handler and return straight from there.

[...]

> +static const struct i2c_device_id axp20x_i2c_id[] =3D {
> +	{ "axp202", AXP202_ID },
> +	{ "axp209", AXP209_ID },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);

Isn't this redundant now that you're using of_id?

[...]

> +#ifndef __LINUX_MFD_AXP20X_H
> +#define __LINUX_MFD_AXP20X_H
> +
> +#define AXP202_ID			0
> +#define AXP209_ID			1

enum?

[...]=20

> +struct axp20x_dev {
> +	struct device			*dev;
> +	struct i2c_client		*i2c_client;
> +	struct regmap			*regmap;
> +	struct regmap_irq_chip_data	*regmap_irqc;
> +	int				variant;
> +	int				irq;

i2c_client->irq?

> +};
> +
> +#endif /* __LINUX_MFD_AXP20X_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
