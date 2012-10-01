From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v4] HID: Add support for Sony PS3 BD Remote Control
Date: Mon, 1 Oct 2012 10:19:38 +0200
Message-ID: <20121001101938.d7736c5e1faf179cb06dcd9a@studenti.unina.it>
References: <1348584182.27596.28.camel@frustration.ornl.gov>
	<1348606947-3055-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348606947-3055-1-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Luiz Augusto von Dentz <luiz.dentz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 25 Sep 2012 23:02:27 +0200
Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org> wrote:

Ping.

Jiri, I see that linux-3.6 is out, can we have this in for 3.7-rc1?

Thanks,
   Antonio

> From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
> 
> The Sony PS3 Blue-ray Disc Remote Control used to be supported by the
> BlueZ project's user space, but the code that handled it was recently
> removed as its functionality conflicted with a real HSP implementation
> and the mapping was thought to be better handled in the kernel. This is
> a port of the mapping logic from the fakehid driver by Marcel Holtmann
> to the in-kernel HID layer.
> 
> We also add support for the Logitech Harmony Adapter for PS3, which
> emulates the BD Remote.
> 
> Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
> Signed-off-by: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
> ---
> 
> Changes since v3:
>   - move the size check into the switch statement.
> 
> Thanks,
>    Antonio
> 
>  drivers/hid/Kconfig         |   13 ++-
>  drivers/hid/Makefile        |    1 +
>  drivers/hid/hid-core.c      |    2 +
>  drivers/hid/hid-ids.h       |    2 +
>  drivers/hid/hid-ps3remote.c |  215 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 232 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hid/hid-ps3remote.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index fbf4950..378be0b 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -534,6 +534,15 @@ config HID_PRIMAX
>  	Support for Primax devices that are not fully compliant with the
>  	HID standard.
>  
> +config HID_PS3REMOTE
> +	tristate "Sony PS3 BD Remote Control"
> +	depends on BT_HIDP
> +	---help---
> +	Support for the Sony PS3 Blue-ray Disk Remote Control and Logitech
> +	Harmony Adapter for PS3, which connect over Bluetooth.
> +
> +	Support for the 6-axis controllers is provided by HID_SONY.
> +
>  config HID_ROCCAT
>  	tristate "Roccat device support"
>  	depends on USB_HID
> @@ -561,7 +570,9 @@ config HID_SONY
>  	tristate "Sony PS3 controller"
>  	depends on USB_HID
>  	---help---
> -	Support for Sony PS3 controller.
> +	Support for Sony PS3 6-axis controllers.
> +
> +	Support for the Sony PS3 BD Remote is provided by HID_PS3REMOTE.
>  
>  config HID_SPEEDLINK
>  	tristate "Speedlink VAD Cezanne mouse support"
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index f975485..333ed6c 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_HID_PANTHERLORD)	+= hid-pl.o
>  obj-$(CONFIG_HID_PETALYNX)	+= hid-petalynx.o
>  obj-$(CONFIG_HID_PICOLCD)	+= hid-picolcd.o
>  obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
> +obj-$(CONFIG_HID_PS3REMOTE)	+= hid-ps3remote.o
>  obj-$(CONFIG_HID_ROCCAT)	+= hid-roccat.o hid-roccat-common.o \
>  	hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
>  	hid-roccat-koneplus.o hid-roccat-kovaplus.o hid-roccat-pyra.o \
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 8bcd168..e4275d4 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1566,6 +1566,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER_2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RECEIVER) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_DINOVO_DESKTOP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_DINOVO_EDGE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_DINOVO_MINI) },
> @@ -1639,6 +1640,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 1dcb76f..40411c9 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -496,6 +496,7 @@
>  #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
>  #define USB_DEVICE_ID_LOGITECH_HARMONY_FIRST  0xc110
>  #define USB_DEVICE_ID_LOGITECH_HARMONY_LAST 0xc14f
> +#define USB_DEVICE_ID_LOGITECH_HARMONY_PS3 0x0306
>  #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD	0xc20a
>  #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD	0xc211
>  #define USB_DEVICE_ID_LOGITECH_EXTREME_3D	0xc215
> @@ -683,6 +684,7 @@
>  
>  #define USB_VENDOR_ID_SONY			0x054c
>  #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE	0x024b
> +#define USB_DEVICE_ID_SONY_PS3_BDREMOTE		0x0306
>  #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
>  #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
>  
> diff --git a/drivers/hid/hid-ps3remote.c b/drivers/hid/hid-ps3remote.c
> new file mode 100644
> index 0000000..03811e5
> --- /dev/null
> +++ b/drivers/hid/hid-ps3remote.c
> @@ -0,0 +1,215 @@
> +/*
> + * HID driver for Sony PS3 BD Remote Control
> + *
> + * Copyright (c) 2012 David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
> + * Based on a blend of the bluez fakehid user-space code by Marcel Holtmann
> + * and other kernel HID drivers.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +/* NOTE: in order for the Sony PS3 BD Remote Control to be found by
> + * a Bluetooth host, the key combination Start+Enter has to be kept pressed
> + * for about 7 seconds with the Bluetooth Host Controller in discovering mode.
> + *
> + * There will be no PIN request from the device.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +static __u8 ps3remote_rdesc[] = {
> +	0x05, 0x01,          /* GUsagePage Generic Desktop */
> +	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
> +	0xA1, 0x01,          /* MCollection Application (mouse, keyboard) */
> +
> +	 /* Use collection 1 for joypad buttons */
> +	 0xA1, 0x02,         /* MCollection Logical (interrelated data) */
> +
> +	  /* Ignore the 1st byte, maybe it is used for a controller
> +	   * number but it's not needed for correct operation */
> +	  0x75, 0x08,        /* GReportSize 0x08 [8] */
> +	  0x95, 0x01,        /* GReportCount 0x01 [1] */
> +	  0x81, 0x01,        /* MInput 0x01 (Const[0] Arr[1] Abs[2]) */
> +
> +	  /* Bytes from 2nd to 4th are a bitmap for joypad buttons, for these
> +	   * buttons multiple keypresses are allowed */
> +	  0x05, 0x09,        /* GUsagePage Button */
> +	  0x19, 0x01,        /* LUsageMinimum 0x01 [Button 1 (primary/trigger)] */
> +	  0x29, 0x18,        /* LUsageMaximum 0x18 [Button 24] */
> +	  0x14,              /* GLogicalMinimum [0] */
> +	  0x25, 0x01,        /* GLogicalMaximum 0x01 [1] */
> +	  0x75, 0x01,        /* GReportSize 0x01 [1] */
> +	  0x95, 0x18,        /* GReportCount 0x18 [24] */
> +	  0x81, 0x02,        /* MInput 0x02 (Data[0] Var[1] Abs[2]) */
> +
> +	  0xC0,              /* MEndCollection */
> +
> +	 /* Use collection 2 for remote control buttons */
> +	 0xA1, 0x02,         /* MCollection Logical (interrelated data) */
> +
> +	  /* 5th byte is used for remote control buttons */
> +	  0x05, 0x09,        /* GUsagePage Button */
> +	  0x18,              /* LUsageMinimum [No button pressed] */
> +	  0x29, 0xFE,        /* LUsageMaximum 0xFE [Button 254] */
> +	  0x14,              /* GLogicalMinimum [0] */
> +	  0x26, 0xFE, 0x00,  /* GLogicalMaximum 0x00FE [254] */
> +	  0x75, 0x08,        /* GReportSize 0x08 [8] */
> +	  0x95, 0x01,        /* GReportCount 0x01 [1] */
> +	  0x80,              /* MInput  */
> +
> +	  /* Ignore bytes from 6th to 11th, 6th to 10th are always constant at
> +	   * 0xff and 11th is for press indication */
> +	  0x75, 0x08,        /* GReportSize 0x08 [8] */
> +	  0x95, 0x06,        /* GReportCount 0x06 [6] */
> +	  0x81, 0x01,        /* MInput 0x01 (Const[0] Arr[1] Abs[2]) */
> +
> +	  /* 12th byte is for battery strength */
> +	  0x05, 0x06,        /* GUsagePage Generic Device Controls */
> +	  0x09, 0x20,        /* LUsage 0x20 [Battery Strength] */
> +	  0x14,              /* GLogicalMinimum [0] */
> +	  0x25, 0x05,        /* GLogicalMaximum 0x05 [5] */
> +	  0x75, 0x08,        /* GReportSize 0x08 [8] */
> +	  0x95, 0x01,        /* GReportCount 0x01 [1] */
> +	  0x81, 0x02,        /* MInput 0x02 (Data[0] Var[1] Abs[2]) */
> +
> +	  0xC0,              /* MEndCollection */
> +
> +	 0xC0                /* MEndCollection [Game Pad] */
> +};
> +
> +static const unsigned int ps3remote_keymap_joypad_buttons[] = {
> +	[0x01] = KEY_SELECT,
> +	[0x02] = BTN_THUMBL,		/* L3 */
> +	[0x03] = BTN_THUMBR,		/* R3 */
> +	[0x04] = BTN_START,
> +	[0x05] = KEY_UP,
> +	[0x06] = KEY_RIGHT,
> +	[0x07] = KEY_DOWN,
> +	[0x08] = KEY_LEFT,
> +	[0x09] = BTN_TL2,		/* L2 */
> +	[0x0a] = BTN_TR2,		/* R2 */
> +	[0x0b] = BTN_TL,		/* L1 */
> +	[0x0c] = BTN_TR,		/* R1 */
> +	[0x0d] = KEY_OPTION,		/* options/triangle */
> +	[0x0e] = KEY_BACK,		/* back/circle */
> +	[0x0f] = BTN_0,			/* cross */
> +	[0x10] = KEY_SCREEN,		/* view/square */
> +	[0x11] = KEY_HOMEPAGE,		/* PS button */
> +	[0x14] = KEY_ENTER,
> +};
> +static const unsigned int ps3remote_keymap_remote_buttons[] = {
> +	[0x00] = KEY_1,
> +	[0x01] = KEY_2,
> +	[0x02] = KEY_3,
> +	[0x03] = KEY_4,
> +	[0x04] = KEY_5,
> +	[0x05] = KEY_6,
> +	[0x06] = KEY_7,
> +	[0x07] = KEY_8,
> +	[0x08] = KEY_9,
> +	[0x09] = KEY_0,
> +	[0x0e] = KEY_ESC,		/* return */
> +	[0x0f] = KEY_CLEAR,
> +	[0x16] = KEY_EJECTCD,
> +	[0x1a] = KEY_MENU,		/* top menu */
> +	[0x28] = KEY_TIME,
> +	[0x30] = KEY_PREVIOUS,
> +	[0x31] = KEY_NEXT,
> +	[0x32] = KEY_PLAY,
> +	[0x33] = KEY_REWIND,		/* scan back */
> +	[0x34] = KEY_FORWARD,		/* scan forward */
> +	[0x38] = KEY_STOP,
> +	[0x39] = KEY_PAUSE,
> +	[0x40] = KEY_CONTEXT_MENU,	/* pop up/menu */
> +	[0x60] = KEY_FRAMEBACK,		/* slow/step back */
> +	[0x61] = KEY_FRAMEFORWARD,	/* slow/step forward */
> +	[0x63] = KEY_SUBTITLE,
> +	[0x64] = KEY_AUDIO,
> +	[0x65] = KEY_ANGLE,
> +	[0x70] = KEY_INFO,		/* display */
> +	[0x80] = KEY_BLUE,
> +	[0x81] = KEY_RED,
> +	[0x82] = KEY_GREEN,
> +	[0x83] = KEY_YELLOW,
> +};
> +
> +static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
> +			     unsigned int *rsize)
> +{
> +	*rsize = sizeof(ps3remote_rdesc);
> +	return ps3remote_rdesc;
> +}
> +
> +static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
> +			     struct hid_field *field, struct hid_usage *usage,
> +			     unsigned long **bit, int *max)
> +{
> +	unsigned int key = usage->hid & HID_USAGE;
> +
> +	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON)
> +		return -1;
> +
> +	switch (usage->collection_index) {
> +	case 1:
> +		if (key >= ARRAY_SIZE(ps3remote_keymap_joypad_buttons))
> +			return -1;
> +
> +		key = ps3remote_keymap_joypad_buttons[key];
> +		if (!key)
> +			return -1;
> +		break;
> +	case 2:
> +		if (key >= ARRAY_SIZE(ps3remote_keymap_remote_buttons))
> +			return -1;
> +
> +		key = ps3remote_keymap_remote_buttons[key];
> +		if (!key)
> +			return -1;
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
> +	return 1;
> +}
> +
> +static const struct hid_device_id ps3remote_devices[] = {
> +	/* PS3 BD Remote Control */
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
> +	/* Logitech Harmony Adapter for PS3 */
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, ps3remote_devices);
> +
> +static struct hid_driver ps3remote_driver = {
> +	.name          = "ps3_remote",
> +	.id_table      = ps3remote_devices,
> +	.report_fixup  = ps3remote_fixup,
> +	.input_mapping = ps3remote_mapping,
> +};
> +
> +static int __init ps3remote_init(void)
> +{
> +	return hid_register_driver(&ps3remote_driver);
> +}
> +
> +static void __exit ps3remote_exit(void)
> +{
> +	hid_unregister_driver(&ps3remote_driver);
> +}
> +
> +module_init(ps3remote_init);
> +module_exit(ps3remote_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>");
> -- 
> 1.7.10.4
> 
> 


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
