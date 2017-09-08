From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v3] HID: google: add google hammer HID driver
Date: Fri, 8 Sep 2017 10:34:34 -0700
Message-ID: <20170908173434.GA13148@roeck-us.net>
References: <20170907083743.31389-1-wnhuang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38450 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756636AbdIHRel (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Sep 2017 13:34:41 -0400
Content-Disposition: inline
In-Reply-To: <20170907083743.31389-1-wnhuang@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei-Ning Huang <wnhuang@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>, Nicolas Boichat <drinkcat@google.com>, Wei-Ning Huang <wnhuang@google.com>

On Thu, Sep 07, 2017 at 04:37:43PM +0800, Wei-Ning Huang wrote:
> From: Wei-Ning Huang <wnhuang@chromium.org>
> 
> Add Google hammer HID driver. This driver allow us to control hammer
> keyboard backlights and support future features.  Since current hid-core
> logic does not allow us to specify different USB interface for binding
> different driver, some code are added in HID core to allow us to bind
> the touchpad to multitouch driver, and bind keyboard to the hammer
> driver and the same time.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> ---

changelog ?

>  drivers/hid/Kconfig             |   6 +++
>  drivers/hid/Makefile            |   1 +
>  drivers/hid/hid-core.c          |  33 ++++++++++--
>  drivers/hid/hid-google-hammer.c | 110 ++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h           |   2 +
>  include/linux/hid.h             |   1 +
>  6 files changed, 148 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/hid/hid-google-hammer.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 0a3117cc29e7..5373887f056e 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -329,6 +329,12 @@ config HOLTEK_FF
>  	  Say Y here if you have a Holtek On Line Grip based game controller
>  	  and want to have force feedback support for it.
>  
> +config HID_GOOGLE_HAMMER
> +	tristate "Google Hammer Keyboard"
> +	depends on USB_HID && LEDS_CLASS
> +	---help---
> +	Say Y here if you have a Google Hammer device.
> +
>  config HID_GT683R
>  	tristate "MSI GT68xR LED support"
>  	depends on LEDS_CLASS && USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 8659d7e633a5..b5d3039286e3 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_HID_ELO)		+= hid-elo.o
>  obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
>  obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
>  obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
> +obj-$(CONFIG_HID_GOOGLE_HAMMER)	+= hid-google-hammer.o
>  obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
>  obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
>  obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9bc91160819b..78d2dbc74cce 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -44,6 +44,12 @@
>  
>  #define DRIVER_DESC "HID core driver"
>  
> +/*
> + * Qurik that is pass to the driver_data of struct hid_device_id indicating

s/Qurik/Quirk/

though something like

    Quirk to be added to driver_data of struct hid_device_id indicating ...

might be a bit easier to read.

> + * that some of the interfaces on the bus should not use the generic hid driver.
> + */
> +#define QUIRK_NO_HID_GENERIC BIT(0)
> +
>  int hid_debug = 0;
>  module_param_named(debug, hid_debug, int, 0600);
>  MODULE_PARM_DESC(debug, "toggle HID debugging messages");
> @@ -2053,6 +2059,12 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  #if IS_ENABLED(CONFIG_HID_GREENASIA)
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0012) },
>  #endif
> +#if IS_ENABLED(CONFIG_HID_GOOGLE_HAMMER)
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER),
> +	  .driver_data = QUIRK_NO_HID_GENERIC },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF),
> +	  .driver_data = QUIRK_NO_HID_GENERIC },
> +#endif
>  #if IS_ENABLED(CONFIG_HID_GT683R)
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
>  #endif
> @@ -2952,11 +2964,22 @@ int hid_add_device(struct hid_device *hdev)
>  	 */
>  	if (hid_ignore_special_drivers) {
>  		hdev->group = HID_GROUP_GENERIC;
> -	} else if (!hdev->group &&
> -		   !hid_match_id(hdev, hid_have_special_driver)) {
> -		ret = hid_scan_report(hdev);
> -		if (ret)
> -			hid_warn(hdev, "bad device descriptor (%d)\n", ret);
> +	} else if (!hdev->group) {
> +		const struct hid_device_id *matched_id = hid_match_id(
> +			hdev, hid_have_special_driver);
> +
> +		if (!matched_id ||
> +		    matched_id->driver_data & QUIRK_NO_HID_GENERIC) {
> +			ret = hid_scan_report(hdev);
> +			if (ret)
> +				hid_warn(hdev, "bad device descriptor (%d)\n",
> +					 ret);
> +
> +			if (matched_id &&
> +			    matched_id->driver_data & QUIRK_NO_HID_GENERIC &&
> +			    hdev->group == HID_GROUP_GENERIC)
> +				hdev->group = HID_GROUP_GENERIC_OVERRIDE;
> +		}
>  	}
>  
>  	/* XXX hack, any other cleaner solution after the driver core
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> new file mode 100644
> index 000000000000..4d301e1a6707
> --- /dev/null
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -0,0 +1,110 @@
> +/*
> + *  HID driver for Google Hammer device.
> + *
> + *  Copyright (c) 2017 Google Inc.
> + *  Author: Wei-Ning Huang <wnhuang@google.com>
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/hid.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +
> +#include "hid-ids.h"
> +
> +#define MAX_BRIGHTNESS 100
> +
> +struct hammer_kbd_leds {
> +	struct led_classdev cdev;
> +	struct hid_device *hdev;
> +	u8 buf[2] ____cacheline_aligned;
> +};
> +
> +static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
> +		enum led_brightness br)
> +{
> +	struct hammer_kbd_leds *led = container_of(cdev,
> +						   struct hammer_kbd_leds,
> +						   cdev);
> +	int ret;
> +
> +	led->buf[0] = 0;
> +	led->buf[1] = br;
> +
> +	ret = hid_hw_output_report(led->hdev, led->buf, sizeof(led->buf));
> +	if (ret == -ENOSYS)
> +		ret = hid_hw_raw_request(led->hdev, 0, led->buf,
> +					 sizeof(led->buf),
> +					 HID_OUTPUT_REPORT,
> +					 HID_REQ_SET_REPORT);
> +	if (ret < 0)
> +		hid_err(led->hdev, "failed to set keyboard backlight: %d\n",
> +			ret);
> +	return ret;
> +}
> +
> +static int hammer_register_leds(struct hid_device *hdev)
> +{
> +	struct hammer_kbd_leds *kbd_backlight;
> +
> +	kbd_backlight = devm_kzalloc(&hdev->dev,
> +				     sizeof(*kbd_backlight),
> +				     GFP_KERNEL);
> +	if (!kbd_backlight)
> +		return -ENOMEM;
> +
> +	kbd_backlight->hdev = hdev;
> +	kbd_backlight->cdev.name = "hammer::kbd_backlight";
> +	kbd_backlight->cdev.max_brightness = MAX_BRIGHTNESS;
> +	kbd_backlight->cdev.brightness_set_blocking =
> +		hammer_kbd_brightness_set_blocking;
> +	kbd_backlight->cdev.flags = LED_HW_PLUGGABLE;
> +
> +	/* Set backlight to 0% initially. */
> +	hammer_kbd_brightness_set_blocking(&kbd_backlight->cdev, 0);
> +
> +	return devm_led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
> +}
> +
> +static int hammer_input_configured(struct hid_device *hdev,
> +				   struct hid_input *hi)
> +{
> +	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> +
> +	if (intf->cur_altsetting->desc.bInterfaceProtocol ==
> +	    USB_INTERFACE_PROTOCOL_KEYBOARD) {
> +		int err = hammer_register_leds(hdev);
> +
> +		if (err)
> +			hid_warn(hdev,
> +				 "Failed to register keyboard backlight: %d\n",
> +				 err);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hid_device_id hammer_devices[] = {
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC_OVERRIDE,
> +		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC_OVERRIDE,
> +		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, hammer_devices);
> +
> +static struct hid_driver hammer_driver = {
> +	.name = "hammer",
> +	.id_table = hammer_devices,
> +	.input_configured = hammer_input_configured,
> +};
> +module_hid_driver(hammer_driver);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b397a14ab970..112ae4053321 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -436,7 +436,9 @@
>  #define USB_DEVICE_ID_GOODTOUCH_000f	0x000f
>  
>  #define USB_VENDOR_ID_GOOGLE		0x18d1
> +#define USB_DEVICE_ID_GOOGLE_HAMMER	0x5022
>  #define USB_DEVICE_ID_GOOGLE_TOUCH_ROSE	0x5028
> +#define USB_DEVICE_ID_GOOGLE_STAFF	0x502b
>  
>  #define USB_VENDOR_ID_GOTOP		0x08f2
>  #define USB_DEVICE_ID_SUPER_Q2		0x007f
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ab05a86269dc..e34430cfc8b8 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -356,6 +356,7 @@ struct hid_item {
>  #define HID_GROUP_MULTITOUCH			0x0002
>  #define HID_GROUP_SENSOR_HUB			0x0003
>  #define HID_GROUP_MULTITOUCH_WIN_8		0x0004
> +#define HID_GROUP_GENERIC_OVERRIDE		0x0005
>  
>  /*
>   * Vendor specific HID device groups
