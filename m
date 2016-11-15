From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Tue, 15 Nov 2016 18:06:17 +0100
Message-ID: <CAL7P5jLxDfWNwSCPfbUEhDte3kEOwh1+2deSzfrB_qkxDpmvMg@mail.gmail.com>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
 <c18883dfacaaf40ab98cbb4938d5164a95a817d7.1478071676.git.ksenija.stanojevic@gmail.com>
 <9560d7a2-98b2-732d-c91a-944ae381107c@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9560d7a2-98b2-732d-c91a-944ae381107c-ynQEQJNshbs@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 14, 2016 at 7:43 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> On 11/02/2016 08:38 AM, Ksenija Stanojevic wrote:
>> Add core files for low resolution analog-to-digital converter (mxs-lradc)
>> MFD driver.
>>
>> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> Changes in v9:
>>  - improve commit message.
>>
>> Changes in v8:
>>  - rebase onto 4.9-rc1
>>
>> Changes in v7:
>>  - define macros ADC_CELL and TSC_CELL
>>  - remove one cell and dynamically set them in the switch()
>>  - fail in the touchscreen driver instead of mfd driver if
>>    hardware doesn't contain a touchscreen
>>
>> Changes in v6:
>>  - update copyright
>>  - add kernel-doc header for struct mxs-lradc
>>  - add error message
>>  - change EINVAL to ENODEV
>>  - use PLATFORM_DEVID_NONE instead -1
>>  - cosmetic fixes
>>
>> Changes in v5:
>>  - use DEFINE_RES_MEM
>>  - don't pass ioreammaped adress to platform cells
>>  - move comment outside of struct mxs_lradc
>>  - change type of argument in mxs_lradc_reg_set, mxs_lradc_reg_clear,
>>    mxs_lradc_reg_wrt (struct mxs_lradc * -> void __iomem *)
>>
>> Changes in v4:
>>  - update copyright
>>  - use DEFINE_RES_IRQ_NAMED
>>  - remove mxs_lradc_add_device function
>>  - use struct mfd_cell in static form
>>  - improve spacing
>>  - remove unnecessary comment
>>  - remove platform_get_irq
>>  - remove touch_ret and use ret instead
>>  - rename use_touchscreen to touchscreen_wire
>>  - use goto statements
>>  - remove irq[13], irq_count and irq_name from struct mxs_lradc
>>  - remove all defines from inside the struct definition
>>
>> Changes in v3:
>>  - add note to commit message
>>  - move switch statement into if(touch_ret == 0) branch
>>  - add MODULE_AUTHOR
>>
>> Changes in v2:
>>  - do not change spacing in Kconfig
>>  - make struct mfd_cell part of struct mxs_lradc
>>  - use switch instead of if in mxs_lradc_irq_mask
>>  - use only necessary header files in mxs_lradc.h
>>  - use devm_mfd_add_device
>>  - use separate function to register mfd device
>>  - change licence to GPL
>>  - add copyright
>>
>>  drivers/mfd/Kconfig           |  17 +++
>>  drivers/mfd/Makefile          |   1 +
>>  drivers/mfd/mxs-lradc.c       | 249 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/mxs-lradc.h | 203 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 470 insertions(+)
>>  create mode 100644 drivers/mfd/mxs-lradc.c
>>  create mode 100644 include/linux/mfd/mxs-lradc.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index c6df644..bdd88cf 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -326,6 +326,23 @@ config MFD_MC13XXX_I2C
>>       help
>>         Select this if your MC13xxx is connected via an I2C bus.
>>
>> +config MFD_MXS_LRADC
>> +     tristate "Freescale i.MX23/i.MX28 LRADC"
>> +     depends on ARCH_MXS || COMPILE_TEST
>> +     select MFD_CORE
>> +     select STMP_DEVICE
>> +     help
>> +       Say yes here to build support for the Low Resolution
>> +       Analog-to-Digital Converter (LRADC) found on the i.MX23 and i.MX28
>> +       processors. This driver provides common support for accessing the
>> +       device, additional drivers must be enabled in order to use the
>> +       functionality of the device:
>> +             mxs-lradc-adc for ADC readings
>> +             mxs-lradc-ts  for touchscreen support
>> +
>> +       This driver can also be built as a module. If so, the module will be
>> +       called mxs-lradc.
>> +
>>  config MFD_MX25_TSADC
>>       tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
>>       select REGMAP_MMIO
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 9834e66..057ca15 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -211,3 +211,4 @@ obj-$(CONFIG_INTEL_SOC_PMIC)      += intel-soc-pmic.o
>>  obj-$(CONFIG_MFD_MT6397)     += mt6397-core.o
>>
>>  obj-$(CONFIG_MFD_ALTERA_A10SR)       += altera-a10sr.o
>> +obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
>> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
>> new file mode 100644
>> index 0000000..ffc8f2e
>> --- /dev/null
>> +++ b/drivers/mfd/mxs-lradc.c
>> @@ -0,0 +1,249 @@
>> +/*
>> + * Freescale MXS Low Resolution Analog-to-Digital Converter driver
>> + *
>> + * Copyright (c) 2012 DENX Software Engineering, GmbH.
>> + * Copyright (c) 2016 Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> + *
>> + * Authors:
>> + *  Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
>> + *  Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#define MXS_LRADC_BASE               0x80050000
>
> Just for my understanding, why is this hardware address hard-coded here?
> Shouldn't that be fetched from DT ?

Do you mean that address should be fetched by using of_address_to_resource()
in probe function, or something else?

Thanks,
Ksenija
