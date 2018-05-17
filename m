From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH v3] Input: add bu21029 touch driver
Date: Thu, 17 May 2018 20:10:27 +0000
Message-ID: <7f0a4cb041354801b732c744ad695495@de.bosch.com>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
 <1526048528-3613-1-git-send-email-mark.jonas@de.bosch.com>
 <CAHp75Vf=eJbJPv5=y3fDKZapAnmABD0=v+WRhrBhMv+RSoBnKg@mail.gmail.com>
 <e514418e94bc4e0492512f7ba24170af@de.bosch.com>
 <20180516174357.GE21971@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516174357.GE21971@dtor-ws>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input <linux-input@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Schocher <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

> > > > +static void bu21029_stop_chip(struct input_dev *dev)
> > > > +{
> > > > +       struct bu21029_ts_data *bu21029 =3D input_get_drvdata(dev);
> > > > +
> > > > +       disable_irq(bu21029->client->irq);
> > > > +       del_timer_sync(&bu21029->timer);
> > > > +
> > > > +       /* put chip into reset */
> > > > +       gpiod_set_value_cansleep(bu21029->reset_gpios, 1);
> > >
> > > > +       udelay(STOP_DELAY_US);
> > >
> > > udelay() ?!
> > >
> > > > +}
> >
> > According to the datasheet disabling the chip will take 30 microseconds=
.
> > In the defines we added a buffer of 20 microseconds and thus
> > STOP_DELAY_US is 50. The function guarantees that the chip is stopped
> > before it returns.
> >
> > We think that it is ok to use udelay() here because in normal operation
> > the chip is not stopped. It is only stopped when loading or unloading
> > the driver, or when the system suspends.
> >
> > We would like to keep it like it is.
>=20
> The issue is not with having delay here, but the kind of delay you are
> using: udelay makes CPU spin for given amount of time; you really want
> msleep() or usleep_range() here.

Understood and changed.

> > > > +static int bu21029_start_chip(struct input_dev *dev)
> > > > +{
> > >
> > > > +       u16 hwid;
> > > > +
> > > > +       /* take chip out of reset */
> > > > +       gpiod_set_value_cansleep(bu21029->reset_gpios, 0);
> > >
> > > > +       mdelay(START_DELAY_MS);
> > >
> > > mdelay()?!
>=20
> Same here - replace with msleep().

Replaced.

> > > Instead...
> > >
> > > > +static int bu21029_suspend(struct device *dev)
> > >
> > > ...use __maby_unused annotation.
> > >
> > > > +static int bu21029_resume(struct device *dev)
> > >
> > > Ditto.
> >
> > OK, added.
>=20
> You also need to drop #ifdef CONFIG_SLEEP. That's the point: we want to
> reduce amount of conditionally compiled code and use __maybe_unused to
> shut off compiler warning about some functions not used in certain
> configurations. We rely on linker to eliminate dead functions from
> executable.

Done.

Greetings,
Mark

 Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
