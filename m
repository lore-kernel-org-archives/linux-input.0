From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 01/18] mfd: add new driver for Sharp LoCoMo
Date: Wed, 27 May 2015 17:55:56 +0300
Message-ID: <CALT56yO5Eu4Bk+_4sn2WgURh9YTsym9inWkvJftKUi_aLy5XXw@mail.gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
	<1432554113-26280-2-git-send-email-dbaryshkov@gmail.com>
	<20150527102756.GH11677@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150527102756.GH11677@x1>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

2015-05-27 13:27 GMT+03:00 Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> On Mon, 25 May 2015, Dmitry Eremin-Solenikov wrote:
>
>> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does has
>> several design issues (special bus instead of platform bus, doesn't use
>> mfd-core, etc).
>>
>> Implement 'core' parts of locomo support as an mfd driver.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>
> These things are much easier to re-review if you keep a change-log
> here.
>
>>  drivers/mfd/Kconfig        |  10 ++
>>  drivers/mfd/Makefile       |   1 +
>>  drivers/mfd/locomo.c       | 336 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/locomo.h | 169 +++++++++++++++++++++++
>>  4 files changed, 516 insertions(+)
>>  create mode 100644 drivers/mfd/locomo.c
>>  create mode 100644 include/linux/mfd/locomo.h
>
> Looks good now though:
>   Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> How do you plan for this to be merged?

I'd like for this to be merged either through mfd tree or through the
arm-soc (or rmk's ARM) tree.
Some of the respective maintainers already gave their blessing for
this patchset to be merged
not through their subsystem trees.

[skipped the patch]


-- 
With best wishes
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
