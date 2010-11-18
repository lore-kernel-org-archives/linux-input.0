From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: LG Flatron T1710B kernel driver
Date: Thu, 18 Nov 2010 09:54:35 -0800
Message-ID: <201011180954.37878.dmitry.torokhov@gmail.com>
References: <4CE54B28.8080205@datanordisk.dk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42577 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203Ab0KRRyv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 12:54:51 -0500
Received: by pvh1 with SMTP id 1so515938pvh.19
        for <linux-input@vger.kernel.org>; Thu, 18 Nov 2010 09:54:50 -0800 (PST)
In-Reply-To: <4CE54B28.8080205@datanordisk.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Glenn Sommer <gsommer@datanordisk.dk>
Cc: linux-input@vger.kernel.org

Hi Glenn,

On Thursday, November 18, 2010 07:50:00 am Glenn Sommer wrote:
> The LG Flatron T1710B touchscreen seems to be a ITM display
> 
> I've patched my kernel, and testet the screen using the ITM drivers, and
> it seems to work fine.
> 
> Just update the list of devices, like this:
> 

Coudl you please resubmit the patch as it is documented in 
Documentation/SubmittingPatches?

Thanks!

> --- usbtouchscreen.c.orig	2010-11-18 16:33:40.806381557 +0100
> +++ usbtouchscreen.c	2010-11-17 16:25:23.794528671 +0100
> @@ -173,6 +173,7 @@
> 
>   #ifdef CONFIG_TOUCHSCREEN_USB_ITM
>   	{USB_DEVICE(0x0403, 0xf9e9), .driver_info = DEVTYPE_ITM},
> +	{USB_DEVICE(0x16e3, 0xf9e9), .driver_info = DEVTYPE_ITM},
>   #endif
> 
>   #ifdef CONFIG_TOUCHSCREEN_USB_ETURBO

-- 
Dmitry
