From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/15] new locomo driver
Date: Tue, 28 Oct 2014 04:28:53 +0400
Message-ID: <CALT56yObXu53ZenS6KNJq-Dx-AYuQnWpT+ejyBg+WCm--tfXXg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<20141028001338.GZ27405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141028001338.GZ27405-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-leds <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

2014-10-28 4:13 GMT+04:00 Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>:
> On Tue, Oct 28, 2014 at 03:01:53AM +0300, Dmitry Eremin-Solenikov wrote:
>> Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array. Current
>> drivers present in Linux kernel has some problems:
>>
>>  * It uses custom bus instead of platform bus/mfd core.
>
> I believe Greg wouldn't see that as a positive point.
>
> Don't think that the platform bus _should_ always be used.  It shouldn't
> (Greg has said he'd like to see the platform bus to be totally killed off.)
> Instead, custom buses properly suited to the class of device in question
> is much preferred, especially if it aids in...

I'm sorry, I must be outdated on this topic. Few years ago things were exactly
opposite - we explicitly had to use platform bus for mfd devices. I
still think that
mfd devices containing several cells should use mfd-core (is it still
OK to use it?).
And mfd-core (up to now) uses platform bus.

>
>>  * Device drivers are not well layered/separated.
>
> ... better layering or separation of drivers.
>
> So, thinking that converting from a custom bus to a platform bus
> definitely is /not/ a positive step forward.

Is there an example of new approach? Current locomo-dev implementation
is poisoned with several bugs. For example it passes ioremapped memory
as resources to child devices that later call request_resource() on it.
Adding additional features (like correct work with IRQs) will duplicate
platform bus code and mfd functions.

>
> (Why mfd was ever allowed to re-use the platform bus stuff is a separate
> question not relevent to these patches.)

I remember this story - Ian Molton and me wrote mfd-core.c.

-- 
With best wishes
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
