From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: HID: dell: Add hid-dell driver
Date: Mon, 8 May 2017 22:14:13 +0200
Message-ID: <1496f8c0-4abf-c05d-d14c-bde1e11104c3@redhat.com>
References: <20170430205535.6682-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753888AbdEHUOS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 8 May 2017 16:14:18 -0400
In-Reply-To: <20170430205535.6682-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Hi,

On 30-04-17 22:55, Hans de Goede wrote:
> The keyboard-dock and the keyboard-cover available with the Dell
> Venue 11 Pro 2-in-1 devices use a custom HID usage code for their
> wireless-lan toggle button.
> 
> This commit adds a specialised hid driver for this (both devices use the
> same VID:PID). Since these devices also contain a synaptics RMI touchpad
> on the same USB-device the hid_have_special_driver table cannot be used,
> instead this commit adds a new HID_GROUP_DELL group and makes
> hid_scan_report set hid_device->group to this for the non touchpad
> interfaces of the shared USB-device.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Self NACK, I just found the exact same HUT usage on a
PEAQ Bay Trail 2-in-1 keyboard using a ITE8595 chipset
rather then the synaptics chipset on the Dell Venue 11 Pro
where I first encountered the 0x100c6 usage.

So different vendor, different chipset same HUT usage
for the wireless kill toggle hotkey. That cannot be a
coincedence, so a quick duckduckgo search for
"human usage table generic desktop page code c6"
found me:

https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/airplane-mode-radio-management

Hurray microsoft recommended extensions to the
generic desktop usage page, not sure if we should
be happy about this, but this does mean that we
should IMHO add the mapping for 0x100c6
directly in hid-input.c and this patch is not
necessary.

I will prepare and submit a new patch for this soonish,
likely tomorrow.

Regards,

Hans




> ---
>   drivers/hid/Kconfig    |  7 +++++++
>   drivers/hid/Makefile   |  1 +
>   drivers/hid/hid-core.c |  7 +++++++
>   drivers/hid/hid-dell.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/hid/hid-ids.h  |  1 +
>   include/linux/hid.h    |  1 +
>   6 files changed, 65 insertions(+)
>   create mode 100644 drivers/hid/hid-dell.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 8c54cb8..08bce92 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -229,6 +229,13 @@ config HID_CYPRESS
>   	---help---
>   	Support for cypress mouse and barcode readers.
>   
> +config HID_DELL
> +	tristate "Dell 2-in-1 keyboard-dock / type-cover"
> +	depends on HID
> +	default !EXPERT
> +	---help---
> +	Support for extra keys on Dell 2-in-1 keyboard-docks / type-covers.
> +
>   config HID_DRAGONRISE
>   	tristate "DragonRise Inc. game controller"
>   	depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 4d111f2..b02a943 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_HID_CMEDIA)	+= hid-cmedia.o
>   obj-$(CONFIG_HID_CORSAIR)	+= hid-corsair.o
>   obj-$(CONFIG_HID_CP2112)	+= hid-cp2112.o
>   obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
> +obj-$(CONFIG_HID_DELL)		+= hid-dell.o
>   obj-$(CONFIG_HID_DRAGONRISE)	+= hid-dr.o
>   obj-$(CONFIG_HID_EMS_FF)	+= hid-emsff.o
>   obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 63ec199..7c7bec43 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -829,6 +829,13 @@ static int hid_scan_report(struct hid_device *hid)
>   				 */
>   				if (IS_ENABLED(CONFIG_HID_RMI))
>   					hid->group = HID_GROUP_RMI;
> +
> +		if (hid->group == HID_GROUP_GENERIC &&
> +		    hid->product == USB_DEVICE_ID_SYNAPTICS_DELL_KBD_DOCK)
> +			/* hid-dell should take care of this device */
> +			if (IS_ENABLED(CONFIG_HID_DELL))
> +				hid->group = HID_GROUP_DELL;
> +
>   		break;
>   	}
>   
> diff --git a/drivers/hid/hid-dell.c b/drivers/hid/hid-dell.c
> new file mode 100644
> index 0000000..4f7a7f8
> --- /dev/null
> +++ b/drivers/hid/hid-dell.c
> @@ -0,0 +1,48 @@
> +/*
> + * HID driver for some Dell "special" devices
> + * Copyright (c) 2017 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +#define DELL_WIRELESS_TOGGLE_HID	0x100c6
> +
> +static int dell_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> +		struct hid_field *field, struct hid_usage *usage,
> +		unsigned long **bit, int *max)
> +{
> +	if (usage->hid == DELL_WIRELESS_TOGGLE_HID) {
> +		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_WLAN);
> +		/* Only press events get reported, simulate release */
> +		field->flags |= HID_MAIN_ITEM_RELATIVE;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hid_device_id dell_devices[] = {
> +	/* Only bind to HID_GROUP_DELL, let RMI deal with the touchpad. */
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_DELL, USB_VENDOR_ID_SYNAPTICS,
> +		     USB_DEVICE_ID_SYNAPTICS_DELL_KBD_DOCK), },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, dell_devices);
> +
> +static struct hid_driver dell_driver = {
> +	.name = "dell",
> +	.id_table = dell_devices,
> +	.input_mapping = dell_input_mapping,
> +};
> +module_hid_driver(dell_driver);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4e2648c..9c3eba7 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -968,6 +968,7 @@
>   #define USB_DEVICE_ID_SYNAPTICS_LTS2	0x1d10
>   #define USB_DEVICE_ID_SYNAPTICS_HD	0x0ac3
>   #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD	0x1ac3
> +#define USB_DEVICE_ID_SYNAPTICS_DELL_KBD_DOCK	0x2819
>   #define USB_DEVICE_ID_SYNAPTICS_TP_V103	0x5710
>   
>   #define USB_VENDOR_ID_TEXAS_INSTRUMENTS	0x2047
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 28f38e2b8..223a61f 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -349,6 +349,7 @@ struct hid_item {
>   #define HID_GROUP_RMI				0x0100
>   #define HID_GROUP_WACOM				0x0101
>   #define HID_GROUP_LOGITECH_DJ_DEVICE		0x0102
> +#define HID_GROUP_DELL				0x0103
>   
>   /*
>    * This is the global environment of the parser. This information is
> 
