From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v3 04/20] power_supply: sysfs: Use power_supply_*() API
 for accessing function attrs
Date: Mon, 9 Feb 2015 20:02:21 +0100 (CET)
Message-ID: <70066540.345820.1423508541546.JavaMail.open-xchange@oxbaltgw00.schlund.de>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com> <1422629278-12202-5-git-send-email-k.kozlowski@samsung.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50302 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbbBITEv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Feb 2015 14:04:51 -0500
In-Reply-To: <1422629278-12202-5-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Support Opensource <support.opensource@diasemi.com>, Darren Hart <dvhart@infradead.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, ac100@lists.launchpad.net, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Russell King <linux@arm.linux.org.uk>, patches@opensource.wolfsonmicro.com, Milo Kim <milo.kim@ti.com>, David Herrmann <dh.herrmann@googlemail.com>, devel@driverdev.osuosl.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-input@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-tegra@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, platf
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Krzysztof,

> Krzysztof Kozlowski <k.kozlowski@samsung.com> hat am 30. Januar 2015 um 15:47
> geschrieben:
>
>
> Replace direct calls to power supply function attributes with wrappers.
> Wrappers provide safe access in case of unregistering the power
> supply (e.g. by removing the driver). Replace:
> - get_property -> power_supply_get_property
> - set_property -> power_supply_set_property
> - property_is_writeable -> power_supply_property_is_writeable
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>

just a nit. It looks like a typo in the mail address which is also in patch 5 -
10.

I applied patch 1 - 14 to my repo with a upcoming power driver (mxs_power) and
didn't see any problems with your patches.

Stefan

> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> ---
