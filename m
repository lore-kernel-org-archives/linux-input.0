From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 00/20] power_supply: Allow safe usage of power supply
Date: Mon, 23 Feb 2015 23:18:36 +0100
Message-ID: <20150223221836.GA4929@amd>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59247 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbBWWSp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 17:18:45 -0500
Content-Disposition: inline
In-Reply-To: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel

Hi!
> 
> The patchset fixes invalid memory accesses in certain race scenarios by
> moving ownership of struct power_supply to the core. All drivers are
> modified.

Ok, who can apply the patches? Sebastian?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
