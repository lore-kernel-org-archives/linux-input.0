From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: sun4i-ts: add thermal driver dependency
Date: Thu, 29 Jan 2015 08:50:18 +0100
Message-ID: <54C9E63A.6020806@redhat.com>
References: <2265502.1m7jYBaqyh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53834 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbbA2Huz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 02:50:55 -0500
In-Reply-To: <2265502.1m7jYBaqyh@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>

Hi,

On 28-01-15 16:17, Arnd Bergmann wrote:
> The sun4i-ts driver has had a dependency on the thermal code
> since it was first merged,

The "since it was first merged bit" is not true, this is caused
by recent changes by ChenYu.

Other then that no objections from me against the proposed fix.

Regards,

Hans


  but this is not currently enforced
> in Kconfig, so in some randconfig builds we get
>
> drivers/built-in.o: In function `sun4i_ts_remove':
> :(.text+0x2376f4): undefined reference to `thermal_zone_of_sensor_unregister'
> drivers/built-in.o: In function `sun4i_ts_probe':
> :(.text+0x237a94): undefined reference to `thermal_zone_of_sensor_register'
> :(.text+0x237c00): undefined reference to `thermal_zone_of_sensor_unregister'
>
> We need the dependency on THERMAL in order to ensure that this
> driver becomes a loadable module if the thermal support itself
> is modular, while the dependency on THERMAL_OF is a runtime dependency
> and the driver will still build but not work if it is missing.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6decea7c5438e2 ("Input: add driver for Allwinner sunxi SoC's rtp controller")
>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 58917525126e..e2447f0063b7 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -943,6 +943,8 @@ config TOUCHSCREEN_SUN4I
>   	tristate "Allwinner sun4i resistive touchscreen controller support"
>   	depends on ARCH_SUNXI || COMPILE_TEST
>   	depends on HWMON
> +	depends on THERMAL
> +	depends on THERMAL_OF || COMPILE_TEST
>   	help
>   	  This selects support for the resistive touchscreen controller
>   	  found on Allwinner sunxi SoCs.
>
