From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH 1/3] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Fri, 29 Apr 2016 15:43:28 +0200
Message-ID: <CAL7P5j+E1WzC9AsS=ge4oHVTwq7Tov=kGbfJSKGyRzjg6Arg5Q@mail.gmail.com>
References: <cover.1461930102.git.ksenija.stanojevic@gmail.com>
	<a93050366ed452b147652abfad21a87f4af87bfb.1461930102.git.ksenija.stanojevic@gmail.com>
	<57235E75.9060409@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33739 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbcD2Nna (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Apr 2016 09:43:30 -0400
In-Reply-To: <57235E75.9060409@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, Harald Geyer <harald@ccbib.org>

On Fri, Apr 29, 2016 at 3:15 PM, Marek Vasut <marex@denx.de> wrote:
> On 04/29/2016 01:47 PM, Ksenija Stanojevic wrote:
>> Add core files for mxs-lradc MFD driver.
>>
>> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>> ---
>>  drivers/mfd/Kconfig           |  33 +++++--
>>  drivers/mfd/Makefile          |   1 +
>>  drivers/mfd/mxs-lradc.c       | 213 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/mxs-lradc.h | 210 +++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 449 insertions(+), 8 deletions(-)
>>  create mode 100644 drivers/mfd/mxs-lradc.c
>>  create mode 100644 include/linux/mfd/mxs-lradc.h
>
> Is there any chance you can also remove the same code from lradc ?

You mean drivers/iio/adc/mxs-lradc.c. I thought to remove it once this
patch set was accepted,
but I can include that in patch set.

>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index eea61e3..fff44d6 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -16,7 +16,7 @@ config MFD_CS5535
>>       depends on PCI && (X86_32 || (X86 && COMPILE_TEST))
>>       ---help---
>>         This is the core driver for CS5535/CS5536 MFD functions.  This is
>> -          necessary for using the board's GPIO and MFGPT functionality.
>> +       necessary for using the board's GPIO and MFGPT functionality.
>
> Probably shouldn't be part of the patch ?

Yeah, sorry about that.

>>  config MFD_ACT8945A
>>       tristate "Active-semi ACT8945A"
>> @@ -319,6 +319,23 @@ config MFD_HI6421_PMIC
>>         menus in order to enable them.
>>         We communicate with the Hi6421 via memory-mapped I/O.
>>
>> +config MFD_MXS_LRADC
>> +     tristate "Freescale i.MX23/i.MX28 LRADC"
>> +     depends on ARCH_MXS || COMPILE_TEST
>> +     select MFD_CORE
>> +     select STMP_DEVICE
>> +     help
>> +       Say yes here to build support for the low-resolution
>> +       analog-to-digital converter (LRADC) found on the i.MX23 and i.MX28
>> +       processors. This driver provides common support for accessing the
>> +       device, additional drivers must be enabled in order to use the
>> +       functionality of the device:
>> +             mxs-lradc-adc for ADC readings
>> +             mxs-lradc-ts  for touchscreen support
>> +
>> +       This driver can also be built as a module. If so, the module will be
>> +       called mxs-lradc.
>> +
>>  config HTC_EGPIO
>>       bool "HTC EGPIO support"
>>       depends on GPIOLIB && ARM
>> @@ -650,7 +667,7 @@ config EZX_PCAP
>>         needed for MMC, TouchScreen, Sound, USB, etc..
>>
>>  config MFD_VIPERBOARD
>> -        tristate "Nano River Technologies Viperboard"
>> +     tristate "Nano River Technologies Viperboard"
>
> Shouldn't be part of this patch

No, I should have check it twice.

>>       select MFD_CORE
>>       depends on USB
>>       default n
>> @@ -898,11 +915,11 @@ config MFD_SMSC
>>         select MFD_CORE
>>         select REGMAP_I2C
>>         help
>> -        If you say yes here you get support for the
>> -        ece1099 chips from SMSC.
>> +     If you say yes here you get support for the
>> +     ece1099 chips from SMSC.
>
> DTTO
>
>> -        To compile this driver as a module, choose M here: the
>> -        module will be called smsc.
>> +     To compile this driver as a module, choose M here: the
>> +     module will be called smsc.
>>
>>  config ABX500_CORE
>>       bool "ST-Ericsson ABX500 Mixed Signal Circuit register functions"
>> @@ -956,8 +973,8 @@ config AB8500_DEBUG
>>         depends on AB8500_GPADC && DEBUG_FS
>>         default y if DEBUG_FS
>>         help
>> -         Select this option if you want debug information using the debug
>> -         filesystem, debugfs.
>> +      Select this option if you want debug information using the debug
>> +      filesystem, debugfs.
>
> Same here
>
>>  config AB8500_GPADC
>>       bool "ST-Ericsson AB8500 GPADC driver"
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 5eaa6465d..236b831 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -203,3 +203,4 @@ intel-soc-pmic-objs               := intel_soc_pmic_core.o intel_soc_pmic_crc.o
>>  intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)       += intel_soc_pmic_bxtwc.o
>>  obj-$(CONFIG_INTEL_SOC_PMIC) += intel-soc-pmic.o
>>  obj-$(CONFIG_MFD_MT6397)     += mt6397-core.o
>> +obj-$(CONFIG_MFD_MXS_LRADC)  += mxs-lradc.o
>> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
>> new file mode 100644
>> index 0000000..e1c8f9e
>> --- /dev/null
>> +++ b/drivers/mfd/mxs-lradc.c
>> @@ -0,0 +1,213 @@
>> +/*
>> + * Freescale MXS LRADC driver
>> + *
>> + * Copyright (c) 2012 DENX Software Engineering, GmbH.
>> + * Marek Vasut <marex@denx.de>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/mxs-lradc.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +static struct mfd_cell lradc_adc_dev = {
>> +     .name = DRIVER_NAME_ADC,
>> +};
>> +
>> +static struct mfd_cell lradc_ts_dev = {
>> +     .name = DRIVER_NAME_TS,
>> +};
>> +
>> +static const char * const mx23_lradc_irq_names[] = {
>> +     "mxs-lradc-touchscreen",
>> +     "mxs-lradc-channel0",
>> +     "mxs-lradc-channel1",
>> +     "mxs-lradc-channel2",
>> +     "mxs-lradc-channel3",
>> +     "mxs-lradc-channel4",
>> +     "mxs-lradc-channel5",
>> +     "mxs-lradc-channel6",
>> +     "mxs-lradc-channel7",
>> +};
>> +
>> +static const char * const mx28_lradc_irq_names[] = {
>> +     "mxs-lradc-touchscreen",
>> +     "mxs-lradc-thresh0",
>> +     "mxs-lradc-thresh1",
>> +     "mxs-lradc-channel0",
>> +     "mxs-lradc-channel1",
>> +     "mxs-lradc-channel2",
>> +     "mxs-lradc-channel3",
>> +     "mxs-lradc-channel4",
>> +     "mxs-lradc-channel5",
>> +     "mxs-lradc-channel6",
>> +     "mxs-lradc-channel7",
>> +     "mxs-lradc-button0",
>> +     "mxs-lradc-button1",
>> +};
>> +
>> +struct mxs_lradc_of_config {
>> +     const int               irq_count;
>> +     const char * const      *irq_name;
>> +};
>> +
>> +static const struct mxs_lradc_of_config mxs_lradc_of_config[] = {
>> +     [IMX23_LRADC] = {
>> +             .irq_count      = ARRAY_SIZE(mx23_lradc_irq_names),
>> +             .irq_name       = mx23_lradc_irq_names,
>> +     },
>> +     [IMX28_LRADC] = {
>> +             .irq_count      = ARRAY_SIZE(mx28_lradc_irq_names),
>> +             .irq_name       = mx28_lradc_irq_names,
>> +     },
>> +};
>> +
>> +static const struct of_device_id mxs_lradc_dt_ids[] = {
>> +     { .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
>> +     { .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
>> +
>> +static int mxs_lradc_probe(struct platform_device *pdev)
>> +{
>> +     const struct of_device_id *of_id =
>> +             of_match_device(mxs_lradc_dt_ids, &pdev->dev);
>> +     const struct mxs_lradc_of_config *of_cfg =
>> +             &mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
>> +     struct device *dev = &pdev->dev;
>> +     struct device_node *node = dev->of_node;
>> +     struct mxs_lradc *lradc;
>> +     struct resource *iores;
>> +     int ret = 0, touch_ret, i;
>> +     u32 ts_wires = 0;
>> +
>> +     lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
>> +     if (!lradc)
>> +             return -ENOMEM;
>> +     lradc->soc = (enum mxs_lradc_id)of_id->data;
>> +
>> +     /* Grab the memory area */
>> +     iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     lradc->base = devm_ioremap_resource(dev, iores);
>> +     if (IS_ERR(lradc->base))
>> +             return PTR_ERR(lradc->base);
>> +
>> +     lradc->clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(lradc->clk)) {
>> +             dev_err(dev, "Failed to get the delay unit clock\n");
>> +             return PTR_ERR(lradc->clk);
>> +     }
>> +     ret = clk_prepare_enable(lradc->clk);
>> +     if (ret != 0) {
>> +             dev_err(dev, "Failed to enable the delay unit clock\n");
>> +             return ret;
>> +     }
>> +
>> +     touch_ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
>> +                                      &ts_wires);
>> +
>> +     if (touch_ret == 0)
>> +             lradc->buffer_vchans = BUFFER_VCHANS_LIMITED;
>> +     else
>> +             lradc->buffer_vchans = BUFFER_VCHANS_ALL;
>> +
>> +     lradc->irq_count = of_cfg->irq_count;
>> +     lradc->irq_name = of_cfg->irq_name;
>> +     for (i = 0; i < lradc->irq_count; i++) {
>> +             lradc->irq[i] = platform_get_irq(pdev, i);
>> +             if (lradc->irq[i] < 0) {
>> +                     ret = lradc->irq[i];
>> +                     goto err_clk;
>> +             }
>> +     }
>> +
>> +     platform_set_drvdata(pdev, lradc);
>> +
>> +     ret = stmp_reset_block(lradc->base);
>> +
>
> Drop this newline here
>
>> +     if (ret)
>> +             return ret;
>> +
>> +     lradc_adc_dev.platform_data = lradc;
>> +     lradc_adc_dev.pdata_size = sizeof(*lradc);
>> +
>> +     ret = mfd_add_devices(&pdev->dev, -1, &lradc_adc_dev, 1, NULL, 0, NULL);
>
> devm_mfd_add_devices()?
>
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "Failed to add the ADC subdevice\n");
>> +             return ret;
>> +     }
>> +
>> +     lradc_ts_dev.platform_data = lradc;
>> +     lradc_ts_dev.pdata_size = sizeof(*lradc);
>> +
>> +     switch (ts_wires) {
>> +     case 4:
>> +             lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_4WIRE;
>> +             break;
>> +     case 5:
>> +             if (lradc->soc == IMX28_LRADC) {
>> +                     lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_5WIRE;
>> +                     break;
>> +             }
>> +             /* fall through an error message for i.MX23 */
>> +     default:
>> +             dev_err(&pdev->dev,
>> +                     "Unsupported number of touchscreen wires (%d)\n",
>> +                     ts_wires);
>> +             return -EINVAL;
>> +     }
>> +
>> +     ret = mfd_add_devices(&pdev->dev, -1, &lradc_ts_dev, 1, NULL, 0, NULL);
>
> devm_mfd_add_devices()?
>
> You might want to split registration of each MFD subdev into separate
> function.

