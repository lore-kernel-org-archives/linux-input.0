From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: add Asus macrokey support for Asus "Republic of
 Gamers" laptop
Date: Tue, 13 Dec 2016 09:16:32 +0100
Message-ID: <20161213081632.GC13907@mail.corp.redhat.com>
References: <1481546578-40703-1-git-send-email-chiu@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932220AbcLMIQi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Dec 2016 03:16:38 -0500
Content-Disposition: inline
In-Reply-To: <1481546578-40703-1-git-send-email-chiu@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux@endlessm.com

On Dec 12 2016 or thereabouts, Chris Chiu wrote:
> ROG means ASUS "Republic of Gamers" laptops. The input device info
> also represents itself as "ASASTeK COMPUTER INC. ROG MacroKey". It
> uses special HID_USAGE code for function keys. This commit remap the
> special code to standard keycode for function keys handling. It's
> verified on GL553VD/VE, GL753VD/VE.
> 
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> Reported-by: Yukai Li <yukaili@gmail.com>
> ---

Hi Chris,

there is no real point of having a separate driver from hid-asus. The
HID tree prefer to group drivers by vendors, so these keyboards should
be supported through hid-asus.

Please fold the patch in hid-asus and probably add a special quirk for
these keyboards in input_mapping. With a little luck, the quirk won't
even be required and we can apply these mapping to all Asus keyboards.

>  drivers/hid/Kconfig        | 11 +++++++
>  drivers/hid/Makefile       |  1 +
>  drivers/hid/hid-asus-rog.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h      |  2 ++
>  include/linux/hid.h        |  1 +
>  5 files changed, 95 insertions(+)
>  create mode 100644 drivers/hid/hid-asus-rog.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 78ac481..925aa7b 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -144,6 +144,17 @@ config HID_ASUS
>  	- EeeBook X205TA
>  	- VivoBook E200HA
>  
> +config HID_ASUS_GAMING_NB_KBD
> +	tristate "ASUS special macrokey device for Republic of Gamers laptop"
> +	depends on HID
> +	---help---
> +	Support for ASUS special macrokey devices on Republic of Gamers latops
> +	that are not fully compliant with HID standard
> +
> +        Say Y if you want support for the non-compliant features of the Asus
> +        Republic of Gamers laptop keyboards, e.g:
> +        - Asus Notebook GL553VD/GL553VE/GL753VD/GL753VE
> +
>  config HID_AUREAL
>  	tristate "Aureal"
>  	depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index fc4b2aa..f15479a 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
>  obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
>  obj-$(CONFIG_HID_APPLEIR)	+= hid-appleir.o
>  obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
> +obj-$(CONFIG_HID_ASUS_GAMING_NB_KBD)	+= hid-asus-rog.o
>  obj-$(CONFIG_HID_AUREAL)	+= hid-aureal.o
>  obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
>  obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
> diff --git a/drivers/hid/hid-asus-rog.c b/drivers/hid/hid-asus-rog.c
> new file mode 100644
> index 0000000..a33a693
> --- /dev/null
> +++ b/drivers/hid/hid-asus-rog.c
> @@ -0,0 +1,80 @@
> +/*
> + *  HID driver for some Asus Gaming model equipped with "special" macrokey
> + *  devices for hotkey handling
> + *
> + *  Currently supported devices are:
> + *    ASUS laptops for "Republic of Gamers"
> + *    GL553VD/GL553VE
> + *    GL753VD/GL753VE
> + *
> + *  Copyright (c) 2016 Chris Chiu <chiu@endlessm.com>
> + *
> + *  This module based on hid-gyration
> + *
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +#define asus_rog_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, \
> +						max, EV_KEY, (c))
> +static int asus_rog_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> +		struct hid_field *field, struct hid_usage *usage,
> +		unsigned long **bit, int *max)
> +{
> +	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_ASUS_ROG_HOTKEY)
> +		return 0;
> +
> +	set_bit(EV_REP, hi->input->evbit);
> +	switch (usage->hid & HID_USAGE) {
> +	/* Reported on ASUS Gaming model (Republic of Gamers) keyboards */
> +	case 0x6c: asus_rog_map_key_clear(KEY_SLEEP);		break;
> +	case 0x88: asus_rog_map_key_clear(KEY_WLAN);		break;
> +	case 0xc5: asus_rog_map_key_clear(KEY_KBDILLUMDOWN);	break;
> +	case 0xc4: asus_rog_map_key_clear(KEY_KBDILLUMUP);	break;
> +	case 0x10: asus_rog_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
> +	case 0x20: asus_rog_map_key_clear(KEY_BRIGHTNESSUP);	break;
> +	case 0x35: asus_rog_map_key_clear(KEY_DISPLAY_OFF);	break;
> +	// KEY_F21 is for ASUS touchpad toggle
> +	case 0x6b: asus_rog_map_key_clear(KEY_F21);             break;
> +	case 0x82: asus_rog_map_key_clear(KEY_CAMERA);          break;
> +	case 0xb5: asus_rog_map_key_clear(KEY_CALC);            break;
> +	// KEY_PROG1 for ROG key
> +	case 0x38: asus_rog_map_key_clear(KEY_PROG1);           break;
> +	// KEY_PROG2 for Fn+C ASUS Splendid
> +	case 0xba: asus_rog_map_key_clear(KEY_PROG2);           break;
> +	// KEY_PROG3 for Fn+Space Power4Gear Hybrid, may not be present
> +	case 0x5c: asus_rog_map_key_clear(KEY_PROG3);           break;
> +
> +	default:
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +static const struct hid_device_id asus_rog_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_MACROKEY1) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_MACROKEY2) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, asus_rog_devices);
> +
> +static struct hid_driver asus_rog_driver = {
> +	.name = "asus-rog",
> +	.id_table = asus_rog_devices,
> +	.input_mapping = asus_rog_input_mapping,
> +};
> +module_hid_driver(asus_rog_driver);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4ed9a4f..5c60aee 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -168,6 +168,8 @@
>  #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
>  #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
>  #define USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD	0x8585
> +#define USB_DEVICE_ID_ASUSTEK_ROG_MACROKEY1	0x1854
> +#define USB_DEVICE_ID_ASUSTEK_ROG_MACROKEY2	0x1837
>  
>  #define USB_VENDOR_ID_ATEN		0x0557
>  #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 75b66ec..a6ccadb 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -170,6 +170,7 @@ struct hid_item {
>  #define HID_UP_LOGIVENDOR	0xffbc0000
>  #define HID_UP_LOGIVENDOR2   0xff090000
>  #define HID_UP_LOGIVENDOR3   0xff430000
> +#define HID_UP_ASUS_ROG_HOTKEY	0xff310000

Not sure this belongs here. You are checking this in a local driver, not
in the generic hid-input path, so there is no point in telling everybody
that ASUS ROG keyboards are using this usage page.

Cheers,
Benjamin

>  #define HID_UP_LNVENDOR		0xffa00000
>  #define HID_UP_SENSOR		0x00200000
>  
> -- 
> 2.1.4
> 
