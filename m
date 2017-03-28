From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
Date: Tue, 28 Mar 2017 10:36:43 +0200
Message-ID: <CAMuHMdX8WH959h50zGQCV7o4E249xBKDn_cVtRbFwYVsVebu9w@mail.gmail.com>
References: <539b8756120ab3558c906f7457e65f94dbe37425.1490608293.git.stwiss.opensource@diasemi.com>
 <201703272258.hWlipe1g%fengguang.wu@intel.com> <20170328082141.u2rgnhei5yhhzxdn@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328082141.u2rgnhei5yhhzxdn@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, "kbuild-all-JC7UmRfGjtg@public.gmane.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Lee,

On Tue, Mar 28, 2017 at 10:21 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> [auto build test WARNING on ljones-mfd/for-mfd-next]
>> [also build test WARNING on v4.11-rc4 next-20170327]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Steve-Twiss/Documentation-devicetree-watchdog-da9062-61-watchdog-timer-binding/20170327-215359
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
>> config: x86_64-randconfig-x009-201713 (attached as .config)
>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64
>>
>> All warnings (new ones prefixed by >>):
>>
>>    drivers//mfd/da9062-core.c: In function 'da9062_i2c_probe':
>> >> drivers//mfd/da9062-core.c:845:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>       chip->chip_type = (int)match->data;
>>                        ^
>
> Please use longs or enums.

Enums would still give a warning on 64-bit.
The simple fix is change the cast from (int) to (uintptr_t).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
