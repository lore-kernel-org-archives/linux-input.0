From: Miguel Ojeda <miguel.ojeda.sandonis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Logitech G13 driver (fixed cc list --- ignore others)
Date: Thu, 14 Jan 2010 22:08:07 +0100
Message-ID: <ca2dc2821001141308s5a552447yb887f619231f449@mail.gmail.com>
References: <200912142122.nBELMW7d001243@mustang.cs.nmsu.edu>
	 <20091216103423.GE1377@ucw.cz>
	 <alpine.LNX.2.00.0912161504360.3755@pobox.suse.cz>
	 <7f9100aac5f9b06ec78efff25c7a5a71.squirrel@intranet.cs.nmsu.edu>
	 <20100104224817.GA21695@elf.ucw.cz>
	 <45a44e481001041614i35ceef84q5f12a068e2f0b97b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <45a44e481001041614i35ceef84q5f12a068e2f0b97b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, krzysztof.h1-5tc4TXWwyLM@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 5, 2010 at 1:14 AM, Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
> On Tue, Jan 5, 2010 at 6:48 AM, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
>>
>> Ok, but I guess you should cc auxdisplay people in future.
>
> Hi Pavel,
>
> I just looked at the drivers/auxdisplay directory and got a bit
> confused. The reason I got confused is because auxdisplay is actually
> an fbdev driver but it is outside of the drivers/video directory. It
> looks like there has only been 1 commit and that was for the Samsung
> KS0108 controller. It also sort of uses platform support but the way
> it is abstracted is odd to my thinking. The controller is ks0108, so
> in my mind that would be the code that would be platform independent,
> and then that would use a board specific IO driver to push data (eg:
> parport or gpio or usb). I think in the long term it would probably
> make sense to write a cleaner approach with a drivers/video/ks0108.c
> which is cleanly platform independent (and back within fbdev proper)
> and then a board specific driver in the appropriate location that
> handles the IO.

I wrote long ago the driver(s) and people that reviewed it thought it
was better to keep it outside. I think that if someone else is going
to need ks0108, then I agree: we should write a independent driver.

It should not be hard, it is an easy controller to play with and the
code is already there. I would try to do it; however, I am not sure if
I would be the most appropriate person to code such generic driver, as
I know almost nothing about all drivers/video/* stuff and the ways of
making it truly generic for future video/ users. Still, I will help
gladly.

>
> Thanks,
> jaya
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
