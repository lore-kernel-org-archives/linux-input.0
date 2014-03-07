From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/7] mfd: AXP20x: Add mfd driver for AXP20x PMIC
Date: Fri, 7 Mar 2014 19:09:36 +0100
Message-ID: <20140307180936.GY607@lukather>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-2-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AJd+a2ML6L6CXP6l"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBAEX5CMAKGQEVKM6TJI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393692352-10839-2-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--AJd+a2ML6L6CXP6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 01, 2014 at 05:45:46PM +0100, Carlo Caione wrote:
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
>  arch/arm/configs/sunxi_defconfig |   1 +
>  drivers/mfd/Kconfig              |  12 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/axp20x.c             | 250 +++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/axp20x.h       | 180 ++++++++++++++++++++++++++++
>  5 files changed, 444 insertions(+)
>  create mode 100644 drivers/mfd/axp20x.c
>  create mode 100644 include/linux/mfd/axp20x.h
>=20
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_de=
fconfig
> index 3e2259b..f8aa7e6 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -52,6 +52,7 @@ CONFIG_GPIO_SYSFS=3Dy
>  # CONFIG_HWMON is not set
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_SUNXI_WATCHDOG=3Dy
> +CONFIG_MFD_AXP20X=3Dy
>  # CONFIG_USB_SUPPORT is not set
>  CONFIG_NEW_LEDS=3Dy
>  CONFIG_LEDS_CLASS=3Dy