Ok, I will fix it in v2

>> +     if (ret) {
>> +             dev_err(&pdev->dev,
>> +                     "Failed to add the touchscreen subdevice\n");
>> +             goto err_remove_adc;
>> +     }
>> +
>> +     return 0;
>> +
>> +err_remove_adc:
>> +     mfd_remove_devices(&pdev->dev);
>> +err_clk:
>> +     clk_disable_unprepare(lradc->clk);
>> +     return ret;
>> +}
>> +
>> +static int mxs_lradc_remove(struct platform_device *pdev)
>> +{
>> +     struct mxs_lradc *lradc = platform_get_drvdata(pdev);
>> +
>> +     mfd_remove_devices(&pdev->dev);
>> +     clk_disable_unprepare(lradc->clk);
>> +     return 0;
>> +}
>> +
>> +static struct platform_driver mxs_lradc_driver = {
>> +     .driver = {
>> +             .name = "mxs-lradc",
>> +             .of_match_table = mxs_lradc_dt_ids,
>> +     },
>> +     .probe = mxs_lradc_probe,
>> +     .remove = mxs_lradc_remove,
>> +};
>> +
>> +module_platform_driver(mxs_lradc_driver);
>> +
>> +MODULE_DESCRIPTION("Freescale i.MX23/i.MX28 LRADC driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:mxs-lradc");
>
> [...]
>
>
> --
> Best regards,
> Marek Vasut
