From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Date: Wed, 28 Aug 2013 19:22:50 +0100
Message-ID: <20130828182249.GB3580@gmail.com>
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com>
 <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
 <20130828141835.GD14111@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130828141835.GD14111-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 28, 2013 at 04:18:35PM +0200, Sebastian Andrzej Siewior wro=
te:
> * Zubair Lutfullah | 2013-08-25 23:45:24 [+0100]:
>=20
> >diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am=
335x_adc.c
> >index a952538..ae2202b 100644
> >--- a/drivers/iio/adc/ti_am335x_adc.c
> >+++ b/drivers/iio/adc/ti_am335x_adc.c
> =E2=80=A6
>=20
> >+static struct iio_trigger *tiadc_iio_allocate_trigger(struct iio_de=
v *indio_dev)
=2E..
> >+	trig =3D iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev-=
>id);
> >+	if (trig =3D=3D NULL)
> >+		return NULL;
> >+
=2E..
> >+	ret =3D iio_trigger_register(trig);
> >+	if (ret)
>=20
> shouldn't you free the trigger / undo iio_trigger_alloc() here?
>=20
> >+		return NULL;
> >+
=2E..
Possible. It's done in the probe section just=20
to keep error handling bunched there.
>=20
> >=20
> > static const char * const chan_name_ain[] =3D {
> >@@ -220,7 +394,8 @@ static int tiadc_probe(struct platform_device *p=
dev)
> > 					  sizeof(struct tiadc_device));
> > 	if (indio_dev =3D=3D NULL) {
> > 		dev_err(&pdev->dev, "failed to allocate iio device\n");
> >-		return -ENOMEM;
> >+		err =3D -ENOMEM;
> >+		goto err_ret;
> Why the jump instead of leave right away?
>=20
> > 	}
Again. Error handling all in one place.

> >=20
> >@@ -262,11 +465,14 @@ static int tiadc_remove(struct platform_device=
 *pdev)
> > 	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
> > 	u32 step_en;
> >=20
> >+	free_irq(adc_dev->irq, indio_dev);
> > 	iio_device_unregister(indio_dev);
> >+	iio_buffer_unregister(indio_dev);
> > 	tiadc_channels_remove(indio_dev);
>=20
> I think you need also to
>=20
> 	iio_trigger_unregister(adc_dev->trig);
> 	iio_trigger_free(adc_dev->trig);
>=20
> here.
Indeed.
Thanks for pointing it out.

Zubair