Please provide a separate patch for both sunxi_defconfig and
multi_v7_defconfig.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index dd67158..33d38c4 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -59,6 +59,18 @@ config MFD_AAT2870_CORE
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
> =20
> +config MFD_AXP20X
> +	bool "X-Powers AXP20X"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C=3Dy
> +	help
> +	  If you say Y here you get support for the AXP20X.
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the
> +	  functionality of the device.
> +
>  config MFD_CROS_EC
>  	tristate "ChromeOS Embedded Controller"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 8a28dc9..371020e 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_PMIC_DA9052)	+=3D da9052-irq.o
>  obj-$(CONFIG_PMIC_DA9052)	+=3D da9052-core.o
>  obj-$(CONFIG_MFD_DA9052_SPI)	+=3D da9052-spi.o
>  obj-$(CONFIG_MFD_DA9052_I2C)	+=3D da9052-i2c.o
> +obj-$(CONFIG_MFD_AXP20X)	+=3D axp20x.o
> =20
>  obj-$(CONFIG_MFD_LP8788)	+=3D lp8788.o lp8788-irq.o
> =20
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> new file mode 100644
> index 0000000..92e5b0f
> --- /dev/null
> +++ b/drivers/mfd/axp20x.c
> @@ -0,0 +1,250 @@
> +/*
> + * axp20x.c - mfd core driver for the X-Powers AXP202 and AXP209
> + *
> + * Author: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/mfd/axp20x.h>
> +#include <linux/mfd/core.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +
> +#define AXP20X_OFF	0x80
> +
> +static const struct regmap_range axp20x_writeable_ranges[] =3D {
> +	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> +	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
> +};
> +
> +static const struct regmap_range axp20x_volatile_ranges[] =3D {
> +	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
> +};
> +
> +static const struct regmap_access_table axp20x_writeable_table =3D {
> +	.yes_ranges	=3D axp20x_writeable_ranges,
> +	.n_yes_ranges	=3D ARRAY_SIZE(axp20x_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table axp20x_volatile_table =3D {
> +	.yes_ranges	=3D axp20x_volatile_ranges,
> +	.n_yes_ranges	=3D ARRAY_SIZE(axp20x_volatile_ranges),
> +};
> +
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
> +
> +static const struct regmap_config axp20x_regmap_config =3D {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 8,
> +	.wr_table	=3D &axp20x_writeable_table,
> +	.volatile_table	=3D &axp20x_volatile_table,
> +	.max_register	=3D AXP20X_FG_RES,
> +	.cache_type	=3D REGCACHE_RBTREE,
> +};
> +
> +#define AXP20X_IRQ(_irq, _off, _mask) \
> +	[AXP20X_IRQ_##_irq] =3D { .reg_offset =3D (_off), .mask =3D BIT(_mask) }
> +
> +static const struct regmap_irq axp20x_regmap_irqs[] =3D {
> +	AXP20X_IRQ(ACIN_OVER_V,		0, 7),
> +	AXP20X_IRQ(ACIN_PLUGIN,		0, 6),
> +	AXP20X_IRQ(ACIN_REMOVAL,	0, 5),
> +	AXP20X_IRQ(VBUS_OVER_V,		0, 4),
> +	AXP20X_IRQ(VBUS_PLUGIN,		0, 3),
> +	AXP20X_IRQ(VBUS_REMOVAL,	0, 2),
> +	AXP20X_IRQ(VBUS_V_LOW,		0, 1),
> +	AXP20X_IRQ(BATT_PLUGIN,		1, 7),
> +	AXP20X_IRQ(BATT_REMOVAL,	1, 6),
> +	AXP20X_IRQ(BATT_ENT_ACT_MODE,	1, 5),
> +	AXP20X_IRQ(BATT_EXIT_ACT_MODE,	1, 4),
> +	AXP20X_IRQ(CHARG,		1, 3),
> +	AXP20X_IRQ(CHARG_DONE,		1, 2),
> +	AXP20X_IRQ(BATT_TEMP_HIGH,	1, 1),
> +	AXP20X_IRQ(BATT_TEMP_LOW,	1, 0),
> +	AXP20X_IRQ(DIE_TEMP_HIGH,	2, 7),
> +	AXP20X_IRQ(CHARG_I_LOW,		2, 6),
> +	AXP20X_IRQ(DCDC1_V_LONG,	2, 5),
> +	AXP20X_IRQ(DCDC2_V_LONG,	2, 4),
> +	AXP20X_IRQ(DCDC3_V_LONG,	2, 3),
> +	AXP20X_IRQ(PEK_SHORT,		2, 1),
> +	AXP20X_IRQ(PEK_LONG,		2, 0),
> +	AXP20X_IRQ(N_OE_PWR_ON,		3, 7),
> +	AXP20X_IRQ(N_OE_PWR_OFF,	3, 6),
> +	AXP20X_IRQ(VBUS_VALID,		3, 5),
> +	AXP20X_IRQ(VBUS_NOT_VALID,	3, 4),
> +	AXP20X_IRQ(VBUS_SESS_VALID,	3, 3),
> +	AXP20X_IRQ(VBUS_SESS_END,	3, 2),
> +	AXP20X_IRQ(LOW_PWR_LVL1,	3, 1),
> +	AXP20X_IRQ(LOW_PWR_LVL2,	3, 0),
> +	AXP20X_IRQ(TIMER,		4, 7),
> +	AXP20X_IRQ(PEK_RIS_EDGE,	4, 6),
> +	AXP20X_IRQ(PEK_FAL_EDGE,	4, 5),
> +	AXP20X_IRQ(GPIO3_INPUT,		4, 3),
> +	AXP20X_IRQ(GPIO2_INPUT,		4, 2),
> +	AXP20X_IRQ(GPIO1_INPUT,		4, 1),
> +	AXP20X_IRQ(GPIO0_INPUT,		4, 0),
> +};
> +
> +static const struct regmap_irq_chip axp20x_regmap_irq_chip =3D {
> +	.name			=3D "axp20x_irq_chip",
> +	.status_base		=3D AXP20X_IRQ1_STATE,
> +	.ack_base		=3D AXP20X_IRQ1_STATE,
> +	.mask_base		=3D AXP20X_IRQ1_EN,
> +	.num_regs		=3D 5,
> +	.irqs			=3D axp20x_regmap_irqs,
> +	.num_irqs		=3D ARRAY_SIZE(axp20x_regmap_irqs),
> +	.mask_invert		=3D true,
> +	.init_ack_masked	=3D true,
> +};
> +
> +static struct mfd_cell axp20x_cells[] =3D {
> +	{
> +		.name		=3D "axp20x-pek",
> +		.of_compatible	=3D "x-powers,axp20x-pek",

You need to add the x-powers prefix to
Documentation/devicetree/bindings/vendor-prefixes.txt, preferably in a
separate patch.

> +		.num_resources	=3D ARRAY_SIZE(axp20x_pek_resources),
> +		.resources	=3D axp20x_pek_resources,
> +	}, {
> +		.name		=3D "axp20x-regulator",
> +	},
> +};
> +
> +const struct of_device_id axp20x_of_match[] =3D {
> +	{ .compatible =3D "x-powers,axp202", .data =3D (void *) AXP202_ID },
> +	{ .compatible =3D "x-powers,axp209", .data =3D (void *) AXP209_ID },
> +	{ },
> +};
> +
> +static struct axp20x_dev *axp20x_pm_power_off;
> +static void axp20x_power_off(void)
> +{
> +	regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL,
> +		     AXP20X_OFF);
> +}
> +
> +static int axp20x_i2c_probe(struct i2c_client *i2c,
> +			 const struct i2c_device_id *id)
> +{
> +	struct axp20x_dev *axp20x;
> +	const struct of_device_id *of_id;
> +	struct device_node *node =3D i2c->dev.of_node;
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
> +
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
> +	if (ret) {
> +		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
> +		goto mfd_err;
> +	}
> +
> +	axp20x->pm_off =3D of_property_read_bool(node, "axp,system-power-contro=
ller");
> +
> +	if (axp20x->pm_off && !pm_power_off) {
> +		axp20x_pm_power_off =3D axp20x;
> +		pm_power_off =3D axp20x_power_off;
> +	}

I don't think we have any other way to actually power down the board.

Is there any reason why we would not need this property?

> +	dev_info(&i2c->dev, "AXP20X driver loaded\n");
> +
> +	return 0;
> +
> +mfd_err:
> +	regmap_del_irq_chip(axp20x->irq, axp20x->regmap_irqc);
> +
> +	return ret;
> +}
> +
> +static int axp20x_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct axp20x_dev *axp20x =3D i2c_get_clientdata(i2c);
> +
> +	if (axp20x =3D=3D axp20x_pm_power_off) {
> +		axp20x_pm_power_off =3D NULL;
> +		pm_power_off =3D NULL;
> +	}
> +
> +	mfd_remove_devices(axp20x->dev);
> +	regmap_del_irq_chip(axp20x->i2c_client->irq, axp20x->regmap_irqc);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id axp20x_i2c_id[] =3D {
> +	{ "axp202", AXP202_ID },
> +	{ "axp209", AXP209_ID },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
> +
> +static struct i2c_driver axp20x_i2c_driver =3D {
> +	.driver =3D {
> +		.name	=3D "axp20x",
> +		.owner	=3D THIS_MODULE,
> +		.of_match_table	=3D of_match_ptr(axp20x_of_match),
> +	},
> +	.probe		=3D axp20x_i2c_probe,
> +	.remove		=3D axp20x_i2c_remove,
> +	.id_table	=3D axp20x_i2c_id,
> +};
> +
> +module_i2c_driver(axp20x_i2c_driver);
> +
> +MODULE_DESCRIPTION("PMIC MFD core driver for AXP20X");
> +MODULE_AUTHOR("Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> new file mode 100644
> index 0000000..fcef32c
> --- /dev/null
> +++ b/include/linux/mfd/axp20x.h
> @@ -0,0 +1,180 @@
> +/*
> + * Functions to access AXP20X power management chip.
> + *
> + * Copyright (C) 2013, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __LINUX_MFD_AXP20X_H
> +#define __LINUX_MFD_AXP20X_H
> +
> +#define AXP202_ID			0
> +#define AXP209_ID			1
> +
> +#define AXP20X_DATACACHE(m)		(0x04 + (m))
> +
> +/* Power supply */
> +#define AXP20X_PWR_INPUT_STATUS		0x00
> +#define AXP20X_PWR_OP_MODE		0x01
> +#define AXP20X_USB_OTG_STATUS		0x02
> +#define AXP20X_PWR_OUT_CTRL		0x12
> +#define AXP20X_DCDC2_V_OUT		0x23
> +#define AXP20X_DCDC2_LDO3_V_SCAL	0x25
> +#define AXP20X_DCDC3_V_OUT		0x27
> +#define AXP20X_LDO24_V_OUT		0x28
> +#define AXP20X_LDO3_V_OUT		0x29
> +#define AXP20X_VBUS_IPSOUT_MGMT		0x30
> +#define AXP20X_V_OFF			0x31
> +#define AXP20X_OFF_CTRL			0x32
> +#define AXP20X_CHRG_CTRL1		0x33
> +#define AXP20X_CHRG_CTRL2		0x34
> +#define AXP20X_CHRG_BAK_CTRL		0x35
> +#define AXP20X_PEK_KEY			0x36
> +#define AXP20X_DCDC_FREQ		0x37
> +#define AXP20X_V_LTF_CHRG		0x38
> +#define AXP20X_V_HTF_CHRG		0x39
> +#define AXP20X_APS_WARN_L1		0x3a
> +#define AXP20X_APS_WARN_L2		0x3b
> +#define AXP20X_V_LTF_DISCHRG		0x3c
> +#define AXP20X_V_HTF_DISCHRG		0x3d
> +
> +/* Interrupt */
> +#define AXP20X_IRQ1_EN			0x40
> +#define AXP20X_IRQ2_EN			0x41
> +#define AXP20X_IRQ3_EN			0x42
> +#define AXP20X_IRQ4_EN			0x43
> +#define AXP20X_IRQ5_EN			0x44
> +#define AXP20X_IRQ1_STATE		0x48
> +#define AXP20X_IRQ2_STATE		0x49
> +#define AXP20X_IRQ3_STATE		0x4a
> +#define AXP20X_IRQ4_STATE		0x4b
> +#define AXP20X_IRQ5_STATE		0x4c
> +
> +/* ADC */
> +#define AXP20X_ACIN_V_ADC_H		0x56
> +#define AXP20X_ACIN_V_ADC_L		0x57
> +#define AXP20X_ACIN_I_ADC_H		0x58
> +#define AXP20X_ACIN_I_ADC_L		0x59
> +#define AXP20X_VBUS_V_ADC_H		0x5a
> +#define AXP20X_VBUS_V_ADC_L		0x5b
> +#define AXP20X_VBUS_I_ADC_H		0x5c
> +#define AXP20X_VBUS_I_ADC_L		0x5d
> +#define AXP20X_TEMP_ADC_H		0x5e
> +#define AXP20X_TEMP_ADC_L		0x5f
> +#define AXP20X_TS_IN_H			0x62
> +#define AXP20X_TS_IN_L			0x63
> +#define AXP20X_GPIO0_V_ADC_H		0x64
> +#define AXP20X_GPIO0_V_ADC_L		0x65
> +#define AXP20X_GPIO1_V_ADC_H		0x66
> +#define AXP20X_GPIO1_V_ADC_L		0x67
> +#define AXP20X_PWR_BATT_H		0x70
> +#define AXP20X_PWR_BATT_M		0x71
> +#define AXP20X_PWR_BATT_L		0x72
> +#define AXP20X_BATT_V_H			0x78
> +#define AXP20X_BATT_V_L			0x79
> +#define AXP20X_BATT_CHRG_I_H		0x7a
> +#define AXP20X_BATT_CHRG_I_L		0x7b
> +#define AXP20X_BATT_DISCHRG_I_H		0x7c
> +#define AXP20X_BATT_DISCHRG_I_L		0x7d
> +#define AXP20X_IPSOUT_V_HIGH_H		0x7e
> +#define AXP20X_IPSOUT_V_HIGH_L		0x7f
> +
> +/* Power supply */
> +#define AXP20X_DCDC_MODE		0x80
> +#define AXP20X_ADC_EN1			0x82
> +#define AXP20X_ADC_EN2			0x83
> +#define AXP20X_ADC_RATE			0x84
> +#define AXP20X_GPIO10_IN_RANGE		0x85
> +#define AXP20X_GPIO1_ADC_IRQ_RIS	0x86
> +#define AXP20X_GPIO1_ADC_IRQ_FAL	0x87
> +#define AXP20X_TIMER_CTRL		0x8a
> +#define AXP20X_VBUS_MON			0x8b
> +#define AXP20X_OVER_TMP			0x8f
> +
> +/* GPIO */
> +#define AXP20X_GPIO0_CTRL		0x90
> +#define AXP20X_LDO5_V_OUT		0x91
> +#define AXP20X_GPIO1_CTRL		0x92
> +#define AXP20X_GPIO2_CTRL		0x93
> +#define AXP20X_GPIO20_SS		0x94
> +#define AXP20X_GPIO3_CTRL		0x95
> +
> +/* Battery */
> +#define AXP20X_CHRG_CC_31_24		0xb0
> +#define AXP20X_CHRG_CC_23_16		0xb1
> +#define AXP20X_CHRG_CC_15_8		0xb2
> +#define AXP20X_CHRG_CC_7_0		0xb3
> +#define AXP20X_DISCHRG_CC_31_24		0xb4
> +#define AXP20X_DISCHRG_CC_23_16		0xb5
> +#define AXP20X_DISCHRG_CC_15_8		0xb6
> +#define AXP20X_DISCHRG_CC_7_0		0xb7
> +#define AXP20X_CC_CTRL			0xb8
> +#define AXP20X_FG_RES			0xb9
> +
> +/* Regulators IDs */
> +enum {
> +	AXP20X_LDO1 =3D 0,
> +	AXP20X_LDO2,
> +	AXP20X_LDO3,
> +	AXP20X_LDO4,
> +	AXP20X_LDO5,
> +	AXP20X_DCDC2,
> +	AXP20X_DCDC3,
> +	AXP20X_REG_ID_MAX,
> +};
> +
> +/* IRQs */
> +enum {
> +	AXP20X_IRQ_ACIN_OVER_V =3D 1,
> +	AXP20X_IRQ_ACIN_PLUGIN,
> +	AXP20X_IRQ_ACIN_REMOVAL,
> +	AXP20X_IRQ_VBUS_OVER_V,
> +	AXP20X_IRQ_VBUS_PLUGIN,
> +	AXP20X_IRQ_VBUS_REMOVAL,
> +	AXP20X_IRQ_VBUS_V_LOW,
> +	AXP20X_IRQ_BATT_PLUGIN,
> +	AXP20X_IRQ_BATT_REMOVAL,
> +	AXP20X_IRQ_BATT_ENT_ACT_MODE,
> +	AXP20X_IRQ_BATT_EXIT_ACT_MODE,
> +	AXP20X_IRQ_CHARG,
> +	AXP20X_IRQ_CHARG_DONE,
> +	AXP20X_IRQ_BATT_TEMP_HIGH,
> +	AXP20X_IRQ_BATT_TEMP_LOW,
> +	AXP20X_IRQ_DIE_TEMP_HIGH,
> +	AXP20X_IRQ_CHARG_I_LOW,
> +	AXP20X_IRQ_DCDC1_V_LONG,
> +	AXP20X_IRQ_DCDC2_V_LONG,
> +	AXP20X_IRQ_DCDC3_V_LONG,
> +	AXP20X_IRQ_PEK_SHORT =3D 22,
> +	AXP20X_IRQ_PEK_LONG,
> +	AXP20X_IRQ_N_OE_PWR_ON,
> +	AXP20X_IRQ_N_OE_PWR_OFF,
> +	AXP20X_IRQ_VBUS_VALID,
> +	AXP20X_IRQ_VBUS_NOT_VALID,
> +	AXP20X_IRQ_VBUS_SESS_VALID,
> +	AXP20X_IRQ_VBUS_SESS_END,
> +	AXP20X_IRQ_LOW_PWR_LVL1,
> +	AXP20X_IRQ_LOW_PWR_LVL2,
> +	AXP20X_IRQ_TIMER,
> +	AXP20X_IRQ_PEK_RIS_EDGE,
> +	AXP20X_IRQ_PEK_FAL_EDGE,
> +	AXP20X_IRQ_GPIO3_INPUT,
> +	AXP20X_IRQ_GPIO2_INPUT,
> +	AXP20X_IRQ_GPIO1_INPUT,
> +	AXP20X_IRQ_GPIO0_INPUT,
> +};
> +
> +struct axp20x_dev {
> +	struct device			*dev;
> +	struct i2c_client		*i2c_client;
> +	struct regmap			*regmap;
> +	struct regmap_irq_chip_data	*regmap_irqc;
> +	int				variant;
> +	int				irq;
> +	bool				pm_off;
> +};
> +
> +#endif /* __LINUX_MFD_AXP20X_H */
> --=20
> 1.8.3.2
>=20

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--AJd+a2ML6L6CXP6l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTGgtfAAoJEBx+YmzsjxAg8O8P/jVZhgVCnNx40QTHf09yTa9w
Z4L4oAeQ7ALjIGLntEA3+yBXv4+C5ktloT1PkHzJNiMN3nb/QtyHlMUfxroL5Mm0
y9qttlay9OYPtIzNZOqQmXs/cbMDWr7uYmJ3f8iF988fE77qvmRR5A9XMD05iaNe
Rrla31lcGeOubn/Kpg4ZGoIVCMdVw6AGTYo422lhYddn+TNoDnjzE5uKjUg1amLl
N1cOCkEu2tkKI1hmrIo3qzSoNTrPFvmTYw2pG8FGzBUCFMj7gAui+8EzcCPDbRQU
LuudroVmrIaea/UJhjejw9gf+tIeV/F0kMbbjHiwskNvhkbVc2ekV/OZXUSqJTNO
tyMS8P7LyAapt9dkudcFFV6lSLeiuT2Lu68J83sXCIbwoaa/8trxnZG6W9XOU0zM
D70pdSFGbZ8Jn+w6mGz7vgknFQmiF4nx89VSU+9Zf33fkyeEhFf3I3uxRHTk15Tn
99OLUNU/W4BZmwcxfcozTth4tEIu7fbIjPoMitY3IVXbypkyvuRHwpMaM61aT8SY
qCFO1KYQzVgBzwJRqU3MnDka9L7fvpBD72eZreLUaDQdC1olhSSpBOGe75KiK6l8
k+3lbViWr80sqLH/SYLvllnpojwIuZ74B3lHSGkIj/S7BDLTTxlgWH1mj7nfoMOQ
Dfq7CfXxJDZYdfVbtGv5
=ZLUE
-----END PGP SIGNATURE-----

--AJd+a2ML6L6CXP6l--
