From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid: cp2112: select GPIOLIB_IRQCHIP instead of depending
 on it
Date: Mon, 13 Mar 2017 10:48:19 +0100
Message-ID: <20170313094819.GD4378@mail.corp.redhat.com>
References: <1489344968-12813-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751905AbdCMJsa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 05:48:30 -0400
Content-Disposition: inline
In-Reply-To: <1489344968-12813-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mar 12 2017 or thereabouts, Bartosz Golaszewski wrote:
> GPIOLIB_IRQCHIP is not visible to user, so we can't depend on it.
> 
> Depend on GPIOLIB but select GPIOLIB_IRQCHIP.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Makes sense. Good catch

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

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
> -- 
> 2.9.3
> 
