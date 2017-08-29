From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] input: misc: don't build m68kspkr when mach_beep is
 undefined
Date: Tue, 29 Aug 2017 10:24:12 +1000
Message-ID: <207ddeee-51dc-9b34-f7d9-eff2cb8143d7@linux-m68k.org>
References: <20170824144427.23873-1-alexandre.belloni@free-electrons.com>
 <20170828165031.GD12195@dtor-ws>
 <CAMuHMdV5um5L9WAk9pNEdQiTyT7YkQdgFRKH4vBqCwLPXsqPRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdV5um5L9WAk9pNEdQiTyT7YkQdgFRKH4vBqCwLPXsqPRw@mail.gmail.com>
Content-Language: en-US
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Geert, Dmitry, Alexandre,

On 29/08/17 03:15, Geert Uytterhoeven wrote:
> On Mon, Aug 28, 2017 at 6:50 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Aug 24, 2017 at 04:44:27PM +0200, Alexandre Belloni wrote:
>>> mach_beep is defined arch/m68k/kernel/setup_mm.c which is compiled only
>>> when MMU is selected.
>>>
>>> To avoid linking errors, make INPUT_M68K_BEEP depend on MMU.
>>
>> Hmm, can we maybe pull mach_beep from setup_mm.c to setup.c? MMU
> 
> Sounds OK to me. Greg?

Yeah, I have no problem with that.

At the moment though setup.c is a basic stub with only this in it:

    #ifdef CONFIG_MMU
    #include "setup_mm.c"
    #else
    #include "setup_no.c"
    #endif

It is one of the very few files remaining that we have not fully
re-merged from the original MMU and no-MMU versions.

Maybe its time we looked at cleaning this up as well...

Regards
Greg



>> dependency seems to be artificial.
> 
> That's indeed artificial, it's really a platform dependency.
> But currently these platforms (Amiga and Atari) do not support mmu-less
> operation (yet).
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
