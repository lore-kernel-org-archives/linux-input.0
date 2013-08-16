From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Fri, 16 Aug 2013 22:10:02 +0100
Message-ID: <20130816210955.GA2528@gmail.com>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
 <20130816145949.GE1263@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130816145949.GE1263@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>, jic23@cam.ac.uk, dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Russ.Dill@ti.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 16, 2013 at 04:59:49PM +0200, Sebastian Andrzej Siewior wro=
te:
> * Zubair Lutfullah | 2013-08-13 21:05:03 [+0100]:
>=20
> >diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am=
335x_adc.c
> >index 3ceac3e..0d7e313 100644
> >--- a/drivers/iio/adc/ti_am335x_adc.c
> >+++ b/drivers/iio/adc/ti_am335x_adc.c
> =E2=80=A6
>=20
> >+static int tiadc_buffer_postdisable(struct iio_dev *indio_dev)
> >+{
> >+	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
> >+	int config;
> >+
> >+	tiadc_step_config(indio_dev);
> >+	if (adc_dev->mfd_tscadc->tsc_cell =3D=3D -1) {
> >+		config =3D tiadc_readl(adc_dev, REG_CTRL);
> >+		tiadc_writel(adc_dev, REG_CTRL, (config | CNTRLREG_TSCSSENB));
> >+	}
>=20
> This kind of check is bad. The tsc cell may have been created but the
> driver not enabled or loaded. Further you should document why you nee=
d
> to enable / disable the ADC in this places and only if the TSC part i=
s
> not active.
>=20
> Sebastian

Noted. I'll look into it.

Thanks for pointing it out.

Zubair
