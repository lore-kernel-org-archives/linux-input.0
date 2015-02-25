From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/5] mfd: max77843: Add max77843 MFD driver core driver
Date: Wed, 25 Feb 2015 16:47:29 +0000
Message-ID: <20150225164729.GG6688@x1>
References: <1424741348-8728-1-git-send-email-jaewon02.kim@samsung.com>
 <1424741348-8728-2-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424741348-8728-2-git-send-email-jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, SangBae Lee <sangbae90.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 24 Feb 2015, Jaewon Kim wrote:

> This patch adds MAX77843 core/irq driver to support PMIC,
> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
> LED and Haptic device.
>=20
> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/mfd/Kconfig                  |   14 ++
>  drivers/mfd/Makefile                 |    1 +
>  drivers/mfd/max77843.c               |  248 +++++++++++++++++++
>  include/linux/mfd/max77843-private.h |  454 ++++++++++++++++++++++++=
++++++++++
>  4 files changed, 717 insertions(+)
>  create mode 100644 drivers/mfd/max77843.c
>  create mode 100644 include/linux/mfd/max77843-private.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 38356e3..f2fd5e5 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -455,6 +455,20 @@ config MFD_MAX77693
>  	  additional drivers must be enabled in order to use the functional=
ity
>  	  of the device.
> =20
> +config MFD_MAX77843
> +	bool "Maxim Semiconductor MAX77843 PMIC Support"
> +	depends on I2C=3Dy
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Say yes here to add support for Maxim Semiconductor MAX77843.
> +	  This is companion Power Management IC with LEDs, Haptic, Charger,
> +	  Fuel Gauge, MUIC(Micro USB Interface Controller) controls on chip=
=2E
> +	  This driver provides common support for accessing the device;
> +	  additional drivers must be enabled in order to use the functional=
ity
> +	  of the device.
> +
>  config MFD_MAX8907
>  	tristate "Maxim Semiconductor MAX8907 PMIC Support"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 19f3d74..b8ac555 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -117,6 +117,7 @@ obj-$(CONFIG_MFD_DA9150)	+=3D da9150-core.o
>  obj-$(CONFIG_MFD_MAX14577)	+=3D max14577.o
>  obj-$(CONFIG_MFD_MAX77686)	+=3D max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+=3D max77693.o
> +obj-$(CONFIG_MFD_MAX77843)	+=3D max77843.o
>  obj-$(CONFIG_MFD_MAX8907)	+=3D max8907.o
>  max8925-objs			:=3D max8925-core.o max8925-i2c.o
>  obj-$(CONFIG_MFD_MAX8925)	+=3D max8925.o
> diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
> new file mode 100644
> index 0000000..2d8b3cc
> --- /dev/null
> +++ b/drivers/mfd/max77843.c
> @@ -0,0 +1,248 @@
> +/*
> + * max77843.c - MFD core driver for the Maxim MAX77843

Please remove the filename.

> + * Copyright (C) 2015 Samsung Electronics
> + * Author: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max77843-private.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +static const struct mfd_cell max77843_devs[] =3D {
> +	{
> +		.name =3D "max77843-muic",
> +		.of_compatible =3D "maxim,max77843-muic",
> +	}, {
> +		.name =3D "max77843-regulator",
> +		.of_compatible =3D "maxim,max77843-regulator",
> +	}, {
> +		.name =3D "max77843-charger",
> +		.of_compatible =3D "maxim,max77843-charger"
> +	}, {
> +		.name =3D "max77843-fuelgauge",
> +		.of_compatible =3D "maxim,max77843-fuelgauge",
> +	}, {
> +		.name =3D "max77843-haptic",
> +		.of_compatible =3D "maxim,max77843-haptic",
> +	},
> +};
> +
> +static const struct regmap_config max77843_charger_regmap_config =3D=
 {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 8,
> +	.max_register	=3D MAX77843_CHG_REG_END,
> +};
> +
> +static const struct regmap_config max77843_regmap_config =3D {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 8,
> +	.max_register	=3D MAX77843_SYS_REG_END,
> +};
> +
> +static const struct regmap_irq max77843_irqs[] =3D {
> +	/* TOPSYS interrupts */
> +	{ .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_SYSUVLO_INT, },
> +	{ .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_SYSOVLO_INT, },
> +	{ .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_TSHDN_INT, },
> +	{ .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_TM_INT, },
> +};
> +
> +static const struct regmap_irq_chip max77843_irq_chip =3D {
> +	.name		=3D "max77843",
> +	.status_base	=3D MAX77843_SYS_REG_SYSINTSRC,
> +	.mask_base	=3D MAX77843_SYS_REG_SYSINTMASK,
> +	.mask_invert	=3D false,
> +	.num_regs	=3D 1,
> +	.irqs		=3D max77843_irqs,
> +	.num_irqs	=3D ARRAY_SIZE(max77843_irqs),
> +};
> +
> +/* Charger and Charger regulator use same regmap. */
> +static int max77843_chg_init(struct max77843 *max77843)
> +{
> +	int ret;
> +
> +	max77843->i2c_chg =3D i2c_new_dummy(max77843->i2c->adapter, I2C_ADD=
R_CHG);
> +	if (!max77843->i2c_chg) {
> +		dev_err(&max77843->i2c->dev,
> +				"Cannot allocate I2C device for Charger\n");
> +		return PTR_ERR(max77843->i2c_chg);
> +	}
> +	i2c_set_clientdata(max77843->i2c_chg, max77843);
> +
> +	max77843->regmap_chg =3D devm_regmap_init_i2c(max77843->i2c_chg,
> +			&max77843_charger_regmap_config);
> +	if (IS_ERR(max77843->regmap_chg)) {
> +		ret =3D PTR_ERR(max77843->regmap_chg);
> +		goto err_chg_i2c;
> +	}
> +
> +	return 0;
> +
> +err_chg_i2c:
> +	i2c_unregister_device(max77843->i2c_chg);
> +
> +	return ret;
> +}
> +
> +static int max77843_probe(struct i2c_client *i2c,
> +			  const struct i2c_device_id *id)
> +{
> +	struct max77843 *max77843;
> +	unsigned int reg_data;
> +	int ret;
> +
> +	max77843 =3D devm_kzalloc(&i2c->dev, sizeof(*max77843), GFP_KERNEL)=
;
> +	if (!max77843)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, max77843);
> +	max77843->dev =3D &i2c->dev;
> +	max77843->i2c =3D i2c;
> +	max77843->irq =3D i2c->irq;
> +
> +	max77843->regmap =3D devm_regmap_init_i2c(i2c,
> +			&max77843_regmap_config);
> +	if (IS_ERR(max77843->regmap)) {
> +		dev_err(&i2c->dev, "Failed to allocate topsys register map\n");
> +		return PTR_ERR(max77843->regmap);
> +	}
> +
> +	ret =3D regmap_add_irq_chip(max77843->regmap, max77843->irq,
> +			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> +			0, &max77843_irq_chip, &max77843->irq_data);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to add TOPSYS IRQ chip\n");
> +		return ret;
> +	}
> +
> +	ret =3D regmap_read(max77843->regmap,
> +			MAX77843_SYS_REG_PMICID, &reg_data);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to read PMIC ID\n");
> +		goto err_pmic_id;
> +	}
> +	dev_info(&i2c->dev, "device ID: 0x%x\n", reg_data);
> +
> +	ret =3D max77843_chg_init(max77843);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to init Charger\n");
> +		goto err_pmic_id;
> +	}
> +
> +	ret =3D regmap_update_bits(max77843->regmap,
> +				 MAX77843_SYS_REG_INTSRCMASK,
> +				 MAX77843_INTSRC_MASK_MASK,
> +				 (unsigned int)~MAX77843_INTSRC_MASK_MASK);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to unmask interrupt source\n");
> +		goto err_pmic_id;
> +	}
> +
> +	ret =3D mfd_add_devices(max77843->dev, -1, max77843_devs,
> +			ARRAY_SIZE(max77843_devs), NULL, 0, NULL);

