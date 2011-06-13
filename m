From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Driver for Lenovo Keyboard w/ Trackpoint
Date: Mon, 13 Jun 2011 15:24:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1106131521550.22872@pobox.suse.cz>
References: <1306512263-8796-1-git-send-email-mail@bernhard-seibold.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57891 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab1FMNZA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 09:25:00 -0400
In-Reply-To: <1306512263-8796-1-git-send-email-mail@bernhard-seibold.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bernhard Seibold <mail@bernhard-seibold.de>
Cc: linux-input@vger.kernel.org

On Fri, 27 May 2011, Bernhard Seibold wrote:

> This patch adds support for setting the trackpoint sensitivity
> of the "Lenovo ThinkPad USB Keyboard with Trackpoint".

Hi Bernhard,

thanks a lot for the patch.

> ---
>  drivers/hid/Kconfig            |   10 +++
>  drivers/hid/Makefile           |    1 +
>  drivers/hid/hid-core.c         |    1 +
>  drivers/hid/hid-ids.h          |    3 +
>  drivers/hid/hid-lenovo-tpkbd.c |  166 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 181 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hid/hid-lenovo-tpkbd.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 67d2a75..85028c4 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -224,6 +224,16 @@ config HID_LCPOWER
>  	---help---
>  	Support for LC-Power RC1000MCE RF remote control.
>  
> +config HID_LENOVO_TPKBD
> +	tristate "Lenovo ThinkPad USB Keyboard with TrackPoint"
> +	depends on USB_HID
> +	---help---
> +	Support for the Lenovo ThinkPad USB Keyboard with TrackPoint.
> +
> +	Say Y here if you have a Lenovo ThinkPad USB Keyboard with TrackPoint
> +	and would like to change the sensitivity of the trackpoint using a
> +	sysfs attribute.
> +

As you are adding sysfs attribute, we'd like to have it documented as well 
Documentation/ABI somewhere.

> --- /dev/null
> +++ b/drivers/hid/hid-lenovo-tpkbd.c
> @@ -0,0 +1,166 @@
> +/*
> + *  HID driver for Lenovo ThinkPad USB Keyboard with TrackPoint
> + *
> + *  Copyright (c) 2011 Bernhard Seibold
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/sysfs.h>
> +#include <linux/device.h>
> +#include <linux/usb.h>
> +#include <linux/hid.h>
> +#include <linux/input.h>
> +#include "usbhid/usbhid.h"
> +
> +#include "hid-ids.h"
> +
> +static int lenovo_tpkbd_input_mapping(struct hid_device *hdev,
> +		struct hid_input *hi, struct hid_field *field,
> +		struct hid_usage *usage, unsigned long **bit, int *max)
> +{
> +	return 0;
> +}
> +

Why is this empty stub needed?

> +static ssize_t pointer_sensitivity_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct hid_device *hdev;
> +	struct hid_report *report;
> +	hdev = container_of(dev, struct hid_device, dev);
> +
> +	if (hdev == NULL)
> +		return -ENODEV;
> +
> +	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[4];
> +	usbhid_submit_report(hdev, report, USB_DIR_IN);
> +	usbhid_wait_io(hdev);

usbhid_wait_io() returns -1 in case it times out.

> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n",
> +		report->field[2]->value[0]);
> +}
> +
> +static ssize_t pointer_sensitivity_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	struct hid_device *hdev;
> +	struct hid_report *report;
> +	int value;
> +
> +	if (kstrtoint(buf, 10, &value) || value < 1 || value > 255)
> +		return -EINVAL;
> +
> +	hdev = container_of(dev, struct hid_device, dev);
> +	if (hdev == NULL)
> +		return -ENODEV;
> +
> +	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[4];
> +	usbhid_submit_report(hdev, report, USB_DIR_IN);
> +	usbhid_wait_io(hdev);

The same here.

Thanks,

-- 
Jiri Kosina
SUSE Labs
