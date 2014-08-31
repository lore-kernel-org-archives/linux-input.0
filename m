From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] m68k/atari: Remove obsolete keyboard_tasklet scheduling
Date: Sun, 31 Aug 2014 11:16:43 +0200
Message-ID: <CAMuHMdVFcFwhnJ0wSOLLucE3hEUavVLMMoqwetG5n9jU57BYiA@mail.gmail.com>
References: <1409328896-8457-1-git-send-email-geert@linux-m68k.org>
	<5402E5D8.6080401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:54246 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaHaJQp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Aug 2014 05:16:45 -0400
In-Reply-To: <5402E5D8.6080401@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Michael,

On Sun, Aug 31, 2014 at 11:07 AM, Michael Schmitz <schmitzmic@gmail.com> wrote:
>> If CONFIG_VT=n:
>>
>> arch/m68k/atari/built-in.o: In function `atari_keyboard_interrupt':
>> atakeyb.c:(.text+0x1846): undefined reference to `keyboard_tasklet'
>> atakeyb.c:(.text+0x1852): undefined reference to `keyboard_tasklet'
>
> Has keyboard_tasklet gone for good, or just been conditionalized on
> CONFIG_VT?

Conditionalized. It's in drivers/tty/vt/keyboard.c.
Note that this was from a randconfig build.

>> I think the keyboard_tasklet scheduling is no longer needed, as I
>> believe it's handled by drivers/tty/vt/keyboard.c based on events
>> received from the input subsystem. So just remove it.
>
> I'd like to test this on real hardware (though ARAnyM does emulate the
> keyboard ACIA IIRC - if you had a working keyboard there I should find no
> different),

Keyboard was still working on ARAnyM.
But AFAICU, the keyboard_tasklet is used for the LED state only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
