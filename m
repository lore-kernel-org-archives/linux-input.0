From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers: Kconfig: Add HAS_IOMEM dependency for allmodconfig
 under score architecture
Date: Tue, 10 Jun 2014 20:20:02 +0800
Message-ID: <5396F7F2.7080202@gmail.com>
References: <5396F46A.30805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36920 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaFJMUM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jun 2014 08:20:12 -0400
In-Reply-To: <5396F46A.30805@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, kishon@ti.com
Cc: linux-input@vger.kernel.org, linux-next@vger.kernel.org, liqin.linux@gmail.com, lennox.wu@gmail.com



On 06/10/2014 08:04 PM, Chen Gang wrote:
> When NO_IOMEM is enabled (e.g. score architecture), some drivers which
> need HAS_IOMEM need notice about it, or it will report related warning:
> 
>   scripts/kconfig/conf --allmodconfig Kconfig
>   kernel/time/Kconfig:162:warning: range is invalid
    ^
Oh, sorry, this line above need be removed, it is not for this patch, if
still necessary to send patch v2 for it, please let me know, thanks.

>   warning: (PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_S5P_FIMC && PHY_SAMSUNG_USB2) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>   warning: (GPIO_SCH && GPIO_ICH && GPIO_VX855 && GPIO_RDC321X && IE6XX_WDT && RADIO_WL1273 && HID_SENSOR_HUB && MFD_NVEC) selects MFD_CORE which has unmet direct dependencies (HAS_IOMEM)
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  drivers/hid/Kconfig | 2 +-
>  drivers/phy/Kconfig | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 800c8b6..5e79c6a 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -810,7 +810,7 @@ config HID_ZYDACRON
>  
>  config HID_SENSOR_HUB
>  	tristate "HID Sensors framework support"
> -	depends on HID
> +	depends on HID && HAS_IOMEM
>  	select MFD_CORE
>  	default n
>  	---help---
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 16a2f06..fcdfe7c 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -122,6 +122,7 @@ config PHY_SUN4I_USB
>  
>  config PHY_SAMSUNG_USB2
>  	tristate "Samsung USB 2.0 PHY driver"
> +	depends on HAS_IOMEM
>  	select GENERIC_PHY
>  	select MFD_SYSCON
>  	help
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
