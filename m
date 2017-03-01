From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: Accutouch: Add driver for ELO Accutouch 2216 USB
 Touchscreens
Date: Wed, 1 Mar 2017 18:01:17 +0100
Message-ID: <20170301170117.GH7064@mail.corp.redhat.com>
References: <1487081876-9743-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdCARBX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Mar 2017 12:01:23 -0500
Content-Disposition: inline
In-Reply-To: <1487081876-9743-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Feb 14 2017 or thereabouts, Martyn Welch wrote:
> The Accutouch 2216 is reporting BTN_LEFT/BTN_MOUSE rather than BTM_TOUCH
> in it's capabilities, which is what user space expects a touchscreen
> device to report. This is causing udev to consider the device to be a
> "VMware's USB mouse" rather than as a touchscreen, which results in a
> mouse cursor being displayed in Weston.
> 
> This patch adds a special driver for the device to correct the
> capabilities reported.

The patch in itself is fine from what I can see. However, we tend to
group devices/drivers by manufacturer, and there is already a hid-elo.c.

So I think this quirk should be integrated in hid-elo.c. You will need
to add a special quirk for this device in .driver_data, but it should be
doable to integrate in the existing code.

Cheers,
Benjamin

> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
>  drivers/hid/Kconfig         | 12 +++++++++++
>  drivers/hid/Makefile        |  1 +
>  drivers/hid/hid-accutouch.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-core.c      |  1 +
>  drivers/hid/hid-ids.h       |  1 +
>  5 files changed, 67 insertions(+)
>  create mode 100644 drivers/hid/hid-accutouch.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 4070b73..ba0d17a 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -98,6 +98,18 @@ config HID_A4TECH
>  	---help---
>  	Support for A4 tech X5 and WOP-35 / Trust 450L mice.
>  
> +config HID_ACCUTOUCH
> +	tristate "Accutouch touch device"
> +	depends on USB_HID
> +	---help---
> +	  This selects a driver for the Accutouch 2216 touch controller.
> +
> +	  The driver works around a problem in the reported device capabilities
> +	  which causes userspace to detect the device as a mouse rather than
> +          a touchscreen.
> +
> +	  Say Y here if you have a Accutouch 2216 touch controller.
> +
>  config HID_ACRUX
>  	tristate "ACRUX game controller support"
>  	depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 4d111f2..48be3ed 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -21,6 +21,7 @@ hid-wiimote-y		:= hid-wiimote-core.o hid-wiimote-modules.o
>  hid-wiimote-$(CONFIG_DEBUG_FS)	+= hid-wiimote-debug.o
>  
>  obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
> +obj-$(CONFIG_HID_ACCUTOUCH)	+= hid-accutouch.o
>  obj-$(CONFIG_HID_ALPS)		+= hid-alps.o
>  obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
>  obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
> diff --git a/drivers/hid/hid-accutouch.c b/drivers/hid/hid-accutouch.c
> new file mode 100644
> index 0000000..4e28716
> --- /dev/null
> +++ b/drivers/hid/hid-accutouch.c
> @@ -0,0 +1,52 @@
> +/*
> + * HID driver for Elo Accutouch touchscreens
> + *
> + * Copyright (c) 2016, Collabora Ltd.
> + * Copyright (c) 2016, General Electric Company
> + *
> + * based on hid-penmount.c
> + *  Copyright (c) 2014 Christian Gmeiner <christian.gmeiner <at> gmail.com>
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
> +#include <linux/module.h>
> +#include "hid-ids.h"
> +
> +static int accutouch_input_mapping(struct hid_device *hdev,
> +				   struct hid_input *hi,
> +				   struct hid_field *field,
> +				   struct hid_usage *usage,
> +				   unsigned long **bit, int *max)
> +{
> +	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
> +		hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hid_device_id accutouch_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_ACCUTOUCH_2216) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, accutouch_devices);
> +
> +static struct hid_driver accutouch_driver = {
> +	.name = "hid-accutouch",
> +	.id_table = accutouch_devices,
> +	.input_mapping = accutouch_input_mapping,
> +};
> +
> +module_hid_driver(accutouch_driver);
> +
> +MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.co.uk");
> +MODULE_DESCRIPTION("Elo Accutouch HID TouchScreen driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index ea36b55..b697491 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1893,6 +1893,7 @@ void hid_disconnect(struct hid_device *hdev)
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0009) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0030) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_ACCUTOUCH_2216) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 350accf..9472ef2 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -362,6 +362,7 @@
>  #define USB_VENDOR_ID_ELO		0x04E7
>  #define USB_DEVICE_ID_ELO_TS2515	0x0022
>  #define USB_DEVICE_ID_ELO_TS2700	0x0020
> +#define USB_DEVICE_ID_ELO_ACCUTOUCH_2216	0x0050
>  
>  #define USB_VENDOR_ID_EMS		0x2006
>  #define USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II 0x0118
> -- 
> 1.8.3.1
> 
