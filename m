From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock handling
Date: Mon, 23 Sep 2013 17:30:18 +0200
Message-ID: <21056.24202.312851.105281@ipc1.ka-ro>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
	<1379946998-23041-2-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379946998-23041-2-git-send-email-jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

Juergen Beisert writes:
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/ii=
o/adc/mxs-lradc.c
> index a08c173..00b61ac 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -35,6 +35,7 @@
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/input.h>
> +#include <linux/clk.h>
> =20
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -134,6 +135,8 @@ struct mxs_lradc {
>  	void __iomem		*base;
>  	int			irq[13];
> =20
> +	struct clk		*clk;
> +
>  	uint32_t		*buffer;
>  	struct iio_trigger	*trig;
> =20
> @@ -928,6 +931,9 @@ static int mxs_lradc_probe(struct platform_device=
 *pdev)
>  	if (IS_ERR(lradc->base))
>  		return PTR_ERR(lradc->base);
> =20
> +	lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	clk_prepare_enable(lradc->clk);
> +
Wouldn't it make sense to enable the clock only when the device is
opened to save power while not actually in use?


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
