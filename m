From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Wed, 15 Jun 2016 23:17:34 +0200 (CEST)
Message-ID: <1140122548.58727.3de61248-4cae-4f94-b8a2-ef63c5c3ec1b.open-xchange@email.1und1.de>
References: <cover.1465396835.git.ksenija.stanojevic@gmail.com>
 <ff8e494d6dbb4fad74e86c27d7823dfa6ff70f7a.1465396835.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:63449 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbcFOVSC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2016 17:18:02 -0400
In-Reply-To: <ff8e494d6dbb4fad74e86c27d7823dfa6ff70f7a.1465396835.git.ksenija.stanojevic@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, linux-input@vger.kernel.org, pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, dmitry.torokhov@gmail.com, harald@ccbib.org, fabio.estevam@freescale.com, linux-iio@vger.kernel.org, marex@denx.de

Hi Ksenija,

sorry for the late review, but i was busy.

> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 8. Juni 2016 um 16:45
> geschrieben:
> 
> 
> Add core files for mxs-lradc MFD driver.

I think it's worth to mention that this patch won't compile in iio/testing
without this patch:

a8f447be8056 ("mfd: Add resource managed APIs for mfd_add_devices")

> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> ---
> Changes in v2:
>  - do not change spacing in Kconfig
>  - make struct mfd_cell part of struct mxs_lradc
>  - use switch instead of if in mxs_lradc_irq_mask
>  - use only necessary header files in mxs_lradc.h
>  - use devm_mfd_add_device
>  - use separate function to register mfd device
>  - change licence to GPL
>  - add copyright
> 
>  drivers/mfd/Kconfig           |  17 ++++
>  drivers/mfd/Makefile          |   1 +
>  drivers/mfd/mxs-lradc.c       | 215
> ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mxs-lradc.h | 204 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 437 insertions(+)
>  create mode 100644 drivers/mfd/mxs-lradc.c
>  create mode 100644 include/linux/mfd/mxs-lradc.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 9ca66de..62593ad 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -271,6 +271,23 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
>  
> +config MFD_MXS_LRADC
> +	tristate "Freescale i.MX23/i.MX28 LRADC"
> +	depends on ARCH_MXS || COMPILE_TEST
> +	select MFD_CORE
> +	select STMP_DEVICE
> +	help
> +	  Say yes here to build support for the low-resolution
> +	  analog-to-digital converter (LRADC) found on the i.MX23 and i.MX28
> +	  processors. This driver provides common support for accessing the
> +	  device, additional drivers must be enabled in order to use the
> +	  functionality of the device:
> +		mxs-lradc-adc for ADC readings
> +		mxs-lradc-ts  for touchscreen support
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called mxs-lradc.
> +
>  config MFD_HI6421_PMIC
>  	tristate "HiSilicon Hi6421 PMU/Codec IC"
>  	depends on OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0f230a6..ecf6399 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -198,3 +198,4 @@ intel-soc-pmic-objs		:= intel_soc_pmic_core.o
> intel_soc_pmic_crc.o
>  intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
> +obj-$(CONFIG_MFD_MXS_LRADC)	+= mxs-lradc.o
> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
> new file mode 100644
> index 0000000..5e894bb
> --- /dev/null
> +++ b/drivers/mfd/mxs-lradc.c
> @@ -0,0 +1,215 @@
> +/*
> + * Freescale MXS LRADC driver
> + *
> + * Copyright (c) 2012 DENX Software Engineering, GmbH.
> + * Marek Vasut <marex@denx.de>
> + * Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
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
> +static const char * const mx23_lradc_irq_names[] = {
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
> +static const char * const mx28_lradc_irq_names[] = {
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
> +static const struct mxs_lradc_of_config mxs_lradc_of_config[] = {
> +	[IMX23_LRADC] = {
> +		.irq_count	= ARRAY_SIZE(mx23_lradc_irq_names),
> +		.irq_name	= mx23_lradc_irq_names,
> +	},
> +	[IMX28_LRADC] = {
> +		.irq_count	= ARRAY_SIZE(mx28_lradc_irq_names),
> +		.irq_name	= mx28_lradc_irq_names,
> +	},
> +};
> +
> +static const struct of_device_id mxs_lradc_dt_ids[] = {
> +	{ .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
> +	{ .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
> +
> +static int mxs_lradc_add_device(struct platform_device *pdev,
> +				struct mxs_lradc *lradc, char *name, int i)
> +{
> +	struct mfd_cell *cell;
> +
> +	cell = &lradc->cells[i];
> +	cell->name = name;
> +	cell->platform_data = lradc;
> +	cell->pdata_size = sizeof(*lradc);
> +
> +	return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
> +}
> +
> +static int mxs_lradc_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id =
> +		of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> +	const struct mxs_lradc_of_config *of_cfg =
> +		&mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct mxs_lradc *lradc;
> +	struct resource *iores;
> +	int ret = 0, touch_ret, i;
> +	u32 ts_wires = 0;
> +
> +	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> +	if (!lradc)
> +		return -ENOMEM;
> +	lradc->soc = (enum mxs_lradc_id)of_id->data;
> +
> +	/* Grab the memory area */
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	lradc->base = devm_ioremap_resource(dev, iores);
> +	if (IS_ERR(lradc->base))
> +		return PTR_ERR(lradc->base);
> +
> +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(lradc->clk)) {
> +		dev_err(dev, "Failed to get the delay unit clock\n");
> +		return PTR_ERR(lradc->clk);
> +	}
> +	ret = clk_prepare_enable(lradc->clk);
> +	if (ret != 0) {
> +		dev_err(dev, "Failed to enable the delay unit clock\n");
> +		return ret;
> +	}
> +
> +	touch_ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
> +					 &ts_wires);
> +
> +	if (touch_ret == 0)
> +		lradc->buffer_vchans = BUFFER_VCHANS_LIMITED;
> +	else
> +		lradc->buffer_vchans = BUFFER_VCHANS_ALL;
> +
> +	lradc->irq_count = of_cfg->irq_count;
> +	lradc->irq_name = of_cfg->irq_name;
> +	for (i = 0; i < lradc->irq_count; i++) {
> +		lradc->irq[i] = platform_get_irq(pdev, i);
> +		if (lradc->irq[i] < 0) {
> +			ret = lradc->irq[i];
> +			goto err_clk;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, lradc);
> +
> +	ret = stmp_reset_block(lradc->base);
> +	if (ret)
> +		return ret;
> +
> +	switch (ts_wires) {
> +	case 4:
> +		lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_4WIRE;
> +		break;
> +	case 5:
> +		if (lradc->soc == IMX28_LRADC) {
> +			lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_5WIRE;
> +			break;
> +		}
> +		/* fall through an error message for i.MX23 */
> +	default:
> +		dev_err(&pdev->dev,
> +			"Unsupported number of touchscreen wires (%d)\n",
> +			ts_wires);
> +		return -EINVAL;
> +	}

The complete switch statement should be in the if (touch_ret == 0) branch:
* so we don't reset the block in case of invalid devicetree settings
* handle the optional property fsl,lradc-touchscreen-wires correctly

> +
> +	ret = mxs_lradc_add_device(pdev, lradc, DRIVER_NAME_ADC, 0);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add the ADC subdevice\n");
> +		goto err_clk;
> +	}
> +
> +	if (!lradc->use_touchscreen)
> +		return 0;
> +
> +	ret = mxs_lradc_add_device(pdev, lradc, DRIVER_NAME_TS, 1);
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
> +	struct mxs_lradc *lradc = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(lradc->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mxs_lradc_driver = {
> +	.driver = {
> +		.name = "mxs-lradc",
> +		.of_match_table = mxs_lradc_dt_ids,
> +	},
> +	.probe = mxs_lradc_probe,
> +	.remove = mxs_lradc_remove,
> +};
> +
> +module_platform_driver(mxs_lradc_driver);
> +
> +MODULE_DESCRIPTION("Freescale i.MX23/i.MX28 LRADC driver");
> +MODULE_LICENSE("GPL");

MODULE_AUTHOR ?

> +MODULE_ALIAS("platform:mxs-lradc");
