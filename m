From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Remove ARCH_SHMOBILE
Date: Thu, 3 Mar 2016 01:00:31 +0900
Message-ID: <CANqRtoQ5R7rpr9uw-9ZASdvFjf11ZUR1vt0CYQY-ADnBTj9eHw@mail.gmail.com>
References: <1456883754-24305-1-git-send-email-horms+renesas@verge.net.au>
	<CAMuHMdU8W1GrBO=UJPk2P+Yt4swrTzxpBR7TNYBGk=N7wqvBcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU8W1GrBO=UJPk2P+Yt4swrTzxpBR7TNYBGk=N7wqvBcQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 2, 2016 at 6:30 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Mar 2, 2016 at 2:55 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
>> [PATCH] Remove ARCH_SHMOBILE
>
> Please use a more appropriate one-line summary.
>
>> Since the removal of legacy (non-multiplatform) support this driver has not
>> been used by any Renesas ARM based SoCs.
>>
>> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
>> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
>> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>  drivers/input/keyboard/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>  Based on v4.5-rc1
>>
>> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
>> index ddd8148d51d7..984532c6e689 100644
>> --- a/drivers/input/keyboard/Kconfig
>> +++ b/drivers/input/keyboard/Kconfig
>> @@ -560,7 +560,7 @@ config KEYBOARD_SUNKBD
>>
>>  config KEYBOARD_SH_KEYSC
>>         tristate "SuperH KEYSC keypad support"
>> -       depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>> +       depends on SUPERH || COMPILE_TEST
>
> I think dropping the SUPERH dependency is the right approach here, as all
> SuperH platforms using the driver select ARCH_SHMOBILE.

Thanks, I agree!

> "sh_keysc" is used on SH_MIGOR, SH_ECOVEC, SH_KFR2R09, SH_7722_SOLUTION_ENGINE,
> and SH_7724_SOLUTION_ENGINE, which depend on either CPU_SUBTYPE_SH7722 or
> CPU_SUBTYPE_SH7724, and both select ARCH_SHMOBILE.
>
>>         help
>>           Say Y here if you want to use a keypad attached to the KEYSC block
>>           on SuperH processors such as sh7722 and sh7343.
>
> FWIW, this has never been enabled on sh7343. But CPU_SUBTYPE_SH7343 also
> selects ARCH_SHMOBILE, so we're safe.

You are right that the SH architecture is the main consumer at this
point. I do however vaguely recall ARM shmobile G3EVM and G4EVM
including sh7367 and some other SoC also having a KEYSC hardware block
included. Due to the iffy interrupt controller upstream support for
those boards/socs were killed off quite some time ago while (not)
migrating to DT. So I think this KEYSC driver is simply a left over
from that time.

Cheers,

/ magnus
