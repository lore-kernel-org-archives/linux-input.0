From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v2] HID: Add support for Sony PS3 BD Remote Control
Date: Wed, 19 Sep 2012 18:48:34 +0200
Message-ID: <20120919184834.8093076c520dba2dc91c2f5d@studenti.unina.it>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	<CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	<1347284864.3532.1.camel@sirocco.hadess.net>
	<CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	<CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	<CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
	<1347394656.1606.10.camel@sirocco.hadess.net>
	<CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
	<1347456657.23874.29.camel@sirocco.hadess.net>
	<CABBYNZLwXhF0gixPGKUTJY4sZ7EHynTYmHzGtiZsoRGXgeEFaw@mail.gmail.com>
	<CANq1E4SDXVHcumBbEA-4xpeuOQ0SjDxxtL_RqAiNYRPj6ccagQ@mail.gmail.com>
	<20120913003628.ce5babb2a66d09fe17fa15de@studenti.unina.it>
	<1347591892.6145.14.camel@obelisk.thedillows.org>
	<20120917120441.a164d2e10bb02aa9a1e8d523@studenti.unina.it>
	<1347929527.29391.9.camel@obelisk.thedillows.org>
	<1347932038.29391.17.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347932038.29391.17.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Luiz Augusto von Dentz <luiz.dentz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 17 Sep 2012 21:33:58 -0400
David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org> wrote:

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
> ---
>  drivers/hid/Kconfig         |   11 ++-
>  drivers/hid/Makefile        |    1 +
>  drivers/hid/hid-core.c      |    2 +
>  drivers/hid/hid-ids.h       |    2 +
>  drivers/hid/hid-ps3remote.c |  199 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 214 insertions(+), 1 deletions(-)
> 
> Here's an updated version of the HID driver for the PS3 BD Remote. I've
> gone ahead and signed off on it as it works for my Harmony adapter, but
> it needs testing with a real BD remote before going upstream. Antonio
> also asked for some text about the pairing process -- I've left it out
> since I don't know what it should be.
>

Tested with the original PS3 BD remote and this version works fine too,
thanks.

Tested-by: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>

About the multiple keys press handling I see that my keyboard does this:

I press 'a' and keep it pressed:
Event: time 1348069423.217974, type 1 (EV_KEY), code 30 (KEY_A), value 1
Event: time 1348069423.249871, type 1 (EV_KEY), code 30 (KEY_A), value 2
Event: time 1348069423.282410, type 1 (EV_KEY), code 30 (KEY_A), value 2
aaa
...

I press 's' and release it:
Event: time 1348069423.290792, type 1 (EV_KEY), code 31 (KEY_S), value 1
Event: time 1348069423.374516, type 1 (EV_KEY), code 31 (KEY_S), value 0
s

I release 'a':
Event: time 1348069427.351315, type 1 (EV_KEY), code 30 (KEY_A), value 0


While on the remote I see:

I press '1' and keep it pressed:
Event: time 1348069656.505528, type 1 (EV_KEY), code 2 (KEY_1), value 1
1111111111...

I press '2' and release it ('1' is sent):
Event: time 1348069666.025543, type 1 (EV_KEY), code 2 (KEY_1), value 0
Event: time 1348069668.395531, type 1 (EV_KEY), code 2 (KEY_1), value 1
1111111111...

I release '1':
Event: time 1348069671.625541, type 1 (EV_KEY), code 2 (KEY_1), value 0

I don't know at what level this behavior is enforced.

I will test later with the old raw_event callback and the fix to the
descriptor you suggested in the other mail.

David D. what is the behavior of the Harmony adapter?

Few more comments inlined below.

> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index fbf4950..7bf3b1a 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -534,6 +534,14 @@ config HID_PRIMAX
>  	Support for Primax devices that are not fully compliant with the
>  	HID standard.
>  
> +config HID_PS3REMOTE
> +	tristate "Sony PS3 BD Remote"

If you are going for a v3, consider using "Sony PS3 BD Remote Control"
here too, not a big deal but that's the name on the user manual.

> +	depends on BT_HIDP
> +	---help---
> +	Support for the Sony PS3 BD Remote and Logitech Harmony Adapter
> +	for PS3, which connect over Bluetooth. Support for the 6-axis
> +	controllers is provided by HID_SONY.
> +
>  config HID_ROCCAT
>  	tristate "Roccat device support"
>  	depends on USB_HID
> @@ -561,7 +569,8 @@ config HID_SONY
>  	tristate "Sony PS3 controller"
>  	depends on USB_HID
>  	---help---
> -	Support for Sony PS3 controller.
> +	Support for Sony PS3 6-axis controllers. Support for the Sony PS3
> +	BD Remote is provided by HID_PS3REMOTE.
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
> index 60ea284..a9f0439 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1591,6 +1591,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACETRAVELLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },

