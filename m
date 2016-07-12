From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: logitech-hidpp: select CONFIG_POWER_SUPPLY
Date: Tue, 12 Jul 2016 11:18:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1607121117420.24757@cbobk.fhfr.pm>
References: <20160711214954.2668262-1-arnd@arndb.de> <20160712071938.GD4663@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53632 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbcGLJSW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 05:18:22 -0400
In-Reply-To: <20160712071938.GD4663@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiner Kallweit <hkallweit1@gmail.com>, Yusuke Fujimaki <usk.fujimaki@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 12 Jul 2016, Benjamin Tissoires wrote:

> > A recent commit added barry support to this driver, but that causes
> > a link failure when CONFIG_POWER_SUPPLY is not set:
> > 
> > drivers/hid/built-in.o: In function `hidpp_battery_get_property':
> > :(.text+0x1a834): undefined reference to `power_supply_get_drvdata'
> > drivers/hid/built-in.o: In function `hidpp_raw_event':
> > :(.text+0x1b10c): undefined reference to `power_supply_changed'
> > drivers/hid/built-in.o: In function `hidpp_connect_event':
> > :(.text+0x1bd88): undefined reference to `devm_power_supply_register'
> > :(.text+0x1be30): undefined reference to `power_supply_powers'
> > 
> > This adds a dependency, identically to the other HID drivers that need this.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 5a2b190cddb9 ("HID: logitech-hidpp: add battery support for HID++ 2.0 devices")
> 
> Thanks for the fix.
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks. I am pushing this to for-4.8/logitech-hidpp-battery, but I will be 
unmerging that branch from 'for-next' shortly anyway, as the whole 
patchset is currently on hold.

-- 
Jiri Kosina
SUSE Labs

