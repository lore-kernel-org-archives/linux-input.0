From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: cp2112: select GPIOLIB_IRQCHIP instead of depending
 on it
Date: Tue, 21 Mar 2017 15:30:59 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703211530540.31814@cbobk.fhfr.pm>
References: <1489344968-12813-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756517AbdCUObC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 10:31:02 -0400
In-Reply-To: <1489344968-12813-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 12 Mar 2017, Bartosz Golaszewski wrote:

> GPIOLIB_IRQCHIP is not visible to user, so we can't depend on it.
> 
> Depend on GPIOLIB but select GPIOLIB_IRQCHIP.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/hid/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 1aeb80e..00e2809 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -214,7 +214,8 @@ config HID_CMEDIA
>  
>  config HID_CP2112
>  	tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
> -	depends on USB_HID && I2C && GPIOLIB && GPIOLIB_IRQCHIP
> +	depends on USB_HID && I2C && GPIOLIB
> +	select GPIOLIB_IRQCHIP
>  	---help---
>  	Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
>  	This is a HID device driver which registers as an i2c adapter

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