The tabbing in this file is all over the place.  Sometimes you match
up to the '(', sometimes you don't.  I would prefer it if you matched
with the opening parenthesis in all cases.

> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to add mfd device\n");
> +		goto err_pmic_id;
> +	}
> +
> +	device_init_wakeup(max77843->dev, 1);

device_init_wakeup's second argument is a bool.  1 is not a bool.
Please use 'true' or 'false'.

> +	return 0;
> +
> +err_pmic_id:
> +	regmap_del_irq_chip(max77843->irq, max77843->irq_data);
> +
> +	return ret;
> +}
> +
> +static int max77843_remove(struct i2c_client *i2c)
> +{
> +	struct max77843 *max77843 =3D i2c_get_clientdata(i2c);
> +
> +	mfd_remove_devices(max77843->dev);
> +
> +	regmap_del_irq_chip(max77843->irq, max77843->irq_data);
> +
> +	i2c_unregister_device(max77843->i2c_chg);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max77843_dt_match[] =3D {
> +	{ .compatible =3D "maxim,max77843", },
> +	{ /* sentinel */ },
> +};
> +
> +static const struct i2c_device_id max77843_id[] =3D {
> +	{ "max77843", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i2c, max77843_id);

There's really no need for these /* sentinel */ comments.  We all know
that they're required and what they do now.

> +static int __maybe_unused max77843_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c =3D container_of(dev, struct i2c_client, dev=
);
> +	struct max77843 *max77843 =3D i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(max77843->irq);
> +	disable_irq(max77843->irq);

Don't you want to disable the IRQs first?

> +	return 0;
> +}
> +
> +static int __maybe_unused max77843_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c =3D container_of(dev, struct i2c_client, dev=
);
> +	struct max77843 *max77843 =3D i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(max77843->irq);
> +	enable_irq(max77843->irq);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(max77843_pm, max77843_suspend, max77843_res=
ume);
> +
> +static struct i2c_driver max77843_i2c_driver =3D {
> +	.driver	=3D {
> +		.name =3D "max77843",
> +		.pm =3D &max77843_pm,
> +		.of_match_table =3D max77843_dt_match,
> +	},
> +	.probe =3D max77843_probe,
> +	.remove =3D max77843_remove,
> +	.id_table =3D max77843_id,
> +};
> +
> +static int __init max77843_i2c_init(void)
> +{
> +	return i2c_add_driver(&max77843_i2c_driver);
> +}
> +subsys_initcall(max77843_i2c_init);
> +
> +static void __exit max77843_i2c_exit(void)
> +{
> +	i2c_del_driver(&max77843_i2c_driver);
> +}
> +module_exit(max77843_i2c_exit);
> +
> +MODULE_AUTHOR("Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_AUTHOR("Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_DESCRIPTION("Maxim MAX77843 multi-function core driver");
> +MODULE_LICENSE("GPL");

You go to the trouble of providing all of these module helpers, but
this driver can not be used as a module.

> diff --git a/include/linux/mfd/max77843-private.h b/include/linux/mfd=
/max77843-private.h
> new file mode 100644
> index 0000000..c314da9
> --- /dev/null
> +++ b/include/linux/mfd/max77843-private.h
> @@ -0,0 +1,454 @@
> +/*
> + * max77843-private.h - Common variables for the Maxim MAX77843 driv=
er

Please remove the filename.

> + * Copyright (C) 2015 Samsung Electronics
> + * Author: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __MAX77843_PRIVATE_H_
> +#define __MAX77843_PRIVATE_H_
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +#define I2C_ADDR_TOPSYS	(0xCC >> 1)
> +#define I2C_ADDR_CHG	(0xD2 >> 1)
> +#define I2C_ADDR_FG	(0x6C >> 1)
> +#define I2C_ADDR_MUIC	(0x4A >> 1)
> +
> +/* Topsys, Haptic and LED registers */
> +enum max77843_sys_reg {
> +	MAX77843_SYS_REG_PMICID		=3D 0x00,
> +	MAX77843_SYS_REG_PMICREV	=3D 0x01,
> +	MAX77843_SYS_REG_MAINCTRL1	=3D 0x02,
> +	MAX77843_SYS_REG_INTSRC		=3D 0x22,
> +	MAX77843_SYS_REG_INTSRCMASK	=3D 0x23,
> +	MAX77843_SYS_REG_SYSINTSRC	=3D 0x24,
> +	MAX77843_SYS_REG_SYSINTMASK	=3D 0x26,
> +	MAX77843_SYS_REG_TOPSYS_STAT	=3D 0x28,
> +	MAX77843_SYS_REG_SAFEOUTCTRL	=3D 0xC6,
> +
> +	MAX77843_SYS_REG_END,
> +};
> +
> +enum max77843_haptic_reg {
> +	MAX77843_HAP_REG_MCONFIG	=3D 0x10,
> +
> +	MAX77843_HAP_REG_END,
> +};
> +
> +enum max77843_led_reg {
> +	MAX77843_LED_REG_LEDEN		=3D 0x30,
> +	MAX77843_LED_REG_LED0BRT	=3D 0x31,
> +	MAX77843_LED_REG_LED1BRT	=3D 0x32,
> +	MAX77843_LED_REG_LED2BRT	=3D 0x33,
> +	MAX77843_LED_REG_LED3BRT	=3D 0x34,
> +	MAX77843_LED_REG_LEDBLNK	=3D 0x38,
> +	MAX77843_LED_REG_LEDRAMP	=3D 0x36,
> +
> +	MAX77843_LED_REG_END,
> +};
> +
> +/* Charger registers */
> +enum max77843_charger_reg {
> +	MAX77843_CHG_REG_CHG_INT	=3D 0xB0,
> +	MAX77843_CHG_REG_CHG_INT_MASK	=3D 0xB1,
> +	MAX77843_CHG_REG_CHG_INT_OK	=3D 0xB2,
> +	MAX77843_CHG_REG_CHG_DTLS_00	=3D 0xB3,
> +	MAX77843_CHG_REG_CHG_DTLS_01	=3D 0xB4,
> +	MAX77843_CHG_REG_CHG_DTLS_02	=3D 0xB5,
> +	MAX77843_CHG_REG_CHG_CNFG_00	=3D 0xB7,
> +	MAX77843_CHG_REG_CHG_CNFG_01	=3D 0xB8,
> +	MAX77843_CHG_REG_CHG_CNFG_02	=3D 0xB9,
> +	MAX77843_CHG_REG_CHG_CNFG_03	=3D 0xBA,
> +	MAX77843_CHG_REG_CHG_CNFG_04	=3D 0xBB,
> +	MAX77843_CHG_REG_CHG_CNFG_06	=3D 0xBD,
> +	MAX77843_CHG_REG_CHG_CNFG_07	=3D 0xBE,
> +	MAX77843_CHG_REG_CHG_CNFG_09	=3D 0xC0,
> +	MAX77843_CHG_REG_CHG_CNFG_10	=3D 0xC1,
> +	MAX77843_CHG_REG_CHG_CNFG_11	=3D 0xC2,
> +	MAX77843_CHG_REG_CHG_CNFG_12	=3D 0xC3,
> +
> +	MAX77843_CHG_REG_END,
> +};
> +
> +/* Fuel gauge registers */
> +enum max77843_fuelgauge {
> +	MAX77843_FG_REG_STATUS		=3D 0x00,
> +	MAX77843_FG_REG_VALRT_TH	=3D 0x01,
> +	MAX77843_FG_REG_TALRT_TH	=3D 0x02,
> +	MAX77843_FG_REG_SALRT_TH	=3D 0x03,
> +	MAX77843_FG_RATE_AT_RATE	=3D 0x04,
> +	MAX77843_FG_REG_REMCAP_REP	=3D 0x05,
> +	MAX77843_FG_REG_SOCREP		=3D 0x06,
> +	MAX77843_FG_REG_AGE		=3D 0x07,
> +	MAX77843_FG_REG_TEMP		=3D 0x08,
> +	MAX77843_FG_REG_VCELL		=3D 0x09,
> +	MAX77843_FG_REG_CURRENT		=3D 0x0A,
> +	MAX77843_FG_REG_AVG_CURRENT	=3D 0x0B,
> +	MAX77843_FG_REG_SOCMIX		=3D 0x0D,
> +	MAX77843_FG_REG_SOCAV		=3D 0x0E,
> +	MAX77843_FG_REG_REMCAP_MIX	=3D 0x0F,
> +	MAX77843_FG_REG_FULLCAP		=3D 0x10,
> +	MAX77843_FG_REG_AVG_TEMP	=3D 0x16,
> +	MAX77843_FG_REG_CYCLES		=3D 0x17,
> +	MAX77843_FG_REG_AVG_VCELL	=3D 0x19,
> +	MAX77843_FG_REG_CONFIG		=3D 0x1D,
> +	MAX77843_FG_REG_REMCAP_AV	=3D 0x1F,
> +	MAX77843_FG_REG_FULLCAP_NOM	=3D 0x23,
> +	MAX77843_FG_REG_MISCCFG		=3D 0x2B,
> +	MAX77843_FG_REG_RCOMP		=3D 0x38,
> +	MAX77843_FG_REG_FSTAT		=3D 0x3D,
> +	MAX77843_FG_REG_DQACC		=3D 0x45,
> +	MAX77843_FG_REG_DPACC		=3D 0x46,
> +	MAX77843_FG_REG_OCV		=3D 0xEE,
> +	MAX77843_FG_REG_VFOCV		=3D 0xFB,
> +	MAX77843_FG_SOCVF		=3D 0xFF,
> +
> +	MAX77843_FG_END,
> +};
> +
> +/* MUIC registers */
> +enum max77843_muic_reg {
> +	MAX77843_MUIC_REG_ID		=3D 0x00,
> +	MAX77843_MUIC_REG_INT1		=3D 0x01,
> +	MAX77843_MUIC_REG_INT2		=3D 0x02,
> +	MAX77843_MUIC_REG_INT3		=3D 0x03,
> +	MAX77843_MUIC_REG_STATUS1	=3D 0x04,
> +	MAX77843_MUIC_REG_STATUS2	=3D 0x05,
> +	MAX77843_MUIC_REG_STATUS3	=3D 0x06,
> +	MAX77843_MUIC_REG_INTMASK1	=3D 0x07,
> +	MAX77843_MUIC_REG_INTMASK2	=3D 0x08,
> +	MAX77843_MUIC_REG_INTMASK3	=3D 0x09,
> +	MAX77843_MUIC_REG_CDETCTRL1	=3D 0x0A,
> +	MAX77843_MUIC_REG_CDETCTRL2	=3D 0x0B,
> +	MAX77843_MUIC_REG_CONTROL1	=3D 0x0C,
> +	MAX77843_MUIC_REG_CONTROL2	=3D 0x0D,
> +	MAX77843_MUIC_REG_CONTROL3	=3D 0x0E,
> +	MAX77843_MUIC_REG_CONTROL4	=3D 0x16,
> +	MAX77843_MUIC_REG_HVCONTROL1	=3D 0x17,
> +	MAX77843_MUIC_REG_HVCONTROL2	=3D 0x18,
> +
> +	MAX77843_MUIC_REG_END,
> +};
> +
> +enum max77843_irq {
> +	/* Topsys: SYSTEM */
> +	MAX77843_SYS_IRQ_SYSINTSRC_SYSUVLO_INT,
> +	MAX77843_SYS_IRQ_SYSINTSRC_SYSOVLO_INT,
> +	MAX77843_SYS_IRQ_SYSINTSRC_TSHDN_INT,
> +	MAX77843_SYS_IRQ_SYSINTSRC_TM_INT,
> +
> +	/* Charger: CHG_INT */
> +	MAX77843_CHG_IRQ_CHG_INT_BYP_I,
> +	MAX77843_CHG_IRQ_CHG_INT_BATP_I,
> +	MAX77843_CHG_IRQ_CHG_INT_BAT_I,
> +	MAX77843_CHG_IRQ_CHG_INT_CHG_I,
> +	MAX77843_CHG_IRQ_CHG_INT_WCIN_I,
> +	MAX77843_CHG_IRQ_CHG_INT_CHGIN_I,
> +	MAX77843_CHG_IRQ_CHG_INT_AICL_I,
> +
> +	MAX77843_IRQ_NUM,
> +};
> +
> +enum max77843_irq_muic {
> +	/* MUIC: INT1 */
> +	MAX77843_MUIC_IRQ_INT1_ADC,
> +	MAX77843_MUIC_IRQ_INT1_ADCERROR,
> +	MAX77843_MUIC_IRQ_INT1_ADC1K,
> +
> +	/* MUIC: INT2 */
> +	MAX77843_MUIC_IRQ_INT2_CHGTYP,
> +	MAX77843_MUIC_IRQ_INT2_CHGDETRUN,
> +	MAX77843_MUIC_IRQ_INT2_DCDTMR,
> +	MAX77843_MUIC_IRQ_INT2_DXOVP,
> +	MAX77843_MUIC_IRQ_INT2_VBVOLT,
> +
> +	/* MUIC: INT3 */
> +	MAX77843_MUIC_IRQ_INT3_VBADC,
> +	MAX77843_MUIC_IRQ_INT3_VDNMON,
> +	MAX77843_MUIC_IRQ_INT3_DNRES,
> +	MAX77843_MUIC_IRQ_INT3_MPNACK,
> +	MAX77843_MUIC_IRQ_INT3_MRXBUFOW,
> +	MAX77843_MUIC_IRQ_INT3_MRXTRF,
> +	MAX77843_MUIC_IRQ_INT3_MRXPERR,
> +	MAX77843_MUIC_IRQ_INT3_MRXRDY,
> +
> +	MAX77843_MUIC_IRQ_NUM,
> +};
> +
> +/* MAX77843 interrupts */
> +#define MAX77843_SYS_IRQ_SYSUVLO_INT		BIT(0)
> +#define MAX77843_SYS_IRQ_SYSOVLO_INT		BIT(1)
> +#define MAX77843_SYS_IRQ_TSHDN_INT		BIT(2)
> +#define MAX77843_SYS_IRQ_TM_INT			BIT(3)
> +
> +/* MAX77843 MAINCTRL1 register */
> +#define MAINCTRL1_BIASEN_SHIFT			7
> +#define MAX77843_MAINCTRL1_BIASEN_MASK		BIT(MAINCTRL1_BIASEN_SHIFT)
> +
> +/* MAX77843 MCONFIG register */
> +#define MCONFIG_MODE_SHIFT			7
> +#define MCONFIG_MEN_SHIFT			6
> +#define MCONFIG_PDIV_SHIFT			0
> +
> +#define MAX77843_MCONFIG_MODE_MASK		BIT(MCONFIG_MODE_SHIFT)
> +#define MAX77843_MCONFIG_MEN_MASK		BIT(MCONFIG_MEN_SHIFT)
> +#define MAX77843_MCONFIG_PDIV_MASK		(0x3 << MCONFIG_PDIV_SHIFT)
> +
> +/* Max77843 charger insterrupts */
> +#define MAX77843_CHG_BYP_I			BIT(0)
> +#define MAX77843_CHG_BATP_I			BIT(2)
> +#define MAX77843_CHG_BAT_I			BIT(3)
> +#define MAX77843_CHG_CHG_I			BIT(4)
> +#define MAX77843_CHG_WCIN_I			BIT(5)
> +#define MAX77843_CHG_CHGIN_I			BIT(6)
> +#define MAX77843_CHG_AICL_I			BIT(7)
> +
> +/* MAX77843 CHG_INT_OK register */
> +#define MAX77843_CHG_BYP_OK			BIT(0)
> +#define MAX77843_CHG_BATP_OK			BIT(2)
> +#define MAX77843_CHG_BAT_OK			BIT(3)
> +#define MAX77843_CHG_CHG_OK			BIT(4)
> +#define MAX77843_CHG_WCIN_OK			BIT(5)
> +#define MAX77843_CHG_CHGIN_OK			BIT(6)
> +#define MAX77843_CHG_AICL_OK			BIT(7)
> +
> +/* MAX77843 CHG_DETAILS_00 register */
> +#define MAX77843_CHG_BAT_DTLS			BIT(0)
> +
> +/* MAX77843 CHG_DETAILS_01 register */
> +#define MAX77843_CHG_DTLS_MASK			0x0f
> +#define MAX77843_CHG_PQ_MODE			0x00
> +#define MAX77843_CHG_CC_MODE			0x01
> +#define MAX77843_CHG_CV_MODE			0x02
> +#define MAX77843_CHG_TO_MODE			0x03
> +#define MAX77843_CHG_DO_MODE			0x04
> +#define MAX77843_CHG_HT_MODE			0x05
> +#define MAX77843_CHG_TF_MODE			0x06
> +#define MAX77843_CHG_TS_MODE			0x07
> +#define MAX77843_CHG_OFF_MODE			0x08
> +
> +#define MAX77843_CHG_BAT_DTLS_MASK		0xf0
> +#define MAX77843_CHG_NO_BAT			(0x00 << 4)
> +#define MAX77843_CHG_LOW_VOLT_BAT		(0x01 << 4)
> +#define MAX77843_CHG_LONG_BAT_TIME		(0x02 << 4)
> +#define MAX77843_CHG_OK_BAT			(0x03 << 4)
> +#define MAX77843_CHG_OK_LOW_VOLT_BAT		(0x04 << 4)
> +#define MAX77843_CHG_OVER_VOLT_BAT		(0x05 << 4)
> +#define MAX77843_CHG_OVER_CURRENT_BAT		(0x06 << 4)
> +
> +/* MAX77843 CHG_CNFG_00 register */
> +#define MAX77843_CHG_DISABLE			0x00
> +#define MAX77843_CHG_ENABLE			0x05
> +#define MAX77843_CHG_MASK			0x01
> +#define MAX77843_CHG_BUCK_MASK			0x04
> +
> +/* MAX77843 CHG_CNFG_01 register */
> +#define MAX77843_CHG_RESTART_THRESHOLD_100	0x00
> +#define MAX77843_CHG_RESTART_THRESHOLD_150	0x10
> +#define MAX77843_CHG_RESTART_THRESHOLD_200	0x20
> +#define MAX77843_CHG_RESTART_THRESHOLD_DISABLE	0x30
> +
> +/* MAX77843 CHG_CNFG_02 register */
> +#define MAX77843_CHG_FAST_CHG_CURRENT_MIN	100000
> +#define MAX77843_CHG_FAST_CHG_CURRENT_MAX	3150000
> +#define MAX77843_CHG_FAST_CHG_CURRENT_STEP	50000
> +#define MAX77843_CHG_FAST_CHG_CURRENT_MASK	0x3f
> +#define MAX77843_CHG_OTG_ILIMIT_500		(0x00 << 6)
> +#define MAX77843_CHG_OTG_ILIMIT_900		(0x01 << 6)
> +#define MAX77843_CHG_OTG_ILIMIT_1200		(0x02 << 6)
> +#define MAX77843_CHG_OTG_ILIMIT_1500		(0x03 << 6)
> +#define MAX77843_CHG_OTG_ILIMIT_MASK		0xc0
> +
> +/* MAX77843 CHG_CNFG_03 register */
> +#define MAX77843_CHG_TOP_OFF_CURRENT_MIN	125000
> +#define MAX77843_CHG_TOP_OFF_CURRENT_MAX	650000
> +#define MAX77843_CHG_TOP_OFF_CURRENT_STEP	75000
> +#define MAX77843_CHG_TOP_OFF_CURRENT_MASK	0x07
> +
> +/* MAX77843 CHG_CNFG_06 register */
> +#define MAX77843_CHG_WRITE_CAP_BLOCK		0x10
> +#define MAX77843_CHG_WRITE_CAP_UNBLOCK		0x0C
> +
> +/* MAX77843_CHG_CNFG_09_register */
> +#define MAX77843_CHG_INPUT_CURRENT_LIMIT_MIN	100000
> +#define MAX77843_CHG_INPUT_CURRENT_LIMIT_MAX	4000000
> +#define MAX77843_CHG_INPUT_CURRENT_LIMIT_REF	3367000
> +#define MAX77843_CHG_INPUT_CURRENT_LIMIT_STEP	33000
> +
> +#define MAX77843_MUIC_ADC			BIT(0)
> +#define MAX77843_MUIC_ADCERROR			BIT(2)
> +#define MAX77843_MUIC_ADC1K			BIT(3)
> +
> +#define MAX77843_MUIC_CHGTYP			BIT(0)
> +#define MAX77843_MUIC_CHGDETRUN			BIT(1)
> +#define MAX77843_MUIC_DCDTMR			BIT(2)
> +#define MAX77843_MUIC_DXOVP			BIT(3)
> +#define MAX77843_MUIC_VBVOLT			BIT(4)
> +
> +#define MAX77843_MUIC_VBADC			BIT(0)
> +#define MAX77843_MUIC_VDNMON			BIT(1)
> +#define MAX77843_MUIC_DNRES			BIT(2)
> +#define MAX77843_MUIC_MPNACK			BIT(3)
> +#define MAX77843_MUIC_MRXBUFOW			BIT(4)
> +#define MAX77843_MUIC_MRXTRF			BIT(5)
> +#define MAX77843_MUIC_MRXPERR			BIT(6)
> +#define MAX77843_MUIC_MRXRDY			BIT(7)
> +
> +/* MAX77843 INTSRCMASK register */
> +#define MAX77843_INTSRCMASK_CHGR		0
> +#define MAX77843_INTSRCMASK_SYS			1
> +#define MAX77843_INTSRCMASK_FG			2
> +#define MAX77843_INTSRCMASK_MUIC		3
> +
> +#define MAX77843_INTSRCMASK_CHGR_MASK          BIT(MAX77843_INTSRCMA=
SK_CHGR)
> +#define MAX77843_INTSRCMASK_SYS_MASK           BIT(MAX77843_INTSRCMA=
SK_SYS)
> +#define MAX77843_INTSRCMASK_FG_MASK            BIT(MAX77843_INTSRCMA=
SK_FG)
> +#define MAX77843_INTSRCMASK_MUIC_MASK          BIT(MAX77843_INTSRCMA=
SK_MUIC)
> +
> +#define MAX77843_INTSRC_MASK_MASK \
> +	(MAX77843_INTSRCMASK_MUIC_MASK | MAX77843_INTSRCMASK_FG_MASK | \
> +	MAX77843_INTSRCMASK_SYS_MASK | MAX77843_INTSRCMASK_CHGR_MASK)
> +
> +/* MAX77843 STATUS register*/
> +#define STATUS1_ADC_SHIFT			0
> +#define STATUS1_ADCERROR_SHIFT			6
> +#define STATUS1_ADC1K_SHIFT			7
> +#define STATUS2_CHGTYP_SHIFT			0
> +#define STATUS2_CHGDETRUN_SHIFT			3
> +#define STATUS2_DCDTMR_SHIFT			4
> +#define STATUS2_DXOVP_SHIFT			5
> +#define STATUS2_VBVOLT_SHIFT			6
> +#define STATUS3_VBADC_SHIFT			0
> +#define STATUS3_VDNMON_SHIFT			4
> +#define STATUS3_DNRES_SHIFT			5
> +#define STATUS3_MPNACK_SHIFT			6
> +
> +#define MAX77843_MUIC_STATUS1_ADC_MASK		(0x1f << STATUS1_ADC_SHIFT)
> +#define MAX77843_MUIC_STATUS1_ADCERROR_MASK	BIT(STATUS1_ADCERROR_SHI=
=46T)
> +#define MAX77843_MUIC_STATUS1_ADC1K_MASK	BIT(STATUS1_ADC1K_SHIFT)
> +#define MAX77843_MUIC_STATUS2_CHGTYP_MASK	(0x7 << STATUS2_CHGTYP_SHI=
=46T)
> +#define MAX77843_MUIC_STATUS2_CHGDETRUN_MASK	BIT(STATUS2_CHGDETRUN_S=
HIFT)
> +#define MAX77843_MUIC_STATUS2_DCDTMR_MASK	BIT(STATUS2_DCDTMR_SHIFT)
> +#define MAX77843_MUIC_STATUS2_DXOVP_MASK	BIT(STATUS2_DXOVP_SHIFT)
> +#define MAX77843_MUIC_STATUS2_VBVOLT_MASK	BIT(STATUS2_VBVOLT_SHIFT)
> +#define MAX77843_MUIC_STATUS3_VBADC_MASK	(0xf << STATUS3_VBADC_SHIFT=
)
> +#define MAX77843_MUIC_STATUS3_VDNMON_MASK	BIT(STATUS3_VDNMON_SHIFT)
> +#define MAX77843_MUIC_STATUS3_DNRES_MASK	BIT(STATUS3_DNRES_SHIFT)
> +#define MAX77843_MUIC_STATUS3_MPNACK_MASK	BIT(STATUS3_MPNACK_SHIFT)
> +
> +/* MAX77843 CONTROL register */
> +#define CONTROL1_COMP1SW_SHIFT			0
> +#define CONTROL1_COMP2SW_SHIFT			3
> +#define CONTROL1_IDBEN_SHIFT			7
> +#define CONTROL2_LOWPWR_SHIFT			0
> +#define CONTROL2_ADCEN_SHIFT			1
> +#define CONTROL2_CPEN_SHIFT			2
> +#define CONTROL2_ACC_DET_SHIFT			5
> +#define CONTROL2_USBCPINT_SHIFT			6
> +#define CONTROL2_RCPS_SHIFT			7
> +#define CONTROL3_JIGSET_SHIFT			0
> +#define CONTROL4_ADCDBSET_SHIFT			0
> +#define CONTROL4_USBAUTO_SHIFT			4
> +#define CONTROL4_FCTAUTO_SHIFT			5
> +#define CONTROL4_ADCMODE_SHIFT			6
> +
> +#define MAX77843_MUIC_CONTROL1_COMP1SW_MASK	(0x7 << CONTROL1_COMP1SW=
_SHIFT)
> +#define MAX77843_MUIC_CONTROL1_COMP2SW_MASK	(0x7 << CONTROL1_COMP2SW=
_SHIFT)
> +#define MAX77843_MUIC_CONTROL1_IDBEN_MASK	BIT(CONTROL1_IDBEN_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_LOWPWR_MASK	BIT(CONTROL2_LOWPWR_SHIFT=
)
> +#define MAX77843_MUIC_CONTROL2_ADCEN_MASK	BIT(CONTROL2_ADCEN_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_CPEN_MASK	BIT(CONTROL2_CPEN_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_ACC_DET_MASK	BIT(CONTROL2_ACC_DET_SHI=
=46T)
> +#define MAX77843_MUIC_CONTROL2_USBCPINT_MASK	BIT(CONTROL2_USBCPINT_S=
HIFT)
> +#define MAX77843_MUIC_CONTROL2_RCPS_MASK	BIT(CONTROL2_RCPS_SHIFT)
> +#define MAX77843_MUIC_CONTROL3_JIGSET_MASK	(0x3 << CONTROL3_JIGSET_S=
HIFT)
> +#define MAX77843_MUIC_CONTROL4_ADCDBSET_MASK	(0x3 << CONTROL4_ADCDBS=
ET_SHIFT)
> +#define MAX77843_MUIC_CONTROL4_USBAUTO_MASK	BIT(CONTROL4_USBAUTO_SHI=
=46T)
> +#define MAX77843_MUIC_CONTROL4_FCTAUTO_MASK	BIT(CONTROL4_FCTAUTO_SHI=
=46T)
> +#define MAX77843_MUIC_CONTROL4_ADCMODE_MASK	(0x3 << CONTROL4_ADCMODE=
_SHIFT)
> +
> +/* MAX77843 switch port */
> +#define COM_OPEN				0
> +#define COM_USB					1
> +#define COM_AUDIO				2
> +#define COM_UART				3
> +#define COM_AUX_USB				4
> +#define COM_AUX_UART				5
> +
> +#define CONTROL1_COM_SW \
> +	((MAX77843_MUIC_CONTROL1_COMP1SW_MASK | \
> +	 MAX77843_MUIC_CONTROL1_COMP2SW_MASK))
> +
> +#define CONTROL1_SW_OPEN \
> +	((COM_OPEN << CONTROL1_COMP1SW_SHIFT | \
> +	 COM_OPEN << CONTROL1_COMP2SW_SHIFT))
> +#define CONTROL1_SW_USB \
> +	((COM_USB << CONTROL1_COMP1SW_SHIFT | \
> +	 COM_USB << CONTROL1_COMP2SW_SHIFT))
> +#define CONTROL1_SW_AUDIO \
> +	((COM_AUDIO << CONTROL1_COMP1SW_SHIFT | \
> +	 COM_AUDIO << CONTROL1_COMP2SW_SHIFT))
> +#define CONTROL1_SW_UART \
> +	((COM_UART << CONTROL1_COMP1SW_SHIFT | \
> +	 COM_UART << CONTROL1_COMP2SW_SHIFT))
> +#define CONTROL1_SW_AUX_USB \
> +	((COM_AUX_USB << CONTROL1_COMP1SW_SHIFT | \
> +	 COM_AUX_USB << CONTROL1_COMP2SW_SHIFT))
> +#define CONTROL1_SW_AUX_UART \
> +	((COM_AUX_UART << CONTROL1_COMP1SW_SHIFT | \
> +	 COM_AUX_UART << CONTROL1_COMP2SW_SHIFT))
> +
> +#define MAX77843_DISABLE			0
> +#define MAX77843_ENABLE				1
> +
> +#define CONTROL4_AUTO_DISABLE \
> +	((MAX77843_DISABLE << CONTROL4_USBAUTO_SHIFT) | \
> +	(MAX77843_DISABLE << CONTROL4_FCTAUTO_SHIFT))
> +#define CONTROL4_AUTO_ENABLE \
> +	((MAX77843_ENABLE << CONTROL4_USBAUTO_SHIFT) | \
> +	(MAX77843_ENABLE << CONTROL4_FCTAUTO_SHIFT))
> +
> +/* MAX77843 SAFEOUT LDO Control register */
> +#define SAFEOUTCTRL_SAFEOUT1_SHIFT		0
> +#define SAFEOUTCTRL_SAFEOUT2_SHIFT		2
> +#define SAFEOUTCTRL_ENSAFEOUT1_SHIFT		6
> +#define SAFEOUTCTRL_ENSAFEOUT2_SHIFT		7
> +
> +#define MAX77843_REG_SAFEOUTCTRL_ENSAFEOUT1 \
> +		BIT(SAFEOUTCTRL_ENSAFEOUT1_SHIFT)
> +#define MAX77843_REG_SAFEOUTCTRL_ENSAFEOUT2 \
> +		BIT(SAFEOUTCTRL_ENSAFEOUT2_SHIFT)
> +#define MAX77843_REG_SAFEOUTCTRL_SAFEOUT1_MASK \
> +		(0x3 << SAFEOUTCTRL_SAFEOUT1_SHIFT)
> +#define MAX77843_REG_SAFEOUTCTRL_SAFEOUT2_MASK \
> +		(0x3 << SAFEOUTCTRL_SAFEOUT2_SHIFT)
> +
> +struct max77843 {
> +	struct device *dev;
> +
> +	struct i2c_client *i2c;
> +	struct i2c_client *i2c_chg;
> +	struct i2c_client *i2c_fuel;
> +	struct i2c_client *i2c_muic;
> +
> +	struct regmap *regmap;
> +	struct regmap *regmap_chg;
> +	struct regmap *regmap_fuel;
> +	struct regmap *regmap_muic;
> +
> +	struct regmap_irq_chip_data *irq_data;
> +	struct regmap_irq_chip_data *irq_data_chg;
> +	struct regmap_irq_chip_data *irq_data_fuel;
> +	struct regmap_irq_chip_data *irq_data_muic;
> +
> +	int irq;
> +};
> +#endif /* __MAX77843_H__ */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
