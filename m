From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 3/3] iio: Add PAT9125 optical tracker sensor
Date: Sun, 14 Jul 2019 11:27:43 +0100
Message-ID: <20190714112743.0b2bfc70@archlinux>
References: <20190610092945.6330-1-amergnat@baylibre.com>
        <20190610092945.6330-4-amergnat@baylibre.com>
        <20190616163945.06bdbef0@archlinux>
        <CAFGrd9ox2FGpL5a26_weZ9tC9XDTL_QnANR5PNTDYXcus2TJGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFGrd9ox2FGpL5a26_weZ9tC9XDTL_QnANR5PNTDYXcus2TJGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, baylibre-upstreaming@groups.io, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 11 Jul 2019 21:39:10 +0200
Alexandre Mergnat <amergnat@baylibre.com> wrote:

> Le dim. 16 juin 2019 =C3=A0 17:39, Jonathan Cameron <jic23@kernel.org> a =
=C3=A9crit :
> >
> > On Mon, 10 Jun 2019 11:29:45 +0200
> > Alexandre Mergnat <amergnat@baylibre.com> wrote: =20
>  ...
> > =20
> > > +/*
> > > + * To detect if a new value is available, register status is checked=
. This
> > > + * method is safer than using a flag on GPIO IRQ to track event whil=
e sampling
> > > + * because falling edge is missed when device trig just after a read=
 reg value
> > > + * (that happen for fast motions or high CPI setting). =20
> >
> > So we have an edge triggered interrupt that doesn't have a 'minimum low'
> > period? If so then the only safe way to handle it would be as a level
> > interrupt. Can you do that here?
> > (I once had the delights of a sensor like this tied to a edge sensitive=
 only
> > interrupt, but thankfully those are a rare thing these days).
> > =20
>=20
> Trigger level is the first setup I tried (and retried during
> modifications) but it cannot
> works despite of ONESHOT flag. I'm wrong or it's probably due to
> nested_irq because
> it works when I reset interrupt (by reading data) during one of the
> IRQ thread, that what
> I did in my V1 patch. I spent a lot of time to try to use level
> trigger but this is the
> best way I found to do it properly without corner cases.
> The result with nested IRQ and low level trigger is a spamming IRQ
> (probably due to IRQ no more masked during nested IRQ thread) who that st=
uck the
> board because it hasn't time to make an I2C read to reset interrupt pin.

I'm not totally following the explanation.  The level interrupt
should remain masked until the irq_thread completes, as long
as you have the irq as IRQF_ONESHOT. The nesting shouldn't
matter for this as the interrupt should only be
unmasked once we the poll_func handler has completed.

If the device is sampling fast enough, you might find that it's
taken another sample so you get an immediate new interrupt.
If that's the case, then only option is to reducing the sampling
rate.

Of course, it's always possible we have a bug, but there
are quite a few drivers doing things with level interrupts
with no problem, so I'm a little doubtful.

>=20
>=20
> > > + * buffer mode and kernel warning due to nested IRQ thread,
> > > + * this function must return 0.
> > > + */
> > > +static int pat9125_trig_try_reenable(struct iio_trigger *trig)
> > > +{
> > > +     struct pat9125_data *data =3D iio_trigger_get_drvdata(trig);
> > > +     struct regmap *regmap =3D data->regmap;
> > > +     int status =3D 0;
> > > +
> > > +     if (data->sampling) {
> > > +             regmap_read(regmap, PAT9125_MOTION_STATUS_REG, &status);
> > > +             if (status & PAT9125_VALID_MOTION_DATA_BIT) {
> > > +                     data->sampling =3D false; =20
> > So we only ever do 2 reads?  Why can't we be unlucky on timing
> > twice in a row? =20
>=20
> That can works indefinitely, I tested for some retry in a row by
> moving the chip fastly.
> If the method blocked at 2 readings, I should have been stuck during this=
 test.
>=20
> If read status return "New data available", a new read value is done
> through the same
> process (that mean data->sampling put to true) thanks to nested IRQ
> thread which will
> call try_reenable again and then re-check pat9125 status.
Hmm. I'm not totally happy with a test that is based on failing to
trigger it.   We need a theoretical argument for why it can't happen
to back up this code.

Jonathan
