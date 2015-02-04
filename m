From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 03/20] power_supply: Add API for safe access of power
 supply function attrs
Date: Wed, 4 Feb 2015 14:44:56 +0100
Message-ID: <20150204134456.GA8312@amd>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-4-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45461 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbbBDNpA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 08:45:00 -0500
Content-Disposition: inline
In-Reply-To: <1422629278-12202-4-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel

On Fri 2015-01-30 15:47:41, Krzysztof Kozlowski wrote:
> Add simple wrappers for accessing power supply's function attributes:
>  - get_property -> power_supply_get_property
>  - set_property -> power_supply_set_property
>  - property_is_writeable -> power_supply_property_is_writeable
>  - external_power_changed -> power_supply_external_power_changed
> 
> This API along with atomic usage counter adds a safe way of accessing a
> power supply from another driver. If power supply is unregistered after
> obtaining reference to it by some driver, then the API wrappers won't be
> executed in invalid (freed) context.
> 
> Next patch changing the ownership of power supply class is still needed
> to fully fix race conditions in accessing freed power supply.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>

For 1-3: Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
