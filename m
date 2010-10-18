From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 3/3] Input: touchscreen: ad7877
 filter events where pressure is beyond the maximum
Date: Sun, 17 Oct 2010 21:25:42 -0700
Message-ID: <20101018042541.GB23778@core.coreip.homeip.net>
References: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
 <1287139250-24777-3-git-send-email-michael.hennerich@analog.com>
 <AANLkTimg2Uv26dcU7noSGCX7SHOn2+p6-LH_q=h9NtWc@mail.gmail.com>
 <20101018040810.GB7782@core.coreip.homeip.net>
 <20101018042428.GA23778@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36133 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab0JREZs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 00:25:48 -0400
Received: by yxm8 with SMTP id 8so160153yxm.19
        for <linux-input@vger.kernel.org>; Sun, 17 Oct 2010 21:25:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018042428.GA23778@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: michael.hennerich@analog.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Sun, Oct 17, 2010 at 09:24:28PM -0700, Dmitry Torokhov wrote:
> On Sun, Oct 17, 2010 at 09:08:10PM -0700, Dmitry Torokhov wrote:
> > On Fri, Oct 15, 2010 at 09:51:12PM -0400, Mike Frysinger wrote:
> > > On Fri, Oct 15, 2010 at 06:40,  <michael.hennerich@analog.com> wr=
ote:
> > > > Suppress events where pressure > pressure_max.
> > > > These events come typically along with inaccurate X and Y sampl=
es.
> > >=20
> > > were you going to commit to the blackfin tree ?
> > >=20
> > > > --- a/drivers/input/touchscreen/ad7877.c
> > > > +++ b/drivers/input/touchscreen/ad7877.c
> > > > @@ -360,6 +360,13 @@ static int ad7877_rx(struct ad7877 *ts)
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Rt /=3D z1;
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Rt =3D (Rt + 2047) >> 12;
> > > >
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Sample found inconsistent, p=
ressure is beyond
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the maximum. Don't report it=
 to user space.
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (Rt > ts->pressure_max)
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > >=20
> > > this has spaces in the middle of your tab indents ...
> >=20
> > I took care of that on my side...
> >=20
>=20
> BTW, I have a couple more small patches to the driver... Here is the
> first:
>=20

And here is second:

Input: ad7877 - switch to using threaded IRQ

Instead of using asynchronous SPI API and then spinning waiting for SPI
transfer to complete when disabling the device, let's use threaded IRQ
model and spi_sync().

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ad7877.c |   65 ++++++++++++++--------------=
--------
 1 files changed, 25 insertions(+), 40 deletions(-)


diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchsc=
reen/ad7877.c
index 326d733..a1952fc 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -191,13 +191,12 @@ struct ad7877 {
 	struct spi_message	msg;
=20
 	struct mutex		mutex;
-	unsigned		disabled:1;	/* P: mutex */
-	unsigned		gpio3:1;	/* P: mutex */
-	unsigned		gpio4:1;	/* P: mutex */
+	bool			disabled;	/* P: mutex */
+	bool			gpio3;		/* P: mutex */
+	bool			gpio4;		/* P: mutex */
=20
 	spinlock_t		lock;
 	struct timer_list	timer;		/* P: lock */
-	unsigned		pending:1;	/* P: lock */
=20
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -333,7 +332,7 @@ static int ad7877_read_adc(struct spi_device *spi, =
unsigned command)
 	return status ? : sample;
 }
=20
-static int ad7877_rx(struct ad7877 *ts)
+static int ad7877_process_data(struct ad7877 *ts)
 {
 	struct input_dev *input_dev =3D ts->input;
 	unsigned Rt;
@@ -374,6 +373,7 @@ static int ad7877_rx(struct ad7877 *ts)
 		input_report_abs(input_dev, ABS_Y, y);
 		input_report_abs(input_dev, ABS_PRESSURE, Rt);
 		input_sync(input_dev);
+
 		return 0;
 	}
