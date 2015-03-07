From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/8] imx25 adc and touchscreen driver
Date: Sat, 07 Mar 2015 18:24:09 +0000
Message-ID: <54FB4249.6070801@kernel.org>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425369498-25541-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Cc: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, =?windows-1252?Q?Eric_B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 03/03/15 07:58, Markus Pargmann wrote:
> Hi,
> 
> This series adds a driver for the Freescale i.MX25 SoC internal ADC unit which
> is used for touchscreen and ADC. The driver consists of three parts, the MFD
> driver which handles interrupts and some central configuration registers, the
> ADC driver and the touchscreen driver.
> 
> v7 has some modifications in the probe functions to use devres irq requests.
> irq checks were fixed to check for irqs <= 0. The header was cleaned up to have
> a more uniform presentation of the bit fields. Detailed changelogs are attached
> to the according mails.
> 
> Best Regards,
> 
> Markus
Almost there as far as I am concerned.  Just that one unbalanced regulator_enable
that needs dealing with.  The bindings are pretty simple so whilst a device-tree
ack would of course be great I guess it could be taken without.

This wants to go via mfd or I suppose the freescale/arm-soc tree.  Either is fine
with me.

Jonathan
> 
> 
> Denis Carikli (2):
>   ARM: dts: imx25: Add TSC and ADC support
>   ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller and ADC
>     support.
> 
> Markus Pargmann (6):
>   ARM: dt: Binding documentation for imx25 ADC/TSC
>   ARM: dt: Binding documentation for imx25 GCQ
>   ARM: dt: Binding documentation for imx25 touchscreen controller
>   mfd: fsl imx25 Touchscreen ADC driver
>   iio: adc: fsl,imx25-gcq driver
>   input: touchscreen: imx25 tcq driver
> 
>  .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  54 ++
>  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  29 +
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++
>  arch/arm/boot/dts/imx25.dtsi                       |  30 +-
>  arch/arm/configs/imx_v4_v5_defconfig               |   4 +
>  drivers/iio/adc/Kconfig                            |   7 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/fsl-imx25-gcq.c                    | 356 +++++++++++++
>  drivers/input/touchscreen/Kconfig                  |   6 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/fsl-imx25-tcq.c          | 593 +++++++++++++++++++++
>  drivers/mfd/Kconfig                                |  10 +
>  drivers/mfd/Makefile                               |   2 +
>  drivers/mfd/fsl-imx25-tsadc.c                      | 164 ++++++
>  include/dt-bindings/iio/adc/fsl-imx25-gcq.h        |  18 +
>  include/linux/mfd/imx25-tsadc.h                    | 141 +++++
>  16 files changed, 1459 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
>  create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
>  create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
>  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
>  create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
>  create mode 100644 include/linux/mfd/imx25-tsadc.h
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
