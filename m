From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] m68k/io: Add missing ioremap define guards, fix typo
Date: Tue, 3 Jul 2018 09:41:38 +0200
Message-ID: <CAMuHMdUHmWiZOofGRFz6Qqphi4iChHa+TY-me_hKEN-xnrrvnA@mail.gmail.com>
References: <20180702133532.5412-1-geert@linux-m68k.org> <20180702133532.5412-2-geert@linux-m68k.org>
 <1349f685-e4a2-5e04-8227-dd55e11153f6@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349f685-e4a2-5e04-8227-dd55e11153f6@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>, netdev <netdev@vger.kernel.org>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Greg,

On Tue, Jul 3, 2018 at 4:13 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 02/07/18 23:35, Geert Uytterhoeven wrote:
> >    - Add missing define guard for ioremap_wt(),
> >    - Fix typo s/ioremap_fillcache/ioremap_fullcache/,
> >    - Add define guard for iounmap() for consistency with other
> >      architectures.
> >
> > Fixes: 9746882f547d2f00 ("m68k: group io mapping definitions and functions")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> If I build for the m5475evb defconfig then I get warnings like this:
>
>    CC      init/main.o
> In file included from ./include/asm-generic/io.h:19:0,
>                   from ./arch/m68k/include/asm/io_no.h:147,
>                   from ./arch/m68k/include/asm/io.h:3,
>                   from ./include/linux/bio.h:28,
>                   from ./include/linux/blkdev.h:21,
>                   from init/main.c:80:
> ./include/asm-generic/iomap.h:79:0: warning: "ioremap_wt" redefined
>   #define ioremap_wt ioremap_nocache
>   ^
> In file included from ./arch/m68k/include/asm/io_no.h:145:0,
>                   from ./arch/m68k/include/asm/io.h:3,
>                   from ./include/linux/bio.h:28,
>                   from ./include/linux/blkdev.h:21,
>                   from init/main.c:80:
> ./arch/m68k/include/asm/kmap.h:37:0: note: this is the location of the previous definition
>   #define ioremap_wt ioremap_wt
>   ^

Thanks, I did some m68knommu compile tests, but didn't see this warning, which
happens for Coldfire+MMU only.

The issue is that there are two ways to declare an architecture has
ioremap_wt():
  1. By defining ioremap_wt,
  2. By defining ARCH_HAS_IOREMAP_WT.

1 is done in arch/m68k/include/asm/kmap.h.
2 is done in arch/m68k/include/asm/io_mm.h. Moving that to kmap.h fixes
the warning. Will send an update shortly.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
