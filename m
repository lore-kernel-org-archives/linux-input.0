From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Date: Wed, 28 Aug 2013 16:18:35 +0200
Message-ID: <20130828141835.GD14111@linutronix.de>
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
=E2=80=A6

>+static struct iio_trigger *tiadc_iio_allocate_trigger(struct iio_dev =
*indio_dev)
>+{
>+	struct iio_trigger *trig;
>+	int ret;
>+
>+	trig =3D iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev->i=
d);
>+	if (trig =3D=3D NULL)
>+		return NULL;
>+
>+	trig->dev.parent =3D indio_dev->dev.parent;
>+	trig->ops =3D &tiadc_trigger_ops;
>+	iio_trigger_set_drvdata(trig, indio_dev);
>+
>+	ret =3D iio_trigger_register(trig);
>+	if (ret)

shouldn't you free the trigger / undo iio_trigger_alloc() here?

>+		return NULL;
>+
>+	return trig;
> }

>=20
> static const char * const chan_name_ain[] =3D {
>@@ -220,7 +394,8 @@ static int tiadc_probe(struct platform_device *pde=
v)
> 					  sizeof(struct tiadc_device));
> 	if (indio_dev =3D=3D NULL) {
> 		dev_err(&pdev->dev, "failed to allocate iio device\n");
>-		return -ENOMEM;
>+		err =3D -ENOMEM;
>+		goto err_ret;
Why the jump instead of leave right away?

> 	}
> 	adc_dev =3D iio_priv(indio_dev);
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

I think you need also to

	iio_trigger_unregister(adc_dev->trig);
	iio_trigger_free(adc_dev->trig);

here.
=20
> 	step_en =3D get_adc_step_mask(adc_dev);
> 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
>+	iio_device_free(indio_dev);
>=20
> 	return 0;
> }

Sebastian
