From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 20/20] arm: mach-pxa: Decrement the power supply's
 device reference counter
Date: Mon, 09 Feb 2015 11:07:12 +0100
Message-ID: <1423476432.4909.15.camel@AMDC1943>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
 <20150206134953.GA25683@amd> <1423233788.31516.5.camel@AMDC1943>
 <20150206145904.GA7872@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20150206145904.GA7872@amd>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Cezary Jackiewicz <cezary.jackiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Julian Andres Klode <jak-4HMq4SXA452hPH1hqNUYSQ@public.gmane.org>, Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, ac100-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel
List-Id: linux-input@vger.kernel.org

On pi=C4=85, 2015-02-06 at 15:59 +0100, Pavel Machek wrote:
> On Fri 2015-02-06 15:43:08, Krzysztof Kozlowski wrote:
> > On pi=C4=85, 2015-02-06 at 14:49 +0100, Pavel Machek wrote:
> > > On Fri 2015-01-30 15:47:58, Krzysztof Kozlowski wrote:
> > > > Use power_supply_put() to decrement the power supply's device r=
eference
> > > > counter.
> > > >=20
> > > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22KIwRZHo2/mJg@public.gmane.org=
m>
> > > > Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > >=20
> > > 11,13,20 nothing obviously wrong. But I'm not sure if I studied t=
hem
> > > closely enough to warrant an ACK.
> > >=20
> > > It would be good to get this into kernel -- I seen no bad comment=
s,
> > > and it is not going to improve without merge into mainline.
> >=20
> > Thanks for looking at patchset. It would be really nice if this cou=
ld be
> > tested for some time in linux-next. Such testing would help a lot. =
But I
> > need acks from various maintainers for that.
>=20
> Actually, you don't. The various maintainers clearly don't care at
> this point. They had enough time. So you select one maintainer you
> want to push this through, and you push it.
>=20
> Someone may complain, so you'll solve the feedback...

I am thinking also on another way of solving this huge-patch problem:
1. Mark all drivers broken (CONFIG_BROKEN).
2. Introduce change in power_supply_register() API. Broken drivers
   will fail to build.
3. Convert broken drivers to new API incrementally (one driver
   per patch) marking them also non-broken.

This would be much easier to review but also this would break
build-bisectability for drivers and some platforms using them (like
OLPC, compal-laptop, ACPI).

In case of important platforms (like ACPI) I could do the old-way:
change the driver along with API change.

What do you think about this?


I pushed the patchset here:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/shortlog=
/refs/heads/v3.19-next-power-supply-core-ownership
(actually this is v4: added acks/reviews and minor issue fixed; merge
window has opened so I'll wait with sending this to LKML).


Best regards,
Krzysztof
