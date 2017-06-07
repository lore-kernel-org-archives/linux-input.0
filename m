From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] HID: Add driver Retrode2 joypad and adapter
Date: Wed, 7 Jun 2017 10:45:12 -0700
Message-ID: <20170607174512.GG13116@dtor-ws>
References: <1496850178.11482.8.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35331 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbdFGRpP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 13:45:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so2284430pfd.2
        for <linux-input@vger.kernel.org>; Wed, 07 Jun 2017 10:45:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1496850178.11482.8.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Wed, Jun 07, 2017 at 05:42:58PM +0200, Bastien Nocera wrote:
> This driver does 2 things:
>  - Apply the MULTI_INPUT quirk to create separate joypad device nodes
>    for each one of the 4 connectors.
>  - Rename the input devices so that their names are different, and allow
>    users to recognise which device corresponds to which physical port,
>    including the SNES (Mario Paint) Mouse.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> 
> New in v2:
> - Removed error paths in probe
> - Added device to hid_have_special_driver
> - Mark N64 ports as using the same device as the SNES joypads
> 
>  drivers/hid/Kconfig       |   8 ++++
>  drivers/hid/Makefile      |   1 +
>  drivers/hid/hid-ids.h     |   3 ++
>  drivers/hid/hid-retrode.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 117 insertions(+)
>  create mode 100644 drivers/hid/hid-retrode.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 687705c50794..d409435fc0c2 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -741,6 +741,14 @@ config HID_PRIMAX
>  	Support for Primax devices that are not fully compliant with the
>  	HID standard.
>  
> +config HID_RETRODE
> +	tristate "Retrode"
> +	depends on USB_HID
> +	---help---
> +	Support for
> +
> +	  * Retrode 2 cartridge and controller adapter
> +
>  config HID_ROCCAT
>  	tristate "Roccat device support"
>  	depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index fef027bc7fa3..9ac08e7ed887 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -81,6 +81,7 @@ hid-picolcd-$(CONFIG_DEBUG_FS)		+= hid-picolcd_debugfs.o
>  
>  obj-$(CONFIG_HID_PLANTRONICS)	+= hid-plantronics.o
>  obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
> +obj-$(CONFIG_HID_RETRODE)	+= hid-retrode.o
>  obj-$(CONFIG_HID_ROCCAT)	+= hid-roccat.o hid-roccat-common.o \
>  	hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
>  	hid-roccat-koneplus.o hid-roccat-konepure.o hid-roccat-kovaplus.o \
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 8ca1e8ce0af2..eabf33199fb2 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -383,6 +383,9 @@
>  #define USB_VENDOR_ID_FUTABA            0x0547
>  #define USB_DEVICE_ID_LED_DISPLAY       0x7000
>  
> +#define USB_VENDOR_ID_FUTURE_TECHNOLOGY	0x0403
> +#define USB_DEVICE_ID_RETRODE2		0x97c1
> +
>  #define USB_VENDOR_ID_ESSENTIAL_REALITY	0x0d7f
>  #define USB_DEVICE_ID_ESSENTIAL_REALITY_P5 0x0100
>  
> diff --git a/drivers/hid/hid-retrode.c b/drivers/hid/hid-retrode.c
> new file mode 100644
> index 000000000000..2bcc507a1f2c
> --- /dev/null
> +++ b/drivers/hid/hid-retrode.c
> @@ -0,0 +1,105 @@
> +/*
> + *  HID driver for Retrode 2 controller adapter and plug-in extensions
> + *
> + *  Copyright (c) 2017 Bastien Nocera <hadess@hadess.net>
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/slab.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include "hid-ids.h"
> +
> +#define CONTROLLER_NAME_BASE "Retrode"
> +
> +static int retrode_input_configured(struct hid_device *hdev,
> +					struct hid_input *hi)
> +{
> +	struct hid_field *field = hi->report->field[0];
> +	const char *suffix;
> +	int number = 0;
> +	unsigned int len;
> +	char *name;
> +
> +	switch (field->report->id) {
> +	case 0:
> +		suffix = "SNES Mouse";
> +		break;
> +	case 1:
> +	case 2:
> +		suffix = "SNES";
> +		number = field->report->id;
> +		break;
> +	case 3:
> +	case 4:
> +		suffix = "Mega Drive";
> +		number = field->report->id - 2;
> +		break;
> +	default:
> +		hid_err(hdev, "Got unhandled report id %d\n", field->report->id);
> +		suffix = "Unknown";
> +	}
> +
> +	len = strlen(CONTROLLER_NAME_BASE) + strlen(suffix) +
> +			number ? 5 : 2;
> +	name = devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);

Please use dev_kasprintf() here.

> +	if (name) {
> +		if (number)
> +			sprintf(name, "%s %s #%d", CONTROLLER_NAME_BASE,
> +				suffix, number);
> +		else
> +			sprintf(name, "%s %s", CONTROLLER_NAME_BASE,
> +				suffix);
> +		hi->input->name = name;
> +	}

else return -ENOMEM ?

> +
> +	return 0;
> +}
> +
> +static int retrode_probe(struct hid_device *hdev,
> +			const struct hid_device_id *id)
> +{
> +
> +	int ret;
> +
> +	/* Has no effect on the mouse device */
> +	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed\n");
> +		return ret;
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hid_device_id retrode_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY, USB_DEVICE_ID_RETRODE2) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, retrode_devices);
> +
> +static struct hid_driver retrode_driver = {
> +	.name             = "hid-retrode",
> +	.id_table         = retrode_devices,
> +	.input_configured = retrode_input_configured,
> +	.probe            = retrode_probe,
> +};
> +
> +module_hid_driver(retrode_driver);
> +
> +MODULE_LICENSE("GPL");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
