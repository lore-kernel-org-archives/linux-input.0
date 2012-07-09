From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 1/1] Input: xpad - Handle all variations of Mad Catz
 Beat Pad
Date: Mon, 9 Jul 2012 16:08:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207091608060.19366@pobox.suse.cz>
References: <1341592324-665-1-git-send-email-yurivkhan@gmail.com> <1341726589-5400-1-git-send-email-yurivkhan@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40456 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527Ab2GIOJF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Jul 2012 10:09:05 -0400
In-Reply-To: <1341726589-5400-1-git-send-email-yurivkhan@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yuri Khan <yurivkhan@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Sun, 8 Jul 2012, Yuri Khan wrote:

> * Add a quirk to usbhid to ignore this device
> ---
>  drivers/hid/hid-ids.h           |    3 +++
>  drivers/hid/usbhid/hid-quirks.c |    2 ++
>  drivers/input/joystick/xpad.c   |    1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index d1cdd2d..43c3d75 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -518,6 +518,9 @@
>  #define USB_DEVICE_ID_CRYSTALTOUCH	0x0006
>  #define USB_DEVICE_ID_CRYSTALTOUCH_DUAL	0x0007
>  
> +#define USB_VENDOR_ID_MADCATZ		0x0738
> +#define USB_DEVICE_ID_MADCATZ_BEATPAD	0x4540
> +
>  #define USB_VENDOR_ID_MCC		0x09db
>  #define USB_DEVICE_ID_MCC_PMD1024LS	0x0076
>  #define USB_DEVICE_ID_MCC_PMD1208LS	0x007a
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 0597ee6..8726d33 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -45,6 +45,8 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
>  	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
>  
> +	{ USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_BEATPAD, HID_QUIRK_IGNORE },
> +

Please put it in drivers/hid/hid-core.c, hid_ignore_list[] array instead. 
HID_QUIRK_IGNORE is there solely for allowing specification as a module 
parameter.

Thanks,

-- 
Jiri Kosina
SUSE Labs
