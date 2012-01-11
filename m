From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: q40kbd - convert driver to the split model
Date: Wed, 11 Jan 2012 00:11:18 -0800
Message-ID: <20120111081118.GC18668@core.coreip.homeip.net>
References: <20111231010814.7392.52389.stgit@hammer.corenet.prv>
 <CAMuHMdV+FFPG8TVA7NwfpCvA3+FrVixE4bfdOu8a_1=xTaKiRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:41093 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757060Ab2AKILZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 03:11:25 -0500
Received: by obbup16 with SMTP id up16so504778obb.19
        for <linux-input@vger.kernel.org>; Wed, 11 Jan 2012 00:11:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMuHMdV+FFPG8TVA7NwfpCvA3+FrVixE4bfdOu8a_1=xTaKiRg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org

On Wed, Jan 11, 2012 at 08:55:54AM +0100, Geert Uytterhoeven wrote:
> Hi Dmitry,
>=20
> On Sat, Dec 31, 2011 at 02:11, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Convert the driver to standard spilt model arch-specific code regis=
ters
> > platform device to which driver code can bind later.
> >
> > Also request IRQ immediately upon binding to the device instead of =
doing
> > this when serio port is being opened.
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> >
> > Not tested as I don't have the hardware...
>=20
> Unfortunately I also don't have the hardware.
> But it compiles. A few comments below.
>=20
> > diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
> > index ad10fec..27d3f76 100644
> > --- a/arch/m68k/q40/config.c
> > +++ b/arch/m68k/q40/config.c
>=20
> > +static struct platform_device q40_kbd_pdev =3D {
> > + =A0 =A0 =A0 .name =A0 =3D "q40kbd",
> > + =A0 =A0 =A0 .id =A0 =A0 =3D -1,
> > +};
> > +
> > +static __init int q40_add_kbd_device(void)
> > +{
> > + =A0 =A0 =A0 return platform_device_register(&q40_kbd_pdev);
>=20
> If you would use platform_device_register_simple(), you don't need th=
e
> q40_kbd_pdev above, reducing memory consumption on non-Q40 platforms.

Isn't this file only compiled on q40 platforms?

>=20
> > +}
> > +arch_initcall(q40_add_kbd_device);
>=20
> For the Amiga platform drivers, I used device_initcall().

Won't it potentially race with initialization of q40kbd? It looks like
module_initcall is the same as device_initcall() when module is compile=
d
in. Given that q40kbd uses platform_dveice_probe() losing race might be
fatal.

>=20
> > diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40=
kbd.c
> > index 5eb84b3..1e61dd4 100644
> > --- a/drivers/input/serio/q40kbd.c
> > +++ b/drivers/input/serio/q40kbd.c
> >
> > +static void q40kbd_stop(struct q40kbd *q40kbd)
> > +{
>=20
> The q40kbd parameters is unused and can be removed.
>=20
> > -static int __devinit q40kbd_probe(struct platform_device *dev)
> > +static int __devinit q40kbd_probe(struct platform_device *pdev)
>=20
> > + =A0 =A0 =A0 serio_register_port(q40kbd->port);
>=20
> This cannot fail?
> I see it returns void, but serio_queue_event() inside can fail and th=
us
> won't propagate its error condition and code.

Yes, this is current limitation of serio.

>=20
> > -static int __devexit q40kbd_remove(struct platform_device *dev)
> > +static int __devexit q40kbd_remove(struct platform_device *pdev)
> > =A0{
> > - =A0 =A0 =A0 serio_unregister_port(q40kbd_port);
> > + =A0 =A0 =A0 struct q40kbd *q40kbd =3D platform_get_drvdata(pdev);
> > +
> > + =A0 =A0 =A0 free_irq(Q40_IRQ_KEYBOARD, q40kbd);
> > +
> > + =A0 =A0 =A0 serio_unregister_port(q40kbd->port);
>=20
> Should the unregister be done before freeing the IRQ, i.e. reverse
> order compared to probe?

Unregister will most likely cause memory being freed; you don't want to
chance IRQ firing here.

>=20
> > + =A0 =A0 =A0 kfree(q40kbd);
> > +
> > + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> >
> > =A0 =A0 =A0 =A0return 0;
> > =A0}
>=20
> Thanks, it's a nice cleanup!
>=20

Thanks for lookign this over.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
