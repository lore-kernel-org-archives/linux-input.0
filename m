From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
Date: Mon, 16 Feb 2015 13:38:29 +0000
Message-ID: <20150216133829.GG14545@x1>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422108103-15052-2-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, 24 Jan 2015, Markus Pargmann wrote:

> This is the core driver for imx25 touchscreen/adc driver. The module
> has one shared ADC and two different conversion queues which use the
> ADC. The two queues are identical. Both can be used for general purpo=
se
> ADC but one is meant to be used for touchscreens.
>=20
> This driver is the core which manages the central components and
> registers of the TSC/ADC unit. It manages the IRQs and forwards them =
to
> the correct components.
>=20
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>=20
> Notes:
>     Changes in v5:
>      - Remove ifdef CONFIG_OF as this driver is only for DT usage
>      - Remove module owner
>      - Add Kconfig dependencies ARCH_MX25 and OF
>    =20
>     @Jonathan Cameron:
>     I left your acked-by on the patch as these were small changes. If=
 it should be
>     removed, please say so. Thanks
>=20
>  drivers/mfd/Kconfig             |  10 +++
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/fsl-imx25-tsadc.c   | 167 ++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/imx25-tsadc.h | 140 ++++++++++++++++++++++++++++++=
+++
>  4 files changed, 319 insertions(+)
>  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
>  create mode 100644 include/linux/mfd/imx25-tsadc.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2e6b7311fabc..44fc15598a6a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -232,6 +232,16 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
> =20
> +config MFD_MX25_TSADC
> +	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
> +	select REGMAP_MMIO
> +	depends on SOC_IMX25
> +	depends on OF
> +	help
> +	  Enable support for the integrated Touchscreen and ADC unit of the
> +	  i.MX25 processors. They consist of a conversion queue for general
> +	  purpose ADC and a queue for Touchscreens.
> +
>  config MFD_HI6421_PMIC
>  	tristate "HiSilicon Hi6421 PMU/Codec IC"
>  	depends on OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 53467e211381..3feeb29f5938 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -78,6 +78,8 @@ obj-$(CONFIG_TWL4030_POWER)    +=3D twl4030-power.o
>  obj-$(CONFIG_MFD_TWL4030_AUDIO)	+=3D twl4030-audio.o
>  obj-$(CONFIG_TWL6040_CORE)	+=3D twl6040.o
> =20
> +obj-$(CONFIG_MFD_MX25_TSADC)	+=3D fsl-imx25-tsadc.o
> +
>  obj-$(CONFIG_MFD_MC13XXX)	+=3D mc13xxx-core.o
>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+=3D mc13xxx-spi.o
>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+=3D mc13xxx-i2c.o
> diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-ts=
adc.c
> new file mode 100644
> index 000000000000..8e4013d57500
> --- /dev/null
> +++ b/drivers/mfd/fsl-imx25-tsadc.c
> @@ -0,0 +1,167 @@
> +/*
> + * Copyright 2014 Markus Pargmann, Pengutronix <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + *
> + * The code contained herein is licensed under the GNU General Publi=
c
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/imx25-tsadc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

[...]

> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> +				struct mx25_tsadc *tsadc)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	int irq;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {

What if 0 is returned?

> +		dev_err(dev, "Failed to get irq\n");
> +		return irq;
> +	}
> +
> +	tsadc->domain =3D irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domai=
n_ops,
> +					      tsadc);
> +	if (!tsadc->domain) {
> +		dev_err(dev, "Failed to add irq domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
> +	irq_set_handler_data(irq, tsadc);
> +
> +	return 0;
> +}

> diff --git a/include/linux/mfd/imx25-tsadc.h b/include/linux/mfd/imx2=
5-tsadc.h
> new file mode 100644
> index 000000000000..8086f18847fe
> --- /dev/null
> +++ b/include/linux/mfd/imx25-tsadc.h
> @@ -0,0 +1,140 @@
> +#ifndef _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
> +#define _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_

INPUT?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
