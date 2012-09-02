From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v3.6-rc4
Date: Sun, 2 Sep 2012 11:33:08 +0200
Message-ID: <CAMuHMdUSGHF4VXa91=n96hnNTywA3e03xp6Ayc32ZyHBn=Vh5A@mail.gmail.com>
References: <1346577700-8156-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346577700-8156-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Sep 2, 2012 at 11:21 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.6-rc4 to v3.6-rc3[3], the summaries are:
>   - build errors: +6/-13

6 regressions:
  + drivers/input/touchscreen/edt-ft5x06.c: error: 'struct
edt_ft5x06_ts_data' has no member named 'raw_buffer':  => 846:14

powerpc-randconfig, fix reported as queued by Dmitry.

  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_restgpr0_25' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff96e4), (.text+0x1ff9438),
(.text+0x1ff8e74)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_restgpr0_28' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff9848)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_restgpr0_30' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff8ea8), (.text+0x1ff8edc)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_savegpr0_29' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff9cf0)
  + error: fore200e.c: relocation truncated to fit: R_PPC64_REL24
against symbol `_restgpr0_22' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff8608), (.text+0x1ff7e5c)

powerpc-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5381/ (all 116 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5359/ (all 116 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
