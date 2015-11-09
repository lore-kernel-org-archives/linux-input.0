From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Input: parkbd - Drop bogus __init from parkbd_allocate_serio()
Date: Mon, 9 Nov 2015 14:13:34 +0100
Message-ID: <CAMuHMdXjPFNH-r4e2TkDomXL+6j_B5Sn0W4JHQnbBppY3CenEw@mail.gmail.com>
References: <1446911603-21242-1-git-send-email-geert@linux-m68k.org>
	<20151109130440.GC3868@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151109130440.GC3868@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Sudip,

On Mon, Nov 9, 2015 at 2:05 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Sat, Nov 07, 2015 at 04:53:23PM +0100, Geert Uytterhoeven wrote:
>> WARNING: vmlinux.o(.text+0x1056606): Section mismatch in reference from the function parkbd_attach() to the function .init.text:parkbd_allocate_serio()
>> The function parkbd_attach() references
>> the function __init parkbd_allocate_serio().
>> This is often because parkbd_attach lacks a __init
>> annotation or the annotation of parkbd_allocate_serio is wrong.
>>
>> Commit 33ca8ab97cbb676d ("Input: parkbd - use parallel port device
>> model") dropped the __init attribute from the sole caller of
>> parkbd_allocate_serio(), but forgot to remove it from
>> parkbd_allocate_serio() itself.
>>
>> Fixes: 33ca8ab97cbb676d ("Input: parkbd - use parallel port device model")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> I don't see this with allmodconfig on i386 or on x86_64. How did you get
> this warning? But anyway, looking at the code, i did miss attribute.

It depends on your compiler version. If your compiler decides to inline
parkbd_allocate_serio(), you won't see that warning.

> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
