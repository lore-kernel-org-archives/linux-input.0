From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Sat, 17 Sep 2016 12:26:14 +0200
Message-ID: <CAL7P5jKx4S-cduxTmNzocD0VrkgzK4vQ+w6G__sWOJMNsoJhCA@mail.gmail.com>
References: <cover.1471524593.git.ksenija.stanojevic@gmail.com>
 <f968582fe3036a2967ed41494c73c43ac19e4767.1471524593.git.ksenija.stanojevic@gmail.com>
 <20160831120552.GF8649@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831120552.GF8649@dell>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 31, 2016 at 2:05 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> On Thu, 18 Aug 2016, Ksenija Stanojevic wrote:
>
> > Add core files for mxs-lradc MFD driver.
> >
> > Note:  this patch won't compile in iio/testing without this patch:
> > a8f447be8056 ("mfd: Add resource managed APIs for mfd_add_devices")
> >
> > Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > Changes in v5:
> >  - use DEFINE_RES_MEM
> >  - don't pass ioreammaped adress to platform cells
> >  - move comment outside of struct mxs_lradc
> >  - change type of argument in mxs_lradc_reg_set, mxs_lradc_reg_clear,
> >    mxs_lradc_reg_wrt (struct mxs_lradc * -> void __iomem *)
> >
> > Changes in v4:
> >  - update copyright
> >  - use DEFINE_RES_IRQ_NAMED
> >  - remove mxs_lradc_add_device function
> >  - use struct mfd_cell in static form
> >  - improve spacing
> >  - remove unnecessary comment
> >  - remove platform_get_irq
> >  - remove touch_ret and use ret instead
> >  - rename use_touchscreen to touchscreen_wire
> >  - use goto statements
> >  - remove irq[13], irq_count and irq_name from struct mxs_lradc
> >  - remove all defines from inside the struct definition
> >
> > Changes in v3:
> >  - add note to commit message
> >  - move switch statement into if(touch_ret =3D=3D 0) branch
> >  - add MODULE_AUTHOR
> >
> > Changes in v2:
> >  - do not change spacing in Kconfig
> >  - make struct mfd_cell part of struct mxs_lradc
> >  - use switch instead of if in mxs_lradc_irq_mask
> >  - use only necessary header files in mxs_lradc.h
> >  - use devm_mfd_add_device
> >  - use separate function to register mfd device
> >  - change licence to GPL
> >  - add copyright
> >
> >  drivers/mfd/Kconfig           |  17 +++
> >  drivers/mfd/Makefile          |   1 +
> >  drivers/mfd/mxs-lradc.c       | 255 ++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/mxs-lradc.h | 194 ++++++++++++++++++++++++++++++++
> >  4 files changed, 467 insertions(+)
> >  create mode 100644 drivers/mfd/mxs-lradc.c
> >  create mode 100644 include/linux/mfd/mxs-lradc.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 9ca66de..ffe14ef 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -271,6 +271,23 @@ config MFD_MC13XXX_I2C
> >       help
> >         Select this if your MC13xxx is connected via an I2C bus.
> >
> > +config MFD_MXS_LRADC
> > +     tristate "Freescale i.MX23/i.MX28 LRADC"
> > +     depends on ARCH_MXS || COMPILE_TEST
> > +     select MFD_CORE
> > +     select STMP_DEVICE
> > +     help
> > +       Say yes here to build support for the Low Resolution
> > +       Analog-to-Digital Converter (LRADC) found on the i.MX23 and i.M=
X28
> > +       processors. This driver provides common support for accessing t=
he
> > +       device, additional drivers must be enabled in order to use the
> > +       functionality of the device:
> > +             mxs-lradc-adc for ADC readings
> > +             mxs-lradc-ts  for touchscreen support
> > +
> > +       This driver can also be built as a module. If so, the module wi=
ll be
> > +       called mxs-lradc.
> > +
> >  config MFD_HI6421_PMIC
> >       tristate "HiSilicon Hi6421 PMU/Codec IC"
> >       depends on OF
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 0f230a6..ecf6399 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -198,3 +198,4 @@ intel-soc-pmic-objs               :=3D intel_soc_pm=
ic_core.o intel_soc_pmic_crc.o
> >  intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)       +=3D intel_soc_pmic_bxtwc=
.o
> >  obj-$(CONFIG_INTEL_SOC_PMIC) +=3D intel-soc-pmic.o
> >  obj-$(CONFIG_MFD_MT6397)     +=3D mt6397-core.o
> > +obj-$(CONFIG_MFD_MXS_LRADC)  +=3D mxs-lradc.o
> > diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
> > new file mode 100644
> > index 0000000..268c48d
> > --- /dev/null
> > +++ b/drivers/mfd/mxs-lradc.c
> > @@ -0,0 +1,255 @@
> > +/*
> > + * Freescale MXS LRADC driver
> > + *
> > + * Copyright (c) 2012 DENX Software Engineering, GmbH.
>
> This needs an update.
>
> > + * Authors:
> > + * Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > + * Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Nit: Add 2 ' 's before the names.
>
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/mxs-lradc.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define MXS_LRADC_BASE               0x80050000
> > +
> > +enum mx23_lradc_irqs {
> > +     MX23_LRADC_TS_IRQ =3D 0,
> > +     MX23_LRADC_CH0_IRQ,
> > +     MX23_LRADC_CH1_IRQ,
> > +     MX23_LRADC_CH2_IRQ,
> > +     MX23_LRADC_CH3_IRQ,
> > +     MX23_LRADC_CH4_IRQ,
> > +     MX23_LRADC_CH5_IRQ,
> > +     MX23_LRADC_CH6_IRQ,
> > +     MX23_LRADC_CH7_IRQ,
> > +};
> > +
> > +enum mx28_lradc_irqs {
> > +     MX28_LRADC_TS_IRQ =3D 0,
> > +     MX28_LRADC_TRESH0_IRQ,
> > +     MX28_LRADC_TRESH1_IRQ,
> > +     MX28_LRADC_CH0_IRQ,
> > +     MX28_LRADC_CH1_IRQ,
> > +     MX28_LRADC_CH2_IRQ,
> > +     MX28_LRADC_CH3_IRQ,
> > +     MX28_LRADC_CH4_IRQ,
> > +     MX28_LRADC_CH5_IRQ,
> > +     MX28_LRADC_CH6_IRQ,
> > +     MX28_LRADC_CH7_IRQ,
> > +     MX28_LRADC_BUTTON0_IRQ,
> > +     MX28_LRADC_BUTTON1_IRQ,
> > +};
> > +
> > +static struct resource mx23_adc_resources[] =3D {
> > +     DEFINE_RES_MEM(MXS_LRADC_BASE, 0x1fff),
> > +     DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH0_IRQ, "mxs-lradc-channel0"),
> > +     DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH1_IRQ, "mxs-lradc-channel1"),
> > +     DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH2_IRQ, "mxs-lradc-channel2"),
> > +     DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH3_IRQ, "mxs-lradc-channel3"),
> > +     DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH4_IRQ, "mxs-lradc-channel4"),
> > +     DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH5_IRQ, "mxs-lradc-channel5"),
> > +};
> > +
> > +static struct resource mx23_touchscreen_resources[] =3D {
> > +     DEFINE_RES_MEM(MXS_LRADC_BASE, 0x1fff),
> > +     DEFINE_RES_IRQ_NAMED(MX23_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
> > +     DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
> > +     DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
> > +};
> > +
> > +static struct resource mx28_adc_resources[] =3D {
> > +     DEFINE_RES_MEM(MXS_LRADC_BASE, 0x1fff),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_TRESH0_IRQ, "mxs-lradc-thresh0"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_TRESH1_IRQ, "mxs-lradc-thresh1"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH0_IRQ, "mxs-lradc-channel0"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH1_IRQ, "mxs-lradc-channel1"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH2_IRQ, "mxs-lradc-channel2"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH3_IRQ, "mxs-lradc-channel3"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH4_IRQ, "mxs-lradc-channel4"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH5_IRQ, "mxs-lradc-channel5"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_BUTTON0_IRQ, "mxs-lradc-button0")=
,
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_BUTTON1_IRQ, "mxs-lradc-button1")=
,
> > +};
> > +
> > +static struct resource mx28_touchscreen_resources[] =3D {
> > +     DEFINE_RES_MEM(MXS_LRADC_BASE, 0x1fff),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
> > +     DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
> > +};
> > +
> > +static struct mfd_cell mx23_cells[] =3D {
> > +     {
> > +             .name =3D "mxs-lradc-adc",
> > +             .resources =3D mx23_adc_resources,
> > +             .num_resources =3D ARRAY_SIZE(mx23_adc_resources),
> > +     },
> > +     {
> > +             .name =3D "mxs-lradc-ts",
> > +             .resources =3D mx23_touchscreen_resources,
> > +             .num_resources =3D ARRAY_SIZE(mx23_touchscreen_resources)=
,
> > +     },
> > +};
> > +
> > +static struct mfd_cell mx28_cells[] =3D {
> > +     {
> > +             .name =3D "mxs-lradc-adc",
> > +             .resources =3D mx28_adc_resources,
> > +             .num_resources =3D ARRAY_SIZE(mx28_adc_resources),
> > +     },
> > +     {
> > +             .name =3D "mxs-lradc-ts",
> > +             .resources =3D mx28_touchscreen_resources,
> > +             .num_resources =3D ARRAY_SIZE(mx28_touchscreen_resources)=
,
> > +     }
> > +};
> > +
> > +static const struct of_device_id mxs_lradc_dt_ids[] =3D {
> > +     { .compatible =3D "fsl,imx23-lradc", .data =3D (void *)IMX23_LRAD=
C, },
> > +     { .compatible =3D "fsl,imx28-lradc", .data =3D (void *)IMX28_LRAD=
C, },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
> > +
> > +static int mxs_lradc_probe(struct platform_device *pdev)
> > +{
> > +     const struct of_device_id *of_id;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_node *node =3D dev->of_node;
> > +     struct mxs_lradc *lradc;
> > +     struct mfd_cell *cells =3D NULL;
> > +     int ret =3D 0;
> > +     u32 ts_wires =3D 0;
> > +
> > +     lradc =3D devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> > +     if (!lradc)
> > +             return -ENOMEM;
> > +
> > +     of_id =3D of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> > +     lradc->soc =3D (enum mxs_lradc_id)of_id->data;
>
> Unnecessary cast.

If I remove the cast I get this error:
drivers/mfd/mxs-lradc.c:148:13: error: incompatible types when
assigning to type =E2=80=98enum mxs_lradc_id=E2=80=99 from type =E2=80=98co=
nst void * const=E2=80=99

> > +     lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +     if (IS_ERR(lradc->clk)) {
> > +             dev_err(dev, "Failed to get the delay unit clock\n");
> > +             return PTR_ERR(lradc->clk);
> > +     }
> > +
> > +     ret =3D clk_prepare_enable(lradc->clk);
> > +     if (ret !=3D 0) {
>
> if (ret)
>
> > +             dev_err(dev, "Failed to enable the delay unit clock\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
> > +                                      &ts_wires);
>
> Superfluous '\n'
>
> if (!ret)
>
> > +     if (ret =3D=3D 0) {
> > +             lradc->buffer_vchans =3D BUFFER_VCHANS_LIMITED;
> > +
> > +             switch (ts_wires) {
> > +             case 4:
> > +                     lradc->touchscreen_wire =3D MXS_LRADC_TOUCHSCREEN=
_4WIRE;
> > +                     break;
> > +             case 5:
> > +                     if (lradc->soc =3D=3D IMX28_LRADC) {
> > +                             lradc->touchscreen_wire =3D
> > +                                     MXS_LRADC_TOUCHSCREEN_5WIRE;
> > +                             break;
> > +                     }
> > +                     /* fall through to an error message for i.MX23 */
> > +             default:
> > +                     dev_err(&pdev->dev,
> > +                             "Unsupported number of touchscreen wires =
(%d)\n"
> > +                             , ts_wires);
> > +                     ret =3D -EINVAL;
> > +                     goto err_clk;
> > +             }
> > +     } else {
> > +             lradc->buffer_vchans =3D BUFFER_VCHANS_ALL;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, lradc);
> > +
> > +     switch (lradc->soc) {
> > +     case IMX23_LRADC:
> > +             cells =3D mx23_cells;
> > +             break;
> > +     case IMX28_LRADC:
> > +             cells =3D mx28_cells;
> > +             break;
> > +     default:
>
> Error message here.
>
> > +             ret =3D -EINVAL;
>
> -ENODEV
>
> > +             goto err_clk;
> > +     }
> > +
> > +     cells[0].platform_data =3D lradc;
> > +     cells[0].pdata_size =3D sizeof(*lradc);
> > +
> > +     ret =3D devm_mfd_add_devices(&pdev->dev, -1, &cells[0], 1, NULL, =
0, NULL);
>
> Use the #defines, not -1.
>
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Failed to add the ADC subdevice\n");
> > +             goto err_clk;
> > +     }
> > +
> > +     if (!lradc->touchscreen_wire)
> > +             return 0;
> > +
> > +     cells[1].platform_data =3D lradc;
> > +     cells[1].pdata_size =3D sizeof(*lradc);
> > +
> > +     ret =3D devm_mfd_add_devices(&pdev->dev, -1, &cells[1], 1, NULL, =
0, NULL);
>
> As above.
>
> > +     if (ret) {
> > +             dev_err(&pdev->dev,
> > +                     "Failed to add the touchscreen subdevice\n");
> > +             goto err_clk;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_clk:
> > +     clk_disable_unprepare(lradc->clk);
> > +
> > +     return ret;
> > +}
> > +
> > +static int mxs_lradc_remove(struct platform_device *pdev)
> > +{
> > +     struct mxs_lradc *lradc =3D platform_get_drvdata(pdev);
> > +
> > +     clk_disable_unprepare(lradc->clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver mxs_lradc_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "mxs-lradc",
> > +             .of_match_table =3D mxs_lradc_dt_ids,
> > +     },
> > +     .probe =3D mxs_lradc_probe,
> > +     .remove =3D mxs_lradc_remove,
> > +};
> > +module_platform_driver(mxs_lradc_driver);
> > +
> > +MODULE_AUTHOR("Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> > +MODULE_DESCRIPTION("Freescale i.MX23/i.MX28 LRADC driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:mxs-lradc");
> > diff --git a/include/linux/mfd/mxs-lradc.h b/include/linux/mfd/mxs-lrad=
c.h
> > new file mode 100644
> > index 0000000..928f355
> > --- /dev/null
> > +++ b/include/linux/mfd/mxs-lradc.h
> > @@ -0,0 +1,194 @@
> > +/*
> > + * Freescale MXS LRADC driver
> > + *
> > + * Copyright (c) 2012 DENX Software Engineering, GmbH.
>
> Update required.
>
> > + * Author: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __MFD_MXS_LRADC_H
> > +#define __MFD_MXS_LRADC_H
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/io.h>
> > +#include <linux/stmp_device.h>
> > +
> > +#define LRADC_MAX_DELAY_CHANS        4
> > +#define LRADC_MAX_MAPPED_CHANS       8
> > +#define LRADC_MAX_TOTAL_CHANS        16
> > +
> > +#define LRADC_DELAY_TIMER_HZ 2000
> > +
> > +#define LRADC_CTRL0                          0x00
> > +# define LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE        BIT(23)
> > +# define LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE  BIT(22)
> > +# define LRADC_CTRL0_MX28_YNNSW /* YM */     BIT(21)
> > +# define LRADC_CTRL0_MX28_YPNSW /* YP */     BIT(20)
> > +# define LRADC_CTRL0_MX28_YPPSW /* YP */     BIT(19)
> > +# define LRADC_CTRL0_MX28_XNNSW /* XM */     BIT(18)
> > +# define LRADC_CTRL0_MX28_XNPSW /* XM */     BIT(17)
> > +# define LRADC_CTRL0_MX28_XPPSW /* XP */     BIT(16)
> > +
> > +# define LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE        BIT(20)
> > +# define LRADC_CTRL0_MX23_YM                 BIT(19)
> > +# define LRADC_CTRL0_MX23_XM                 BIT(18)
> > +# define LRADC_CTRL0_MX23_YP                 BIT(17)
> > +# define LRADC_CTRL0_MX23_XP                 BIT(16)
> > +
> > +# define LRADC_CTRL0_MX28_PLATE_MASK \
> > +             (LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE | \
> > +             LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
> > +             LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
> > +             LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW)
> > +
> > +# define LRADC_CTRL0_MX23_PLATE_MASK \
> > +             (LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE | \
> > +             LRADC_CTRL0_MX23_YM | LRADC_CTRL0_MX23_XM | \
> > +             LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XP)
> > +
> > +#define LRADC_CTRL1                          0x10
> > +#define LRADC_CTRL1_TOUCH_DETECT_IRQ_EN              BIT(24)
> > +#define LRADC_CTRL1_LRADC_IRQ_EN(n)          (1 << ((n) + 16))
> > +#define LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK   (0x1fff << 16)
> > +#define LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK   (0x01ff << 16)
> > +#define LRADC_CTRL1_LRADC_IRQ_EN_OFFSET              16
> > +#define LRADC_CTRL1_TOUCH_DETECT_IRQ         BIT(8)
> > +#define LRADC_CTRL1_LRADC_IRQ(n)             (1 << (n))
> > +#define LRADC_CTRL1_MX28_LRADC_IRQ_MASK              0x1fff
> > +#define LRADC_CTRL1_MX23_LRADC_IRQ_MASK              0x01ff
> > +#define LRADC_CTRL1_LRADC_IRQ_OFFSET         0
> > +
> > +#define LRADC_CTRL2                          0x20
> > +#define LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET     24
> > +#define LRADC_CTRL2_TEMPSENSE_PWD            BIT(15)
> > +
> > +#define LRADC_STATUS                         0x40
> > +#define LRADC_STATUS_TOUCH_DETECT_RAW                BIT(0)
> > +
> > +#define LRADC_CH(n)                          (0x50 + (0x10 * (n)))
> > +#define LRADC_CH_ACCUMULATE                  BIT(29)
> > +#define LRADC_CH_NUM_SAMPLES_MASK            (0x1f << 24)
> > +#define LRADC_CH_NUM_SAMPLES_OFFSET          24
> > +#define LRADC_CH_NUM_SAMPLES(x) \
> > +                             ((x) << LRADC_CH_NUM_SAMPLES_OFFSET)
> > +#define LRADC_CH_VALUE_MASK                  0x3ffff
> > +#define LRADC_CH_VALUE_OFFSET                        0
> > +
> > +#define LRADC_DELAY(n)                               (0xd0 + (0x10 * (=
n)))
> > +#define LRADC_DELAY_TRIGGER_LRADCS_MASK              (0xffUL << 24)
> > +#define LRADC_DELAY_TRIGGER_LRADCS_OFFSET    24
> > +#define LRADC_DELAY_TRIGGER(x) \
> > +                             (((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSE=
T) & \
> > +                             LRADC_DELAY_TRIGGER_LRADCS_MASK)
> > +#define LRADC_DELAY_KICK                     BIT(20)
> > +#define LRADC_DELAY_TRIGGER_DELAYS_MASK              (0xf << 16)
> > +#define LRADC_DELAY_TRIGGER_DELAYS_OFFSET    16
> > +#define LRADC_DELAY_TRIGGER_DELAYS(x) \
> > +                             (((x) << LRADC_DELAY_TRIGGER_DELAYS_OFFSE=
T) & \
> > +                             LRADC_DELAY_TRIGGER_DELAYS_MASK)
> > +#define LRADC_DELAY_LOOP_COUNT_MASK          (0x1f << 11)
> > +#define LRADC_DELAY_LOOP_COUNT_OFFSET                11
> > +#define LRADC_DELAY_LOOP(x) \
> > +                             (((x) << LRADC_DELAY_LOOP_COUNT_OFFSET) &=
 \
> > +                             LRADC_DELAY_LOOP_COUNT_MASK)
> > +#define LRADC_DELAY_DELAY_MASK                       0x7ff
> > +#define LRADC_DELAY_DELAY_OFFSET             0
> > +#define LRADC_DELAY_DELAY(x) \
> > +                             (((x) << LRADC_DELAY_DELAY_OFFSET) & \
> > +                             LRADC_DELAY_DELAY_MASK)
> > +
> > +#define LRADC_CTRL4                          0x140
> > +#define LRADC_CTRL4_LRADCSELECT_MASK(n)              (0xf << ((n) * 4)=
)
> > +#define LRADC_CTRL4_LRADCSELECT_OFFSET(n)    ((n) * 4)
> > +#define LRADC_CTRL4_LRADCSELECT(n, x) \
> > +                             (((x) << LRADC_CTRL4_LRADCSELECT_OFFSET(n=
)) & \
> > +                             LRADC_CTRL4_LRADCSELECT_MASK(n))
> > +
> > +#define LRADC_RESOLUTION                     12
> > +#define LRADC_SINGLE_SAMPLE_MASK             ((1 << LRADC_RESOLUTION) =
- 1)
> > +
> > +#define BUFFER_VCHANS_LIMITED                0x3f
> > +#define BUFFER_VCHANS_ALL            0xff
> > +
> > +     /*
> > +      * Certain LRADC channels are shared between touchscreen
> > +      * and/or touch-buttons and generic LRADC block. Therefore when u=
sing
> > +      * either of these, these channels are not available for the regu=
lar
> > +      * sampling. The shared channels are as follows:
> > +      *
> > +      * CH0 -- Touch button #0
> > +      * CH1 -- Touch button #1
> > +      * CH2 -- Touch screen XPUL
> > +      * CH3 -- Touch screen YPLL
> > +      * CH4 -- Touch screen XNUL
> > +      * CH5 -- Touch screen YNLR
> > +      * CH6 -- Touch screen WIPER (5-wire only)
> > +      *
> > +      * The bit fields below represents which parts of the LRADC block=
 are
> > +      * switched into special mode of operation. These channels can no=
t
> > +      * be sampled as regular LRADC channels. The driver will refuse a=
ny
> > +      * attempt to sample these channels.
> > +      */
> > +#define CHAN_MASK_TOUCHBUTTON                (BIT(1) | BIT(0))
> > +#define CHAN_MASK_TOUCHSCREEN_4WIRE  (0xf << 2)
> > +#define CHAN_MASK_TOUCHSCREEN_5WIRE  (0x1f << 2)
> > +
> > +enum mxs_lradc_id {
> > +     IMX23_LRADC,
> > +     IMX28_LRADC,
> > +};
> > +
> > +enum mxs_lradc_ts_wires {
> > +     MXS_LRADC_TOUCHSCREEN_NONE =3D 0,
> > +     MXS_LRADC_TOUCHSCREEN_4WIRE,
> > +     MXS_LRADC_TOUCHSCREEN_5WIRE,
> > +};
> > +
> > +struct mxs_lradc {
> > +     enum mxs_lradc_id       soc;
> > +     struct clk              *clk;
> > +     u8                      buffer_vchans;
> > +
> > +     enum mxs_lradc_ts_wires touchscreen_wire;
> > +     bool                    use_touchbutton;
> > +};
>
> A kernel-doc header would be helpful.
>
> > +static inline void mxs_lradc_reg_set(void __iomem *base, u32 val, u32 =
reg)
> > +{
> > +     writel(val, base + reg + STMP_OFFSET_REG_SET);
> > +}
> > +
> > +static inline void mxs_lradc_reg_clear(void __iomem *base, u32 val,
> > +                                    u32 reg)
> > +{
> > +     writel(val, base + reg + STMP_OFFSET_REG_CLR);
> > +}
> > +
> > +static inline void mxs_lradc_reg_wrt(void __iomem *base, u32 val, u32 =
reg)
> > +{
> > +     writel(val, base + reg);
> > +}
> > +
> > +static inline u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
> > +{
> > +     switch (lradc->soc) {
> > +     case IMX23_LRADC:
> > +             return LRADC_CTRL1_MX23_LRADC_IRQ_MASK;
> > +     case IMX28_LRADC:
> > +             return LRADC_CTRL1_MX28_LRADC_IRQ_MASK;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +#endif /* __MXS_LRADC_H */
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