Jiri, what is supposed to be the ordering of entries here? Alphabetical
on the product field, or by product numerical value like in hid-ids.h?

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD_BOOTLOADER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500) },
> @@ -1641,6 +1642,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 1dcb76f..0f5c2bb 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -492,6 +492,7 @@
>  #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
>  
>  #define USB_VENDOR_ID_LOGITECH		0x046d
> +#define USB_DEVICE_ID_LOGITECH_HARMONY_PS3 0x0306
>  #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
>  #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
>  #define USB_DEVICE_ID_LOGITECH_HARMONY_FIRST  0xc110
> @@ -684,6 +685,7 @@
>  #define USB_VENDOR_ID_SONY			0x054c
>  #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE	0x024b
>  #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
> +#define USB_DEVICE_ID_SONY_PS3_BDREMOTE		0x0306
>  #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
>  
>  #define USB_VENDOR_ID_SOUNDGRAPH	0x15c2
> diff --git a/drivers/hid/hid-ps3remote.c b/drivers/hid/hid-ps3remote.c
> new file mode 100644
> index 0000000..e8caef0
> --- /dev/null
> +++ b/drivers/hid/hid-ps3remote.c
> @@ -0,0 +1,199 @@
> +/*
> + * HID driver for Sony PS3 BD Remote
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

For the note about the association procedure I had in mind something
like this:

/* NOTE: in order to associate the Sony PS3 BD Remote with a Bluetooth host
 * the key combination Start+Enter has to be kept pressed for about 7 seconds,
 * with the host BT Controller in discovering mode.
 *
 * Also the pin request should be ignored by the BT Controller (NULL pin).
 */

Could someone more into BT please check the terminology here? Thanks.

