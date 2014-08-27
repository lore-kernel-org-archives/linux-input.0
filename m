From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH] HID: add support for PenMount HID TouchScreen Driver v2
Date: Wed, 27 Aug 2014 10:27:04 +0200
Message-ID: <CAH9NwWet=-DkMpxdvjHFjJByB4bhj=xxOv5QyyOMFqEdyf17FQ@mail.gmail.com>
References: <1409127649-2495-1-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:41334 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbaH0I1Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Aug 2014 04:27:25 -0400
Received: by mail-we0-f177.google.com with SMTP id w62so15477971wes.8
        for <linux-input@vger.kernel.org>; Wed, 27 Aug 2014 01:27:24 -0700 (PDT)
In-Reply-To: <1409127649-2495-1-git-send-email-christian.gmeiner@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christian Gmeiner <christian.gmeiner@gmail.com>

2014-08-27 10:20 GMT+02:00 Christian Gmeiner <christian.gmeiner@gmail.com>:
> This patch adds a seperate hid-penmount driver to work
> around an issue with the HID report descriptor. The
> descriptor does not contain the ContactID usage and as
> result the touchscreen is represented as normal mouse
> to the system.
>
> This driver maps the button 0 emitted by the touchscreen
> to BTN_TOUCH. This makes it possible to use touch events
> in userspace.
>
> changes from v1 to v2
>  - incorporated feedback from Benjamin Tissoires
>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/hid/Kconfig        |  6 ++++++
>  drivers/hid/Makefile       |  1 +
>  drivers/hid/hid-penmount.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
>  create mode 100644 drivers/hid/hid-penmount.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index c18d5d7..0351b66 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -530,6 +530,12 @@ config PANTHERLORD_FF
>           Say Y here if you have a PantherLord/GreenAsia based game controller
>           or adapter and want to enable force feedback support for it.
>
> +config HID_PENMOUNT
> +       tristate "Penmount touch device"
> +       depends on USB_HID
> +       ---help---
> +         Say Y here if you have a Penmount based touch controller.
> +
>  config HID_PETALYNX
>         tristate "Petalynx Maxter remote control"
>         depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 4dbac7f..e2850d8 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_HID_NTRIG)               += hid-ntrig.o
>  obj-$(CONFIG_HID_ORTEK)                += hid-ortek.o
>  obj-$(CONFIG_HID_PRODIKEYS)    += hid-prodikeys.o
>  obj-$(CONFIG_HID_PANTHERLORD)  += hid-pl.o
> +obj-$(CONFIG_HID_PENMOUNT)     += hid-penmount.o
>  obj-$(CONFIG_HID_PETALYNX)     += hid-petalynx.o
>  obj-$(CONFIG_HID_PICOLCD)      += hid-picolcd.o
>  hid-picolcd-y                  += hid-picolcd_core.o
> diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
> new file mode 100644
> index 0000000..02de4b8
> --- /dev/null
> +++ b/drivers/hid/hid-penmount.c
> @@ -0,0 +1,51 @@
> +/*
> + *  HID driver for PenMount touchscreens
> + *
> + *  Copyright (c) 2014 Christian Gmeiner <christian.gmeiner@gmail.com>
> + *
> + *  based on hid-penmount copyrighted by
> + *    PenMount Touch Solutions <penmount@seed.net.tw>
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
> +#include <linux/hid.h>
> +#include "hid-ids.h"
> +
> +static int penmount_input_mapping(struct hid_device *hdev,
> +               struct hid_input *hi, struct hid_field *field,
> +               struct hid_usage *usage, unsigned long **bit, int *max)
> +{
> +       int mapped = 0;
> +
> +       if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
> +               hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
> +               mapped = 1;
> +       }
> +
> +       return mapped;
> +}
> +
> +static const struct hid_device_id penmount_devices[] = {
> +       { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(hid, penmount_devices);
> +
> +static struct hid_driver penmount_driver = {
> +       .name = "hid-penmount",
> +       .id_table = penmount_devices,
> +       .input_mapping = penmount_input_mapping,
> +};
> +
> +module_hid_driver(penmount_driver);
> +
> +MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner@gmail.com>");
> +MODULE_DESCRIPTION("PenMount HID TouchScreen driver");
> +MODULE_LICENSE("GPL");
> --
> 1.9.3
>

Please ignore...

--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
