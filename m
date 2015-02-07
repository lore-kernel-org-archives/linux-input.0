From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 20/20] arm: mach-pxa: Decrement the power supply's device reference counter
Date: Sat, 07 Feb 2015 13:54:13 +0100
Message-ID: <87iofd991m.fsf@free.fr>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
	<1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
	(Krzysztof Kozlowski's message of "Fri, 30 Jan 2015 15:47:58 +0100")
Sender: platform-driver-x86-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel
List-Id: linux-input@vger.kernel.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> Use power_supply_put() to decrement the power supply's device reference
> counter.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
