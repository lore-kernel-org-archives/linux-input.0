From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Tue, 20 Aug 2013 17:26:58 +0100
Message-ID: <20130820162657.GA6776@gmail.com>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
 <20130819171238.GA31610@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130819171238.GA31610-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 19, 2013 at 07:12:38PM +0200, Sebastian Andrzej Siewior wro=
te:
> * Zubair Lutfullah | 2013-08-13 21:05:03 [+0100]:
>=20
> >diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am=
335x_adc.c
> >index 3ceac3e..0d7e313 100644
> >--- a/drivers/iio/adc/ti_am335x_adc.c
> >+++ b/drivers/iio/adc/ti_am335x_adc.c
> =E2=80=A6
> >+static irqreturn_t tiadc_irq(int irq, void *private)
> >+{
> =E2=80=A6
> >+		wake_up_interruptible(&adc_dev->wq_data_avail);
> =E2=80=A6
> >+}
> =E2=80=A6
> >+static irqreturn_t tiadc_trigger_h(int irq, void *p)
> >+{
> =E2=80=A6
> >+	schedule_work(&adc_dev->poll_work);
> =E2=80=A6
> >+}
> =E2=80=A6
> >+static void tiadc_adc_work(struct work_struct *work_s)
> >+{
> =E2=80=A6
> >+		wait_event_interruptible(adc_dev->wq_data_avail,
> >+					(adc_dev->data_avail =3D=3D 1));
> =E2=80=A6
> >+}
>=20
> This is not very nice. The problem is that you might sleep in a
> workqueue and so the other jobs will wait until you are done. I'm thi=
nk
This will change to a different style.

> I'm looking into DMA support for this so once your code is working it
> should be possible to switch to DMA instead reading byte wise from th=
e
> fifo.
Great.

> How did you test the whole thing? Do you have a test program which
> selects a few sources and reads them in continuous mode?
>=20
generic_buffer.c runs for this for sysfs trigger..=20
However. If you follow the other thread.=20
This is obsolete and trigger style is changing to a driver trigger.

I'll update when I'm done.

Thanks
ZubairLK
