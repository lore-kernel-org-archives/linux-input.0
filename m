From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Date: Wed, 28 Aug 2013 15:01:24 +0200
Message-ID: <20130828130124.GC14111@linutronix.de>
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com>
 <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, lee.jones@linaro.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-input@vger.kernel.org

* Zubair Lutfullah | 2013-08-25 23:45:24 [+0100]:

I am mostly happy with it. There are just two things I pointed out.
Besides that, it looks good from my side.

>diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am33=
5x_adc.c
>index a952538..ae2202b 100644
>--- a/drivers/iio/adc/ti_am335x_adc.c
>+++ b/drivers/iio/adc/ti_am335x_adc.c
>@@ -85,7 +96,175 @@ static void tiadc_step_config(struct tiadc_device =
*adc_dev)
> 		adc_dev->channel_step[i] =3D steps;
> 		steps++;
> 	}
>+}
>+
>+static irqreturn_t tiadc_irq(int irq, void *private)
>+{
>+	struct iio_dev *indio_dev =3D private;
>+	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
>+	unsigned int status, config;
>+	status =3D tiadc_readl(adc_dev, REG_IRQSTATUS);
>+
>+	/*
>+	 * ADC and touchscreen share the IRQ line.
>+	 * FIFO0 interrupts are used by TSC. Handle FIFO1 IRQs here only
>+	 */
>+	if (status & IRQENB_FIFO1OVRRUN) {
>+		/* FIFO Overrun. Clear flag. Disable/Enable ADC to recover */
>+		config =3D tiadc_readl(adc_dev, REG_CTRL);
>+		config &=3D ~(CNTRLREG_TSCSSENB);
>+		tiadc_writel(adc_dev, REG_CTRL, config);
>+		tiadc_writel(adc_dev, REG_IRQSTATUS, IRQENB_FIFO1OVRRUN
>+				| IRQENB_FIFO1UNDRFLW | IRQENB_FIFO1THRES);
>+		tiadc_writel(adc_dev, REG_CTRL, (config | CNTRLREG_TSCSSENB));
>+	} else if (status & IRQENB_FIFO1THRES) {
>+		/* Trigger to push FIFO data to iio buffer */
>+		tiadc_writel(adc_dev, REG_IRQCLR, IRQENB_FIFO1THRES);
>+		iio_trigger_poll(indio_dev->trig, iio_get_time_ns());
>+	} else
>+		return IRQ_NONE;
>+
>+	/* If any IRQ flags left, return none. So TSC can handle its IRQs */
>+	status =3D tiadc_readl(adc_dev, REG_IRQSTATUS);
>+	if (status =3D=3D false)
>+		return IRQ_HANDLED;
>+	else
>+		return IRQ_NONE;

As I said in 1/2 of this series, you shouldn't do this. Both handlers o=
f a
shared line are invoked once an interrupt is detected.

=E2=80=A6

>+static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
>+{
>+	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
>+	struct iio_buffer *buffer =3D indio_dev->buffer;
>+	unsigned int enb =3D 0, stepnum;
>+	u8 bit;
>+
>+	adc_dev->data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>+	if (adc_dev->data =3D=3D NULL)
>+		return -ENOMEM;
>+
>+	tiadc_step_config(indio_dev);
>+	for_each_set_bit(bit, buffer->scan_mask,
>+			adc_dev->channels) {
>+		struct iio_chan_spec const *chan =3D indio_dev->channels + bit;
>+		/*
>+		 * There are a total of 16 steps available
>+		 * that are shared between ADC and touchscreen.
>+		 * We start configuring from step 16 to 0 incase of
>+		 * ADC. Hence the relation between input channel
>+		 * and step for ADC would be as below.
>+		 */
>+		stepnum =3D chan->channel + 9;
>+		enb |=3D (1 << stepnum);

Hmm. This looks odd.
=20
In tiadc_step_config() we do:
| steps =3D TOTAL_STEPS - adc_dev->channels;
|=E2=80=A6
| for (i =3D 0; i < adc_dev->channels; i++) {
|         chan =3D adc_dev->channel_line[i];
|         tiadc_writel(adc_dev,
|                         REG_STEPCONFIG(steps),
|                         stepconfig
|                         |
|                         STEPCONFIG_INP(chan));
|         tiadc_writel(adc_dev,
|                         REG_STEPDELAY(steps),
|                         STEPCONFIG_OPENDLY);
|         adc_dev->channel_step[i]
|                 =3D
|                 steps;
|         steps++;
| }

That means if we have only one channel we enable the last step bit /
topmost that is bit 16. For the "default" four channels we get 0x1e000
as mask which means bit 13 to 16.=20
If you do have only one channel with the number 4 you then
get_adc_step_mask() will compute the correct step mask but here enable
step 14 instead of step 16.

What about the following as replacement?

index 08681d3..3bfcf1b 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -65,6 +65,11 @@ static u32 get_adc_step_mask(struct tiadc_device *ad=
c_dev)
 	return step_en;
 }
=20
+static u32 get_adc_step_bit(struct tiadc_device *adc_dev, int chan)
+{
+	return 1 << adc_dev->channel_step[chan];
+}
+
 static void tiadc_step_config(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
@@ -179,7 +187,7 @@ static int tiadc_buffer_postenable(struct iio_dev *=
indio_dev)
 {
 	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
 	struct iio_buffer *buffer =3D indio_dev->buffer;
-	unsigned int enb =3D 0, stepnum;
+	unsigned int enb =3D 0;
 	u8 bit;
=20
 	adc_dev->data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
@@ -187,19 +195,8 @@ static int tiadc_buffer_postenable(struct iio_dev =
*indio_dev)
 		return -ENOMEM;
=20
 	tiadc_step_config(indio_dev);
-	for_each_set_bit(bit, buffer->scan_mask,
-			adc_dev->channels) {
-		struct iio_chan_spec const *chan =3D indio_dev->channels + bit;
-		/*
-		 * There are a total of 16 steps available
-		 * that are shared between ADC and touchscreen.
-		 * We start configuring from step 16 to 0 incase of
-		 * ADC. Hence the relation between input channel
-		 * and step for ADC would be as below.
-		 */
-		stepnum =3D chan->channel + 9;
-		enb |=3D (1 << stepnum);
-	}
+	for_each_set_bit(bit, buffer->scan_mask, adc_dev->channels)
+		enb |=3D get_adc_step_bit(adc_dev, bit);
=20
 	adc_dev->buffer_en_ch_steps =3D enb;
 	am335x_tsc_se_set(adc_dev->mfd_tscadc, enb);


Would it work? This is untested but it could work :)

Sebastian
