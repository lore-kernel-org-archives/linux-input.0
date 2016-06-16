From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Alps I2C HID Touchpad-Stick support
Date: Thu, 16 Jun 2016 10:00:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606160955110.6874@cbobk.fhfr.pm>
References: <1466041410-4015-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57158 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbcFPIA2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2016 04:00:28 -0400
In-Reply-To: <1466041410-4015-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: benjamin.tissorires@redhat.com, peter.hutterer@who-t.net, hdegoede@redhat.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, masaki.ota@jp.alps.com, naoki.saito@jp.alps.com, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, 16 Jun 2016, Masaki Ota wrote:

> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>

You're almost there, but please provide a patch changelog. I can't commit 
the patch without any changelog whatsoever.

[ ... snip ... ]
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b6ff6e7..92f7fca 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -67,6 +67,8 @@
>  #define USB_VENDOR_ID_ALPS		0x0433
>  #define USB_DEVICE_ID_IBM_GAMEPAD	0x1101
>  
> +#define USB_VENDOR_ID_ALPS_JP		0x044E
> +
>  #define USB_VENDOR_ID_ANTON		0x1130
>  #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
>  
> @@ -510,7 +512,6 @@
>  #define USB_VENDOR_ID_ITE               0x048d
>  #define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
>  #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
> -#define USB_DEVICE_ID_ITE_LENOVO_YOGA900	0x8396
>  
>  #define USB_VENDOR_ID_JABRA		0x0b0e
>  #define USB_DEVICE_ID_JABRA_SPEAK_410	0x0412
> @@ -616,7 +617,6 @@
>  #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2	0xc218
>  #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2	0xc219
>  #define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
> -#define USB_DEVICE_ID_LOGITECH_G920_WHEEL	0xc262
>  #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
>  #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
>  #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
> @@ -666,7 +666,6 @@
>  #define USB_DEVICE_ID_PICOLCD		0xc002
>  #define USB_DEVICE_ID_PICOLCD_BOOTLOADER	0xf002
>  #define USB_DEVICE_ID_PICK16F1454	0x0042
> -#define USB_DEVICE_ID_PICK16F1454_V2	0xf2f7

What is the point of these removals?

-- 
Jiri Kosina
SUSE Labs

