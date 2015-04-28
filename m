From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 01/17] mfd: add new driver for Sharp LoCoMo
Date: Tue, 28 Apr 2015 19:45:25 +0100
Message-ID: <20150428184525.GJ9169@x1>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430178954-11138-2-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 28 Apr 2015, Dmitry Eremin-Solenikov wrote:

> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does has
> several design issues (special bus instead of platform bus, doesn't u=
se
> mfd-core, etc).
>=20
> Implement 'core' parts of locomo support as an mfd driver.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mfd/Kconfig        |  10 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/locomo.c       | 356 +++++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/locomo.h | 173 ++++++++++++++++++++++
>  4 files changed, 540 insertions(+)
>  create mode 100644 drivers/mfd/locomo.c
>  create mode 100644 include/linux/mfd/locomo.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index d5ad04d..8c33940 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1430,6 +1430,16 @@ config MFD_STW481X
>  	  in various ST Microelectronics and ST-Ericsson embedded
>  	  Nomadik series.
> =20
> +config MFD_LOCOMO
> +	bool "Sharp LoCoMo support"
> +	depends on ARM
> +	select MFD_CORE
> +	select IRQ_DOMAIN
> +	select REGMAP_MMIO
> +	help
> +	  Support for Sharp LoCoMo Grid Array found in Sharp SL-5x00
> +          PDA family.

Are people really still using this stuff?

>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
> =20
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0e5cfeb..6c23b73 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -181,6 +181,7 @@ obj-$(CONFIG_MFD_HI6421_PMIC)	+=3D hi6421-pmic-co=
re.o
>  obj-$(CONFIG_MFD_DLN2)		+=3D dln2.o
>  obj-$(CONFIG_MFD_RT5033)	+=3D rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)	+=3D sky81452.o
> +obj-$(CONFIG_MFD_LOCOMO)	+=3D locomo.o
> =20
>  intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
> diff --git a/drivers/mfd/locomo.c b/drivers/mfd/locomo.c
> new file mode 100644
> index 0000000..f981c94
> --- /dev/null
> +++ b/drivers/mfd/locomo.c
> @@ -0,0 +1,356 @@
> +/*
> + * Sharp LoCoMo support
> + *
> + * Based on old driver at arch/arm/common/locomo.c
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This file contains all generic LoCoMo support.
> + *
> + * All initialization functions provided here are intended to be cal=
led
> + * from machine specific code with proper arguments when required.
> + */

'\n'

> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/locomo.h>
> +
> +/* LoCoMo Interrupts */
> +#define IRQ_LOCOMO_KEY		(0)
> +#define IRQ_LOCOMO_GPIO		(1)
> +#define IRQ_LOCOMO_LT		(2)
> +#define IRQ_LOCOMO_SPI		(3)
> +
> +#define LOCOMO_NR_IRQS		(4)

No need for all this added () protection.

> +/* the following is the overall data for the locomo chip */
> +struct locomo {
> +	struct device *dev;
> +	unsigned int irq;
> +	spinlock_t lock;
> +	struct irq_domain *domain;
> +	struct regmap *regmap;
> +};
> +
> +static struct resource locomo_kbd_resources[] =3D {
> +	DEFINE_RES_IRQ(IRQ_LOCOMO_KEY),
> +};
> +
> +static struct resource locomo_gpio_resources[] =3D {
> +	DEFINE_RES_IRQ(IRQ_LOCOMO_GPIO),
> +};
> +
> +/* Filled in locomo_probe() function. */
> +static struct locomo_gpio_platform_data locomo_gpio_pdata;

I'd prefer you didn't use globals for this.

