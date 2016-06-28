From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Tue, 28 Jun 2016 17:28:34 +0100
Message-ID: <20160628162834.GF29166@dell>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com
List-Id: linux-input@vger.kernel.org

On Fri, 24 Jun 2016, Ksenija Stanojevic wrote:

> Add core files for mxs-lradc MFD driver.
>=20
> Note:  this patch won't compile in iio/testing without this patch:
> a8f447be8056 ("mfd: Add resource managed APIs for mfd_add_devices")
>=20
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> Changes in v3:
>  - add note to commit message
>  - move switch statement into if(touch_ret =3D=3D 0) branch
>  - add MODULE_AUTHOR
>=20
> Changes in v2:
>  - do not change spacing in Kconfig
>  - make struct mfd_cell part of struct mxs_lradc
>  - use switch instead of if in mxs_lradc_irq_mask
>  - use only necessary header files in mxs_lradc.h
>  - use devm_mfd_add_device
>  - use separate function to register mfd device
>  - change licence to GPL
>  - add copyright
>=20
>  drivers/mfd/Kconfig           |  17 ++++
>  drivers/mfd/Makefile          |   1 +
>  drivers/mfd/mxs-lradc.c       | 217 ++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/mxs-lradc.h | 204 ++++++++++++++++++++++++++++++++=
+++++++
>  4 files changed, 439 insertions(+)
>  create mode 100644 drivers/mfd/mxs-lradc.c
>  create mode 100644 include/linux/mfd/mxs-lradc.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 9ca66de..62593ad 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -271,6 +271,23 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
> =20
> +config MFD_MXS_LRADC
> +	tristate "Freescale i.MX23/i.MX28 LRADC"
> +	depends on ARCH_MXS || COMPILE_TEST
> +	select MFD_CORE
> +	select STMP_DEVICE
> +	help
> +	  Say yes here to build support for the low-resolution
> +	  analog-to-digital converter (LRADC) found on the i.MX23 and i.MX2=
8

Low Resolution Analogue-to-Digital Converter=20

> +	  processors. This driver provides common support for accessing the
> +	  device, additional drivers must be enabled in order to use the
> +	  functionality of the device:
> +		mxs-lradc-adc for ADC readings
> +		mxs-lradc-ts  for touchscreen support
> +
> +	  This driver can also be built as a module. If so, the module will=
 be
