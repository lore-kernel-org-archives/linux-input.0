From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 20/20] arm: mach-pxa: Decrement the power supply's
 device reference counter
Date: Fri, 06 Feb 2015 15:43:08 +0100
Message-ID: <1423233788.31516.5.camel@AMDC1943>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
 <20150206134953.GA25683@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <20150206134953.GA25683@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel
List-Id: linux-input@vger.kernel.org

On pi=C4=85, 2015-02-06 at 14:49 +0100, Pavel Machek wrote:
> On Fri 2015-01-30 15:47:58, Krzysztof Kozlowski wrote:
> > Use power_supply_put() to decrement the power supply's device refer=
ence
> > counter.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Reviewed-by: Sebastian Reichel <sre@kernel.org>
>=20
> 11,13,20 nothing obviously wrong. But I'm not sure if I studied them
> closely enough to warrant an ACK.
>=20
> It would be good to get this into kernel -- I seen no bad comments,
> and it is not going to improve without merge into mainline.

Thanks for looking at patchset. It would be really nice if this could b=
e
tested for some time in linux-next. Such testing would help a lot. But =
I
need acks from various maintainers for that.

Of course the patchset to big enough to go into 3.20. If needed this
could be taken gradually in following steps:
1. Patches 1-2 (patch 2 touches *all drivers*),
2. Patches 3-10 (touch only individual drivers),
3. Patch 11 (again *everything* changed),
4. Patches 12-20 (individual changes).

In such case I will refresh everything after each step so new drivers
would be also updated.

Thanks again Pavel for prompt replies.

Best regards,
Krzysztof

