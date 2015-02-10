From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 04/20] power_supply: sysfs: Use power_supply_*() API for
 accessing function attrs
Date: Tue, 10 Feb 2015 08:39:19 +0100
Message-ID: <1423553959.1327.1.camel@AMDC1943>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-5-git-send-email-k.kozlowski@samsung.com>
 <70066540.345820.1423508541546.JavaMail.open-xchange@oxbaltgw00.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <70066540.345820.1423508541546.JavaMail.open-xchange-h4m1HHXQYNHZ78VGacPtK8gmgJlYmuWJ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, ac100-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, Cezary Jackiewicz <cezary.jackiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian
List-Id: linux-input@vger.kernel.org

On pon, 2015-02-09 at 20:02 +0100, Stefan Wahren wrote:
> Hi Krzysztof,
> 
> > Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> hat am 30. Januar 2015 um 15:47
> > geschrieben:
> >
> >
> > Replace direct calls to power supply function attributes with wrappers.
> > Wrappers provide safe access in case of unregistering the power
> > supply (e.g. by removing the driver). Replace:
> > - get_property -> power_supply_get_property
> > - set_property -> power_supply_set_property
> > - property_is_writeable -> power_supply_property_is_writeable
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Acked-by: Jonghwa Lee <jonghwa3.lee-Ns6yrYG9TJBBDgjK7y7TUQ@public.gmane.org>
> 
> just a nit. It looks like a typo in the mail address which is also in patch 5 -
> 10.

Right, I copied it directly from Jonghwa's response. Thank you for
noticing it.

> 
> I applied patch 1 - 14 to my repo with a upcoming power driver (mxs_power) and
> didn't see any problems with your patches.

Great, thanks!

Best regards,
Krzysztof
