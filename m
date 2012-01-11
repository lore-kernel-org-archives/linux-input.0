From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Input: q40kbd - convert driver to the split model
Date: Wed, 11 Jan 2012 08:55:54 +0100
Message-ID: <CAMuHMdV+FFPG8TVA7NwfpCvA3+FrVixE4bfdOu8a_1=xTaKiRg@mail.gmail.com>
References: <20111231010814.7392.52389.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40929 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab2AKHzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 02:55:55 -0500
Received: by wibhm14 with SMTP id hm14so147632wib.19
        for <linux-input@vger.kernel.org>; Tue, 10 Jan 2012 23:55:54 -0800 (PST)
In-Reply-To: <20111231010814.7392.52389.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org

Hi Dmitry,

On Sat, Dec 31, 2011 at 02:11, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Convert the driver to standard spilt model arch-specific code registe=
rs
> platform device to which driver code can bind later.
>
> Also request IRQ immediately upon binding to the device instead of do=
ing
> this when serio port is being opened.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> Not tested as I don't have the hardware...

Unfortunately I also don't have the hardware.
But it compiles. A few comments below.

> diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
> index ad10fec..27d3f76 100644
> --- a/arch/m68k/q40/config.c
> +++ b/arch/m68k/q40/config.c

> +static struct platform_device q40_kbd_pdev =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "q40kbd",
> + =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =3D -1,
> +};
> +
> +static __init int q40_add_kbd_device(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return platform_device_register(&q40_kbd_pdev)=
;

If you would use platform_device_register_simple(), you don't need the
q40_kbd_pdev above, reducing memory consumption on non-Q40 platforms.

> +}
> +arch_initcall(q40_add_kbd_device);

=46or the Amiga platform drivers, I used device_initcall().

> diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kb=
d.c
> index 5eb84b3..1e61dd4 100644
> --- a/drivers/input/serio/q40kbd.c
> +++ b/drivers/input/serio/q40kbd.c
>
> +static void q40kbd_stop(struct q40kbd *q40kbd)
> +{

The q40kbd parameters is unused and can be removed.

> -static int __devinit q40kbd_probe(struct platform_device *dev)
> +static int __devinit q40kbd_probe(struct platform_device *pdev)

> + =C2=A0 =C2=A0 =C2=A0 serio_register_port(q40kbd->port);

This cannot fail?
I see it returns void, but serio_queue_event() inside can fail and thus
won't propagate its error condition and code.

> -static int __devexit q40kbd_remove(struct platform_device *dev)
> +static int __devexit q40kbd_remove(struct platform_device *pdev)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 serio_unregister_port(q40kbd_port);
> + =C2=A0 =C2=A0 =C2=A0 struct q40kbd *q40kbd =3D platform_get_drvdata=
(pdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 free_irq(Q40_IRQ_KEYBOARD, q40kbd);
> +
> + =C2=A0 =C2=A0 =C2=A0 serio_unregister_port(q40kbd->port);

Should the unregister be done before freeing the IRQ, i.e. reverse
order compared to probe?

> + =C2=A0 =C2=A0 =C2=A0 kfree(q40kbd);
> +
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}

Thanks, it's a nice cleanup!

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
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
