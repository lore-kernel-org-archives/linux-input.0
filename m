From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 01/18] mfd: add new driver for Sharp LoCoMo
Date: Wed, 27 May 2015 11:27:56 +0100
Message-ID: <20150527102756.GH11677@x1>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
 <1432554113-26280-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432554113-26280-2-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-spi@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

On Mon, 25 May 2015, Dmitry Eremin-Solenikov wrote:

> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does has
> several design issues (special bus instead of platform bus, doesn't u=
se
> mfd-core, etc).
>=20
> Implement 'core' parts of locomo support as an mfd driver.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---

These things are much easier to re-review if you keep a change-log
here.

>  drivers/mfd/Kconfig        |  10 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/locomo.c       | 336 +++++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/locomo.h | 169 +++++++++++++++++++++++
>  4 files changed, 516 insertions(+)
>  create mode 100644 drivers/mfd/locomo.c
>  create mode 100644 include/linux/mfd/locomo.h

Looks good now though:
  Acked-by: Lee Jones <lee.jones@linaro.org>

How do you plan for this to be merged?

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
> +
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
> index 0000000..4682893
> --- /dev/null
> +++ b/drivers/mfd/locomo.c
> @@ -0,0 +1,336 @@
> +/*
> + * Sharp LoCoMo support
> + *
> + * (C) Copyright 2015 Dmitry Eremin-Solenikov
> + *
> + * Based on old driver at arch/arm/common/locomo.c
> + *
> + * (C) Copyright 2004 John Lenz
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
> +
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/locomo.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +/* LoCoMo Interrupts */
> +#define IRQ_LOCOMO_KEY		0
> +#define IRQ_LOCOMO_GPIO		1
> +#define IRQ_LOCOMO_LT		2
> +#define IRQ_LOCOMO_SPI		3
> +
> +#define LOCOMO_NR_IRQS		4
> +
> +/* The following is the overall data for the locomo chip */
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
> +/* Filled in locomo_probe() function, will be kmemduped by platform =
core */
> +static struct locomo_gpio_platform_data locomo_gpio_pdata;
> +
> +static struct resource locomo_lt_resources[] =3D {
> +	DEFINE_RES_IRQ(IRQ_LOCOMO_LT),
> +};
> +
> +static struct resource locomo_spi_resources[] =3D {
> +	DEFINE_RES_IRQ(IRQ_LOCOMO_SPI),
> +};
> +
> +/* Filled in locomo_probe() function, will be kmemduped by platform =
core */
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
> +		.name =3D "locomo-lcd",
> +		.platform_data =3D &locomo_lcd_pdata,
> +		.pdata_size =3D sizeof(locomo_lcd_pdata),
> +	},
> +	{ .name =3D "locomo-led", },
> +	{ .name =3D "locomo-backlight", },
> +	{ .name =3D "locomo-i2c", },
> +};
> +
> +/*
> + * IRQ support
> + */
> +static void locomo_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct locomo *ldev =3D irq_get_handler_data(irq);
> +	struct irq_chip *irqchip =3D irq_desc_get_chip(desc);
> +	unsigned int req;
> +
> +	chained_irq_enter(irqchip, desc);
> +
> +	/* Check why this interrupt was generated */
> +	while (1) {
> +		regmap_read(ldev->regmap, LOCOMO_ICR, &req);
> +		req >>=3D LOCOMO_ICR_STATUS_SHIFT;
> +
> +		if (!req)
> +			break;
> +
> +		irq =3D ffs(req) - 1;
> +		generic_handle_irq(irq_find_mapping(ldev->domain, irq));
> +	}
> +
> +	chained_irq_exit(irqchip, desc);
> +}
> +
> +static void locomo_mask_irq(struct irq_data *d)
> +{
> +	struct locomo *ldev =3D irq_data_get_irq_chip_data(d);
> +	unsigned int mask =3D BIT(d->hwirq + LOCOMO_ICR_MASK_SHIFT);
> +
> +	regmap_update_bits(ldev->regmap, LOCOMO_ICR, mask, 0);
> +}
> +
> +static void locomo_unmask_irq(struct irq_data *d)
> +{
> +	struct locomo *ldev =3D irq_data_get_irq_chip_data(d);
> +	unsigned int mask =3D BIT(d->hwirq + LOCOMO_ICR_MASK_SHIFT);
> +
> +	regmap_update_bits(ldev->regmap, LOCOMO_ICR, mask, mask);
> +}
> +
> +static struct irq_chip locomo_chip =3D {
> +	.name		=3D "locomo",
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
> +	irq_set_chip_and_handler(virq, &locomo_chip, handle_level_irq);
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
> +static int locomo_setup_irq(struct locomo *ldev)
> +{
> +	ldev->domain =3D irq_domain_add_simple(NULL, LOCOMO_NR_IRQS, 0,
> +					     &locomo_irq_ops, ldev);
> +	if (!ldev->domain)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Install handler for IRQ_LOCOMO_HW.
> +	 */
> +	irq_set_irq_type(ldev->irq, IRQ_TYPE_EDGE_FALLING);
> +	irq_set_handler_data(ldev->irq, ldev);
> +	irq_set_chained_handler(ldev->irq, locomo_handler);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int locomo_suspend(struct device *dev)
> +{
> +	struct locomo *ldev =3D dev_get_drvdata(dev);
> +
> +	/* Audio */
> +	regmap_write(ldev->regmap, LOCOMO_PAIF, 0x00);
> +
> +	/*
> +	 * Original code disabled the clock depending on leds settings
> +	 * However we disable leds before suspend, thus it's safe
> +	 * to just assume this setting.
> +	 */
> +	/* CLK32 off */
> +	regmap_write(ldev->regmap, LOCOMO_C32K, 0x00);
> +
> +	/* 22MHz/24MHz clock off */
> +	regmap_write(ldev->regmap, LOCOMO_ACC, 0x00);
> +
> +	return 0;
> +}
> +
> +static int locomo_resume(struct device *dev)
> +{
> +	struct locomo *ldev =3D dev_get_drvdata(dev);
> +
> +	regmap_write(ldev->regmap, LOCOMO_C32K, 0x00);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(locomo_pm, locomo_suspend, locomo_resume);
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
> +static int locomo_probe(struct platform_device *pdev)
> +{
> +	struct locomo_platform_data *pdata =3D dev_get_platdata(&pdev->dev)=
;
> +	struct resource *res;
> +	void __iomem *base;
> +	struct locomo *ldev;
> +	unsigned int rev;
> +	int ret;
> +
> +	ldev =3D devm_kzalloc(&pdev->dev, sizeof(*ldev), GFP_KERNEL);
> +	if (!ldev)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&ldev->lock);
> +	ldev->dev =3D &pdev->dev;
> +
> +	ldev->irq =3D platform_get_irq(pdev, 0);
> +	if (ldev->irq < 0)
> +		return ldev->irq;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ldev->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
> +					      &locomo_regmap_config);
> +	if (IS_ERR(ldev->regmap))
> +		return PTR_ERR(ldev->regmap);
> +
> +	if (pdata) {
> +		locomo_gpio_pdata.gpio_base =3D pdata->gpio_base;
> +		locomo_lcd_pdata.comadj =3D pdata->comadj;
> +	} else {
> +		locomo_gpio_pdata.gpio_base =3D -1;
> +		locomo_lcd_pdata.comadj =3D 128;
> +	}
> +
> +	platform_set_drvdata(pdev, ldev);
> +
> +	regmap_read(ldev->regmap, LOCOMO_VER, &rev);
> +	dev_info(&pdev->dev, "LoCoMo Chip: %04x\n", rev);
> +
> +	/* Clear IRQ status and mask */
> +	regmap_write(ldev->regmap, LOCOMO_ICR, 0);
> +
> +	/* Longtime timer */
> +	regmap_write(ldev->regmap, LOCOMO_LTINT, 0);
> +
> +	ret =3D locomo_setup_irq(ldev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mfd_add_devices(&pdev->dev, pdev->id,
> +			locomo_cells, ARRAY_SIZE(locomo_cells),
> +			res, -1, ldev->domain);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	irq_set_chained_handler(ldev->irq, NULL);
> +	irq_set_handler_data(ldev->irq, NULL);
> +
> +	irq_domain_remove(ldev->domain);
> +
> +	return ret;
> +}
> +
> +static int locomo_remove(struct platform_device *dev)
> +{
> +	struct locomo *ldev =3D platform_get_drvdata(dev);
> +
> +	mfd_remove_devices(&dev->dev);
> +
> +	irq_set_chained_handler(ldev->irq, NULL);
> +	irq_set_handler_data(ldev->irq, NULL);
> +
> +	irq_domain_remove(ldev->domain);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver locomo_device_driver =3D {
> +	.probe	=3D locomo_probe,
> +	.remove	=3D locomo_remove,
> +	.driver	=3D {
> +		.name	=3D "locomo",
> +		.pm	=3D &locomo_pm,
> +	},
> +};
> +
> +module_platform_driver(locomo_device_driver);
> +
> +MODULE_DESCRIPTION("Sharp LoCoMo core driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
> +MODULE_ALIAS("platform:locomo");
> diff --git a/include/linux/mfd/locomo.h b/include/linux/mfd/locomo.h
> new file mode 100644
> index 0000000..999e3de
> --- /dev/null
> +++ b/include/linux/mfd/locomo.h
> @@ -0,0 +1,169 @@
> +/*
> + * This file contains the definitions for the LoCoMo G/A Chip
> + *
> + * (C) Copyright 2015 Dmitry Eremin-Solenikov
> + * (C) Copyright 2004 John Lenz
> + *
> + * May be copied or modified under the terms of the GNU General Publ=
ic
> + * License.  See linux/COPYING for more information.
> + *
> + * Based on sa1111.h
> + */
> +
> +#ifndef _ASM_ARCH_LOCOMO
> +#define _ASM_ARCH_LOCOMO
> +
> +/* LOCOMO chip version */
> +#define LOCOMO_VER	0x00
> +
> +/* Pin status */
> +#define LOCOMO_ST	0x04
> +
> +/* Pin status */
> +#define LOCOMO_C32K	0x08
> +
> +/* Interrupt controller */
> +#define LOCOMO_ICR	0x0c
> +#define LOCOMO_ICR_MASK_SHIFT	4
> +#define LOCOMO_ICR_STATUS_SHIFT	8
> +
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
> +#define LOCOMO_ACC_XON		0x80
> +#define LOCOMO_ACC_XEN		0x40
> +#define LOCOMO_ACC_XSEL0	0x00
> +#define LOCOMO_ACC_XSEL1	0x20
> +#define LOCOMO_ACC_MCLKEN	0x10
> +#define LOCOMO_ACC_64FSEN	0x08
> +#define LOCOMO_ACC_CLKSEL000	0x00	/* mclk  2 */
> +#define LOCOMO_ACC_CLKSEL001	0x01	/* mclk  3 */
> +#define LOCOMO_ACC_CLKSEL010	0x02	/* mclk  4 */
> +#define LOCOMO_ACC_CLKSEL011	0x03	/* mclk  6 */
> +#define LOCOMO_ACC_CLKSEL100	0x04	/* mclk  8 */
> +#define LOCOMO_ACC_CLKSEL101	0x05	/* mclk 12 */
> +
> +/* SPI interface */
> +#define LOCOMO_SPIMD	0x60		/* SPI mode setting */
> +#define LOCOMO_SPIMD_LOOPBACK BIT(15)	/* loopback tx to rx */
> +#define LOCOMO_SPIMD_MSB1ST   BIT(14)	/* send MSB first */
> +#define LOCOMO_SPIMD_DOSTAT   BIT(13)	/* transmit line is idle high =
*/
> +#define LOCOMO_SPIMD_TCPOL    BIT(11)	/* transmit CPOL (maybe affect=
s CPHA) */
> +#define LOCOMO_SPIMD_RCPOL    BIT(10)	/* receive CPOL (maybe affects=
 CPHA) */
> +#define LOCOMO_SPIMD_TDINV    BIT(9)	/* invert transmit line */
> +#define LOCOMO_SPIMD_RDINV    BIT(8)	/* invert receive line */
> +#define LOCOMO_SPIMD_XON      BIT(7)	/* enable spi controller clock =
*/
> +#define LOCOMO_SPIMD_XEN      BIT(6)	/* clock bit write enable */
> +#define LOCOMO_SPIMD_XSEL     0x0018	/* clock select */
> +/* xon must be off when enabling xen, wait 300 us before xon -> 1 */
> +#define CLOCK_18MHZ	      0		/* 18,432 MHz clock */
> +#define CLOCK_22MHZ	      1		/* 22,5792 MHz clock */
> +#define CLOCK_25MHZ	      2		/* 24,576 MHz clock */
> +#define LOCOMO_SPIMD_CLKSEL   0x7
> +#define DIV_1		      0		/* don't divide clock */
> +#define DIV_2		      1		/* divide clock by two */
> +#define DIV_4		      2		/* divide clock by four */
> +#define DIV_8		      3		/* divide clock by eight */
> +#define DIV_64		      4		/* divide clock by 64 */
> +
> +#define LOCOMO_SPICT	0x64		/* SPI mode control */
> +#define LOCOMO_SPICT_CRC16_7_B	BIT(15)	/* 0: crc16 1: crc7 */
> +#define LOCOMO_SPICT_CRCRX_TX_B	BIT(14)
> +#define LOCOMO_SPICT_CRCRESET_B	BIT(13)
> +#define LOCOMO_SPICT_CEN	BIT(7)	/* ?? enable */
> +#define LOCOMO_SPICT_CS		BIT(6)	/* chip select */
> +#define LOCOMO_SPICT_UNIT16	BIT(5)	/* 0: 8 bit, 1: 16 bit*/
> +#define LOCOMO_SPICT_ALIGNEN	BIT(2)	/* align transfer enable */
> +#define LOCOMO_SPICT_RXWEN	BIT(1)	/* continuous receive */
> +#define LOCOMO_SPICT_RXUEN	BIT(0)	/* aligned receive */
> +
> +#define LOCOMO_SPIST	0x68		/* SPI status */
> +#define LOCOMO_SPI_TEND		BIT(3)	/* Transfer end bit */
> +#define LOCOMO_SPI_REND		BIT(2)	/* Receive end bit */
> +#define LOCOMO_SPI_RFW		BIT(1)	/* write buffer bit */
> +#define LOCOMO_SPI_RFR		BIT(0)		/* read buffer bit */
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
> +#define LOCOMO_PAIF_SCINV	0x20
> +#define LOCOMO_PAIF_SCEN	0x10
> +#define LOCOMO_PAIF_LRCRST	0x08
> +#define LOCOMO_PAIF_LRCEVE	0x04
> +#define LOCOMO_PAIF_LRCINV	0x02
> +#define LOCOMO_PAIF_LRCEN	0x01
> +
> +/* Long time timer */
> +#define LOCOMO_LTC	0xd8		/* LTC interrupt setting */
> +#define LOCOMO_LTINT	0xdc		/* LTC interrupt */
> +
> +/* DAC control signal for LCD (COMADJ ) */
> +#define LOCOMO_DAC	0xe0
> +/* DAC control */
> +#define LOCOMO_DAC_SCLOEB	0x08	/* SCL pin output data       */
> +#define LOCOMO_DAC_TEST		0x04	/* Test bit                  */
> +#define LOCOMO_DAC_SDA		0x02	/* SDA pin level (read-only) */
> +#define LOCOMO_DAC_SDAOEB	0x01	/* SDA pin output data       */
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
> +
> +struct locomo_lcd_platform_data {
> +	u8 comadj;
> +};
> +
> +struct locomo_platform_data {
> +	unsigned int gpio_base;
> +	u8 comadj;
> +};
> +
> +#endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
