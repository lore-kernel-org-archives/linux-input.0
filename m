From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/5] m68k: IO Fixes and Cleanups
Date: Wed, 18 Jul 2018 13:37:34 +0200
Message-ID: <CAMuHMdVCA4C4TYfeM+McL2EhHzUrPDEfP14oinYVp10KdOoiBA@mail.gmail.com>
References: <20180709093040.23597-1-geert@linux-m68k.org> <0f38c6fd-82f1-7211-3b2e-425bbd44b157@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f38c6fd-82f1-7211-3b2e-425bbd44b157@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>, netdev <netdev@vger.kernel.org>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 10, 2018 at 3:48 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 09/07/18 19:30, Geert Uytterhoeven wrote:
> > This patch series contains fixes and cleanups for I/O accessors on m68k
> > platforms (with MMU).
> >
> > The first patch contains small fixes without any dependencies.
> > Patches 2 and 3 make small adjustments to drivers that are dependencies
> > for further cleanup.
> > Patch 4 and 5 complete the cleanup.
> >
> > Changes compared to v1:
> >    - Move ARCH_HAS_IOREMAP_WT to fix "ioremap_wt redefined" warnings with
> >      m5475evb defconfig,
> >    - Add Acked-by.
> >
> > Given the dependencies, I think it's easiest if the respective
> > maintainers would provide their Acked-by, so all patches can go in
> > through the m68k tree.
>
> Retested on ColdFire 5475, looks good.
> For the whole series:
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Thanks, applied and queued for v4.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
