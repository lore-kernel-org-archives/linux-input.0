From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Fri, 16 Aug 2013 22:13:29 +0100
Message-ID: <20130816211312.GB2528@gmail.com>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
 <20130816132549.GD1263@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130816132549.GD1263@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>, jic23@cam.ac.uk, dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Russ.Dill@ti.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 16, 2013 at 03:25:49PM +0200, Sebastian Andrzej Siewior wro=
te:
> * Zubair Lutfullah | 2013-08-13 21:05:03 [+0100]:
>=20
> >diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am=
335x_adc.c
> >index 3ceac3e..0d7e313 100644
> >--- a/drivers/iio/adc/ti_am335x_adc.c
> >+++ b/drivers/iio/adc/ti_am335x_adc.c
> >@@ -141,58 +350,51 @@ static int tiadc_read_raw(struct iio_dev *indi=
o_dev,
> > {
> =E2=80=A6
> >+	if (iio_buffer_enabled(indio_dev))
> >+		return -EBUSY;
> >+	else {
>=20
> You can drop else so you lose one ident level.
>=20
Noted.

> >+		unsigned long timeout =3D jiffies + usecs_to_jiffies
> >+					(IDLE_TIMEOUT * adc_dev->channels);
>=20
> What computing this once? ->channels is assigned at probe time.
>=20
The timeout depends on number of SW enabled channels.
Hence the calculation. In this read_raw, one channel is to be
read.=20
However, all channels are sampled. And the one that the=20
userspace requires is pushed to user.

> >+		/* Wait for ADC sequencer to complete sampling */
> >+		while (tiadc_readl(adc_dev, REG_ADCFSM) & SEQ_STATUS) {
> >+			if (time_after(jiffies, timeout))
> >+				return -EAGAIN;
>=20
> You should check the condition after the timeout occured once again. =
It
> is possible that the task performing the read has been pushed away by=
 a
> higher prio task (or preempted incase this sounds like a bully) and
> after it got back on the cpu the timeout occured but the condition is
> valid and no reason for -EAGAIN.
>=20
> Sebastian

Interesting catch. I'll look into it.

Thanks for pointing it out.

Zubair
