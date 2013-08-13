From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Tue, 13 Aug 2013 18:05:00 +0100
Message-ID: <20130813170500.GI15278@lee--X1>
References: <1376412499-21007-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376412499-21007-5-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:54237 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756904Ab3HMRFU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Aug 2013 13:05:20 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so4229719eak.15
        for <linux-input@vger.kernel.org>; Tue, 13 Aug 2013 10:05:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376412499-21007-5-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, gregkh@linuxfoundation.org, Russ.Dill@ti.com

On Tue, 13 Aug 2013, Zubair Lutfullah wrote:

> Previously the driver had only one-shot reading functionality.
> This patch adds triggered buffer support to the driver.
> A buffer of samples can now be read via /dev/iio.
> Any IIO trigger can be used to start acquisition.
>=20
> Patil Rachna (TI) laid the ground work for ADC HW register access.
> Russ Dill (TI) fixed bugs in the driver relevant to FIFOs and IRQs.
>=20
> I fixed channel scanning so multiple ADC channels can be read
> simultaneously and pushed to userspace. Restructured the driver
> to fit IIO ABI. And added trigger support.
>=20
> Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
> ---
>  drivers/iio/adc/ti_am335x_adc.c      |  353 ++++++++++++++++++++++++=
++++------
>  include/linux/mfd/ti_am335x_tscadc.h |   13 +-
>  2 files changed, 303 insertions(+), 63 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am3=
35x_adc.c

<snip>

> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd=
/ti_am335x_tscadc.h
> index e2db978..a1d22de 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -46,6 +46,9 @@
>  /* Step Enable */
>  #define STEPENB_MASK		(0x1FFFF << 0)
>  #define STEPENB(val)		((val) << 0)
> +#define ENB(val)			(1 << (val))
> +#define STPENB_STEPENB		STEPENB(0x1FFFF)
> +#define STPENB_STEPENB_TC	STEPENB(0x1FFF)
> =20
>  /* IRQ enable */
>  #define IRQENB_HW_PEN		BIT(0)
> @@ -54,11 +57,14 @@
>  #define IRQENB_FIFO0UNDRFLW	BIT(4)
>  #define IRQENB_FIFO1THRES	BIT(5)
>  #define IRQENB_PENUP		BIT(9)
> +#define IRQENB_FIFO1OVRRUN	BIT(6)
> +#define IRQENB_FIFO1UNDRFLW	BIT(7)

Nit: Can we keep these in numerical order?

>  /* Step Configuration */
>  #define STEPCONFIG_MODE_MASK	(3 << 0)
>  #define STEPCONFIG_MODE(val)	((val) << 0)
>  #define STEPCONFIG_MODE_HWSYNC	STEPCONFIG_MODE(2)
> +#define STEPCONFIG_MODE_SWCNT	STEPCONFIG_MODE(1)
>  #define STEPCONFIG_AVG_MASK	(7 << 2)
>  #define STEPCONFIG_AVG(val)	((val) << 2)
>  #define STEPCONFIG_AVG_16	STEPCONFIG_AVG(4)
> @@ -126,7 +132,8 @@
>  #define	MAX_CLK_DIV		7
>  #define TOTAL_STEPS		16
>  #define TOTAL_CHANNELS		8
> -
> +#define FIFO1_THRESHOLD		19
> +#define FIFO_SIZE			64

Nit: Keep the line space between the defines and the multi-line comment=
=2E

>  /*
>  * ADC runs at 3MHz, and it takes
>  * 15 cycles to latch one data output.
> @@ -155,6 +162,10 @@ struct ti_tscadc_dev {
> =20
>  	/* adc device */
>  	struct adc_device *adc;
> +
> +	/* Context save */
> +	unsigned int irqstat;
> +	unsigned int ctrl;
>  };
> =20
>  static inline struct ti_tscadc_dev *ti_tscadc_dev_get(struct platfor=
m_device *p)

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