> +	  called mxs-lradc.
> +
>  config MFD_HI6421_PMIC
>  	tristate "HiSilicon Hi6421 PMU/Codec IC"
>  	depends on OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0f230a6..ecf6399 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -198,3 +198,4 @@ intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o i=
ntel_soc_pmic_crc.o
>  intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+=3D intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
>  obj-$(CONFIG_MFD_MT6397)	+=3D mt6397-core.o
> +obj-$(CONFIG_MFD_MXS_LRADC)	+=3D mxs-lradc.o
> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
> new file mode 100644
> index 0000000..d53a524
> --- /dev/null
> +++ b/drivers/mfd/mxs-lradc.c
> @@ -0,0 +1,217 @@
> +/*
> + * Freescale MXS LRADC driver
> + *
> + * Copyright (c) 2012 DENX Software Engineering, GmbH.


You need to update the copyright.

Authors:

> + * Marek Vasut <marex@denx.de>
> + * Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/mxs-lradc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +static const char * const mx23_lradc_irq_names[] =3D {
> +	"mxs-lradc-touchscreen",
> +	"mxs-lradc-channel0",
> +	"mxs-lradc-channel1",
> +	"mxs-lradc-channel2",
> +	"mxs-lradc-channel3",
> +	"mxs-lradc-channel4",
> +	"mxs-lradc-channel5",
> +	"mxs-lradc-channel6",
> +	"mxs-lradc-channel7",
> +};
> +
> +static const char * const mx28_lradc_irq_names[] =3D {
> +	"mxs-lradc-touchscreen",
> +	"mxs-lradc-thresh0",
> +	"mxs-lradc-thresh1",
> +	"mxs-lradc-channel0",
> +	"mxs-lradc-channel1",
> +	"mxs-lradc-channel2",
> +	"mxs-lradc-channel3",
> +	"mxs-lradc-channel4",
> +	"mxs-lradc-channel5",
> +	"mxs-lradc-channel6",
> +	"mxs-lradc-channel7",
> +	"mxs-lradc-button0",
> +	"mxs-lradc-button1",
> +};
> +
> +struct mxs_lradc_of_config {
> +	const int		irq_count;
> +	const char * const	*irq_name;
> +};
> +
> +static const struct mxs_lradc_of_config mxs_lradc_of_config[] =3D {
> +	[IMX23_LRADC] =3D {
> +		.irq_count	=3D ARRAY_SIZE(mx23_lradc_irq_names),
> +		.irq_name	=3D mx23_lradc_irq_names,
> +	},
> +	[IMX28_LRADC] =3D {
> +		.irq_count	=3D ARRAY_SIZE(mx28_lradc_irq_names),
> +		.irq_name	=3D mx28_lradc_irq_names,
> +	},
> +};

Please use DEFINE_RES_IRQ_NAMED() instead.

> +static const struct of_device_id mxs_lradc_dt_ids[] =3D {
> +	{ .compatible =3D "fsl,imx23-lradc", .data =3D (void *)IMX23_LRADC,=
 },
> +	{ .compatible =3D "fsl,imx28-lradc", .data =3D (void *)IMX28_LRADC,=
 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
> +
> +static int mxs_lradc_add_device(struct platform_device *pdev,
> +				struct mxs_lradc *lradc, char *name, int i)
> +{
> +	struct mfd_cell *cell;
> +
> +	cell =3D &lradc->cells[i];
> +	cell->name =3D name;
> +	cell->platform_data =3D lradc;
> +	cell->pdata_size =3D sizeof(*lradc);
> +
> +	return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL)=
;
> +}

Please don't roll your own API.

Use 'struct mfd_cell' like everyone else does.

> +static int mxs_lradc_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id =3D
> +		of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> +	const struct mxs_lradc_of_config *of_cfg =3D
> +		&mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];

This implementation is wayyyy more complicated than it needs to be.

You've entangled DT probing with the MFD API.

Please use the MFD API properly.

> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *node =3D dev->of_node;
> +	struct mxs_lradc *lradc;
> +	struct resource *iores;
> +	int ret =3D 0, touch_ret, i;
> +	u32 ts_wires =3D 0;
> +
> +	lradc =3D devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> +	if (!lradc)
> +		return -ENOMEM;
> +	lradc->soc =3D (enum mxs_lradc_id)of_id->data;

If you're going to pull the platform ID out like this, please pull the
*_match_* function down, just above this line.  And separate them both
from allocating memory.

> +	/* Grab the memory area */

This comment doesn't add anything.

We know what these calls do, and they don't "grab" anything.

> +	iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	lradc->base =3D devm_ioremap_resource(dev, iores);
> +	if (IS_ERR(lradc->base))
> +		return PTR_ERR(lradc->base);
> +
> +	lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(lradc->clk)) {
> +		dev_err(dev, "Failed to get the delay unit clock\n");
> +		return PTR_ERR(lradc->clk);
> +	}

'\n' here.  Nice spacing makes code easier to follow.

> +	ret =3D clk_prepare_enable(lradc->clk);
> +	if (ret !=3D 0) {
> +		dev_err(dev, "Failed to enable the delay unit clock\n");
> +		return ret;
> +	}
> +
> +	touch_ret =3D of_property_read_u32(node, "fsl,lradc-touchscreen-wir=
es",
> +					 &ts_wires);

Why do you need more than one 'ret' variable?

