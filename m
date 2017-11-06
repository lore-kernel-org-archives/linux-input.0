From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/3] HID: cp2112: add HIDRAW dependency
Date: Mon, 6 Nov 2017 09:12:20 +0100
Message-ID: <20171106081220.GD9728@mail.corp.redhat.com>
References: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
 <1509621164-28830-2-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbdKFIMZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Nov 2017 03:12:25 -0500
Content-Disposition: inline
In-Reply-To: <1509621164-28830-2-git-send-email-sebastien.szymanski@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Julien Boibessot <julien.boibessot@armadeus.com>

On Nov 02 2017 or thereabouts, Sébastien Szymanski wrote:
> Otherwise, with HIDRAW=n, the probe function crashes because of null
> dereference of hdev->hidraw.
> 
> Fixes: 42cb6b35b9e6 ("HID: cp2112: use proper hidraw name with minor number")
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Patches 1 and 2 (only) are:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

> ---
>  drivers/hid/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 374301f..8c7a0ce 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -230,7 +230,7 @@ config HID_CMEDIA
>  
>  config HID_CP2112
>  	tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
> -	depends on USB_HID && I2C && GPIOLIB
> +	depends on USB_HID && HIDRAW && I2C && GPIOLIB
>  	select GPIOLIB_IRQCHIP
>  	---help---
>  	Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
> -- 
> 2.7.3
> 
