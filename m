From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Date: Wed, 28 Aug 2013 18:43:08 +0200
Message-ID: <20130828164308.GE14111@linutronix.de>
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com>
 <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377470724-15710-3-git-send-email-zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Zubair Lutfullah | 2013-08-25 23:45:24 [+0100]:

>diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am33=
5x_adc.c
>index a952538..ae2202b 100644
>--- a/drivers/iio/adc/ti_am335x_adc.c
>+++ b/drivers/iio/adc/ti_am335x_adc.c
>@@ -231,28 +406,56 @@ static int tiadc_probe(struct platform_device *p=
dev)
=E2=80=A6
>+err_free_device:
>+	iio_device_free(indio_dev);

I am not sure about this one.

>+err_ret:
> 	return err;
> }
>=20
>@@ -262,11 +465,14 @@ static int tiadc_remove(struct platform_device *=
pdev)
> 	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
> 	u32 step_en;
>=20
>+	free_irq(adc_dev->irq, indio_dev);
> 	iio_device_unregister(indio_dev);
>+	iio_buffer_unregister(indio_dev);
> 	tiadc_channels_remove(indio_dev);
>=20
> 	step_en =3D get_adc_step_mask(adc_dev);
> 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
>+	iio_device_free(indio_dev);

But this one is wrong. The will be removed via dev_res() and if you do
it here as well then dev_res() will decrement the reference of an unuse=
d
object.

>=20
> 	return 0;
> }

Sebastian