> +	if (touch_ret =3D=3D 0) {
> +		lradc->buffer_vchans =3D BUFFER_VCHANS_LIMITED;

'\n' here  or else we think it's related to the switch().

> +		switch (ts_wires) {
> +		case 4:
> +			lradc->use_touchscreen =3D MXS_LRADC_TOUCHSCREEN_4WIRE;

This is not a good name for a variable.  It looks like a bool here,
but you're initialising with a configuration option.

> +			break;
> +		case 5:
> +			if (lradc->soc =3D=3D IMX28_LRADC) {
> +				lradc->use_touchscreen =3D
> +					MXS_LRADC_TOUCHSCREEN_5WIRE;
> +				break;
> +			}
> +			/* fall through an error message for i.MX23 */

"to an error"

> +		default:
> +			dev_err(&pdev->dev,
> +				"Unsupported number of touchscreen wires (%d)\n",
> +				ts_wires);
> +			return -EINVAL;

The clock is still enabled.

> +		}
> +	} else {
> +		lradc->buffer_vchans =3D BUFFER_VCHANS_ALL;
> +	}
> +
> +	lradc->irq_count =3D of_cfg->irq_count;
> +	lradc->irq_name =3D of_cfg->irq_name;
> +	for (i =3D 0; i < lradc->irq_count; i++) {
> +		lradc->irq[i] =3D platform_get_irq(pdev, i);
> +		if (lradc->irq[i] < 0) {
> +			ret =3D lradc->irq[i];
> +			goto err_clk;
> +		}
> +	}

You shouldn't be 'get'ing the IRQ here.

Where are you consuming these IRQs?

> +	platform_set_drvdata(pdev, lradc);
> +
> +	ret =3D stmp_reset_block(lradc->base);
> +	if (ret)
> +		return ret;


The clock is still enabled.


> +	ret =3D mxs_lradc_add_device(pdev, lradc, DRIVER_NAME_ADC, 0);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add the ADC subdevice\n");
> +		goto err_clk;
> +	}

Do this using statically defined mfd_cells.

