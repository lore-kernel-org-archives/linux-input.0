From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Add special driver for Jabra devices
Date: Fri, 8 Sep 2017 14:10:43 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709081408220.3285@jbgna.fhfr.qr>
References: <1504269832-23142-1-git-send-email-nolsen@jabra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752858AbdIHMKp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Sep 2017 08:10:45 -0400
In-Reply-To: <1504269832-23142-1-git-send-email-nolsen@jabra.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com

On Fri, 1 Sep 2017, nolsen@jabra.com wrote:

> From: Niels Skou Olsen <nolsen@jabra.com>
> 
> Add a hid-jabra driver to the list of special drivers in hid-core. The
> driver prevents vendor defined HID usages (FF00-FFFF) in Jabra devices
> from being mapped to input events that become unintended mouse events
> in the X11 server.
> 
> Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
> ---
>  drivers/hid/Kconfig     | 11 ++++++++++
>  drivers/hid/Makefile    |  1 +
>  drivers/hid/hid-core.c  |  3 +++
>  drivers/hid/hid-jabra.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 73 insertions(+)
>  create mode 100644 drivers/hid/hid-jabra.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 0a3117c..d9d2843 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -395,6 +395,17 @@ config HID_ITE
>  	---help---
>  	Support for ITE devices not fully compliant with HID standard.
>  
> +config HID_JABRA
> +	tristate "Jabra USB HID Driver"
> +	depends on HID
> +	---help---
> +	Support for Jabra USB HID devices.
> +
> +	Prevents mapping of vendor defined HID usages to input events. Without
> +	this driver HID	reports from Jabra devices may incorrectly be seen as
> +	mouse button events.
> +	Say M here if you may ever plug in a Jabra USB device.
> +
>  config HID_TWINHAN
>  	tristate "Twinhan IR remote control"
>  	depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 8659d7e..d2563e5 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
>  obj-$(CONFIG_HID_HYPERV_MOUSE)	+= hid-hyperv.o
>  obj-$(CONFIG_HID_ICADE)		+= hid-icade.o
>  obj-$(CONFIG_HID_ITE)		+= hid-ite.o
> +obj-$(CONFIG_HID_JABRA)		+= hid-jabra.o
>  obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
>  obj-$(CONFIG_HID_KEYTOUCH)	+= hid-keytouch.o
>  obj-$(CONFIG_HID_KYE)		+= hid-kye.o
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9bc9116..0603012 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2077,6 +2077,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  #if IS_ENABLED(CONFIG_HID_ITE)
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE8595) },
>  #endif
> +#if IS_ENABLED(CONFIG_HID_JABRA)
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, HID_ANY_ID) },
> +#endif
>  #if IS_ENABLED(CONFIG_HID_KENSINGTON)
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
>  #endif
> diff --git a/drivers/hid/hid-jabra.c b/drivers/hid/hid-jabra.c
> new file mode 100644
> index 0000000..1f52daf
> --- /dev/null
> +++ b/drivers/hid/hid-jabra.c
> @@ -0,0 +1,58 @@
> +/*
> + *  Jabra USB HID Driver
> + *
> + *  Copyright (c) 2017 Niels Skou Olsen <nolsen@jabra.com>
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
> +
> +#include "hid-ids.h"
> +
> +#define HID_UP_VENDOR_DEFINED_MIN	0xff000000
> +#define HID_UP_VENDOR_DEFINED_MAX	0xffff0000
> +
> +static int jabra_input_mapping(struct hid_device *hdev,
> +			       struct hid_input *hi,
> +			       struct hid_field *field,
> +			       struct hid_usage *usage,
> +			       unsigned long **bit, int *max)
> +{
> +	int is_vendor_defined =
> +		((usage->hid & HID_USAGE_PAGE) >= HID_UP_VENDOR_DEFINED_MIN &&
> +		 (usage->hid & HID_USAGE_PAGE) <= HID_UP_VENDOR_DEFINED_MAX);
> +
> +	dbg_hid("hid=0x%08x appl=0x%08x coll_idx=0x%02x usage_idx=0x%02x: %s\n",
> +		usage->hid,
> +		field->application,
> +		usage->collection_index,
> +		usage->usage_index,
> +		is_vendor_defined ? "ignored" : "defaulted");
> +
> +	/* Ignore vendor defined usages, default map standard usages */
> +	return is_vendor_defined ? -1 : 0;
> +}
> +
> +static const struct hid_device_id jabra_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, HID_ANY_ID) },

You also need to update hid-core so that generic driver doesn't bind to 
those device. See hid_have_special_driver[] in drivers/hid/hid-core.c

Thanks,

-- 
Jiri Kosina
SUSE Labs

