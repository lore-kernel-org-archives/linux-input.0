From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] input: misc: don't build m68kspkr when mach_beep is undefined
Date: Mon, 28 Aug 2017 19:15:46 +0200
Message-ID: <CAMuHMdV5um5L9WAk9pNEdQiTyT7YkQdgFRKH4vBqCwLPXsqPRw@mail.gmail.com>
References: <20170824144427.23873-1-alexandre.belloni@free-electrons.com> <20170828165031.GD12195@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170828165031.GD12195@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, Aug 28, 2017 at 6:50 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Aug 24, 2017 at 04:44:27PM +0200, Alexandre Belloni wrote:
>> mach_beep is defined arch/m68k/kernel/setup_mm.c which is compiled only
>> when MMU is selected.
>>
>> To avoid linking errors, make INPUT_M68K_BEEP depend on MMU.
>
> Hmm, can we maybe pull mach_beep from setup_mm.c to setup.c? MMU

Sounds OK to me. Greg?

> dependency seems to be artificial.

That's indeed artificial, it's really a platform dependency.
But currently these platforms (Amiga and Atari) do not support mmu-less
operation (yet).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