> +	if (!lradc->use_touchscreen)
> +		return 0;
> +
> +	ret =3D mxs_lradc_add_device(pdev, lradc, DRIVER_NAME_TS, 1);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to add the touchscreen subdevice\n");
> +		goto err_clk;
> +	}
> +
> +	return 0;
> +
> +err_clk:
> +	clk_disable_unprepare(lradc->clk);
> +
> +	return ret;
> +}
> +
> +static int mxs_lradc_remove(struct platform_device *pdev)
> +{
> +	struct mxs_lradc *lradc =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(lradc->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mxs_lradc_driver =3D {
> +	.driver =3D {
> +		.name =3D "mxs-lradc",
> +		.of_match_table =3D mxs_lradc_dt_ids,
> +	},
> +	.probe =3D mxs_lradc_probe,
> +	.remove =3D mxs_lradc_remove,
> +};
> +

This line is superfluous.

> +module_platform_driver(mxs_lradc_driver);
> +
> +MODULE_AUTHOR("Ksenija Stanojevic <ksenija.stanojevic@gmail.com>");
> +MODULE_DESCRIPTION("Freescale i.MX23/i.MX28 LRADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mxs-lradc");
> diff --git a/include/linux/mfd/mxs-lradc.h b/include/linux/mfd/mxs-lr=
adc.h
> new file mode 100644
> index 0000000..c1475c0
> --- /dev/null
> +++ b/include/linux/mfd/mxs-lradc.h
> @@ -0,0 +1,204 @@
> +/*
> + * Freescale MXS LRADC driver
> + *
> + * Copyright (c) 2012 DENX Software Engineering, GmbH.

You need to update the copyright.

Author:

> + * Marek Vasut <marex@denx.de>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __MXS_LRADC_H
> +#define __MXS_LRADC_H

__MFD_MXS_*

> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/stmp_device.h>
> +
> +#define DRIVER_NAME_ADC "mxs-lradc-adc"
> +#define DRIVER_NAME_TS "mxs-lradc-ts"

Don't define these.  Just use the proper names.

> +#define LRADC_MAX_DELAY_CHANS	4
> +#define LRADC_MAX_MAPPED_CHANS	8
> +#define LRADC_MAX_TOTAL_CHANS	16
> +
> +#define LRADC_DELAY_TIMER_HZ	2000
> +
> +#define LRADC_CTRL0				0x00
> +# define LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE	BIT(23)
> +# define LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE	BIT(22)
> +# define LRADC_CTRL0_MX28_YNNSW /* YM */	BIT(21)
> +# define LRADC_CTRL0_MX28_YPNSW /* YP */	BIT(20)
> +# define LRADC_CTRL0_MX28_YPPSW /* YP */	BIT(19)
> +# define LRADC_CTRL0_MX28_XNNSW /* XM */	BIT(18)
> +# define LRADC_CTRL0_MX28_XNPSW /* XM */	BIT(17)
> +# define LRADC_CTRL0_MX28_XPPSW /* XP */	BIT(16)
> +
> +# define LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE	BIT(20)
> +# define LRADC_CTRL0_MX23_YM			BIT(19)
> +# define LRADC_CTRL0_MX23_XM			BIT(18)
> +# define LRADC_CTRL0_MX23_YP			BIT(17)
> +# define LRADC_CTRL0_MX23_XP			BIT(16)
> +
> +# define LRADC_CTRL0_MX28_PLATE_MASK \
> +		(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE | \
> +		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
> +		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
> +		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW)
> +
> +# define LRADC_CTRL0_MX23_PLATE_MASK \
> +		(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE | \
> +		LRADC_CTRL0_MX23_YM | LRADC_CTRL0_MX23_XM | \
> +		LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XP)
> +
> +#define LRADC_CTRL1				0x10
> +#define LRADC_CTRL1_TOUCH_DETECT_IRQ_EN		BIT(24)
> +#define LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
> +#define LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
> +#define LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK	(0x01ff << 16)
> +#define LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
> +#define LRADC_CTRL1_TOUCH_DETECT_IRQ		BIT(8)
> +#define LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
> +#define LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff
> +#define LRADC_CTRL1_MX23_LRADC_IRQ_MASK		0x01ff
> +#define LRADC_CTRL1_LRADC_IRQ_OFFSET		0
> +
> +#define LRADC_CTRL2				0x20
> +#define LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET	24
> +#define LRADC_CTRL2_TEMPSENSE_PWD		BIT(15)
> +
> +#define LRADC_STATUS				0x40
> +#define LRADC_STATUS_TOUCH_DETECT_RAW		BIT(0)
> +
> +#define LRADC_CH(n)				(0x50 + (0x10 * (n)))
> +#define LRADC_CH_ACCUMULATE			BIT(29)
> +#define LRADC_CH_NUM_SAMPLES_MASK		(0x1f << 24)
> +#define LRADC_CH_NUM_SAMPLES_OFFSET		24
> +#define LRADC_CH_NUM_SAMPLES(x) \
> +				((x) << LRADC_CH_NUM_SAMPLES_OFFSET)
> +#define LRADC_CH_VALUE_MASK			0x3ffff
> +#define LRADC_CH_VALUE_OFFSET			0
> +
> +#define LRADC_DELAY(n)				(0xd0 + (0x10 * (n)))
> +#define LRADC_DELAY_TRIGGER_LRADCS_MASK		(0xffUL << 24)
> +#define LRADC_DELAY_TRIGGER_LRADCS_OFFSET	24
> +#define LRADC_DELAY_TRIGGER(x) \
> +				(((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
> +				LRADC_DELAY_TRIGGER_LRADCS_MASK)
> +#define LRADC_DELAY_KICK			BIT(20)
> +#define LRADC_DELAY_TRIGGER_DELAYS_MASK		(0xf << 16)
> +#define LRADC_DELAY_TRIGGER_DELAYS_OFFSET	16
> +#define LRADC_DELAY_TRIGGER_DELAYS(x) \
> +				(((x) << LRADC_DELAY_TRIGGER_DELAYS_OFFSET) & \
> +				LRADC_DELAY_TRIGGER_DELAYS_MASK)
> +#define LRADC_DELAY_LOOP_COUNT_MASK		(0x1f << 11)
> +#define LRADC_DELAY_LOOP_COUNT_OFFSET		11
> +#define LRADC_DELAY_LOOP(x) \
> +				(((x) << LRADC_DELAY_LOOP_COUNT_OFFSET) & \
> +				LRADC_DELAY_LOOP_COUNT_MASK)
> +#define LRADC_DELAY_DELAY_MASK			0x7ff
> +#define LRADC_DELAY_DELAY_OFFSET		0
> +#define LRADC_DELAY_DELAY(x) \
> +				(((x) << LRADC_DELAY_DELAY_OFFSET) & \
> +				LRADC_DELAY_DELAY_MASK)
> +
> +#define LRADC_CTRL4				0x140
> +#define LRADC_CTRL4_LRADCSELECT_MASK(n)		(0xf << ((n) * 4))
> +#define LRADC_CTRL4_LRADCSELECT_OFFSET(n)	((n) * 4)
> +#define LRADC_CTRL4_LRADCSELECT(n, x) \
> +				(((x) << LRADC_CTRL4_LRADCSELECT_OFFSET(n)) & \
> +				LRADC_CTRL4_LRADCSELECT_MASK(n))
> +
> +#define LRADC_RESOLUTION			12
> +#define LRADC_SINGLE_SAMPLE_MASK		((1 << LRADC_RESOLUTION) - 1)
> +
> +enum mxs_lradc_id {
> +	IMX23_LRADC,
> +	IMX28_LRADC,
> +};
> +
> +enum mxs_lradc_ts_wires {
> +	MXS_LRADC_TOUCHSCREEN_NONE =3D 0,
> +	MXS_LRADC_TOUCHSCREEN_4WIRE,
> +	MXS_LRADC_TOUCHSCREEN_5WIRE,
> +};
> +
> +struct mxs_lradc {
> +	enum mxs_lradc_id	soc;
> +
> +	void __iomem		*base;
> +	struct clk		*clk;
> +
> +	int			irq[13];
> +	const char * const	*irq_name;
> +	int			irq_count;

I guess you won't be needing these.

> +#define BUFFER_VCHANS_LIMITED		0x3f
> +#define BUFFER_VCHANS_ALL		0xff

Can you remove all these defines from inside the struct definition
please?

> +	u8			buffer_vchans;
> +
> +	/*
> +	 * Certain LRADC channels are shared between touchscreen
> +	 * and/or touch-buttons and generic LRADC block. Therefore when usi=
ng
> +	 * either of these, these channels are not available for the regula=
r
> +	 * sampling. The shared channels are as follows:
> +	 *
> +	 * CH0 -- Touch button #0
> +	 * CH1 -- Touch button #1
> +	 * CH2 -- Touch screen XPUL
> +	 * CH3 -- Touch screen YPLL
> +	 * CH4 -- Touch screen XNUL
> +	 * CH5 -- Touch screen YNLR
> +	 * CH6 -- Touch screen WIPER (5-wire only)
> +	 *
> +	 * The bit fields below represents which parts of the LRADC block a=
re
> +	 * switched into special mode of operation. These channels can not
> +	 * be sampled as regular LRADC channels. The driver will refuse any
> +	 * attempt to sample these channels.
> +	 */
> +#define CHAN_MASK_TOUCHBUTTON		(BIT(1) | BIT(0))
> +#define CHAN_MASK_TOUCHSCREEN_4WIRE	(0xf << 2)
> +#define CHAN_MASK_TOUCHSCREEN_5WIRE	(0x1f << 2)
> +	enum mxs_lradc_ts_wires	use_touchscreen;
> +	bool			use_touchbutton;
> +
> +#define MXS_LRADC_CELLS			2
> +	struct mfd_cell cells[MXS_LRADC_CELLS];
> +};
> +
> +static inline void mxs_lradc_reg_set(struct mxs_lradc *lradc, u32 va=
l, u32 reg)
> +{
> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_SET);
> +}
> +
> +static inline void mxs_lradc_reg_clear(struct mxs_lradc *lradc, u32 =
val,
> +				       u32 reg)
> +{
> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_CLR);
> +}
> +
> +static inline void mxs_lradc_reg_wrt(struct mxs_lradc *lradc, u32 va=
l, u32 reg)
> +{
> +	writel(val, lradc->base + reg);
> +}

Why do you need to abstract the well know, accepted writel calls?

> +static inline u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
> +{
> +	switch (lradc->soc) {
> +	case IMX23_LRADC:
> +		return LRADC_CTRL1_MX23_LRADC_IRQ_MASK;
> +	case IMX28_LRADC:
> +		return LRADC_CTRL1_MX28_LRADC_IRQ_MASK;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +#endif /* __MXS_LRADC_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
