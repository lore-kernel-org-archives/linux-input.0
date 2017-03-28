From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
Date: Tue, 28 Mar 2017 12:50:47 +0200
Message-ID: <CAMuHMdU-kaAZ-Reji2v3jSypoDSiwYEWqD0vyYWwJpr6+rAPOA@mail.gmail.com>
References: <539b8756120ab3558c906f7457e65f94dbe37425.1490608293.git.stwiss.opensource@diasemi.com>
 <201703272258.hWlipe1g%fengguang.wu@intel.com> <20170328082141.u2rgnhei5yhhzxdn@dell>
 <CAMuHMdX8WH959h50zGQCV7o4E249xBKDn_cVtRbFwYVsVebu9w@mail.gmail.com> <6ED8E3B22081A4459DAC7699F3695FB7018CD69ECA@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34187 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754450AbdC1KvI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Mar 2017 06:51:08 -0400
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD69ECA@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, kbuild test robot <lkp@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>

Hi Steve,

On Tue, Mar 28, 2017 at 12:42 PM, Steve Twiss
<stwiss.opensource@diasemi.com> wrote:
> On 28 March 2017 09:37, Geert Uytterhoeven wrote:
>> Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
>> On Tue, Mar 28, 2017 at 10:21 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> >> [auto build test WARNING on ljones-mfd/for-mfd-next]
>> >> [also build test WARNING on v4.11-rc4 next-20170327]
>> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
>> >> config: x86_64-randconfig-x009-201713 (attached as .config)
>> >> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> >> reproduce:
>> >>         # save the attached .config to linux build tree
>> >>         make ARCH=x86_64
>> >>
>> >> All warnings (new ones prefixed by >>):
>> >>
>> >>    drivers//mfd/da9062-core.c: In function 'da9062_i2c_probe':
>> >> >> drivers//mfd/da9062-core.c:845:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>> >>       chip->chip_type = (int)match->data;
>> >>                        ^
>> >
>> > Please use longs or enums.
>>
>> Enums would still give a warning on 64-bit.
>> The simple fix is change the cast from (int) to (uintptr_t).
>
> Hi Lee and Geert,
>
> How about this? Fix by redefining the enum chip_type to be an int.
> Then, just use substitution:
> #define COMPAT_TYPE_DA9061  1
> #define COMPAT_TYPE_DA9062  2
>
> That would be simple.
> Are there any reasons this would not be acceptable?

I don't see how that can help.
The warning is caused by casting the "void *" (which is either 32-bit or
64-bit) in of_device_if.data to an integer or enum (which is always 32-bit).

The right fix is to cast it to uintptr_t intead of int, like other drivers do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
