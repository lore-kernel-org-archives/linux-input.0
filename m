From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Fri, 16 Aug 2013 15:25:49 +0200
Message-ID: <20130816132549.GD1263@linutronix.de>
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
>@@ -141,58 +350,51 @@ static int tiadc_read_raw(struct iio_dev *indio_=
dev,
> {
=E2=80=A6
>+	if (iio_buffer_enabled(indio_dev))
>+		return -EBUSY;
>+	else {

You can drop else so you lose one ident level.

>+		unsigned long timeout =3D jiffies + usecs_to_jiffies
>+					(IDLE_TIMEOUT * adc_dev->channels);

What computing this once? ->channels is assigned at probe time.

>+		step_en =3D get_adc_step_mask(adc_dev);
>+		am335x_tsc_se_set(adc_dev->mfd_tscadc, step_en);
>+
>+		/* Wait for ADC sequencer to complete sampling */
>+		while (tiadc_readl(adc_dev, REG_ADCFSM) & SEQ_STATUS) {
>+			if (time_after(jiffies, timeout))
>+				return -EAGAIN;

You should check the condition after the timeout occured once again. It
is possible that the task performing the read has been pushed away by a
higher prio task (or preempted incase this sounds like a bully) and
after it got back on the cpu the timeout occured but the condition is
valid and no reason for -EAGAIN.

>+			}
and the bracket needs to left by one tab.

Sebastian
