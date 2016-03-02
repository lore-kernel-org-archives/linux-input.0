From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Remove ARCH_SHMOBILE
Date: Wed, 2 Mar 2016 17:08:52 +0100
Message-ID: <CAMuHMdXBOUANzg-UiDTHDU7GvDw2--9peUJ9UMkngrYhuAinbQ@mail.gmail.com>
References: <1456883754-24305-1-git-send-email-horms+renesas@verge.net.au>
	<CAMuHMdU8W1GrBO=UJPk2P+Yt4swrTzxpBR7TNYBGk=N7wqvBcQ@mail.gmail.com>
	<CANqRtoQ5R7rpr9uw-9ZASdvFjf11ZUR1vt0CYQY-ADnBTj9eHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CANqRtoQ5R7rpr9uw-9ZASdvFjf11ZUR1vt0CYQY-ADnBTj9eHw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Magnus,

On Wed, Mar 2, 2016 at 5:00 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Mar 2, 2016 at 6:30 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, Mar 2, 2016 at 2:55 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
>>> --- a/drivers/input/keyboard/Kconfig
>>> +++ b/drivers/input/keyboard/Kconfig
>>> @@ -560,7 +560,7 @@ config KEYBOARD_SUNKBD
>>>
>>>  config KEYBOARD_SH_KEYSC
>>>         tristate "SuperH KEYSC keypad support"
>>> -       depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>>> +       depends on SUPERH || COMPILE_TEST
>>
>> I think dropping the SUPERH dependency is the right approach here, as all
>> SuperH platforms using the driver select ARCH_SHMOBILE.
>
> Thanks, I agree!
>
>> "sh_keysc" is used on SH_MIGOR, SH_ECOVEC, SH_KFR2R09, SH_7722_SOLUTION_ENGINE,
>> and SH_7724_SOLUTION_ENGINE, which depend on either CPU_SUBTYPE_SH7722 or
>> CPU_SUBTYPE_SH7724, and both select ARCH_SHMOBILE.
>>
>>>         help
>>>           Say Y here if you want to use a keypad attached to the KEYSC block
>>>           on SuperH processors such as sh7722 and sh7343.
>>
>> FWIW, this has never been enabled on sh7343. But CPU_SUBTYPE_SH7343 also
>> selects ARCH_SHMOBILE, so we're safe.
>
> You are right that the SH architecture is the main consumer at this
> point. I do however vaguely recall ARM shmobile G3EVM and G4EVM
> including sh7367 and some other SoC also having a KEYSC hardware block
> included. Due to the iffy interrupt controller upstream support for
> those boards/socs were killed off quite some time ago while (not)
> migrating to DT. So I think this KEYSC driver is simply a left over
> from that time.

Note that sh73a0 also has keysc, but I don't think it's usable on kzm9g
(after a quick look at the schematics).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
