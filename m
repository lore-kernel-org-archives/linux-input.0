From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: add appletv IR receiver quirk
Date: Mon, 6 Oct 2008 11:22:27 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810061122030.26779@jikos.suse.cz>
References: <1223280388-1297-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:37122 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751982AbYJFJW3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Oct 2008 05:22:29 -0400
In-Reply-To: <1223280388-1297-1-git-send-email-jacmet@sunsite.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-input@vger.kernel.org

On Mon, 6 Oct 2008, Peter Korsgaard wrote:

> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index a808e57..fd7f896 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -359,6 +359,8 @@ static void apple_remove(struct hid_device *hdev)
>  }
>  
>  static const struct hid_device_id apple_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ATV_IRCONTROL),
> +		.driver_data = APPLE_HIDDEV | APPLE_IGNORE_HIDINPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4),
>  		.driver_data = APPLE_HIDDEV | APPLE_IGNORE_HIDINPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE),
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index fa4e4fd..9fc2636 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -84,6 +84,7 @@
>  #define USB_DEVICE_ID_APPLE_WELLSPRING2_JIS	0x0232
>  #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
>  #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
> +#define USB_DEVICE_ID_APPLE_ATV_IRCONTROL	0x8241
>  #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
>  
>  #define USB_VENDOR_ID_ASUS		0x0b05

Applied, thanks Peter.

-- 
Jiri Kosina
SUSE Labs
