From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Patch for LG Flatron T1710B touchscreen
Date: Fri, 19 Nov 2010 09:08:37 -0800
Message-ID: <20101119170837.GC6236@core.coreip.homeip.net>
References: <4CE63CC7.9040709@datanordisk.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55310 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050Ab0KSRIq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 12:08:46 -0500
Content-Disposition: inline
In-Reply-To: <4CE63CC7.9040709@datanordisk.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Glenn Sommer <gsommer@datanordisk.dk>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, linux-input@vger.kernel.org

On Fri, Nov 19, 2010 at 10:00:55AM +0100, Glenn Sommer wrote:
> I've recently got my hands on a LG Flatron T1710B touchscreen.
> As other LG products, this seems to use the ITM panel.
> 
> I've patches my kernel to use the ITM driver with this device, and it seems to work great.
> 

Glenn,

I need you "Signed-off-by: ..." so I can apply the patch.

Thank you.

> --- PATCH START ---
> 
> --- drivers/input/touchscreen/usbtouchscreen.c.orig	2010-11-18 16:33:40.806381557 +0100
> +++ drivers/input/touchscreen/usbtouchscreen.c	2010-11-19 09:40:13.909222383 +0100
> @@ -173,6 +173,7 @@ static struct usb_device_id usbtouch_dev
> 
>  #ifdef CONFIG_TOUCHSCREEN_USB_ITM
>  	{USB_DEVICE(0x0403, 0xf9e9), .driver_info = DEVTYPE_ITM},
> +	{USB_DEVICE(0x16e3, 0xf9e9), .driver_info = DEVTYPE_ITM},
>  #endif
> 
>  #ifdef CONFIG_TOUCHSCREEN_USB_ETURB
> 
> --- PATCH END ---
> 
> -- 
> Med venlig hilsen / Best regards
> Data Nordisk
> 
> Glenn Sommer
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
