From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/6] mfd: fsl imx25 Touchscreen ADC driver
Date: Wed, 9 Jul 2014 14:06:30 +0100
Message-ID: <20140709130630.GA479@lee--X1>
References: <1403621195-9622-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403621195-9622-1-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 24 Jun 2014, Denis Carikli wrote:

> From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
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
> Changelog v3->v4:
> - Added Jonathan's Ack
> - ARCH_MXC Kconfigdependency removed.
> - mx25_tsadc_get_regmap and mx25_tsadc_get_ipg contents have been mov=
ed
>   in the caller function.
> - mx25_tsadc_irq_chip has been removed.
> - Register definitions are now more humain readable.
> - Many other code and style cleanups.
>=20
> Changelog v2->v3:
> - None
> ---
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |   46 ++++++
>  drivers/mfd/Kconfig                                |    8 +
>  drivers/mfd/Makefile                               |    2 +
>  drivers/mfd/fsl-imx25-tsadc.c                      |  170 ++++++++++=
++++++++++
>  include/linux/mfd/imx25-tsadc.h                    |  140 ++++++++++=
++++++
>  5 files changed, 366 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-t=
sadc.txt
>  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
>  create mode 100644 include/linux/mfd/imx25-tsadc.h
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.tx=
t b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt

You need to split the DT documentation out into a separate patch.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index af0e83f..d354547 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig

[...]

> +static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned int =
irq,
> +			     irq_hw_number_t hwirq)
> +{
> +	struct mx25_tsadc *tsadc =3D d->host_data;
> +
> +	irq_set_chip_data(irq, tsadc);
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> +				 handle_level_irq);
> +	set_irq_flags(irq, IRQF_VALID);

This is only valid on ARM based systems and the Kconfig options do not
limit this driver enough for that to hold true.  In other words, this
code should easily run on X86, PPC, etc etc.

> +	return 0;
> +}

[...]

> +#ifdef CONFIG_OF
> +static const struct of_device_id mx25_tsadc_ids[] =3D {
> +	{ .compatible =3D "fsl,imx25-tsadc" },
> +	{ /* Sentinel */ }
> +};
> +#endif

Can this actually work without device tree?

> +static struct platform_driver mx25_tsadc_driver =3D {
> +	.driver =3D {
> +		.name =3D "mx25-tsadc",
> +		.owner =3D THIS_MODULE,

Remove this line, it's done for you.

> +		.of_match_table =3D of_match_ptr(mx25_tsadc_ids),
> +	},
> +	.probe =3D mx25_tsadc_probe,
> +};
> +module_platform_driver(mx25_tsadc_driver);

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
