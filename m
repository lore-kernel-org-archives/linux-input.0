From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: logitech-hidpp: select CONFIG_POWER_SUPPLY
Date: Tue, 12 Jul 2016 09:19:39 +0200
Message-ID: <20160712071938.GD4663@mail.corp.redhat.com>
References: <20160711214954.2668262-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48036 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbcGLHTn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 03:19:43 -0400
Content-Disposition: inline
In-Reply-To: <20160711214954.2668262-1-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jikos@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Yusuke Fujimaki <usk.fujimaki@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jul 11 2016 or thereabouts, Arnd Bergmann wrote:
> A recent commit added barry support to this driver, but that causes
> a link failure when CONFIG_POWER_SUPPLY is not set:
> 
> drivers/hid/built-in.o: In function `hidpp_battery_get_property':
> :(.text+0x1a834): undefined reference to `power_supply_get_drvdata'
> drivers/hid/built-in.o: In function `hidpp_raw_event':
> :(.text+0x1b10c): undefined reference to `power_supply_changed'
> drivers/hid/built-in.o: In function `hidpp_connect_event':
> :(.text+0x1bd88): undefined reference to `devm_power_supply_register'
> :(.text+0x1be30): undefined reference to `power_supply_powers'
> 
> This adds a dependency, identically to the other HID drivers that need this.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5a2b190cddb9 ("HID: logitech-hidpp: add battery support for HID++ 2.0 devices")

Thanks for the fix.
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 78ac4811bd3c..4c6b59c9fa15 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -440,6 +440,7 @@ config HID_LOGITECH_DJ
>  config HID_LOGITECH_HIDPP
>  	tristate "Logitech HID++ devices support"
>  	depends on HID_LOGITECH
> +	select POWER_SUPPLY
>  	---help---
>  	Support for Logitech devices relyingon the HID++ Logitech specification
>  
> -- 
> 2.9.0
> 