> +static struct resource locomo_lt_resources[] =3D {
> +	DEFINE_RES_IRQ(IRQ_LOCOMO_LT),
> +};
> +
> +static struct resource locomo_spi_resources[] =3D {
> +	DEFINE_RES_IRQ(IRQ_LOCOMO_SPI),
> +};
> +
> +/* Filled in locomo_probe() function. */
> +static struct locomo_lcd_platform_data locomo_lcd_pdata;
> +
> +static struct mfd_cell locomo_cells[] =3D {
> +	{
> +		.name =3D "locomo-kbd",
> +		.resources =3D locomo_kbd_resources,
> +		.num_resources =3D ARRAY_SIZE(locomo_kbd_resources),
> +	},
> +	{
> +		.name =3D "locomo-gpio",
> +		.resources =3D locomo_gpio_resources,
> +		.num_resources =3D ARRAY_SIZE(locomo_gpio_resources),
> +		.platform_data =3D &locomo_gpio_pdata,
> +		.pdata_size =3D sizeof(locomo_gpio_pdata),
> +	},
> +	{
> +		.name =3D "locomo-lt", /* Long time timer */
> +		.resources =3D locomo_lt_resources,
> +		.num_resources =3D ARRAY_SIZE(locomo_lt_resources),
> +	},
> +	{
> +		.name =3D "locomo-spi",
> +		.resources =3D locomo_spi_resources,
> +		.num_resources =3D ARRAY_SIZE(locomo_spi_resources),
> +	},
> +	{
> +		.name =3D "locomo-led",
> +	},
> +	{
> +		.name =3D "locomo-backlight",
> +	},

Please make these:

> +	{ .name =3D "locomo-led" },
> +	{ .name =3D "locomo-backlight" },

=2E.. and put them at the bottom.

> +	{
> +		.name =3D "locomo-lcd",
> +		.platform_data =3D &locomo_lcd_pdata,
> +		.pdata_size =3D sizeof(locomo_lcd_pdata),
> +	},
> +	{
> +		.name =3D "locomo-i2c",
> +	},
> +};
> +
> +/* IRQ support */
> +static void locomo_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct locomo *lchip =3D irq_get_handler_data(irq);
> +	struct irq_chip *irqchip =3D irq_desc_get_chip(desc);
> +	unsigned int req;
> +
> +	chained_irq_enter(irqchip, desc);
> +
> +	/* check why this interrupt was generated */

Start comments with an uppercase character.

> +	while (1) {
> +		regmap_read(lchip->regmap, LOCOMO_ICR, &req);
> +		req &=3D 0x0f00;

What is this magic number?  Please #define it.

> +		if (!req)
> +			break;
> +
> +		irq =3D ffs(req) - 9;

Minus another random number?  Either define it or enter a comment.

> +		generic_handle_irq(irq_find_mapping(lchip->domain, irq));
> +	}
> +
> +	chained_irq_exit(irqchip, desc);
> +}
> +
> +static void locomo_ack_irq(struct irq_data *d)
> +{
> +}

Not sure you need this.  Please check.

If you do, please fix the caller, as it should be checked for NULL
prior to invocation.

