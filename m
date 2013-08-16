From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Fri, 16 Aug 2013 22:18:10 +0100
Message-ID: <20130816211809.GA2636@gmail.com>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
 <20130816125340.GC1263@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130816125340.GC1263@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>, jic23@cam.ac.uk, dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Russ.Dill@ti.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 16, 2013 at 02:53:40PM +0200, Sebastian Andrzej Siewior wro=
te:
> * Zubair Lutfullah | 2013-08-13 21:05:03 [+0100]:
>=20
> >diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am=
335x_adc.c
> >index 3ceac3e..0d7e313 100644
> >--- a/drivers/iio/adc/ti_am335x_adc.c
> >+++ b/drivers/iio/adc/ti_am335x_adc.c
> >@@ -24,16 +24,28 @@
> =E2=80=A6
> >+static irqreturn_t tiadc_irq(int irq, void *private)
> >+{
> >+	struct iio_dev *idev =3D private;
> >+	struct tiadc_device *adc_dev =3D iio_priv(idev);
> >+	unsigned int status, config;
> >+	status =3D tiadc_readl(adc_dev, REG_IRQSTATUS);
> >+
> >+	/* FIFO Overrun. Clear flag. Disable/Enable ADC to recover */
> >+	if (status & IRQENB_FIFO1OVRRUN) {
> >+		config =3D tiadc_readl(adc_dev, REG_CTRL);
> >+		config &=3D ~(CNTRLREG_TSCSSENB);
> >+		tiadc_writel(adc_dev, REG_CTRL, config);
> >+		tiadc_writel(adc_dev, REG_IRQSTATUS, IRQENB_FIFO1OVRRUN |
> >+				IRQENB_FIFO1UNDRFLW | IRQENB_FIFO1THRES);
> >+		tiadc_writel(adc_dev, REG_CTRL, (config | CNTRLREG_TSCSSENB));
>=20
> I have no idea how other handle this but shouldn't you somehow inform
> *anyone* that you lost some samples due to this overrun?
>=20
> Sebastian

The ref manual states that TSCADC module doesn't recover=20
from overrun interrupts. Thats why the disable enable of
the module here to handle the situation.
And of course, clearing interrupt flags.
The data is lost.

Informing someone about lost samples is important indeed.
But a print statement in this area causes more overruns.

I'm open to some input on how to inform userspace of such=20
a situation.

Thanks
Zubair
