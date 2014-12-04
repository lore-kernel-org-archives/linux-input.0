From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] Input: amikbd - Allocate temporary keymap buffer
 on the stack
Date: Thu, 4 Dec 2014 10:00:12 +0100
Message-ID: <CAMuHMdUXz3cE+SpVEKVbr6OeJpyssCesF3=s1jKK8ZrA=hPNJw@mail.gmail.com>
References: <1417339820-5285-1-git-send-email-geert@linux-m68k.org>
	<1417339820-5285-2-git-send-email-geert@linux-m68k.org>
	<20141203225934.GF16951@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20141203225934.GF16951@dtor-ws>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Wed, Dec 3, 2014 at 11:59 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Nov 30, 2014 at 10:30:20AM +0100, Geert Uytterhoeven wrote:
>> Allocate the temporary buffer needed for initialization of the console
>> keyboard maps (512 bytes, as NR_KEYS = 256) on the stack instead of
>> statically, to reduce kernel size.
>>
>> add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-512 (-512)
>> function                                     old     new   delta
>> temp_map                                     512       -    -512
>
> So because it is marked __initdata and is placed into a separate
> section we have to allocate the space in the image?

Indeed. __initdata consumes space in both the vmlinux image and in
memory.
Note that we don't have __initbss for uninitialized data, which would
obviously still consume space in memory.

> Anyway, applied both, thank you.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