>
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +/*
> + * The first byte of the raw event report seems to contain a fixed number,
> + * possibly a controller number. The next three bytes contain a bitmask,
> + * in big-endian order, of a portion of the buttons available.
> + *
> + * Button	Bit	Scan	Mapped Key
> + * PS		0	0x43	KEY_HOMEPAGE
> + * Unknown	1-2
> + * Enter	3	0x0b	KEY_ENTER
> + * Unknown	4-7
> + * L2		8	0x58	BTN_TL2
> + * R2		9	0x59	BTN_TR2
> + * L1		10	0x5a	BTN_TL
> + * R1		11	0x5b	BTN_TR
> + * Triangle	12	0x5c	KEY_OPTION
> + * Circle	13	0x5d	KEY_BACK
> + * Cross	14	0x5e	BTN_0
> + * Square	15	0x5f	KEY_SCREEN
> + * Select	16	0x50	KEY_SELECT
> + * L3		17	0x51	BTN_THUMBL
> + * R3		18	0x52	BTN_THUMBR
> + * Start	19	0x53	BTN_START
> + * Up		20	0x54	KEY_UP
> + * Right	21	0x55	KEY_RIGHT
> + * Down		22	0x56	KEY_DOWN
> + * Left		23	0x57	KEY_LEFT
> + *
> + * The keymap is generally ordered by the physical location of the buttons,
> + * as this makes it easier to verify a correct mapping during testing.
> + */
> +static const unsigned int ps3remote_keymap[] = {
> +	[0x16] = KEY_EJECTCD,
> +	[0x64] = KEY_AUDIO,
> +	[0x65] = KEY_ANGLE,
> +	[0x63] = KEY_SUBTITLE,
> +	[0x0f] = KEY_CLEAR,
> +	[0x28] = KEY_TIME,
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
> +	[0x81] = KEY_RED,
> +	[0x82] = KEY_GREEN,
> +	[0x80] = KEY_BLUE,
> +	[0x83] = KEY_YELLOW,
> +	[0x70] = KEY_INFO,		/* display */
> +	[0x1a] = KEY_MENU,		/* top menu */
> +	[0x40] = KEY_CONTEXT_MENU,	/* pop up/menu */
> +	[0x0e] = KEY_ESC,		/* return */
> +	[0x5c] = KEY_OPTION,		/* options/triangle */
> +	[0x5d] = KEY_BACK,		/* back/circle */
> +	[0x5f] = KEY_SCREEN,		/* view/square */
> +	[0x5e] = BTN_0,			/* cross */
> +	[0x54] = KEY_UP,
> +	[0x56] = KEY_DOWN,
> +	[0x57] = KEY_LEFT,
> +	[0x55] = KEY_RIGHT,
> +	[0x0b] = KEY_ENTER,
> +	[0x5a] = BTN_TL,		/* L1 */
> +	[0x58] = BTN_TL2,		/* L2 */
> +	[0x51] = BTN_THUMBL,		/* L3 */
> +	[0x5b] = BTN_TR,		/* R1 */
> +	[0x59] = BTN_TR2,		/* R2 */
> +	[0x52] = BTN_THUMBR,		/* R3 */
> +	[0x43] = KEY_HOMEPAGE,		/* PS button */
> +	[0x50] = KEY_SELECT,
> +	[0x53] = BTN_START,
> +	[0x33] = KEY_REWIND,		/* scan back */
> +	[0x32] = KEY_PLAY,
> +	[0x34] = KEY_FORWARD,		/* scan forward */
> +	[0x30] = KEY_PREVIOUS,
> +	[0x38] = KEY_STOP,
> +	[0x31] = KEY_NEXT,
> +	[0x60] = KEY_FRAMEBACK,		/* slow/step back */
> +	[0x39] = KEY_PAUSE,
> +	[0x61] = KEY_FRAMEFORWARD,	/* slow/step forward */
> +};
> +
> +static __u8 ps3remote_rdesc[] = {
> +	0x05, 0x01,	/* USAGE PAGE (Generic Desktop) */
> +	0x09, 0x05,	/* USAGE (Game Pad) */
> +	0xa1, 0x01,	/* COLLECTION (Application) */
> +
> +	/* First four bytes contain a bitmask for some of the buttons, and
> +	 * possibly a controller number. We don't need this information,
> +	 * as the keys will be reported in the next field as well.
> +	 */
> +	0x75, 0x20,	/*   REPORT SIZE (32) */
> +	0x95, 0x01,	/*   REPORT COUNT (1) */
> +	0x81, 0x01,	/*   INPUT (Constant) */
> +
> +	/* All key presses are reported in this field  */
> +	0x05, 0x09,	/*   USAGE PAGE (Button) */
> +	0x19, 0x00,	/*   USAGE MINIMUM (0) */
> +	0x29, 0xfe,	/*   USAGE MAXIMUM (254) */
> +	0x15, 0x00,	/*   LOGICAL MINIMUM (0) */
> +	0x25, 0xfe,	/*   LOGICAL MAXIMUM (254) */
> +	0x75, 0x08,	/*   REPORT SIZE (8) */
> +	0x95, 0x06,	/*   REPORT COUNT (6) */
> +	0x81, 0x00,	/*   INPUT (Array, Absolute) */
> +
> +	/* Ignore press indication */
> +	0x75, 0x08,	/*   REPORT SIZE (8) */
> +	0x95, 0x01,	/*   REPORT COUNT (1) */
> +	0x81, 0x01,	/*   INPUT (Constant) */
> +
> +	/* Report the battery level */
> +	0x05, 0x06,	/*   USAGE PAGE (Generic Device) */
> +	0x09, 0x20,	/*   USAGE (Battery Strength) */
> +	0x15, 0x00,	/*   LOGICAL MINIMUM (0) */
> +	0x25, 0x05,	/*   LOGICAL MAXIMUM (5) */
> +	0x75, 0x08,	/*   REPORT SIZE (8) */
> +	0x95, 0x01,	/*   REPORT COUNT (1) */
> +	0x81, 0x02,	/*   INPUT (Variable, Absolute) */
> +	0xc0,		/* END_COLLECTION */
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
> +	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON ||
> +	    key >= ARRAY_SIZE(ps3remote_keymap))
> +		return -1;
> +
> +	key = ps3remote_keymap[key];
> +	if (!key)
> +		return -1;
> +
> +	hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
> +	return 1;
> +}
> +
> +static const struct hid_device_id ps3remote_devices[] = {
> +	/* PS3 BD Remote */
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
> +	/* Logitech Harmony Adapter for PS3 */
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, ps3remote_devices);
> +
> +static struct hid_driver ps3remote_driver = {
> +	.name		= "ps3_remote",
> +	.id_table	= ps3remote_devices,
> +	.report_fixup	= ps3remote_fixup,
> +	.input_mapping	= ps3remote_mapping,
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
> +MODULE_AUTHOR("David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>");
> 

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
