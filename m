From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: blacklist Powercom UPSes which are not HIDs but Serial<=>USB
 things
Date: Wed, 28 Jan 2009 23:04:25 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0901282302450.15460@twin.jikos.cz>
References: <1233173972.288064.6256.nullmailer@msgid.corpit.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:44919 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755AbZA1WEa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 17:04:30 -0500
In-Reply-To: <1233173972.288064.6256.nullmailer@msgid.corpit.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux INPUT list <linux-input@vger.kernel.org>

On Wed, 28 Jan 2009, Michael Tokarev wrote:

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 5d7640e..dcd4add 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1295,6 +1295,7 @@ static const struct hid_device_id hid_blacklist[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_POWERCOM, USB_DEVICE_ID_POWERCOM_UPS) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },

This has to be added into hid_ignore_list[] so that HID code doesn't care 
at all about that device.

hid_blacklist[] is for devices which are broken in some way and require 
some special handling by special hid sub-driver, but still this driver 
operates on HID bus.

I think a little comment for these lists won't hurt, you are not the first 
one to get it wrong. I'll add it.

-- 
Jiri Kosina
SUSE Labs

