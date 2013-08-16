From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Fri, 16 Aug 2013 14:53:40 +0200
Message-ID: <20130816125340.GC1263@linutronix.de>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376424303-22740-5-git-send-email-zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Zubair Lutfullah | 2013-08-13 21:05:03 [+0100]:

>diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am33=
5x_adc.c
>index 3ceac3e..0d7e313 100644
>--- a/drivers/iio/adc/ti_am335x_adc.c
>+++ b/drivers/iio/adc/ti_am335x_adc.c
>@@ -24,16 +24,28 @@
=E2=80=A6
>+static irqreturn_t tiadc_irq(int irq, void *private)
>+{
>+	struct iio_dev *idev =3D private;
>+	struct tiadc_device *adc_dev =3D iio_priv(idev);
>+	unsigned int status, config;
>+	status =3D tiadc_readl(adc_dev, REG_IRQSTATUS);
>+
>+	/* FIFO Overrun. Clear flag. Disable/Enable ADC to recover */
>+	if (status & IRQENB_FIFO1OVRRUN) {
>+		config =3D tiadc_readl(adc_dev, REG_CTRL);
>+		config &=3D ~(CNTRLREG_TSCSSENB);
>+		tiadc_writel(adc_dev, REG_CTRL, config);
>+		tiadc_writel(adc_dev, REG_IRQSTATUS, IRQENB_FIFO1OVRRUN |
>+				IRQENB_FIFO1UNDRFLW | IRQENB_FIFO1THRES);
>+		tiadc_writel(adc_dev, REG_CTRL, (config | CNTRLREG_TSCSSENB));

I have no idea how other handle this but shouldn't you somehow inform
*anyone* that you lost some samples due to this overrun?

>+	} else if (status & IRQENB_FIFO1THRES) {
>+		/* Wake adc_work that pushes FIFO data to iio buffer */
>+		tiadc_writel(adc_dev, REG_IRQCLR, IRQENB_FIFO1THRES);
>+		adc_dev->data_avail =3D 1;
>+		wake_up_interruptible(&adc_dev->wq_data_avail);
>+	} else
>+		return IRQ_NONE;

Sebastian
