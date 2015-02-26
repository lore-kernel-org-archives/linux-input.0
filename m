From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: sun4i-ts: add thermal driver dependency
Date: Wed, 25 Feb 2015 17:28:47 -0800
Message-ID: <20150226012847.GD25965@dtor-ws>
References: <1423728011-30272-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33114 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbbBZB2w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 20:28:52 -0500
Received: by iecar1 with SMTP id ar1so10201843iec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Feb 2015 17:28:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423728011-30272-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 12, 2015 at 04:00:11PM +0800, Chen-Yu Tsai wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sun4i-ts driver has had a dependency on the thermal code
> with the addition of the thermal zone sensor support, but this
> is not currently enforced in Kconfig, so with TOUCHSCREEN_SUN4I=y,
> THERMAL=m and THERMAL_OF=y we get
> 
> drivers/built-in.o: In function `sun4i_ts_remove':
> :(.text+0x2376f4): undefined reference to `thermal_zone_of_sensor_unregister'
> drivers/built-in.o: In function `sun4i_ts_probe':
> :(.text+0x237a94): undefined reference to `thermal_zone_of_sensor_register'
> :(.text+0x237c00): undefined reference to `thermal_zone_of_sensor_unregister'
> 
> We need the dependency on THERMAL in order to ensure that this
> driver becomes a loadable module if the thermal support itself
> is modular, while the dependency on THERMAL_OF is a runtime
> dependency and the driver will still build if it is missing.
> It is entirely possible to build sun4i-ts without THERMAL_OF
> just to use the hwmon sensors and/or touchscreen.
> 
> Fixes: 223697107949 ("Input: sun4i-ts - add thermal zone sensor support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [wens@csie.org: Fix description and Kconfig dependencies]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thank you.

> ---
> 
> v2 updates the Kconfig dependencies as Dmitry pointed out, and makes
> the description be more specific on the failing config and why a
> dependency on THERMAL_OF is not required. The failing commit hash
> is also updated.
> 
> ---
>  drivers/input/touchscreen/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 58917525126e..6261fd6d7c3c 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -943,6 +943,7 @@ config TOUCHSCREEN_SUN4I
>  	tristate "Allwinner sun4i resistive touchscreen controller support"
>  	depends on ARCH_SUNXI || COMPILE_TEST
>  	depends on HWMON
> +	depends on THERMAL || !THERMAL_OF
>  	help
>  	  This selects support for the resistive touchscreen controller
>  	  found on Allwinner sunxi SoCs.
> -- 
> 2.1.4
> 

-- 
Dmitry
