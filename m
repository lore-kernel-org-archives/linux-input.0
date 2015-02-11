From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 20/20] arm: mach-pxa: Decrement the power supply's
 device reference counter
Date: Wed, 11 Feb 2015 23:12:33 +0100
Message-ID: <20150211221233.GD11313@amd>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
 <20150206134953.GA25683@amd>
 <1423233788.31516.5.camel@AMDC1943>
 <20150206145904.GA7872@amd>
 <1423476432.4909.15.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55412 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbbBKWMh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2015 17:12:37 -0500
Content-Disposition: inline
In-Reply-To: <1423476432.4909.15.camel@AMDC1943>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel

On Mon 2015-02-09 11:07:12, Krzysztof Kozlowski wrote:
> On pi=C4=85, 2015-02-06 at 15:59 +0100, Pavel Machek wrote:
> > On Fri 2015-02-06 15:43:08, Krzysztof Kozlowski wrote:
> > > On pi=C4=85, 2015-02-06 at 14:49 +0100, Pavel Machek wrote:
> > > > On Fri 2015-01-30 15:47:58, Krzysztof Kozlowski wrote:
> > > > > Use power_supply_put() to decrement the power supply's device=
 reference
> > > > > counter.
> > > > >=20
> > > > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > > > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.=
com>
> > > > > Reviewed-by: Sebastian Reichel <sre@kernel.org>
> > > >=20
> > > > 11,13,20 nothing obviously wrong. But I'm not sure if I studied=
 them
> > > > closely enough to warrant an ACK.
> > > >=20
> > > > It would be good to get this into kernel -- I seen no bad comme=
nts,
> > > > and it is not going to improve without merge into mainline.
> > >=20
> > > Thanks for looking at patchset. It would be really nice if this c=
ould be
> > > tested for some time in linux-next. Such testing would help a lot=
=2E But I
> > > need acks from various maintainers for that.
> >=20
> > Actually, you don't. The various maintainers clearly don't care at
> > this point. They had enough time. So you select one maintainer you
> > want to push this through, and you push it.
> >=20
> > Someone may complain, so you'll solve the feedback...
>=20
> I am thinking also on another way of solving this huge-patch problem:
> 1. Mark all drivers broken (CONFIG_BROKEN).
> 2. Introduce change in power_supply_register() API. Broken drivers
>    will fail to build.
> 3. Convert broken drivers to new API incrementally (one driver
>    per patch) marking them also non-broken.
>=20
> This would be much easier to review but also this would break
> build-bisectability for drivers and some platforms using them (like
> OLPC, compal-laptop, ACPI).

It is easy enough to review as it is, playing with CONFIG_BROKEN will
not improve it. Just push the patch...

> I pushed the patchset here:
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/shortl=
og/refs/heads/v3.19-next-power-supply-core-ownership
> (actually this is v4: added acks/reviews and minor issue fixed; merge
> window has opened so I'll wait with sending this to LKML).

Great... now you just need one of maintainers to merge it...

POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
M:      Sebastian Reichel <sre@kernel.org>
M:      Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
M:      David Woodhouse <dwmw2@infradead.org>
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
