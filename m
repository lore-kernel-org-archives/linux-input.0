From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: q40kbd - convert driver to the split model
Date: Wed, 11 Jan 2012 09:30:51 -0800
Message-ID: <20120111173051.GB21047@core.coreip.homeip.net>
References: <20111231010814.7392.52389.stgit@hammer.corenet.prv>
 <CAMuHMdV+FFPG8TVA7NwfpCvA3+FrVixE4bfdOu8a_1=xTaKiRg@mail.gmail.com>
 <20120111081118.GC18668@core.coreip.homeip.net>
 <CAMuHMdXfs2ru7KG-xFRoKPso5Y+UuAnOOUie8HoOZHYyoVeyaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfs2ru7KG-xFRoKPso5Y+UuAnOOUie8HoOZHYyoVeyaA@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 11, 2012 at 10:25:20AM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 11, 2012 at 09:11, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Jan 11, 2012 at 08:55:54AM +0100, Geert Uytterhoeven wrote:
> >> On Sat, Dec 31, 2011 at 02:11, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
>=20
> >> > +static struct platform_device q40_kbd_pdev =3D {
> >> > +       .name   =3D "q40kbd",
> >> > + =A0 =A0 =A0 .id =A0 =A0 =3D -1,
> >> > +};
> >> > +
> >> > +static __init int q40_add_kbd_device(void)
> >> > +{
> >> > + =A0 =A0 =A0 return platform_device_register(&q40_kbd_pdev);
> >>
> >> If you would use platform_device_register_simple(), you don't need=
 the
> >> q40_kbd_pdev above, reducing memory consumption on non-Q40 platfor=
ms.
> >
> > Isn't this file only compiled on q40 platforms?
>=20
> No, m68k does support multi-platform kernels.

OK, I'll do dynamic platform device allocation.

>=20
> >> > +}
> >> > +arch_initcall(q40_add_kbd_device);
> >>
> >> For the Amiga platform drivers, I used device_initcall().
> >
> > Won't it potentially race with initialization of q40kbd? It looks l=
ike
> > module_initcall is the same as device_initcall() when module is com=
piled
> > in. Given that q40kbd uses platform_dveice_probe() losing race migh=
t be
> > fatal.
>=20
> So far I haven't encountered any problems on Amiga.
> I'll look into this.

I guess link order (arch before drivers) saves you here but it is not
very clean.

>
> >> > -static int __devexit q40kbd_remove(struct platform_device *dev)
> >> > +static int __devexit q40kbd_remove(struct platform_device *pdev=
)
> >> > =A0{
> >> > - =A0 =A0 =A0 serio_unregister_port(q40kbd_port);
> >> > + =A0 =A0 =A0 struct q40kbd *q40kbd =3D platform_get_drvdata(pde=
v);
> >> > +
> >> > + =A0 =A0 =A0 free_irq(Q40_IRQ_KEYBOARD, q40kbd);
> >> > +
> >> > + =A0 =A0 =A0 serio_unregister_port(q40kbd->port);
> >>
> >> Should the unregister be done before freeing the IRQ, i.e. reverse
> >> order compared to probe?
> >
> > Unregister will most likely cause memory being freed; you don't wan=
t to
> > chance IRQ firing here.
>=20
> And in the probe case that can't happen when request_irq() is called?

We explicitly do q40kbd_stop() before requesting IRQ. Frankly serio
will be stopped by the serio core (via serio->stop() which is
q40kbd_stop()) so freeing IRQ fisrt should be fine, it just was looking
scary. I'll revert the order and add a comment.

Thanks.

--=20
Dmitry
