From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Input: q40kbd - convert driver to the split model
Date: Wed, 11 Jan 2012 10:25:20 +0100
Message-ID: <CAMuHMdXfs2ru7KG-xFRoKPso5Y+UuAnOOUie8HoOZHYyoVeyaA@mail.gmail.com>
References: <20111231010814.7392.52389.stgit@hammer.corenet.prv>
	<CAMuHMdV+FFPG8TVA7NwfpCvA3+FrVixE4bfdOu8a_1=xTaKiRg@mail.gmail.com>
	<20120111081118.GC18668@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20120111081118.GC18668@core.coreip.homeip.net>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 11, 2012 at 09:11, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jan 11, 2012 at 08:55:54AM +0100, Geert Uytterhoeven wrote:
>> On Sat, Dec 31, 2011 at 02:11, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:

>> > +static struct platform_device q40_kbd_pdev =3D {
>> > +       .name   =3D "q40kbd",
>> > + =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =3D -1,
>> > +};
>> > +
>> > +static __init int q40_add_kbd_device(void)
>> > +{
>> > + =C2=A0 =C2=A0 =C2=A0 return platform_device_register(&q40_kbd_pd=
ev);
>>
>> If you would use platform_device_register_simple(), you don't need t=
he
>> q40_kbd_pdev above, reducing memory consumption on non-Q40 platforms=
=2E
>
> Isn't this file only compiled on q40 platforms?

No, m68k does support multi-platform kernels.

>> > +}
>> > +arch_initcall(q40_add_kbd_device);
>>
>> For the Amiga platform drivers, I used device_initcall().
>
> Won't it potentially race with initialization of q40kbd? It looks lik=
e
> module_initcall is the same as device_initcall() when module is compi=
led
> in. Given that q40kbd uses platform_dveice_probe() losing race might =
be
> fatal.

So far I haven't encountered any problems on Amiga.
I'll look into this.

>> > -static int __devexit q40kbd_remove(struct platform_device *dev)
>> > +static int __devexit q40kbd_remove(struct platform_device *pdev)
>> > =C2=A0{
>> > - =C2=A0 =C2=A0 =C2=A0 serio_unregister_port(q40kbd_port);
>> > + =C2=A0 =C2=A0 =C2=A0 struct q40kbd *q40kbd =3D platform_get_drvd=
ata(pdev);
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 free_irq(Q40_IRQ_KEYBOARD, q40kbd);
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 serio_unregister_port(q40kbd->port);
>>
>> Should the unregister be done before freeing the IRQ, i.e. reverse
>> order compared to probe?
>
> Unregister will most likely cause memory being freed; you don't want =
to
> chance IRQ firing here.

And in the probe case that can't happen when request_irq() is called?

Can a call to q40kbd_stop() first fix that?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
