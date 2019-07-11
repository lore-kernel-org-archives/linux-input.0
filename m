From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v3 3/3] iio: Add PAT9125 optical tracker sensor
Date: Thu, 11 Jul 2019 21:39:10 +0200
Message-ID: <CAFGrd9ox2FGpL5a26_weZ9tC9XDTL_QnANR5PNTDYXcus2TJGw@mail.gmail.com>
References: <20190610092945.6330-1-amergnat@baylibre.com> <20190610092945.6330-4-amergnat@baylibre.com>
 <20190616163945.06bdbef0@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190616163945.06bdbef0@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, baylibre-upstreaming@groups.io, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Le dim. 16 juin 2019 =C3=A0 17:39, Jonathan Cameron <jic23@kernel.org> a =
=C3=A9crit :
>
> On Mon, 10 Jun 2019 11:29:45 +0200
> Alexandre Mergnat <amergnat@baylibre.com> wrote:
 ...
>
> > +/*
> > + * To detect if a new value is available, register status is checked. =
This
> > + * method is safer than using a flag on GPIO IRQ to track event while =
sampling
> > + * because falling edge is missed when device trig just after a read r=
eg value
> > + * (that happen for fast motions or high CPI setting).
>
> So we have an edge triggered interrupt that doesn't have a 'minimum low'
> period? If so then the only safe way to handle it would be as a level
> interrupt. Can you do that here?
> (I once had the delights of a sensor like this tied to a edge sensitive o=
nly
> interrupt, but thankfully those are a rare thing these days).
>

Trigger level is the first setup I tried (and retried during
modifications) but it cannot
works despite of ONESHOT flag. I'm wrong or it's probably due to
nested_irq because
it works when I reset interrupt (by reading data) during one of the
IRQ thread, that what
I did in my V1 patch. I spent a lot of time to try to use level
trigger but this is the
best way I found to do it properly without corner cases.
The result with nested IRQ and low level trigger is a spamming IRQ
(probably due to IRQ no more masked during nested IRQ thread) who that stuc=
k the
board because it hasn't time to make an I2C read to reset interrupt pin.


> > + * buffer mode and kernel warning due to nested IRQ thread,
> > + * this function must return 0.
> > + */
> > +static int pat9125_trig_try_reenable(struct iio_trigger *trig)
> > +{
> > +     struct pat9125_data *data =3D iio_trigger_get_drvdata(trig);
> > +     struct regmap *regmap =3D data->regmap;
> > +     int status =3D 0;
> > +
> > +     if (data->sampling) {
> > +             regmap_read(regmap, PAT9125_MOTION_STATUS_REG, &status);
> > +             if (status & PAT9125_VALID_MOTION_DATA_BIT) {
> > +                     data->sampling =3D false;
> So we only ever do 2 reads?  Why can't we be unlucky on timing
> twice in a row?

That can works indefinitely, I tested for some retry in a row by
moving the chip fastly.
If the method blocked at 2 readings, I should have been stuck during this t=
est.

If read status return "New data available", a new read value is done
through the same
process (that mean data->sampling put to true) thanks to nested IRQ
thread which will
call try_reenable again and then re-check pat9125 status.