=20
@@ -392,64 +392,49 @@ static inline void ad7877_ts_event_release(struct=
 ad7877 *ts)
 static void ad7877_timer(unsigned long handle)
 {
 	struct ad7877 *ts =3D (void *)handle;
+	unsigned long flags;
=20
+	spin_lock_irqsave(&ts->lock, flags);
 	ad7877_ts_event_release(ts);
+	spin_unlock_irqrestore(&ts->lock, flags);
 }
=20
 static irqreturn_t ad7877_irq(int irq, void *handle)
 {
 	struct ad7877 *ts =3D handle;
 	unsigned long flags;
-	int status;
+	int error;
=20
-	/*
-	 * The repeated conversion sequencer controlled by TMR kicked off
-	 * too fast. We ignore the last and process the sample sequence
-	 * currently in the queue. It can't be older than 9.4ms, and we
-	 * need to avoid that ts->msg doesn't get issued twice while in work.
-	 */
+	error =3D spi_sync(ts->spi, &ts->msg);
+	if (error) {
+		dev_err(&ts->spi->dev, "spi_sync --> %d\n", error);
+		goto out;
+	}
=20
 	spin_lock_irqsave(&ts->lock, flags);
-	if (!ts->pending) {
-		ts->pending =3D 1;
-
-		status =3D spi_async(ts->spi, &ts->msg);
-		if (status)
-			dev_err(&ts->spi->dev, "spi_sync --> %d\n", status);
-	}
+	error =3D ad7877_process_data(ts);
+	if (!error)
+		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
 	spin_unlock_irqrestore(&ts->lock, flags);
=20
+out:
 	return IRQ_HANDLED;
 }
=20
-static void ad7877_callback(void *_ts)
-{
-	struct ad7877 *ts =3D _ts;
-
-	spin_lock_irq(&ts->lock);
-	if (!ad7877_rx(ts))
-		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
-	ts->pending =3D 0;
-	spin_unlock_irq(&ts->lock);
-}
-
 static void ad7877_disable(struct ad7877 *ts)
 {
 	mutex_lock(&ts->mutex);
=20
 	if (!ts->disabled) {
-		ts->disabled =3D 1;
+		ts->disabled =3D true;
 		disable_irq(ts->spi->irq);
=20
-		/* Wait for spi_async callback */
-		while (ts->pending)
-			msleep(1);
-
 		if (del_timer_sync(&ts->timer))
 			ad7877_ts_event_release(ts);
 	}
=20
-	/* we know the chip's in lowpower mode since we always
+	/*
+	 * We know the chip's in lowpower mode since we always
 	 * leave it that way after every request
 	 */
=20
@@ -461,7 +446,7 @@ static void ad7877_enable(struct ad7877 *ts)
 	mutex_lock(&ts->mutex);
=20
 	if (ts->disabled) {
-		ts->disabled =3D 0;
+		ts->disabled =3D false;
 		enable_irq(ts->spi->irq);
 	}
=20
@@ -672,7 +657,6 @@ static void ad7877_setup_ts_def_msg(struct spi_devi=
ce *spi, struct ad7877 *ts)
=20
 	spi_message_init(m);
=20
-	m->complete =3D ad7877_callback;
 	m->context =3D ts;
=20
 	ts->xfer[0].tx_buf =3D &ts->cmd_crtl1;
@@ -795,8 +779,9 @@ static int __devinit ad7877_probe(struct spi_device=
 *spi)
=20
 	/* Request AD7877 /DAV GPIO interrupt */
=20
-	err =3D request_irq(spi->irq, ad7877_irq, IRQF_TRIGGER_FALLING,
-			spi->dev.driver->name, ts);
+	err =3D request_threaded_irq(spi->irq, NULL, ad7877_irq,
+				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				   spi->dev.driver->name, ts);
 	if (err) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		goto err_free_mem;
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