> +static void locomo_mask_irq(struct irq_data *d)
> +{
> +	struct locomo *lchip =3D irq_data_get_irq_chip_data(d);
> +
> +	regmap_update_bits(lchip->regmap, LOCOMO_ICR,
> +		0x0010 << d->hwirq,
> +		0);

Why the forced line break here.

More magic numbers -- please define.

> +}
> +
> +static void locomo_unmask_irq(struct irq_data *d)
> +{
> +	struct locomo *lchip =3D irq_data_get_irq_chip_data(d);
> +
> +	regmap_update_bits(lchip->regmap, LOCOMO_ICR,
> +		(0x0010 << d->hwirq),
> +		(0x0010 << d->hwirq));

This looks hacky.  Please define a proper mask and value.

> +}
> +
> +static struct irq_chip locomo_chip =3D {
> +	.name		=3D "LOCOMO",

Any reason why this has to be uppercase?

> +	.irq_ack	=3D locomo_ack_irq,
> +	.irq_mask	=3D locomo_mask_irq,
> +	.irq_unmask	=3D locomo_unmask_irq,
> +};
> +
> +static int locomo_irq_map(struct irq_domain *d, unsigned int virq,
> +				irq_hw_number_t hwirq)
> +{
> +	struct locomo *locomo =3D d->host_data;
> +
> +	irq_set_chip_data(virq, locomo);
> +	irq_set_chip_and_handler(virq, &locomo_chip,
> +				handle_level_irq);
> +	set_irq_flags(virq, IRQF_VALID);
> +
> +	return 0;
> +}
> +
> +static void locomo_irq_unmap(struct irq_domain *d, unsigned int virq=
)
> +{
> +	set_irq_flags(virq, 0);
> +	irq_set_chip_and_handler(virq, NULL, NULL);
> +	irq_set_chip_data(virq, NULL);
> +}
> +
> +static struct irq_domain_ops locomo_irq_ops =3D {
> +	.map    =3D locomo_irq_map,
> +	.unmap  =3D locomo_irq_unmap,
> +	.xlate  =3D irq_domain_xlate_onecell,
> +};
> +
> +static int locomo_setup_irq(struct locomo *lchip)
> +{
> +	lchip->domain =3D irq_domain_add_simple(NULL, LOCOMO_NR_IRQS, 0,
> +			&locomo_irq_ops, lchip);

Please line up line breaks with the '('.

> +	if (!lchip->domain) {
> +		dev_err(lchip->dev, "Failed to register irqdomain\n");

No need for this.  The IRQ domain handling with print one out for you.

> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * Install handler for IRQ_LOCOMO_HW.
> +	 */
> +	irq_set_irq_type(lchip->irq, IRQ_TYPE_EDGE_FALLING);
> +	irq_set_handler_data(lchip->irq, lchip);
> +	irq_set_chained_handler(lchip->irq, locomo_handler);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int locomo_suspend(struct device *dev)
> +{
> +	struct locomo *lchip =3D dev_get_drvdata(dev);
> +
> +	/* AUDIO */

WHY ARE YOU SHOUTING?  Ironic eh? ;)

> +	regmap_write(lchip->regmap, LOCOMO_PAIF, 0x00);
> +
> +	/*
> +	 * Original code disabled the clock depending on leds settings
> +	 * However we disable leds before suspend, thus it's safe
> +	 * to just assume this setting.
> +	 */
> +	/* CLK32 off */
> +	regmap_write(lchip->regmap, LOCOMO_C32K, 0x00);
> +
> +	/* 22MHz/24MHz clock off */
> +	regmap_write(lchip->regmap, LOCOMO_ACC, 0x00);
> +
> +	return 0;
> +}
> +
> +static int locomo_resume(struct device *dev)
> +{
> +	struct locomo *lchip =3D dev_get_drvdata(dev);

Do audio and clk sort themselves out?

> +	regmap_write(lchip->regmap, LOCOMO_C32K, 0x00);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(locomo_pm, locomo_suspend, locomo_resume);

Put this outside of CONFIG_PM_SLEEP and SIMPLE_DEV_PM_OPS() will take
care of this for you.

> +#define LOCOMO_PM	(&locomo_pm)
> +
> +#else
> +#define LOCOMO_PM/	NULL

This you can remove all of this.

> +#endif
> +
> +static const struct regmap_config locomo_regmap_config =3D {
> +	.name =3D "LoCoMo",
> +	.reg_bits =3D 8,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 16,
> +	.cache_type =3D REGCACHE_NONE,
> +	.max_register =3D 0xec,
> +};
> +
> +static int locomo_probe(struct platform_device *dev)

s/dev/pdev/

dev is usually used for 'struct device' pointers.

> +{
> +	struct locomo_platform_data *pdata =3D dev_get_platdata(&dev->dev);
> +	struct resource *mem;

Nit: res is more commonplace.

> +	void __iomem *base;
> +	struct locomo *lchip;

I always quite like ldev.

> +	unsigned int r;

r is not a good variable name.

> +	int ret =3D -ENODEV;

No need to initialise.

> +	lchip =3D devm_kzalloc(&dev->dev, sizeof(struct locomo), GFP_KERNEL=
);

s/struct locomo/*lchip/

> +	if (!lchip)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&lchip->lock);
> +	lchip->dev =3D &dev->dev;
> +
> +	lchip->irq =3D platform_get_irq(dev, 0);
> +	if (lchip->irq < 0)
> +		return -ENXIO;

Why are you making up your own return codes?

return lchip->irq;

> +	mem =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	base =3D devm_ioremap_resource(&dev->dev, mem);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	lchip->regmap =3D devm_regmap_init_mmio(&dev->dev, base,
> +			&locomo_regmap_config);

Line up with '('.

> +	if (IS_ERR(lchip->regmap))
> +		return PTR_ERR(lchip->regmap);
> +
> +	if (pdata) {
> +		locomo_gpio_pdata.gpio_base =3D pdata->gpio_base;
> +		locomo_lcd_pdata.comadj =3D pdata->comadj;
> +	} else {
> +		locomo_gpio_pdata.gpio_base =3D -1;
> +		locomo_lcd_pdata.comadj =3D 128;
> +	}

struct locomo_gpio_platform_data locomo_gpio_pdata;

locomo_gpio_pdata =3D devm_kzalloc(<blah>);

locomo_cells[GPIO].platform_data =3D locomo_gpio_pdata;

> +	platform_set_drvdata(dev, lchip);
> +
> +	regmap_read(lchip->regmap, LOCOMO_VER, &r);
> +	dev_info(&dev->dev, "LoCoMo Chip: %04x\n", r);

s/r/rev/

or

s/r/id/

> +	/* locomo initialize */
> +	regmap_write(lchip->regmap, LOCOMO_ICR, 0);

What does initialize mean?  Enable? Reset IRQs? Reset chip?

> +	/* Longtime timer */
> +	regmap_write(lchip->regmap, LOCOMO_LTINT, 0);
> +
> +	/*
> +	 * The interrupt controller must be initialised before any
> +	 * other device to ensure that the interrupts are available.
> +	 */

That's pretty normal isn't it?

> +	ret =3D locomo_setup_irq(lchip);
> +	if (ret < 0)
> +		goto err_add;

What if ret > 0?

Suggest:
  if (ret)

> +	ret =3D mfd_add_devices(&dev->dev, dev->id,
> +			locomo_cells, ARRAY_SIZE(locomo_cells),
> +			mem, -1, lchip->domain);

s/mem/base/

> +	if (ret)
> +		goto err_add;
> +
> +	return 0;
> +
> +err_add:

What does err_add mean?

> +	irq_set_chained_handler(lchip->irq, NULL);
> +	irq_set_handler_data(lchip->irq, NULL);
> +	if (lchip->domain)
> +		irq_domain_remove(lchip->domain);
> +
> +	return ret;
> +}
> +
> +static int locomo_remove(struct platform_device *dev)
> +{
> +	struct locomo *lchip =3D platform_get_drvdata(dev);
> +
> +	if (!lchip)
> +		return 0;

Is that even possible?

> +	mfd_remove_devices(&dev->dev);
> +
> +	irq_set_chained_handler(lchip->irq, NULL);
> +	irq_set_handler_data(lchip->irq, NULL);

'\n'

> +	if (lchip->domain)
> +		irq_domain_remove(lchip->domain);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver locomo_device_driver =3D {
> +	.probe		=3D locomo_probe,
> +	.remove		=3D locomo_remove,
> +	.driver		=3D {
> +		.name	=3D "locomo",
> +		.pm	=3D LOCOMO_PM,
> +	},
> +};

Lining these up looks weird.  Especially as the stuff in .driver is
*meant* to be indented.

> +module_platform_driver(locomo_device_driver);
> +
> +MODULE_DESCRIPTION("Sharp LoCoMo core driver");
> +MODULE_LICENSE("GPL");

GPL v2

> +MODULE_AUTHOR("John Lenz <lenz-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>");
> +MODULE_ALIAS("platform:locomo");
> diff --git a/include/linux/mfd/locomo.h b/include/linux/mfd/locomo.h
> new file mode 100644
> index 0000000..6729767
> --- /dev/null
> +++ b/include/linux/mfd/locomo.h

This whole file needs a jolly good tidy-up.

> @@ -0,0 +1,173 @@
> +/*
> + * include/linux/mfd/locomo.h

Remove this.  We know what file it's in.

> + * This file contains the definitions for the LoCoMo G/A Chip
> + *
> + * (C) Copyright 2004 John Lenz

This is out of date.

> + * May be copied or modified under the terms of the GNU General Publ=
ic
> + * License.  See linux/COPYING for more information.
> + *
> + * Based on sa1111.h
> + */

'/n'

> +#ifndef _ASM_ARCH_LOCOMO
> +#define _ASM_ARCH_LOCOMO
> +
> +/* LOCOMO version */
> +#define LOCOMO_VER	0x00

This is misleading.

The version is not 0, this is the register address.

> +/* Pin status */
> +#define LOCOMO_ST	0x04
> +
> +/* Pin status */
> +#define LOCOMO_C32K	0x08
> +
> +/* Interrupt controller */
> +#define LOCOMO_ICR	0x0C
> +
> +/* MCS decoder for boot selecting */
> +#define LOCOMO_MCSX0	0x10
> +#define LOCOMO_MCSX1	0x14
> +#define LOCOMO_MCSX2	0x18
> +#define LOCOMO_MCSX3	0x1c

These are pretty cryptic.  Any way of making them easier to identify.

> +/* Touch panel controller */
> +#define LOCOMO_ASD	0x20		/* AD start delay */
> +#define LOCOMO_HSD	0x28		/* HSYS delay */
> +#define LOCOMO_HSC	0x2c		/* HSYS period */
> +#define LOCOMO_TADC	0x30		/* tablet ADC clock */
> +
> +/* Backlight controller: TFT signal */
> +#define LOCOMO_TC	0x38		/* TFT control signal */
> +#define LOCOMO_CPSD	0x3c		/* CPS delay */
> +
> +/* Keyboard controller */
> +#define LOCOMO_KIB	0x40	/* KIB level */
> +#define LOCOMO_KSC	0x44	/* KSTRB control */
> +#define LOCOMO_KCMD	0x48	/* KSTRB command */
> +#define LOCOMO_KIC	0x4c	/* Key interrupt */
> +
> +/* Audio clock */
> +#define LOCOMO_ACC	0x54	/* Audio clock */
> +#define	LOCOMO_ACC_XON		0x80
> +#define	LOCOMO_ACC_XEN		0x40
> +#define	LOCOMO_ACC_XSEL0	0x00
> +#define	LOCOMO_ACC_XSEL1	0x20
> +#define	LOCOMO_ACC_MCLKEN	0x10
> +#define	LOCOMO_ACC_64FSEN	0x08
> +#define	LOCOMO_ACC_CLKSEL000	0x00	/* mclk  2 */
> +#define	LOCOMO_ACC_CLKSEL001	0x01	/* mclk  3 */
> +#define	LOCOMO_ACC_CLKSEL010	0x02	/* mclk  4 */
> +#define	LOCOMO_ACC_CLKSEL011	0x03	/* mclk  6 */
> +#define	LOCOMO_ACC_CLKSEL100	0x04	/* mclk  8 */
> +#define	LOCOMO_ACC_CLKSEL101	0x05	/* mclk 12 */

I think you have an issue with spaces and tabs here.

> +/* SPI interface */
> +#define LOCOMO_SPIMD	0x60		/* SPI mode setting */
> +#define LOCOMO_SPIMD_LOOPBACK (1 << 15)	/* loopback tx to rx */

Use BIT() for all '1 <<'s.

> +#define LOCOMO_SPIMD_MSB1ST   (1 << 14)	/* send MSB first */
> +#define LOCOMO_SPIMD_DOSTAT   (1 << 13)	/* transmit line is idle hig=
h */
> +#define LOCOMO_SPIMD_TCPOL    (1 << 11)	/* transmit CPOL (maybe affe=
cts CPHA) */
> +#define LOCOMO_SPIMD_RCPOL    (1 << 10)	/* receive CPOL (maybe affec=
ts CPHA) */
> +#define	LOCOMO_SPIMD_TDINV    (1 << 9)	/* invert transmit line */

Why is this different?

> +#define LOCOMO_SPIMD_RDINV    (1 << 8)	/* invert receive line */
> +#define LOCOMO_SPIMD_XON      (1 << 7)	/* enable spi controller cloc=
k */
> +#define LOCOMO_SPIMD_XEN      (1 << 6)	/* clock bit write enable */
> +#define LOCOMO_SPIMD_XSEL     0x0018	/* clock select */
> +/* xon must be off when enabling xen, wait 300 us before xon -> 1 */
> +#define CLOCK_18MHZ	    0		/* 18,432 MHz clock */
> +#define CLOCK_22MHZ	    1		/* 22,5792 MHz clock */
> +#define CLOCK_25MHZ	    2		/* 24,576 MHz clock */
> +#define LOCOMO_SPIMD_CLKSEL   0x7
> +#define DIV_1		    0		/* don't divide clock   */
> +#define DIV_2		    1		/* divide clock by two	*/
> +#define DIV_4		    2		/* divide clock by four */
> +#define DIV_8		    3		/* divide clock by eight*/
> +#define DIV_64		    4		/* divide clock by 64 */

Better to line all of these up along with the rest of the file.

> +#define LOCOMO_SPICT	0x64		/* SPI mode control */
> +#define LOCOMO_SPICT_CRC16_7_B	(1 << 15)	/* 0: crc16 1: crc7 */
> +#define LOCOMO_SPICT_CRCRX_TX_B	(1 << 14)
> +#define LOCOMO_SPICT_CRCRESET_B	(1 << 13)
> +#define LOCOMO_SPICT_CEN	(1 << 7)	/* ?? enable */
> +#define LOCOMO_SPICT_CS		(1 << 6)	/* chip select */
> +#define LOCOMO_SPICT_UNIT16	(1 << 5)	/* 0: 8 bit, 1: 16 bit*/
> +#define LOCOMO_SPICT_ALIGNEN	(1 << 2)	/* align transfer enable */
> +#define LOCOMO_SPICT_RXWEN	(1 << 1)	/* continuous receive */
> +#define LOCOMO_SPICT_RXUEN	(1 << 0)	/* aligned receive */
> +
> +#define LOCOMO_SPIST	0x68		/* SPI status */
> +#define	LOCOMO_SPI_TEND	(1 << 3)	/* Transfer end bit */
> +#define	LOCOMO_SPI_REND	(1 << 2)	/* Receive end bit */
> +#define	LOCOMO_SPI_RFW	(1 << 1)	/* write buffer bit */
> +#define	LOCOMO_SPI_RFR	(1)		/* read buffer bit */
> +
> +#define LOCOMO_SPIIS	0x70		/* SPI interrupt status */
> +#define LOCOMO_SPIWE	0x74		/* SPI interrupt status write enable */
> +#define LOCOMO_SPIIE	0x78		/* SPI interrupt enable */
> +#define LOCOMO_SPIIR	0x7c		/* SPI interrupt request */
> +#define LOCOMO_SPITD	0x80		/* SPI transfer data write */
> +#define LOCOMO_SPIRD	0x84		/* SPI receive data read */
> +#define LOCOMO_SPITS	0x88		/* SPI transfer data shift */
> +#define LOCOMO_SPIRS	0x8C		/* SPI receive data shift */
> +
> +/* GPIO */
> +#define LOCOMO_GPD	0x90	/* GPIO direction */
> +#define LOCOMO_GPE	0x94	/* GPIO input enable */
> +#define LOCOMO_GPL	0x98	/* GPIO level */
> +#define LOCOMO_GPO	0x9c	/* GPIO out data setting */
> +#define LOCOMO_GRIE	0xa0	/* GPIO rise detection */
> +#define LOCOMO_GFIE	0xa4	/* GPIO fall detection */
> +#define LOCOMO_GIS	0xa8	/* GPIO edge detection status */
> +#define LOCOMO_GWE	0xac	/* GPIO status write enable */
> +#define LOCOMO_GIE	0xb0	/* GPIO interrupt enable */
> +#define LOCOMO_GIR	0xb4	/* GPIO interrupt request */
> +
> +/* Front light adjustment controller */
> +#define LOCOMO_ALS	0xc8	/* Adjust light cycle */
> +#define LOCOMO_ALS_EN		0x8000
> +#define LOCOMO_ALD	0xcc	/* Adjust light duty */
> +
> +/* PCM audio interface */
> +#define LOCOMO_PAIF	0xd0	/* PCM audio interface */
> +#define	LOCOMO_PAIF_SCINV	0x20
> +#define	LOCOMO_PAIF_SCEN	0x10
> +#define	LOCOMO_PAIF_LRCRST	0x08
> +#define	LOCOMO_PAIF_LRCEVE	0x04
> +#define	LOCOMO_PAIF_LRCINV	0x02
> +#define	LOCOMO_PAIF_LRCEN	0x01
> +
> +/* Long time timer */
> +#define LOCOMO_LTC	0xd8		/* LTC interrupt setting */
> +#define LOCOMO_LTINT	0xdc		/* LTC interrupt */
> +
> +/* DAC control signal for LCD (COMADJ ) */
> +#define LOCOMO_DAC	0xe0
> +/* DAC control */
> +#define	LOCOMO_DAC_SCLOEB	0x08	/* SCL pin output data       */
> +#define	LOCOMO_DAC_TEST		0x04	/* Test bit                  */
> +#define	LOCOMO_DAC_SDA		0x02	/* SDA pin level (read-only) */
> +#define	LOCOMO_DAC_SDAOEB	0x01	/* SDA pin output data       */
> +
> +/* LED controller */
> +#define LOCOMO_LPT0	0xe8
> +#define LOCOMO_LPT1	0xec
> +#define LOCOMO_LPT_TOFH		0x80
> +#define LOCOMO_LPT_TOFL		0x08
> +#define LOCOMO_LPT_TOH(TOH)	((TOH & 0x7) << 4)
> +#define LOCOMO_LPT_TOL(TOL)	((TOL & 0x7))
> +
> +struct locomo_gpio_platform_data {
> +	unsigned int gpio_base;
> +};

A struct for a single int seems overkill.

> +struct locomo_lcd_platform_data {
> +	u8 comadj;
> +};
> +
> +struct locomo_platform_data {
> +	unsigned int gpio_base;
> +	u8 comadj;
> +};

Why do you need to pass gpio_base twice?

> +#endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
