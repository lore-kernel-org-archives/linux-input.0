From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v9 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Mon, 14 Nov 2016 19:43:44 +0100
Message-ID: <9560d7a2-98b2-732d-c91a-944ae381107c@denx.de>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
 <c18883dfacaaf40ab98cbb4938d5164a95a817d7.1478071676.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c18883dfacaaf40ab98cbb4938d5164a95a817d7.1478071676.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com
List-Id: linux-input@vger.kernel.org

On 11/02/2016 08:38 AM, Ksenija Stanojevic wrote:
> Add core files for low resolution analog-to-digital converter (mxs-lradc)
> MFD driver.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> ---
> Changes in v9:
>  - improve commit message.
> 
> Changes in v8:
>  - rebase onto 4.9-rc1
> 
> Changes in v7:
>  - define macros ADC_CELL and TSC_CELL
>  - remove one cell and dynamically set them in the switch()
>  - fail in the touchscreen driver instead of mfd driver if
>    hardware doesn't contain a touchscreen
> 
> Changes in v6:
>  - update copyright
>  - add kernel-doc header for struct mxs-lradc
>  - add error message
>  - change EINVAL to ENODEV
>  - use PLATFORM_DEVID_NONE instead -1
>  - cosmetic fixes
> 
> Changes in v5:
>  - use DEFINE_RES_MEM
>  - don't pass ioreammaped adress to platform cells
>  - move comment outside of struct mxs_lradc
>  - change type of argument in mxs_lradc_reg_set, mxs_lradc_reg_clear,
>    mxs_lradc_reg_wrt (struct mxs_lradc * -> void __iomem *)
> 
> Changes in v4:
>  - update copyright
>  - use DEFINE_RES_IRQ_NAMED
>  - remove mxs_lradc_add_device function
>  - use struct mfd_cell in static form
>  - improve spacing
>  - remove unnecessary comment
>  - remove platform_get_irq
>  - remove touch_ret and use ret instead
>  - rename use_touchscreen to touchscreen_wire
>  - use goto statements
>  - remove irq[13], irq_count and irq_name from struct mxs_lradc
>  - remove all defines from inside the struct definition
> 
> Changes in v3:
>  - add note to commit message
>  - move switch statement into if(touch_ret == 0) branch
>  - add MODULE_AUTHOR
> 
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
>  drivers/mfd/Kconfig           |  17 +++
>  drivers/mfd/Makefile          |   1 +
>  drivers/mfd/mxs-lradc.c       | 249 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mxs-lradc.h | 203 ++++++++++++++++++++++++++++++++++
>  4 files changed, 470 insertions(+)
>  create mode 100644 drivers/mfd/mxs-lradc.c
>  create mode 100644 include/linux/mfd/mxs-lradc.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index c6df644..bdd88cf 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -326,6 +326,23 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
>  
> +config MFD_MXS_LRADC
> +	tristate "Freescale i.MX23/i.MX28 LRADC"
> +	depends on ARCH_MXS || COMPILE_TEST
> +	select MFD_CORE
> +	select STMP_DEVICE
> +	help
> +	  Say yes here to build support for the Low Resolution
> +	  Analog-to-Digital Converter (LRADC) found on the i.MX23 and i.MX28
> +	  processors. This driver provides common support for accessing the
> +	  device, additional drivers must be enabled in order to use the
> +	  functionality of the device:
> +		mxs-lradc-adc for ADC readings
> +		mxs-lradc-ts  for touchscreen support
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called mxs-lradc.
> +
>  config MFD_MX25_TSADC
>  	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
>  	select REGMAP_MMIO
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 9834e66..057ca15 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -211,3 +211,4 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> +obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
> new file mode 100644
> index 0000000..ffc8f2e
> --- /dev/null
> +++ b/drivers/mfd/mxs-lradc.c
> @@ -0,0 +1,249 @@
> +/*
> + * Freescale MXS Low Resolution Analog-to-Digital Converter driver
> + *
> + * Copyright (c) 2012 DENX Software Engineering, GmbH.
> + * Copyright (c) 2016 Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> + *
> + * Authors:
> + *  Marek Vasut <marex@denx.de>
> + *  Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
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
> +#define MXS_LRADC_BASE		0x80050000

Just for my understanding, why is this hardware address hard-coded here?
Shouldn't that be fetched from DT ?

> +#define ADC_CELL		0
> +#define TSC_CELL		1

[...]

-- 
Best regards,
Marek Vasut
