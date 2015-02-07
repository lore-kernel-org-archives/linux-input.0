From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v3 02/20] power_supply: Move run-time configuration to
 separate structure
Date: Fri, 6 Feb 2015 18:19:52 -0800
Message-ID: <20150207021952.GA30250@fury.dvhart.com>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59803 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbbBGCUB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 21:20:01 -0500
Content-Disposition: inline
In-Reply-To: <1422629278-12202-3-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee

On Fri, Jan 30, 2015 at 03:47:40PM +0100, Krzysztof Kozlowski wrote:
> Add new structure 'power_supply_config' for holding run-time
> initialization data like of_node, supplies and private driver data.
> 
> The power_supply_register() function is changed so all power supply
> drivers need updating.
> 
> When registering the power supply this new 'power_supply_config' should be
> used instead of directly initializing 'struct power_supply'. This allows
> changing the ownership of power_supply structure from driver to the
> power supply core in next patches.
> 
> When a driver does not use of_node or supplies then it should use NULL
> as config. If driver uses of_node or supplies then it should allocate
> config on stack and initialize it with proper values.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

For drivers/platform/x86/compal-laptop.c

Reviewed-by: Darren Hart <dvhart@linux.intel.com>
