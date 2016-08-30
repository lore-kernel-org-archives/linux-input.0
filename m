From: Roland Singer <roland.singer@desertbit.com>
Subject: Re: [PATCH 1/1] input: hid-razer driver: add support for Razer
 devices
Date: Tue, 30 Aug 2016 11:22:52 +0200
Message-ID: <28ad9ba3-74ba-f36c-b955-f016ab6f23f1@desertbit.com>
References: <2f678bc0-64a5-a33c-d088-0309a6cef143@desertbit.com>
 <784849b9-7b09-cd3d-259d-57781076879c@desertbit.com>
 <20160829154622.GB21864@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from static.146.197.76.144.clients.your-server.de ([144.76.197.146]:57122
        "EHLO desertbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbcH3JYO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 Aug 2016 05:24:14 -0400
In-Reply-To: <20160829154622.GB21864@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org

Hi Benjamin,

thank you for your hints and your thoughts about using hidraw!
I must admit, that you're absolutely right and this really doesn't
belong into the kernel. I'll stop the development of the OpenRazer
kernel driver and work on an userspace hidraw implementation.

I mentioned your thoughts here in our Github discussion:
https://github.com/terrycain/razer-drivers/issues/29#issuecomment-243380127

Cheers,
Roland


Am 29.08.2016 um 17:46 schrieb Benjamin Tissoires:
> Hi Roland,
> 
> On Aug 26 2016 or thereabouts, Roland Singer wrote:
>> From: Roland Singer <roland.singer@desertbit.com>
>>
>> This driver adds support for Razer devices. It supports custom keyboard
>> and laptop lightning modes, special macro keys and various settings.
>> It has been tested with the Razer Blade 14 2016 laptop,
>> Razer Blade Stealth 2016 laptop and the BlackWidow Chroma keyboard.
>>
>> It supports brightness control, lid logo control, FN mode control,
>> all lighting modes, set custom key colors and macro keys.
>>
>> Signed-off-by: Roland Singer <roland.singer@desertbit.com>
>> ---
>> This driver is the initial release and will be extended with further
>> Razer device support. Common functionalities have been extracted
>> to the razer-common module.
>> This driver belongs to the new OpenRazer Project, which also provides
>> userland tools to configure and handle Razer devices.
>> Reference: https://github.com/openrazer
> 
> I saw your other email, but I still wants to make some high-level review
> so that you don't spend too much time in code you will need to remove.
> 
> So here they come:
> Generally, it is better to keep the kernel interface to a minimum. It's
> OK to enable macro keys from the kernel, but setting the color of the
> keyboard is something which should be done IMO in userspace only through
> hidraw.
> 
> The reasons are:
> - maintaining a kernel API is a pain
> - you basically can't change it while it's there given that you might
>   have users using it
> - roccat used to have a kernel API, and the latest userspace version
>   of the tool went away from this given that it was too much of a pain
>   and using hidraw allows a lot more flexibility
> - we have standard API for LED, and you are not using them
> - add some more which would convince you :)
> 
> Please have a look at what hidraw offers and think twice before adding a
> sysfs API for a functionality (I'll give you my ideas below). You can
> see what we are doing for Logitech and some others in libratbag
> (github.com/libratbag/libratbag) or what roccat (the open project, not
> the company) did.
> 
>> ---
>> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-razer b/Documentation/ABI/testing/sysfs-driver-hid-razer
>> new file mode 100644
>> index 0000000..594ca18
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-hid-razer
>> @@ -0,0 +1,190 @@
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/device_type
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Returns a friendly device type string.
>> +		This file is readonly.
>> +Users:		https://github.com/openrazer
> 
> Do we need that? (can't this be appended to the device name or something
> similar)
> 
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/get_serial
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Returns the serial number from the device as string.
>> +		This file is readonly.
>> +Users:		https://github.com/openrazer
>> +
> 
> This would fit in the .uniq field of struct input for instance.
> 
> Plus the name is wrong. "serial" is better.
> 
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/get_firmware_version
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Returns the firmware version from the device as string.
>> +		This file is readonly.
>> +Users:		https://github.com/openrazer
> 
> Usually we just output it in the dmesg. If your tool needs to retrieve
> it, you have the request handy in userspace, so there might not be a
> strong need here either.
> 
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/brightness
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	When read, this file returns the brightness value from 0-255.
>> +		When written, this file sets the brightness to the ASCII number
>> +		written to this file. Values from 0-255.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
> 
> Please refrain from using custom sysfs when dealing with LEDs. We have
> the kernel LED API, which is basic, but it should be sufficient for most
> needs.
> If you need to do more fancy configurations, then maybe this belongs to
> userspace.
> 
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/fn_mode
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	When read, this file returns the current set FN mode.
>> +		When written, this file sets the FN mode to the ASCII number
>> +		written to this file.
>> +
>> +		ASCII VALUE   DESCRIPTION
>> +		0             The F-keys work as normal F-keys
>> +		1             The F-keys act as if the FN key is held
>> +
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
> 
> I'd keep this one, or I would let userspace set the expected fn mode at login.
> 
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/set_logo
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Sets the logo lighting state to the ASCII number written to this file.
>> +
>> +		ASCII VALUE   STATE
>> +		0             off
>> +		1             on
>> +
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
> 
> Definitively userspace thingy. I mean, the API. I would be happy if you
> set a specific mode in the driver at probe to not annoy users using the
> VT only.
> 
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/set_key_colors
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Set the colors of all keys of the keyboard. 3 bytes per color.
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:			https://github.com/openrazer
> 
> If you need, use three kernel LED api.
> But honestly, do you need to set this at boot in the kernel? If your
> tool is required to change a setting, that's a good sign that the
> parameter should not be in the kernel.
> 
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/get_key_rows
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Returns the amount of key rows as number.
>> +		This file is readonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
> 
> This one and the one after seems tightly linked to the LED setting and
> should IMO be done in userspace.
> 
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/get_key_columns
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Returns the amount of key columns as number.
>> +		This file is readonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/mode_none
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	When written to, disables keyboard effects / turns the keyboard LEDs off.
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/mode_static
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Set the keyboard to static mode when 3 RGB bytes are written.
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/mode_custom
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Sets the keyboard to custom mode whenever the file is written to.
>> +		Custom colors previously set with set_key_colors are shown.
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/mode_wave
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Sets the keyboard to wave mode.
>> +
>> +		ASCII VALUE   DESCRIPTION
>> +		1             wave effect is displayed moving left across the keyboard.
>> +		2             wave effect is displayed moving right across the keyboard.
>> +
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/mode_spectrum
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Sets the keyboard to spectrum mode whenever the file is written to.
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/mode_reactive
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Sets the keyboard to reactive mode.
>> +		A speed byte and 3 RGB bytes should be written.
>> +
>> +		VALUE SPEED
>> +		1     Short
>> +		2     Medium
>> +		3     Long
>> +
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/mode_starlight
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Sets the keyboard to starlight mode.
>> +		Requires at least one byte representing the effect speed.
>> +
>> +		Mode 1: single color. 3 RGB bytes.
>> +		Mode 2: two colors. 6 RGB bytes.
>> +		Mode 3: random colors. Anything else passed.
>> +
>> +		VALUE SPEED
>> +		1     Short
>> +		2     Medium
>> +		3     Long
>> +
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
>> +
>> +
>> +What:		/sys/bus/hid/drivers/hid-razer/<hid-bus>:<vendor-id>:<product-id>.<num>/mode_breath
>> +Date:		August 2016
>> +Contact:	Roland Singer <roland.singer@desertbit.com>
>> +Description:	Sets the keyboard to breath mode.
>> +		Breathing mode has 3 modes of operation.
>> +
>> +		Mode 1 fading in and out using a single color. 3 RGB bytes.
>> +		Mode 2 is fading in and out between two colors. 6 RGB bytes.
>> +		Mode 3 is fading in and out between random colors. Anything else passed.
>> +
>> +		This file is writeonly.
>> +		This file is optional and exists if the device supports this.
>> +Users:		https://github.com/openrazer
> 
> All those mode_* will be a pain for you to maintain. When a new device
> comes in, you'll have to update the kernel for it, wait for your users
> to have it, update your tool and maintain old versions of the modes.
> 
> If Razer decides to add an other mode, you'll have to add a new API, and
> if the breathing changes, you might need to add a new
> mode_breathing_2...
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a306795..594789a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9771,6 +9771,13 @@ L:	linux-wireless@vger.kernel.org
>>  S:	Orphan
>>  F:	drivers/net/wireless/ray*
>>  
>> +RAZER DRIVERS
>> +M:	Roland Singer <roland.singer@desertbit.com>
>> +W:	https://github.com/openrazer
>> +S:	Maintained
>> +F:	drivers/hid/hid-razer*
>> +F:	Documentation/ABI/*/sysfs-driver-hid-razer*
>> +
>>  RCUTORTURE MODULE
>>  M:	Josh Triplett <josh@joshtriplett.org>
>>  M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 78ac481..5e74a0e 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -702,6 +702,14 @@ config HID_PRIMAX
>>  	Support for Primax devices that are not fully compliant with the
>>  	HID standard.
>>  
>> +config HID_RAZER
>> +	tristate "Razer device support"
>> +	depends on USB_HID
>> +	---help---
>> +	Support for Razer devices.
>> +	Supports custom mouse, keyboard and laptop lightning modes, special keys
>> +	and various settings. This driver is required for the OpenRazer project.
>> +
>>  config HID_ROCCAT
>>  	tristate "Roccat device support"
>>  	depends on USB_HID
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index fc4b2aa..30fbc8c 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -78,6 +78,7 @@ hid-picolcd-$(CONFIG_DEBUG_FS)		+= hid-picolcd_debugfs.o
>>  
>>  obj-$(CONFIG_HID_PLANTRONICS)	+= hid-plantronics.o
>>  obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
>> +obj-$(CONFIG_HID_RAZER) 	+= hid-razer-common.o hid-razer.o
>>  obj-$(CONFIG_HID_ROCCAT)	+= hid-roccat.o hid-roccat-common.o \
>>  	hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
>>  	hid-roccat-koneplus.o hid-roccat-konepure.o hid-roccat-kovaplus.o \
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 4ed9a4f..ee76e46 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -1085,4 +1085,9 @@
>>  #define USB_DEVICE_ID_RAPHNET_2NES2SNES	0x0002
>>  #define USB_DEVICE_ID_RAPHNET_4NES4SNES	0x0003
>>  
>> +#define USB_VENDOR_ID_RAZER                     0x1532
>> +#define USB_DEVICE_ID_RAZER_BLADE_STEALTH_2016  0x0205
>> +#define USB_DEVICE_ID_RAZER_BLADE_14_2016       0x020F
>> +#define USB_DEVICE_ID_RAZER_BLACKWIDOW_CHROMA   0x0203
>> +
>>  #endif
>> diff --git a/drivers/hid/hid-razer-common.c b/drivers/hid/hid-razer-common.c
> 
> What's the point of having 2 files? Roccat was special in a way but we
> now prefer having only one file per manufacturer.
> 
>> new file mode 100644
>> index 0000000..2f3406d
>> --- /dev/null
>> +++ b/drivers/hid/hid-razer-common.c
>> @@ -0,0 +1,296 @@
>> +/*
>> + * Razer Kernel Drivers
>> + * Copyright (c) 2016 Roland Singer <roland.singer@desertbit.com>
>> + * Based on Tim Theede <pez2001@voyagerproject.de> razer_chroma_drivers project.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/printk.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/usb/input.h>
> 
> eeeeks
> 
> HID is transport agnostic, you shouldn't have to include anything usb
> related. (unless the device is not using HID after all for configuration)
> 
>> +#include <linux/hid.h>
>> +
>> +#include "hid-razer-common.h"
>> +
>> +//###########################//
>> +//### Version Information ###//
>> +//###########################//
>> +
>> +MODULE_AUTHOR("Roland Singer <roland.singer@desertbit.com>");
>> +MODULE_DESCRIPTION("USB Razer common driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_VERSION("1.0.0");
>> +
>> +//##########################//
>> +//### Exported Functions ###//
>> +//##########################//
>> +
>> +/*
>> + * Initialize a razer device struct.
>> + */
>> +int razer_init_device(struct razer_device *razer_dev,
>> +		      struct usb_device *usb_dev)
>> +{
>> +	razer_dev->data     = NULL;
>> +	razer_dev->usb_dev  = usb_dev;
>> +	mutex_init(&razer_dev->lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(razer_init_device);
>> +
>> +/*
>> + * Get an initialised razer report
>> + */
>> +struct razer_report razer_new_report(void)
>> +{
>> +	struct razer_report new_report;
>> +
>> +	memset(&new_report, 0, sizeof(new_report));
>> +
>> +	new_report.status             = RAZER_STATUS_NEW_COMMAND;
>> +	new_report.transaction_id     = 0xFF;
>> +	new_report.remaining_packets  = 0x00;
>> +	new_report.protocol_type      = 0x00;
>> +	new_report.reserved           = 0x00;
>> +	new_report.command_class      = 0x00;
>> +	new_report.command_id         = 0x00;
>> +	new_report.data_size          = 0x00;
>> +
>> +	return new_report;
>> +}
>> +EXPORT_SYMBOL_GPL(razer_new_report);
>> +
>> +/*
>> + * Send an USB control report to the device.
>> + * Returns 0 on success.
>> + */
>> +int _razer_send(struct razer_device *razer_dev, struct razer_report *report)
>> +{
>> +	const uint size = sizeof(*report);
>> +	char *buf;
>> +	int len;
>> +
>> +	buf = kmemdup(report, size, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	len =
>> +	usb_control_msg(razer_dev->usb_dev,
>> +			usb_sndctrlpipe(razer_dev->usb_dev, 0),
>> +			HID_REQ_SET_REPORT,                        // Request
>> +			USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
>> +			0x300,                                     // Value
>> +			razer_dev->report_index,                   // Index
>> +			buf,                                       // Data
>> +			size,                                      // Length
>> +			USB_CTRL_SET_TIMEOUT);
> 
> Why not using hid_hw_request?
> 
>> +
>> +	usleep_range(600, 800);
>> +
>> +	kfree(buf);
>> +
>> +	return ((len < 0) ? len : ((len != size) ? -EIO : 0));
>> +}
>> +
>> +int razer_send(struct razer_device *razer_dev, struct razer_report *report)
>> +{
>> +	int retval;
>> +
>> +	mutex_lock(&razer_dev->lock);
>> +	retval = _razer_send(razer_dev, report);
>> +	mutex_unlock(&razer_dev->lock);
>> +
>> +	return retval;
>> +}
>> +EXPORT_SYMBOL_GPL(razer_send);
>> +
>> +/*
>> + * Get a response from the razer device.
>> + * Returns 0 on success.
>> + */
>> +int _razer_receive(struct razer_device *razer_dev, struct razer_report *report)
>> +{
>> +	const uint size = sizeof(*report);
>> +	int len;
>> +
>> +	memset(report, 0, size);
>> +
>> +	len =
>> +	usb_control_msg(razer_dev->usb_dev,
>> +			usb_rcvctrlpipe(razer_dev->usb_dev, 0),
>> +			HID_REQ_GET_REPORT,                          // Request
>> +			USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
>> +			0x300,                                       // Value
>> +			razer_dev->report_index,                     // Index
>> +			report,                                      // Data
>> +			size,
>> +			USB_CTRL_SET_TIMEOUT);
>> +
>> +	usleep_range(600, 800);
>> +
>> +	return ((len < 0) ? len : ((len != size) ? -EIO : 0));
>> +}
>> +
>> +int razer_receive(struct razer_device *razer_dev, struct razer_report *report)
>> +{
>> +	int retval;
>> +
>> +	mutex_lock(&razer_dev->lock);
>> +	retval = _razer_receive(razer_dev, report);
>> +	mutex_unlock(&razer_dev->lock);
>> +
>> +	return retval;
>> +}
>> +EXPORT_SYMBOL_GPL(razer_receive);
>> +
>> +/*
>> + * Send a report and wait for a response.
>> + * Returns 0 on success.
>> + */
>> +int _razer_send_with_response(struct razer_device *razer_dev,
>> +			      struct razer_report *request_r,
>> +			      struct razer_report *response_r)
>> +{
>> +	int retval, r;
>> +
>> +	retval = _razer_send(razer_dev, request_r);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	// Retry 40 times when busy -> 125 milliseconds -> max 5 seconds wait
>> +	for (r = 0; r < 40; r++) {
>> +		retval = _razer_receive(razer_dev, response_r);
>> +		if (retval != 0)
>> +			return retval;
>> +
>> +		if (response_r->command_class != request_r->command_class ||
>> +		    response_r->command_id != request_r->command_id) {
>> +			dev_err(&razer_dev->usb_dev->dev,
>> +				"razer_send_with_response: "
>> +				"response commands do not match: "
>> +				"Request Class: %d "
>> +				"Request ID: %d "
>> +				"Response Class: %d "
>> +				"Response ID: %d\n",
>> +				request_r->command_class,
>> +				request_r->command_id,
>> +				response_r->command_class,
>> +				response_r->command_id);
>> +			return -EINVAL;
>> +		}
>> +
>> +		switch (response_r->status) {
>> +		case RAZER_STATUS_SUCCESS:
>> +			return 0;
>> +
>> +		case RAZER_STATUS_BUSY:
>> +			msleep(125);
>> +			continue;
>> +
>> +		case RAZER_STATUS_FAILURE:
>> +		case RAZER_STATUS_TIMEOUT:
>> +		case RAZER_STATUS_NOT_SUPPORTED:
>> +			return -EINVAL;
>> +
>> +		default:
>> +			dev_err(&razer_dev->usb_dev->dev,
>> +				"razer_send_with_response: "
>> +				"unknown response status 0x%x\n",
>> +				response_r->status);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	dev_err(&razer_dev->usb_dev->dev, "razer_send_with_response: "
>> +		"request failed: device is busy\n");
>> +
>> +	return -EBUSY;
>> +}
>> +
>> +int razer_send_with_response(struct razer_device *razer_dev,
>> +			     struct razer_report *request_report,
>> +			     struct razer_report *response_report)
>> +{
>> +	int retval;
>> +
>> +	mutex_lock(&razer_dev->lock);
>> +	retval = _razer_send_with_response(razer_dev,
>> +					   request_report, response_report);
>> +	mutex_unlock(&razer_dev->lock);
>> +
>> +	return retval;
>> +}
>> +EXPORT_SYMBOL_GPL(razer_send_with_response);
>> +
>> +/*
>> + * Send a report, wait for a response and check the response status.
>> + * Returns 0 on success.
>> + */
>> +int razer_send_check_response(struct razer_device *razer_dev,
>> +			      struct razer_report *request_report)
>> +{
>> +	struct razer_report response_report;
>> +
>> +	return razer_send_with_response(razer_dev,
>> +					request_report, &response_report);
>> +}
>> +EXPORT_SYMBOL_GPL(razer_send_check_response);
>> +
>> +/*
>> + * Calculate the checksum for the usb message
>> + *
>> + * Checksum byte is stored in the 2nd last byte in the messages payload.
>> + * The checksum is generated by XORing all the bytes in the report starting
>> + * at byte number 2 (0 based) and ending at byte 88.
>> + */
>> +unsigned char razer_calculate_crc(struct razer_report *report)
>> +{
>> +	// Second to last byte of report is a simple checksum.
>> +	// Just xor all bytes up with overflow and you are done.
>> +	unsigned char crc = 0;
>> +	unsigned char *_report = (unsigned char *)report;
>> +	unsigned int i;
>> +
>> +	for (i = 2; i < 88; i++)
>> +		crc ^= _report[i];
>> +
>> +	return crc;
>> +}
>> +EXPORT_SYMBOL_GPL(razer_calculate_crc);
>> +
>> +/*
>> + * Detailed error print
>> + */
>> +void razer_print_err_report(struct razer_report *report,
>> +			    char *driver_name, char *message)
>> +{
>> +	printk(KERN_WARNING "%s: %s. Status: %02x Transaction ID: %02x"
>> +	       " Data Size: %02x Command Class: %02x Command ID: %02x"
>> +	       " Params: %02x%02x%02x%02x%02x%02x%02x%02x%02x%02x\n",
>> +	       driver_name,
>> +	       message,
>> +	       report->status,
>> +	       report->transaction_id,
>> +	       report->data_size,
>> +	       report->command_class,
>> +	       report->command_id,
>> +	       report->arguments[0], report->arguments[1],
>> +	       report->arguments[2], report->arguments[3],
>> +	       report->arguments[4], report->arguments[5],
>> +	       report->arguments[6], report->arguments[7],
>> +	       report->arguments[8], report->arguments[9]);
> 
> %10ph would help you here, instead of using all of the bytes one by one.
> 
>> +}
>> +EXPORT_SYMBOL_GPL(razer_print_err_report);
>> diff --git a/drivers/hid/hid-razer-common.h b/drivers/hid/hid-razer-common.h
>> new file mode 100644
>> index 0000000..ec5d191
>> --- /dev/null
>> +++ b/drivers/hid/hid-razer-common.h
>> @@ -0,0 +1,96 @@
>> +/*
>> + * Razer Kernel Drivers
>> + * Copyright (c) 2016 Roland Singer <roland.singer@desertbit.com>
>> + * Based on Tim Theede <pez2001@voyagerproject.de> razer_chroma_drivers project.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __HID_RAZER_COMMON_H
>> +#define __HID_RAZER_COMMON_H
>> +
>> +#include <linux/usb.h>
>> +#include <linux/types.h>
>> +
>> +//#############//
>> +//### Types ###//
>> +//#############//
>> +
>> +enum razer_status {
>> +	RAZER_STATUS_NEW_COMMAND   = 0x00,
>> +	RAZER_STATUS_BUSY          = 0x01,
>> +	RAZER_STATUS_SUCCESS       = 0x02,
>> +	RAZER_STATUS_FAILURE       = 0x03,
>> +	RAZER_STATUS_TIMEOUT       = 0x04,
>> +	RAZER_STATUS_NOT_SUPPORTED = 0x05
>> +};
>> +
>> +struct razer_device {
>> +	struct usb_device *usb_dev;
>> +	struct mutex      lock;          // Synchronize usb access.
>> +	uint              report_index;  // The report index to use.
>> +	void              *data;         // Optional custom data.
>> +};
>> +
>> +struct razer_rgb {
>> +	unsigned char r, g, b;
>> +};
>> +
>> +// Report send or received from the device.
>> +// transaction_id: Used to group request-response.
>> +// remaining_packets: Number of remaining packets in the sequence (Big Endian).
>> +// protocol_type: Always 0x0.
>> +// data_size:     Size of payload, cannot be greater than 80.
>> +//                90 = header (8B) + data + CRC (1B) + Reserved (1B)
>> +// command_id:    Type of command being issued.
>> +// command_class: Type of command being send. Direction 0 is Host->Device.
>> +//                Direction 1 is Device->Host. AKA Get LED 0x80, Set LED 0x00
>> +// crc:           xor'ed bytes of report
>> +// reserved:      Is always 0x0.
>> +struct razer_report {
>> +	unsigned char   status;
>> +	unsigned char   transaction_id;
>> +	unsigned short  remaining_packets;
>> +	unsigned char   protocol_type;
>> +	unsigned char   data_size;
>> +	unsigned char   command_class;
>> +	unsigned char   command_id;
>> +	unsigned char   arguments[80];
>> +	unsigned char   crc;
>> +	unsigned char   reserved;
>> +};
>> +
>> +//#################//
>> +//### Functions ###//
>> +//#################//
>> +
>> +int razer_init_device(struct razer_device *razer_dev,
>> +		      struct usb_device *usb_dev);
>> +
>> +struct razer_report razer_new_report(void);
>> +
>> +int razer_send(struct razer_device *razer_dev, struct razer_report *report);
>> +
>> +int razer_receive(struct razer_device *razer_dev, struct razer_report *report);
>> +
>> +int razer_send_with_response(struct razer_device *razer_dev,
>> +			     struct razer_report *request_report,
>> +			     struct razer_report *response_report);
>> +
>> +int razer_send_check_response(struct razer_device *razer_dev,
>> +			      struct razer_report *request_report);
>> +
>> +unsigned char razer_calculate_crc(struct razer_report *report);
>> +
>> +void razer_print_err_report(struct razer_report *report,
>> +			    char *driver_name, char *message);
>> +
>> +#endif // __HID_RAZER_COMMON_H
>> diff --git a/drivers/hid/hid-razer.c b/drivers/hid/hid-razer.c
>> new file mode 100644
>> index 0000000..9cbc53f
>> --- /dev/null
>> +++ b/drivers/hid/hid-razer.c
>> @@ -0,0 +1,1430 @@
>> +/*
>> + * Razer Kernel Drivers
>> + * Copyright (c) 2016 Roland Singer <roland.singer@desertbit.com>
>> + * Based on Tim Theede <pez2001@voyagerproject.de> razer_chroma_drivers project.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/printk.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/usb/input.h>
>> +#include <linux/hid.h>
>> +#include <linux/dmi.h>
>> +
>> +#include "hid-ids.h"
>> +#include "hid-razer-common.h"
>> +#include "hid-razer.h"
>> +
>> +//###########################//
>> +//### Version Information ###//
>> +//###########################//
>> +
>> +MODULE_AUTHOR("Roland Singer <roland.singer@desertbit.com>");
>> +MODULE_DESCRIPTION("USB HID Razer Driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_VERSION("1.0.0");
>> +
>> +//########################//
>> +//### Helper functions ###//
>> +//########################//
>> +
>> +// Get the firmware version.
>> +int razer_get_firmware_version(struct razer_device *razer_dev,
>> +			       unsigned char *fw_string)
>> +{
>> +	int retval;
>> +	struct razer_report response_r;
>> +	struct razer_report request_r = razer_new_report();
>> +
>> +	request_r.command_class = 0x00;
>> +	request_r.command_id    = 0x81;
>> +	request_r.data_size     = 0x00;
>> +	request_r.crc           = razer_calculate_crc(&request_r);
>> +
>> +	retval = razer_send_with_response(razer_dev, &request_r, &response_r);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&response_r, KBUILD_MODNAME,
>> +				       "get_firmware_version: request failed");
>> +		return retval;
>> +	}
>> +
>> +	retval = sprintf(fw_string, "v%d.%d", response_r.arguments[0],
>> +			 response_r.arguments[1]);
>> +	if (retval <= 0) {
>> +		pr_warn("get_firmware_version: failed to compose string");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Get brightness of the keyboard.
>> +int razer_get_brightness(struct razer_device *razer_dev)
>> +{
>> +	int retval;
>> +	struct usb_device *usb_dev          = razer_dev->usb_dev;
>> +	struct razer_report request_report  = razer_new_report();
>> +	struct razer_report response_report;
>> +	int response_value_index            = 1;
>> +	const unsigned int product_id       = usb_dev->descriptor.idProduct;
>> +
>> +	request_report.command_class = 0x0E;
>> +	request_report.command_id    = 0x84;
>> +	request_report.data_size     = 0x01;
>> +	request_report.arguments[0]  = 0x01;     // LED Class
>> +
>> +	// Device support.
>> +	if (product_id == USB_DEVICE_ID_RAZER_BLACKWIDOW_CHROMA) {
>> +		request_report.command_class    = 0x03;
>> +		request_report.command_id       = 0x83;
>> +		request_report.arguments[1]     = 0x05;     // Backlight LED
>> +		request_report.data_size        = 0x02;
>> +		response_value_index            = 2;
>> +	}
>> +
>> +	request_report.crc = razer_calculate_crc(&request_report);
>> +
>> +	retval = razer_send_with_response(razer_dev,
>> +					  &request_report, &response_report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&response_report, KBUILD_MODNAME,
>> +				       "get_brightness: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return response_report.arguments[response_value_index];
>> +}
>> +
>> +// Set the keyboard brightness.
>> +int razer_set_brightness(struct razer_device *razer_dev,
>> +			 unsigned char brightness)
>> +{
>> +	int retval;
>> +	struct usb_device *usb_dev    = razer_dev->usb_dev;
>> +	struct razer_report report    = razer_new_report();
>> +	const unsigned int product_id = usb_dev->descriptor.idProduct;
>> +
>> +	report.command_class = 0x0E;
>> +	report.command_id    = 0x04;
>> +	report.data_size     = 0x02;
>> +	report.arguments[0]  = 0x01;
>> +	report.arguments[1]  = brightness;
>> +
>> +	// Device support.
>> +	if (product_id == USB_DEVICE_ID_RAZER_BLACKWIDOW_CHROMA) {
>> +		report.command_class    = 0x03;
>> +		report.command_id       = 0x03;
>> +		report.arguments[1]     = 0x05;     // Backlight LED
>> +		report.arguments[2]     = brightness;
>> +		report.data_size        = 0x03;
>> +	}
>> +
>> +	report.crc = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "set_brightness: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Set the logo lighting state (on/off only)
>> +int razer_set_logo(struct razer_device *razer_dev, unsigned char state)
>> +{
>> +	int retval;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	if (state != 0 && state != 1) {
>> +		pr_warn("set_logo: logo lighting state must be either 0 or 1: "
>> +			"got: %d\n", state);
>> +		return -EINVAL;
>> +	}
>> +
>> +	report.command_class = 0x03;
>> +	report.command_id    = 0x00;
>> +	report.data_size     = 0x03;
>> +	report.arguments[0]  = 0x01;     // LED Class
>> +	report.arguments[1]  = 0x04;     // LED ID, Logo
>> +	report.arguments[2]  = state;    // State
>> +	report.crc           = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "set_logo: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Toggle FN key
>> +int razer_set_fn_mode(struct razer_device *razer_dev, unsigned char state)
>> +{
>> +	int retval;
>> +	struct razer_data *data     = razer_dev->data;
>> +	struct razer_report report  = razer_new_report();
>> +
>> +	if (state != 0 && state != 1) {
>> +		pr_warn("fn_mode: must be either 0 or 1: got: %d\n", state);
>> +		return -EINVAL;
>> +	}
>> +
>> +	report.command_class = 0x02;
>> +	report.command_id    = 0x06;
>> +	report.data_size     = 0x02;
>> +	report.arguments[0]  = 0x00;
>> +	report.arguments[1]  = state; // State
>> +	report.crc           = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "fn_mode: request failed");
>> +		return retval;
>> +	}
>> +
>> +	// Save the new fn mode state.
>> +	data->fn_mode_state = (char)state;
>> +
>> +	return 0;
>> +}
>> +
>> +// Returns the row count of the keyboard.
>> +// On error a value smaller than 0 is returned.
>> +int razer_get_rows(struct usb_device *usb_dev)
>> +{
>> +	switch (usb_dev->descriptor.idProduct) {
>> +	case USB_DEVICE_ID_RAZER_BLADE_STEALTH_2016:
>> +		return RAZER_STEALTH_2016_ROWS;
>> +
>> +	case USB_DEVICE_ID_RAZER_BLADE_14_2016:
>> +		return RAZER_BLADE_14_2016_ROWS;
>> +
>> +	case USB_DEVICE_ID_RAZER_BLACKWIDOW_CHROMA:
>> +		return RAZER_BLACKWIDOW_CHROMA_ROWS;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +// Returns the column count of the keyboard.
>> +// On error a value smaller than 0 is returned.
>> +int razer_get_columns(struct usb_device *usb_dev)
>> +{
>> +	switch (usb_dev->descriptor.idProduct) {
>> +	case USB_DEVICE_ID_RAZER_BLADE_STEALTH_2016:
>> +		return RAZER_STEALTH_2016_COLUMNS;
>> +
>> +	case USB_DEVICE_ID_RAZER_BLADE_14_2016:
>> +		return RAZER_BLADE_14_2016_COLUMNS;
>> +
>> +	case USB_DEVICE_ID_RAZER_BLACKWIDOW_CHROMA:
>> +		return RAZER_BLACKWIDOW_CHROMA_COLUMNS;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +// Set the key colors for a specific row. Takes in an array of RGB bytes.
>> +int razer_set_key_row(struct razer_device *razer_dev, unsigned char row_index,
>> +		      unsigned char *row_cols, size_t row_cols_len)
>> +{
>> +	int retval;
>> +	int rows                        = razer_get_rows(razer_dev->usb_dev);
>> +	int columns                     = razer_get_columns(razer_dev->usb_dev);
>> +	size_t row_cols_required_len    = columns * 3;
>> +	struct razer_report report      = razer_new_report();
>> +
>> +	if (rows < 0 || columns < 0) {
>> +		pr_warn("set_key_row: unsupported device\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	// Validate the input.
>> +	if (row_index >= rows) {
>> +		pr_warn("set_key_row: invalid row index: %d\n", row_index);
>> +		return -EINVAL;
>> +	}
>> +	if (row_cols_len != row_cols_required_len) {
>> +		pr_warn("set_key_row: wrong amount of RGB data provided: "
>> +			"%lu of %lu\n", row_cols_len, row_cols_required_len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	report.command_class  = 0x03;
>> +	report.command_id     = 0x0B;
>> +	report.data_size      = row_cols_required_len + 4;
>> +	report.transaction_id = 0x80;         // Set a custom transaction ID.
>> +	report.arguments[0]   = 0xFF;         // Frame ID
>> +	report.arguments[1]   = row_index;    // Row
>> +	report.arguments[2]   = 0x00;         // Start Index
>> +	report.arguments[3]   = columns - 1;  // End Index (Calc to end of row)
>> +	memcpy(&report.arguments[4], row_cols, row_cols_required_len);
>> +	report.crc            = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "set_key_row: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return retval;
>> +}
>> +
>> +// Set the key colors for the complete keyboard. Takes in an array of RGB bytes.
>> +int razer_set_key_colors(struct razer_device *razer_dev,
>> +			 unsigned char *row_cols, size_t row_cols_len)
>> +{
>> +	int i, retval;
>> +	int rows                        = razer_get_rows(razer_dev->usb_dev);
>> +	int columns                     = razer_get_columns(razer_dev->usb_dev);
>> +	size_t row_cols_required_len    = columns * 3 * rows;
>> +
>> +	if (columns < 0 || rows < 0 || row_cols_required_len < 0) {
>> +		pr_warn("set_key_colors: unsupported device\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	// Validate the input.
>> +	if (row_cols_len != row_cols_required_len) {
>> +		pr_warn("set_key_colors: wrong amount of RGB data provided: "
>> +			"%lu of %lu\n", row_cols_len, row_cols_required_len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < rows; i++) {
>> +		retval =
>> +		razer_set_key_row(razer_dev, i,
>> +				  (unsigned char *)&row_cols[i * columns * 3],
>> +				   columns * 3);
>> +		if (retval != 0) {
>> +			pr_warn("set_key_colors: failed to set colors for row: "
>> +				"%d\n", i);
>> +			return retval;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Enable keyboard macro keys.
>> +// Keycodes for the macro keys are 191-195 for M1-M5.
>> +int razer_activate_macro_keys(struct razer_device *razer_dev)
>> +{
>> +	int retval;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	report.command_class = 0x00;
>> +	report.command_id    = 0x04;
>> +	report.data_size     = 0x02;
>> +	report.arguments[0]  = 0x02;
>> +	report.arguments[1]  = 0x04;
>> +	report.crc           = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "activate_macro_keys: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Disable any keyboard effect
>> +int razer_set_none_mode(struct razer_device *razer_dev)
>> +{
>> +	int retval;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	report.command_class = 0x03;
>> +	report.command_id    = 0x0A;
>> +	report.data_size     = 0x01;
>> +	report.arguments[0]  = 0x00; // Effect ID
>> +	report.crc           = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "none_mode: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Set static effect on the keyboard
>> +int razer_set_static_mode(struct razer_device *razer_dev,
>> +			  struct razer_rgb *color)
>> +{
>> +	int retval;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	report.command_class = 0x03;
>> +	report.command_id    = 0x0A;
>> +	report.data_size     = 0x04;
>> +	report.arguments[0]  = 0x06;     // Effect ID
>> +	report.arguments[1]  = color->r;
>> +	report.arguments[2]  = color->g;
>> +	report.arguments[3]  = color->b;
>> +	report.crc           = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "static_mode: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Set custom effect on the keyboard
>> +int razer_set_custom_mode(struct razer_device *razer_dev)
>> +{
>> +	int retval;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	report.command_class = 0x03;
>> +	report.command_id    = 0x0A;
>> +	report.data_size     = 0x02;
>> +	report.arguments[0]  = 0x05; // Effect ID
>> +	report.arguments[1]  = 0x00; // Data frame ID
>> +	report.crc           = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "custom_mode: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Set the wave effect on the keyboard
>> +int razer_set_wave_mode(struct razer_device *razer_dev,
>> +			unsigned char direction)
>> +{
>> +	int retval;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	if (direction != 1 && direction != 2) {
>> +		pr_warn("wave_mode: wave direction must be 1 or 2: got: %d\n",
>> +			direction);
>> +		return -EINVAL;
>> +	}
>> +
>> +	report.command_class = 0x03;
>> +	report.command_id    = 0x0A;
>> +	report.data_size     = 0x02;
>> +	report.arguments[0]  = 0x01; // Effect ID
>> +	report.arguments[1]  = direction; // Direction
>> +	report.crc           = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "wave_mode: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Set spectrum effect on the keyboard
>> +int razer_set_spectrum_mode(struct razer_device *razer_dev)
>> +{
>> +	int retval;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	report.command_class = 0x03;
>> +	report.command_id    = 0x0A;
>> +	report.data_size     = 0x01;
>> +	report.arguments[0]  = 0x04; // Effect ID
>> +	report.crc           = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "spectrum_mode: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Set reactive effect on the keyboard
>> +int razer_set_reactive_mode(struct razer_device *razer_dev,
>> +			    unsigned char speed, struct razer_rgb *color)
>> +{
>> +	int retval = 0;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	if (speed <= 0 || speed >= 4) {
>> +		pr_warn("reactive_mode: speed must be within 1-3: got: %d\n",
>> +			speed);
>> +		return -EINVAL;
>> +	}
>> +
>> +	report.command_class = 0x03;
>> +	report.command_id    = 0x0A;
>> +	report.data_size     = 0x05;
>> +	report.arguments[0]  = 0x02;     // Effect ID
>> +	report.arguments[1]  = speed;    // Speed
>> +	report.arguments[2]  = color->r;
>> +	report.arguments[3]  = color->g;
>> +	report.arguments[4]  = color->b;
>> +	report.crc           = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "reactive_mode: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Set the starlight effect on the keyboard.
>> +// Possible speed values: 1-3.
>> +// 1. Random color mode: set both colors to NULL
>> +// 2. One color mode: Set color1 and color2 to NULL
>> +// 3. Two color mode: Set both colors
>> +int razer_set_starlight_mode(struct razer_device *razer_dev,
>> +			     unsigned char speed, struct razer_rgb *color1,
>> +			     struct razer_rgb *color2)
>> +{
>> +	int retval;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	if (speed <= 0 || speed >= 4) {
>> +		pr_warn("starlight_mode: speed must be within 1-3: got: %d\n",
>> +			speed);
>> +		return -EINVAL;
>> +	}
>> +
>> +	report.command_class = 0x03;
>> +	report.command_id    = 0x0A;
>> +	report.arguments[0]  = 0x19;     // Effect ID
>> +	report.arguments[2]  = speed;    // Speed
>> +
>> +	if (!color1 && !color2) {
>> +		report.arguments[1] = 0x03;       // Random colors
>> +		report.data_size    = 0x03;
>> +	} else if (color1 && !color2) {
>> +		report.arguments[1] = 0x01;       // One color
>> +		report.arguments[3] = color1->r;
>> +		report.arguments[4] = color1->g;
>> +		report.arguments[5] = color1->b;
>> +		report.data_size    = 0x06;
>> +	} else if (color1 && color2) {
>> +		report.arguments[1] = 0x02;       // Two colors
>> +		report.arguments[3] = color1->r;
>> +		report.arguments[4] = color1->g;
>> +		report.arguments[5] = color1->b;
>> +		report.arguments[6] = color2->r;
>> +		report.arguments[7] = color2->g;
>> +		report.arguments[8] = color2->b;
>> +		report.data_size    = 0x09;
>> +	} else {
>> +		pr_warn("starlight_mode: invalid colors set\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	report.crc = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "starlight_mode: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +// Set breath effect on the keyboard.
>> +// 1. Random color mode: set both colors to NULL
>> +// 2. One color mode: Set color1 and color2 to NULL
>> +// 3. Two color mode: Set both colors
>> +int razer_set_breath_mode(struct razer_device *razer_dev,
>> +			  struct razer_rgb *color1, struct razer_rgb *color2)
>> +{
>> +	int retval;
>> +	struct razer_report report = razer_new_report();
>> +
>> +	report.command_class = 0x03;
>> +	report.command_id    = 0x0A;
>> +	report.arguments[0]  = 0x03; // Effect ID
>> +
>> +	if (!color1 && !color2) {
>> +		report.arguments[1] = 0x03;       // Random colors
>> +		report.data_size    = 0x02;
>> +	} else if (color1 && !color2) {
>> +		report.arguments[1] = 0x01;       // One color
>> +		report.arguments[2] = color1->r;
>> +		report.arguments[3] = color1->g;
>> +		report.arguments[4] = color1->b;
>> +		report.data_size    = 0x05;
>> +	} else if (color1 && color2) {
>> +		report.arguments[1] = 0x02;       // Two colors
>> +		report.arguments[2] = color1->r;
>> +		report.arguments[3] = color1->g;
>> +		report.arguments[4] = color1->b;
>> +		report.arguments[5] = color2->r;
>> +		report.arguments[6] = color2->g;
>> +		report.arguments[7] = color2->b;
>> +		report.data_size    = 0x08;
>> +	} else {
>> +		pr_warn("breath_mode: invalid colors set\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	report.crc = razer_calculate_crc(&report);
>> +
>> +	retval = razer_send_check_response(razer_dev, &report);
>> +	if (retval != 0) {
>> +		razer_print_err_report(&report, KBUILD_MODNAME,
>> +				       "breath_mode: request failed");
>> +		return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +//#########################//
>> +//### Device Attributes ###//
>> +//#########################//
>> +
>> +/*
>> + * Read device file "get_serial"
>> + * Gets the serial number from the device.
>> + * Returns a string.
>> + */
>> +static ssize_t razer_attr_read_get_serial(struct device *dev,
>> +					  struct device_attribute *attr,
>> +					  char *buf)
>> +{
>> +	char serial_string[100] = "";
>> +
>> +	// Stealth and the Blade does not have serial via USB,
>> +	// so get it from the DMI table.
>> +	strcpy(serial_string, dmi_get_system_info(DMI_PRODUCT_SERIAL));
>> +	return sprintf(buf, "%s\n", &serial_string[0]);
>> +}
>> +
>> +/**
>> + * Read device file "get_firmware_version"
>> + * Gets the firmware version from the device.
>> + * Returns a string.
>> + */
>> +static ssize_t
>> +razer_attr_read_get_firmware_version(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     char *buf)
>> +{
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +	char fw_string[100]             = "";
>> +	int retval;
>> +
>> +	retval = razer_get_firmware_version(razer_dev, &fw_string[0]);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return sprintf(buf, "%s\n", &fw_string[0]);
>> +}
>> +
>> +/*
>> + * Read device file "get_key_rows"
>> + * Returns the amount of key rows.
>> + */
>> +static ssize_t razer_attr_read_get_key_rows(struct device *dev,
>> +					    struct device_attribute *attr,
>> +					    char *buf)
>> +{
>> +	struct usb_interface *intf  = to_usb_interface(dev->parent);
>> +	struct usb_device *usb_dev  = interface_to_usbdev(intf);
>> +	int rows                    = razer_get_rows(usb_dev);
>> +
>> +	return sprintf(buf, "%d\n", rows);
>> +}
>> +
>> +/*
>> + * Read device file "get_key_columns"
>> + * Returns the amount of key columns.
>> + */
>> +static ssize_t razer_attr_read_get_key_columns(struct device *dev,
>> +					       struct device_attribute *attr,
>> +					       char *buf)
>> +{
>> +	struct usb_interface *intf  = to_usb_interface(dev->parent);
>> +	struct usb_device *usb_dev  = interface_to_usbdev(intf);
>> +	int columns                 = razer_get_columns(usb_dev);
>> +
>> +	return sprintf(buf, "%d\n", columns);
>> +}
>> +
>> +/**
>> + * Read device file "device_type"
>> + * Returns a friendly device type string.
>> + */
>> +static ssize_t razer_attr_read_device_type(struct device *dev,
>> +					   struct device_attribute *attr,
>> +					   char *buf)
>> +{
>> +	struct usb_interface *intf = to_usb_interface(dev->parent);
>> +	struct usb_device *usb_dev = interface_to_usbdev(intf);
>> +
>> +	char *device_type;
>> +
>> +	switch (usb_dev->descriptor.idProduct) {
>> +	case USB_DEVICE_ID_RAZER_BLADE_STEALTH_2016:
>> +		device_type = "Razer Blade Stealth 2016\n";
>> +		break;
>> +
>> +	case USB_DEVICE_ID_RAZER_BLADE_14_2016:
>> +		device_type = "Razer Blade 14 2016\n";
>> +		break;
>> +
>> +	case USB_DEVICE_ID_RAZER_BLACKWIDOW_CHROMA:
>> +		device_type = "Razer BlackWidow Chroma\n";
>> +		break;
>> +
>> +	default:
>> +		device_type = "Unknown Device\n";
>> +	}
>> +
>> +	return sprintf(buf, device_type);
>> +}
>> +
>> +/*
>> + * Read device file "brightness"
>> + * Returns the brightness value from 0-255.
>> + */
>> +static ssize_t razer_attr_read_brightness(struct device *dev,
>> +					  struct device_attribute *attr,
>> +					  char *buf)
>> +{
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +	int brightness                  = razer_get_brightness(razer_dev);
>> +
>> +	return sprintf(buf, "%d\n", brightness);
>> +}
>> +
>> +/*
>> + * Write device file "brightness"
>> + * Sets the brightness to the ASCII number written to this file.
>> + * Values from 0-255.
>> + */
>> +static ssize_t razer_attr_write_brightness(struct device *dev,
>> +					   struct device_attribute *attr,
>> +					   const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +	unsigned long temp;
>> +	int retval;
>> +
>> +	retval = kstrtoul(buf, 10, &temp);
>> +	if (retval != 0) {
>> +		pr_warn("set brightness requires an ASCII number\n");
>> +		return retval;
>> +	}
>> +
>> +	retval = razer_set_brightness(razer_dev, (unsigned char)temp);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "set_logo"
>> + * Sets the logo lighting state to the ASCII number written to this file.
>> + * 0 = off
>> + * 1 = on
>> + */
>> +static ssize_t razer_attr_write_set_logo(struct device *dev,
>> +					 struct device_attribute *attr,
>> +					 const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +	unsigned long temp;
>> +	int retval;
>> +
>> +	retval = kstrtoul(buf, 10, &temp);
>> +	if (retval != 0) {
>> +		pr_warn("set_logo: requires an ASCII number\n");
>> +		return retval;
>> +	}
>> +
>> +	retval = razer_set_logo(razer_dev, (unsigned char)temp);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "fn_mode"
>> + * Sets the FN mode to the ASCII number written to this file.
>> + * If 0 the F-keys work as normal F-keys
>> + * If 1 the F-keys act as if the FN key is held
>> + */
>> +static ssize_t razer_attr_write_fn_mode(struct device *dev,
>> +					struct device_attribute *attr,
>> +					const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev = dev_get_drvdata(dev);
>> +	unsigned long temp;
>> +	int retval;
>> +
>> +	retval = kstrtoul(buf, 10, &temp);
>> +	if (retval != 0) {
>> +		pr_warn("set fn_mode requires an ASCII number\n");
>> +		return retval;
>> +	}
>> +
>> +	retval = razer_set_fn_mode(razer_dev, (unsigned char)temp);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Read device file "fn_mode"
>> + * Returns the current fn mode state.
>> + */
>> +static ssize_t razer_attr_read_fn_mode(struct device *dev,
>> +				       struct device_attribute *attr, char *buf)
>> +{
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +	struct razer_data *data         = razer_dev->data;
>> +
>> +	return sprintf(buf, "%d\n", data->fn_mode_state);
>> +}
>> +
>> +/*
>> + * Write device file "set_key_colors"
>> + * Set the colors of all keys of the keyboard. 3 bytes per color.
>> + */
>> +static ssize_t razer_attr_write_set_key_colors(struct device *dev,
>> +					       struct device_attribute *attr,
>> +					       const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev = dev_get_drvdata(dev);
>> +	int retval;
>> +
>> +	retval = razer_set_key_colors(razer_dev,
>> +				      (unsigned char *)&buf[0], count);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	retval = razer_set_custom_mode(razer_dev);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "mode_none"
>> + * Disable keyboard effects / turns the keyboard LEDs off.
>> + */
>> +static ssize_t razer_attr_write_mode_none(struct device *dev,
>> +					  struct device_attribute *attr,
>> +					  const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev = dev_get_drvdata(dev);
>> +	int retval;
>> +
>> +	retval = razer_set_none_mode(razer_dev);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "mode_static"
>> + * Set the keyboard to static mode when 3 RGB bytes are written.
>> + */
>> +static ssize_t razer_attr_write_mode_static(struct device *dev,
>> +					    struct device_attribute *attr,
>> +					    const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev = dev_get_drvdata(dev);
>> +	int retval;
>> +
>> +	if (count != 3) {
>> +		pr_warn("mode static requires 3 RGB bytes\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	retval = razer_set_static_mode(razer_dev, (struct razer_rgb *)&buf[0]);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "mode_custom"
>> + * Sets the keyboard to custom mode whenever the file is written to.
>> + */
>> +static ssize_t razer_attr_write_mode_custom(struct device *dev,
>> +					    struct device_attribute *attr,
>> +					    const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev = dev_get_drvdata(dev);
>> +	int retval;
>> +
>> +	retval = razer_set_custom_mode(razer_dev);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "mode_wave"
>> + * If the ASCII number 1 is written then the wave effect is displayed
>> + * moving left across the keyboard.
>> + * If the ASCII number 2 is written then the wave effect goes right.
>> + */
>> +static ssize_t razer_attr_write_mode_wave(struct device *dev,
>> +					  struct device_attribute *attr,
>> +					  const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +	unsigned long temp;
>> +	int retval;
>> +
>> +	retval = kstrtoul(buf, 10, &temp);
>> +	if (retval != 0) {
>> +		pr_warn("mode_wave: requires an ASCII number\n");
>> +		return retval;
>> +	}
>> +
>> +	retval = razer_set_wave_mode(razer_dev, temp);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "mode_spectrum"
>> + * Specrum effect mode is activated whenever the file is written to.
>> + */
>> +static ssize_t razer_attr_write_mode_spectrum(struct device *dev,
>> +					      struct device_attribute *attr,
>> +					      const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev = dev_get_drvdata(dev);
>> +	int retval;
>> +
>> +	retval = razer_set_spectrum_mode(razer_dev);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "mode_reactive"
>> + * Sets reactive mode when this file is written to.
>> + * A speed byte and 3 RGB bytes should be written.
>> + * The speed must be within 1-3
>> + * 1 Short, 2 Medium, 3 Long
>> + */
>> +static ssize_t razer_attr_write_mode_reactive(struct device *dev,
>> +					      struct device_attribute *attr,
>> +					      const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev = dev_get_drvdata(dev);
>> +	int retval;
>> +
>> +	if (count != 4) {
>> +		pr_warn("mode reactive requires one speed byte followed by 3 RGB bytes\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	retval = razer_set_reactive_mode(razer_dev,
>> +					 (unsigned char)buf[0],
>> +					 (struct razer_rgb *)&buf[1]);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "mode_starlight"
>> + * Requires at least one byte representing the effect speed.
>> + * The speed must be within 1-3
>> + * 1 Short, 2 Medium, 3 Long
>> + *
>> + * Starlight mode has 3 modes of operation:
>> + *   Mode 1: single color. 3 RGB bytes.
>> + *   Mode 2: two colors. 6 RGB bytes.
>> + *   Mode 3: random colors. Anything else passed.
>> + */
>> +static ssize_t razer_attr_write_mode_starlight(struct device *dev,
>> +					       struct device_attribute *attr,
>> +					       const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +	struct razer_rgb *color1        = NULL;
>> +	struct razer_rgb *color2        = NULL;
>> +	int retval;
>> +
>> +	if (count < 1) {
>> +		pr_warn("mode starlight requires one speed byte\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (count == 4) {
>> +		// Single color mode
>> +		color1 = (struct razer_rgb *)&buf[1];
>> +	} else if (count == 7) {
>> +		// Dual color mode
>> +		color1 = (struct razer_rgb *)&buf[1];
>> +		color2 = (struct razer_rgb *)&buf[4];
>> +	}
>> +
>> +	retval = razer_set_starlight_mode(razer_dev, (unsigned char)buf[0],
>> +					  color1, color2);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +/*
>> + * Write device file "mode_breath"
>> + * Breathing mode has 3 modes of operation.
>> + * Mode 1 fading in and out using a single color. 3 RGB bytes.
>> + * Mode 2 is fading in and out between two colors. 6 RGB bytes.
>> + * Mode 3 is fading in and out between random colors. Anything else passed.
>> + */
>> +static ssize_t razer_attr_write_mode_breath(struct device *dev,
>> +					    struct device_attribute *attr,
>> +					    const char *buf, size_t count)
>> +{
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +	struct razer_rgb *color1        = NULL;
>> +	struct razer_rgb *color2        = NULL;
>> +	int retval;
>> +
>> +	if (count == 3) {
>> +		// Single color mode
>> +		color1 = (struct razer_rgb *)&buf[0];
>> +	} else if (count == 6) {
>> +		// Dual color mode
>> +		color1 = (struct razer_rgb *)&buf[0];
>> +		color2 = (struct razer_rgb *)&buf[3];
>> +	}
>> +
>> +	retval = razer_set_breath_mode(razer_dev, color1, color2);
>> +	if (retval != 0)
>> +		return retval;
>> +
>> +	return count;
>> +}
>> +
>> +//######################################//
>> +//### Set up the device driver files ###//
>> +//######################################//
>> +
>> +/*
>> + * Read only is 0444
>> + * Write only is 0220
>> + * Read and write is 0664
>> + */
>> +
>> +static DEVICE_ATTR(get_serial,              0444, razer_attr_read_get_serial,           NULL);
>> +static DEVICE_ATTR(get_firmware_version,    0444, razer_attr_read_get_firmware_version, NULL);
>> +static DEVICE_ATTR(device_type,             0444, razer_attr_read_device_type,          NULL);
>> +static DEVICE_ATTR(brightness,              0664, razer_attr_read_brightness, razer_attr_write_brightness);
>> +
>> +static DEVICE_ATTR(fn_mode,         0664, razer_attr_read_fn_mode, razer_attr_write_fn_mode);
>> +static DEVICE_ATTR(set_logo,        0220, NULL, razer_attr_write_set_logo);
>> +static DEVICE_ATTR(set_key_colors,  0220, NULL, razer_attr_write_set_key_colors);
>> +static DEVICE_ATTR(get_key_rows,    0444, razer_attr_read_get_key_rows, NULL);
>> +static DEVICE_ATTR(get_key_columns, 0444, razer_attr_read_get_key_columns, NULL);
>> +
>> +static DEVICE_ATTR(mode_none,      0220, NULL, razer_attr_write_mode_none);
>> +static DEVICE_ATTR(mode_static,    0220, NULL, razer_attr_write_mode_static);
>> +static DEVICE_ATTR(mode_custom,    0220, NULL, razer_attr_write_mode_custom);
>> +static DEVICE_ATTR(mode_wave,      0220, NULL, razer_attr_write_mode_wave);
>> +static DEVICE_ATTR(mode_spectrum,  0220, NULL, razer_attr_write_mode_spectrum);
>> +static DEVICE_ATTR(mode_reactive,  0220, NULL, razer_attr_write_mode_reactive);
>> +static DEVICE_ATTR(mode_breath,    0220, NULL, razer_attr_write_mode_breath);
>> +static DEVICE_ATTR(mode_starlight, 0220, NULL, razer_attr_write_mode_starlight);
>> +
>> +//#############################//
>> +//### Driver Main Functions ###//
>> +//#############################//
>> +
>> +/*
>> + * Initialize a razer_data struct.
>> + */
>> +int razer_init_data(struct razer_data *data)
>> +{
>> +	// Set all values to an unset state.
>> +	data->macro_keys_state  = -1;
>> +	data->fn_mode_state     = -1;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Sets the device to the specific states if set.
>> + */
>> +int razer_load_states(struct razer_device *razer_dev)
>> +{
>> +	int retval;
>> +	struct razer_data *data = razer_dev->data;
>> +
>> +	if (!data)
>> +		return 0;
>> +
>> +	// Enable the macro keys if required.
>> +	if (data->macro_keys_state == 1) {
>> +		retval = razer_activate_macro_keys(razer_dev);
>> +		if (retval != 0)
>> +			return retval;
>> +	}
>> +
>> +	// Set the FN mode if required.
>> +	if (data->fn_mode_state >= 0) {
>> +		retval = razer_set_fn_mode(razer_dev,
>> +					   (unsigned char)data->fn_mode_state);
>> +		if (retval != 0)
>> +			return retval;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Probe method is ran whenever a device is bound to the driver.
>> + */
>> +static int razer_probe(struct hid_device *hdev,
>> +		       const struct hid_device_id *id)
>> +{
>> +	int retval;
>> +	struct device *dev              = &hdev->dev;
>> +	struct usb_interface *intf      = to_usb_interface(dev->parent);
>> +	struct usb_device *usb_dev      = interface_to_usbdev(intf);
>> +	struct razer_device *razer_dev;
>> +	struct razer_data *data;
>> +	const unsigned int product_id   = usb_dev->descriptor.idProduct;
>> +
>> +	razer_dev = kzalloc(sizeof(*razer_dev), GFP_KERNEL);
>> +	if (!razer_dev) {
>> +		hid_err(hdev, "can't alloc razer device descriptor\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	retval = razer_init_device(razer_dev, usb_dev);
>> +	if (retval != 0) {
>> +		hid_err(hdev, "failed to initialize razer device descriptor\n");
>> +		goto exit_free_razer_dev;
>> +	}
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (!data) {
>> +		hid_err(hdev, "can't alloc razer data\n");
>> +		retval = -ENOMEM;
>> +		goto exit_free_razer_dev;
>> +	}
>> +
>> +	retval = razer_init_data(data);
>> +	if (retval != 0) {
>> +		hid_err(hdev, "failed to initialize razer data\n");
>> +		goto exit_free;
>> +	}
>> +
>> +	dev_set_drvdata(dev, razer_dev);
>> +	razer_dev->data         = data;
>> +	razer_dev->report_index = RAZER_DEFAULT_REPORT_INDEX;
>> +
>> +	// Default files
>> +	retval = device_create_file(dev, &dev_attr_get_serial);
>> +	if (retval)
>> +		goto exit_free;
>> +	retval = device_create_file(dev, &dev_attr_get_firmware_version);
>> +	if (retval)
>> +		goto exit_free;
>> +	retval = device_create_file(dev, &dev_attr_device_type);
>> +	if (retval)
>> +		goto exit_free;
>> +	retval = device_create_file(dev, &dev_attr_brightness);
>> +	if (retval)
>> +		goto exit_free;
>> +
>> +	// Custom files depending on the device support.
>> +	// #############################################
>> +	if (product_id == USB_DEVICE_ID_RAZER_BLADE_STEALTH_2016 ||
>> +	    product_id == USB_DEVICE_ID_RAZER_BLADE_14_2016) {
>> +		// Set the default fn mode state.
>> +		data->fn_mode_state = 1;
>> +
>> +		retval = device_create_file(dev, &dev_attr_fn_mode);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_get_key_rows);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_get_key_columns);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_set_logo);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_set_key_colors);
>> +		if (retval)
>> +			goto exit_free;
>> +
>> +		// Modes
>> +		retval = device_create_file(dev, &dev_attr_mode_none);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_static);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_custom);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_wave);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_spectrum);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_reactive);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_breath);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_starlight);
>> +		if (retval)
>> +			goto exit_free;
>> +	} else if (product_id == USB_DEVICE_ID_RAZER_BLACKWIDOW_CHROMA) {
>> +		// Enable the macro keys state.
>> +		data->macro_keys_state = 1;
>> +
>> +		retval = device_create_file(dev, &dev_attr_get_key_rows);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_get_key_columns);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_set_key_colors);
>> +		if (retval)
>> +			goto exit_free;
>> +
>> +		// Modes
>> +		retval = device_create_file(dev, &dev_attr_mode_none);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_static);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_custom);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_wave);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_spectrum);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_reactive);
>> +		if (retval)
>> +			goto exit_free;
>> +		retval = device_create_file(dev, &dev_attr_mode_breath);
>> +		if (retval)
>> +			goto exit_free;
>> +	}
>> +
>> +	retval = hid_parse(hdev);
>> +	if (retval)    {
>> +		hid_err(hdev, "parse failed\n");
>> +		goto exit_free;
>> +	}
>> +	retval = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>> +	if (retval) {
>> +		hid_err(hdev, "hw start failed\n");
>> +		goto exit_free;
>> +	}
>> +
>> +	usb_disable_autosuspend(usb_dev);
>> +
>> +	// Finally load any set states. Ignore errors. They are not fatal.
>> +	// Errors will be logged.
>> +	razer_load_states(razer_dev);
>> +
>> +	return 0;
>> +exit_free:
>> +	kfree(data);
>> +exit_free_razer_dev:
>> +	kfree(razer_dev);
>> +	return retval;
>> +}
>> +
>> +/*
>> + * Driver unbind function.
>> + */
>> +static void razer_disconnect(struct hid_device *hdev)
>> +{
>> +	struct device *dev              = &hdev->dev;
>> +	struct usb_interface *intf      = to_usb_interface(dev->parent);
>> +	struct usb_device *usb_dev      = interface_to_usbdev(intf);
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +	struct razer_data *data         = razer_dev->data;
>> +	const unsigned int product_id   = usb_dev->descriptor.idProduct;
>> +
>> +	// Remove the default files
>> +	device_remove_file(dev, &dev_attr_get_firmware_version);
>> +	device_remove_file(dev, &dev_attr_get_serial);
>> +	device_remove_file(dev, &dev_attr_device_type);
>> +	device_remove_file(dev, &dev_attr_brightness);
>> +
>> +	// Custom files depending on the device support.
>> +	// #############################################
>> +	if (product_id == USB_DEVICE_ID_RAZER_BLADE_STEALTH_2016 ||
>> +	    product_id == USB_DEVICE_ID_RAZER_BLADE_14_2016) {
>> +		device_remove_file(dev, &dev_attr_fn_mode);
>> +		device_remove_file(dev, &dev_attr_get_key_rows);
>> +		device_remove_file(dev, &dev_attr_get_key_columns);
>> +		device_remove_file(dev, &dev_attr_set_logo);
>> +		device_remove_file(dev, &dev_attr_set_key_colors);
>> +
>> +		// Modes
>> +		device_remove_file(dev, &dev_attr_mode_none);
>> +		device_remove_file(dev, &dev_attr_mode_static);
>> +		device_remove_file(dev, &dev_attr_mode_custom);
>> +		device_remove_file(dev, &dev_attr_mode_wave);
>> +		device_remove_file(dev, &dev_attr_mode_spectrum);
>> +		device_remove_file(dev, &dev_attr_mode_reactive);
>> +		device_remove_file(dev, &dev_attr_mode_breath);
>> +		device_remove_file(dev, &dev_attr_mode_starlight);
>> +	} else if (product_id == USB_DEVICE_ID_RAZER_BLACKWIDOW_CHROMA) {
>> +		device_remove_file(dev, &dev_attr_get_key_rows);
>> +		device_remove_file(dev, &dev_attr_get_key_columns);
>> +		device_remove_file(dev, &dev_attr_set_key_colors);
>> +
>> +		// Modes
>> +		device_remove_file(dev, &dev_attr_mode_none);
>> +		device_remove_file(dev, &dev_attr_mode_static);
>> +		device_remove_file(dev, &dev_attr_mode_custom);
>> +		device_remove_file(dev, &dev_attr_mode_wave);
>> +		device_remove_file(dev, &dev_attr_mode_spectrum);
>> +		device_remove_file(dev, &dev_attr_mode_reactive);
>> +		device_remove_file(dev, &dev_attr_mode_breath);
>> +	}
>> +
>> +	hid_hw_stop(hdev);
>> +	kfree(razer_dev);
>> +	kfree(data);
>> +	dev_info(dev, "razer device disconnected\n");
>> +}
>> +
>> +//################################//
>> +//### Power Management Support ###//
>> +//################################//
>> +
>> +#ifdef CONFIG_PM
>> +
>> +/*
>> + * Called when the device is going to be suspended.
>> + */
>> +static int razer_suspend(struct hid_device *hdev, pm_message_t message)
>> +{
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Called when the device is being resumed by the system.
>> + */
>> +static int razer_resume(struct hid_device *hdev)
>> +{
>> +	struct device *dev              = &hdev->dev;
>> +	struct razer_device *razer_dev  = dev_get_drvdata(dev);
>> +
>> +	// Load any set states. Ignore errors. They are not fatal.
>> +	// Errors will be logged.
>> +	razer_load_states(razer_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Called when the suspended device has been reset instead of being resumed.
>> + */
>> +static int razer_reset_resume(struct hid_device *hdev)
>> +{
>> +	return razer_resume(hdev);
>> +}
>> +
>> +#endif
>> +
>> +//###############################//
>> +//### Device ID mapping table ###//
>> +//###############################//
>> +
>> +static const struct hid_device_id razer_devices[] = {
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_STEALTH_2016) },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14_2016) },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLACKWIDOW_CHROMA) },
>> +	{ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(hid, razer_devices);
>> +
>> +//############################################//
>> +//### Describes the contents of the driver ###//
>> +//############################################//
>> +
>> +static struct hid_driver razer_driver = {
>> +	.name           = "hid-razer",
>> +	.id_table       = razer_devices,
>> +
>> +#ifdef CONFIG_PM
>> +	.suspend        = razer_suspend,
>> +	.resume         = razer_resume,
>> +	.reset_resume   = razer_reset_resume,
>> +#endif
>> +
>> +	.probe          = razer_probe,
>> +	.remove         = razer_disconnect
>> +};
>> +
>> +module_hid_driver(razer_driver);
>> diff --git a/drivers/hid/hid-razer.h b/drivers/hid/hid-razer.h
>> new file mode 100644
>> index 0000000..1a1c92e
>> --- /dev/null
>> +++ b/drivers/hid/hid-razer.h
>> @@ -0,0 +1,48 @@
>> +/*
>> + * Razer Kernel Drivers
>> + * Copyright (c) 2016 Roland Singer <roland.singer@desertbit.com>
>> + * Based on Tim Theede <pez2001@voyagerproject.de> razer_chroma_drivers project.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __HID_RAZER_H
>> +#define __HID_RAZER_H
>> +
>> +#include <linux/types.h>
>> +
>> +//#################//
>> +//### Constants ###//
>> +//#################//
>> +
>> +// Report indexes.
>> +#define RAZER_DEFAULT_REPORT_INDEX  0x02
>> +
>> +// Keyboard rows and columns:
>> +#define RAZER_STEALTH_2016_ROWS     0x06
>> +#define RAZER_STEALTH_2016_COLUMNS  0x10
>> +
>> +#define RAZER_BLADE_14_2016_ROWS    0x06
>> +#define RAZER_BLADE_14_2016_COLUMNS 0x10
>> +
>> +#define RAZER_BLACKWIDOW_CHROMA_ROWS    0x06
>> +#define RAZER_BLACKWIDOW_CHROMA_COLUMNS 0x16
>> +
>> +//#############//
>> +//### Types ###//
>> +//#############//
>> +
>> +struct razer_data {
>> +	char macro_keys_state;
>> +	char fn_mode_state;
>> +};
>> +
>> +#endif // __HID_RAZER_H
> 
> This is not a full review, but I hope you will find it useful anyway.
> 
> Cheers,
> Benjamin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

