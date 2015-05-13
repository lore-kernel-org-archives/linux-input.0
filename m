From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 02/17] leds: port locomo leds driver to new locomo core
Date: Wed, 13 May 2015 09:42:48 -0700
Message-ID: <20150513164248.GB11891@dtor-ws>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-3-git-send-email-dbaryshkov@gmail.com>
 <554A2DB4.3020000@samsung.com>
 <CALT56yNJWapNw1XLrzfbUDUz1LF_BB9DfF94H6GhbnBUEP80_w@mail.gmail.com>
 <555327EA.5060402@samsung.com>
 <CALT56yOJyZvWF9neC2A09Y_w1Ej41uwWvU=aOOM0idbzUkBiFQ@mail.gmail.com>
 <5553654F.4010608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5553654F.4010608-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-leds <linux-leds-u79uwXL29TZUIDd8j+nm9g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 13, 2015 at 04:53:03PM +0200, Jacek Anaszewski wrote:
> On 05/13/2015 04:14 PM, Dmitry Eremin-Solenikov wrote:
> >2015-05-13 13:31 GMT+03:00 Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
> >>On 05/12/2015 05:35 PM, Dmitry Eremin-Solenikov wrote:
> >>>
> >>>2015-05-06 18:05 GMT+03:00 Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
> >>>>
> >>>>On 04/28/2015 01:55 AM, Dmitry Eremin-Solenikov wrote:
> >>>>>
> >>>>>
> >>>>>Adapt locomo leds driver to new locomo core setup.
> >>>>>
> >>>>>Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>>>>---
> >>>>>    drivers/leds/Kconfig       |   1 -
> >>>>>    drivers/leds/leds-locomo.c | 119
> >>>>>+++++++++++++++++++++++----------------------
> >>>>>    2 files changed, 61 insertions(+), 59 deletions(-)
> >>>>>
> >>>>>diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> >>>>>index 966b960..4b4650b 100644
> >>>>>--- a/drivers/leds/Kconfig
> >>>>>+++ b/drivers/leds/Kconfig
> >>>>>@@ -79,7 +79,6 @@ config LEDS_LM3642
> >>>>>    config LEDS_LOCOMO
> >>>>>          tristate "LED Support for Locomo device"
> >>>>>          depends on LEDS_CLASS
> >>>>>-       depends on SHARP_LOCOMO
> >>>>
> >>>>
> >>>>
> >>>>Why do you remove this dependency?
> >>>
> >>>
> >>>Because SHARP_LOCOMO is a Kconfig symbol for the old driver. New driver
> >>>uses MFD_LOCOMO Kconfig entry. Also the driver now uses generic platform
> >>>device and regmap interfaces, so there is no direct dependency on main
> >>>LoCoMo driver. And the policy (IIRC) was not to have such dependencies.
> >>
> >>
> >>Ack. Shouldn't you also need "select REGMAP_MMIO" ?
> >
> >No. Maybe I should add "select REGMAP" instead.
> 
> REGMAP is enabled by default if REGMAP_MMIO is enabled. Having

That is unfortunately not how select works: it does not automatically
select parents for the selected symbol.

Thanks.

-- 
Dmitry
