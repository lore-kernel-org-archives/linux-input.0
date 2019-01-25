From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH][RESEND] wistron_btns needs executable BIOS image
Date: Fri, 25 Jan 2019 13:41:47 -0800
Message-ID: <CAKdAkRSZ6cT=fO42YG320Po6cYtWaPgg2puAf5jMnC+hD+Em2g@mail.gmail.com>
References: <20170731182010.GA933@stranger.qboosh.pl> <20190125191437.GA25902@stranger.qboosh.pl>
 <20190125211349.nfbbcuaip5y6l5dr@dcvr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125211349.nfbbcuaip5y6l5dr@dcvr>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Wong <e@80x24.org>
Cc: Jakub Bogusz <qboosh@pld-linux.org>, lkml <linux-kernel@vger.kernel.org>, Miloslav Trmac <mitr@volny.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jan 25, 2019 at 1:13 PM Eric Wong <e@80x24.org> wrote:
>
> Jakub Bogusz <qboosh@pld-linux.org> wrote:
> > Let's try once again... (take 3)
> >
> > First time I sent this patch when I prepared it in 2013 for Linux 3.12,
> > the second time after update for Linux 4.12 in 2017...
> > And it still applies to Linux 4.20.
>
> Adding Dmitry Torokhov and linux-input to Cc:
> (that's what ./scripts/get_maintainer.pl says)
>
> > Actual description in forwarded message.
> >
> >
> > --
> > Jakub Bogusz    http://qboosh.pl/
>
> > From: Jakub Bogusz <qboosh@pld-linux.org>
> > To: linux-kernel@vger.kernel.org, mitr@volny.cz
> > Subject: [PATCH] wistron_btns needs executable BIOS image
> >
> > Hello,
> >
> > This patch (originally agains 3.1x, now I updated include to build
> > against 4.12.x) fixes winstron_btns module issue with calling BIOS
> > functions in non-executable memory.
> >
> > Tested (on Linux 3.10.x and few later versions) on F-S Amilo 8210 laptop.
> >
> >
> > --
> > Jakub Bogusz    http://qboosh.pl/
>
> > wistron_btns needs executable BIOS image.
> >
> > Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>
> >
> > --- linux-4.12/drivers/input/misc/wistron_btns.c.orig 2013-11-16 09:05:55.612742472 +0100
> > +++ linux-4.12/drivers/input/misc/wistron_btns.c      2013-11-16 09:24:37.356028732 +0100
> > @@ -33,6 +33,7 @@
> >  #include <linux/types.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/leds.h>
> > +#include <asm/set_memory.h>
> >
> >  /* How often we poll keys - msecs */
> >  #define POLL_INTERVAL_DEFAULT        500 /* when idle */
> > @@ -124,6 +125,7 @@
> >       if (entry_point >= 0xF0000) {
> >               bios_code_map_base = base;
> >               bios_entry_point = bios_code_map_base + (entry_point & 0xFFFF);
> > +             set_memory_x((unsigned long)bios_code_map_base, 0x10000 >> PAGE_SHIFT);
> >       } else {
> >               iounmap(base);
> >               bios_code_map_base = ioremap(entry_point & ~0x3FFF, 0x4000);
> > @@ -134,6 +136,7 @@
> >                       goto err;
> >               }
> >               bios_entry_point = bios_code_map_base + (entry_point & 0x3FFF);
> > +             set_memory_x((unsigned long)bios_code_map_base, 0x4000 >> PAGE_SHIFT);
> >       }
> >       /* The Windows driver maps 0x10000 bytes, we keep only one page... */
> >       bios_data_map_base = ioremap(0x400, 0xc00);

It is really weird have __iomem region to have executable bit set. I
wonder if, along with the setting memory to X, we should not change
that ioremap() to memremap()?

Thanks.

-- 
Dmitry
