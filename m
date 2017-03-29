From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
Date: Wed, 29 Mar 2017 09:30:58 +0100
Message-ID: <20170329083058.6pcslbsq3qnifwjv@dell>
References: <539b8756120ab3558c906f7457e65f94dbe37425.1490608293.git.stwiss.opensource@diasemi.com>
 <201703272258.hWlipe1g%fengguang.wu@intel.com>
 <20170328082141.u2rgnhei5yhhzxdn@dell>
 <CAMuHMdX8WH959h50zGQCV7o4E249xBKDn_cVtRbFwYVsVebu9w@mail.gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD69ECA@SW-EX-MBX02.diasemi.com>
 <CAMuHMdU-kaAZ-Reji2v3jSypoDSiwYEWqD0vyYWwJpr6+rAPOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU-kaAZ-Reji2v3jSypoDSiwYEWqD0vyYWwJpr6+rAPOA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kbuild-all-JC7UmRfGjtg@public.gmane.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 28 Mar 2017, Geert Uytterhoeven wrote:

> Hi Steve,
> 
> On Tue, Mar 28, 2017 at 12:42 PM, Steve Twiss
> <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org> wrote:
> > On 28 March 2017 09:37, Geert Uytterhoeven wrote:
> >> Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
> >> On Tue, Mar 28, 2017 at 10:21 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> >> >> [auto build test WARNING on ljones-mfd/for-mfd-next]
> >> >> [also build test WARNING on v4.11-rc4 next-20170327]
> >> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> >> >> config: x86_64-randconfig-x009-201713 (attached as .config)
> >> >> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> >> >> reproduce:
> >> >>         # save the attached .config to linux build tree
> >> >>         make ARCH=x86_64
> >> >>
> >> >> All warnings (new ones prefixed by >>):
> >> >>
> >> >>    drivers//mfd/da9062-core.c: In function 'da9062_i2c_probe':
> >> >> >> drivers//mfd/da9062-core.c:845:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >> >>       chip->chip_type = (int)match->data;
> >> >>                        ^
> >> >
> >> > Please use longs or enums.
> >>
> >> Enums would still give a warning on 64-bit.
> >> The simple fix is change the cast from (int) to (uintptr_t).
> >
> > Hi Lee and Geert,
> >
> > How about this? Fix by redefining the enum chip_type to be an int.
> > Then, just use substitution:
> > #define COMPAT_TYPE_DA9061  1
> > #define COMPAT_TYPE_DA9062  2
> >
> > That would be simple.
> > Are there any reasons this would not be acceptable?
> 
> I don't see how that can help.
> The warning is caused by casting the "void *" (which is either 32-bit or
> 64-bit) in of_device_if.data to an integer or enum (which is always 32-bit).
> 
> The right fix is to cast it to uintptr_t intead of int, like other drivers do.

That's a hack though, isn't it?  chip->chip_type is not of type
uintptr_t, so all you're doing here is making the compiler happy.

I see people using (int)(uintptr_t), which I guess keeps the
compiler happy in the first instance and actually culminates in a
correct cast to the right type.

So how about something like (enum da9062_compatible_types)(long)?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
