From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Date: Wed, 28 Aug 2013 19:43:21 +0100
Message-ID: <20130828184320.GB3777@gmail.com>
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com>
 <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
 <20130828130124.GC14111@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130828130124.GC14111@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>, jic23@cam.ac.uk, lee.jones@linaro.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 28, 2013 at 03:01:24PM +0200, Sebastian Andrzej Siewior wro=
te:
> * Zubair Lutfullah | 2013-08-25 23:45:24 [+0100]:
>=20
> I am mostly happy with it. There are just two things I pointed out.
> Besides that, it looks good from my side.
Sign-off?

> >+static irqreturn_t tiadc_irq(int irq, void *private)
> >+{
=2E..
> >+	/* If any IRQ flags left, return none. So TSC can handle its IRQs =
*/
> >+	status =3D tiadc_readl(adc_dev, REG_IRQSTATUS);
> >+	if (status =3D=3D false)
> >+		return IRQ_HANDLED;
> >+	else
> >+		return IRQ_NONE;
>=20
> As I said in 1/2 of this series, you shouldn't do this. Both handlers=
 of a
> shared line are invoked once an interrupt is detected.
>=20
> =E2=80=A6
I somehow missed sending these patches to Dmitry..=20
I'll do it next series.

He originally suggested this way.
An alternative was to handle irqs in mfd core which would=20
seriously complicate code and patches..

Whenever I change the handlers to the way you suggest.
i.e. Handle what each irq handler does and return IRQ_HANDLED
if the irq handler handled nothing then return IRQ_NONE.

The driver hangs when I'm brutal while touching the TSC and=20
continuously sampling the ADC. Not always. But happens.

When I check /proc/interrupts the hardware irqs seem to be firing.
But for some reason the whole thing messes up..

> >+static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
> >+{
> >+	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
> >+	struct iio_buffer *buffer =3D indio_dev->buffer;
> >+	unsigned int enb =3D 0, stepnum;
> >+	u8 bit;
> >+
> >+	adc_dev->data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> >+	if (adc_dev->data =3D=3D NULL)
> >+		return -ENOMEM;
> >+
> >+	tiadc_step_config(indio_dev);
> >+	for_each_set_bit(bit, buffer->scan_mask,
> >+			adc_dev->channels) {
> >+		struct iio_chan_spec const *chan =3D indio_dev->channels + bit;
> >+		/*
> >+		 * There are a total of 16 steps available
> >+		 * that are shared between ADC and touchscreen.
> >+		 * We start configuring from step 16 to 0 incase of
> >+		 * ADC. Hence the relation between input channel
> >+		 * and step for ADC would be as below.
> >+		 */
> >+		stepnum =3D chan->channel + 9;
> >+		enb |=3D (1 << stepnum);
>=20
> Hmm. This looks odd.
> =20
> In tiadc_step_config() we do:
> | steps =3D TOTAL_STEPS - adc_dev->channels;
> |=E2=80=A6
> | for (i =3D 0; i < adc_dev->channels; i++) {
> |         chan =3D adc_dev->channel_line[i];
> |         tiadc_writel(adc_dev,
> |                         REG_STEPCONFIG(steps),
> |                         stepconfig
> |                         |
> |                         STEPCONFIG_INP(chan));
> |         tiadc_writel(adc_dev,
> |                         REG_STEPDELAY(steps),
> |                         STEPCONFIG_OPENDLY);
> |         adc_dev->channel_step[i]
> |                 =3D
> |                 steps;
> |         steps++;
> | }
>=20
> That means if we have only one channel we enable the last step bit /
> topmost that is bit 16. For the "default" four channels we get 0x1e00=
0
> as mask which means bit 13 to 16.=20
> If you do have only one channel with the number 4 you then
> get_adc_step_mask() will compute the correct step mask but here enabl=
e
> step 14 instead of step 16.
>=20
> What about the following as replacement?
I sense a mismatch. Probably because of different styles of coding
these bit handling :).

I'll look into it and the alternative way you suggested as well.

Thanks
ZubairLK
