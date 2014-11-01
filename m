From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/2] Introduces Plantronics driver to fix errant mouse events.
Date: Fri, 31 Oct 2014 22:12:19 -0400
Message-ID: <CAN+gG=Ftj41ThcGkBouGK0zC9-RPBXQUf_iSYEGFCSuadQf5JA@mail.gmail.com>
References: <512A3191-0BAA-4E92-A863-66AFD2A16422@plantronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:60030 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386AbaKACMU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 22:12:20 -0400
Received: by mail-qc0-f178.google.com with SMTP id b13so7548357qcw.37
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 19:12:20 -0700 (PDT)
In-Reply-To: <512A3191-0BAA-4E92-A863-66AFD2A16422@plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Cole, JD" <JD.Cole@plantronics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jkosina@suse.cz" <jkosina@suse.cz>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "bleung@chromium.org" <bleung@chromium.org>, "Junge, Terry" <Terry.Junge@plantronics.com>, "Dsouza, Sunil" <Sunil.Dsouza@plantronics.com>, "Wesselman, Tom" <Tom.Wesselman@plantronics.com>

On Fri, Oct 31, 2014 at 3:20 PM, Cole, JD <JD.Cole@plantronics.com> wrote:
> This version of the driver prevents Telephony pages which are not
> mapped as Consumer Control applications AND are not on the Consumer Page
> from being registered by the hid-input driver.
>
> Signed-off-by: JD Cole <jd.cole@plantronics.com>
> ---
> drivers/hid/Kconfig           |    7 ++++
> drivers/hid/Makefile          |    1 +
> drivers/hid/hid-core.c        |    1 +
> drivers/hid/hid-ids.h         |    2 ++
> drivers/hid/hid-plantronics.c |   78 +++++++++++++++++++++++++++++++++++++++++
> include/linux/hid.h           |    3 ++
> 6 files changed, 92 insertions(+)
> create mode 100644 drivers/hid/hid-plantronics.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index f42df4d..bf1c74e 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -613,6 +613,13 @@ config HID_PICOLCD_CIR
>         ---help---
>           Provide access to PicoLCD's CIR interface via remote control (LIRC).
>
> +config HID_PLANTRONICS
> +       tristate "Plantronics USB HID Driver"
> +       default !EXPERT
> +       depends on HID
> +       ---help---
> +       Provides HID support for Plantronics telephony devices.
> +
> config HID_PRIMAX
>         tristate "Primax non-fully HID-compliant devices"
>         depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index e2850d8..5e7ac59 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -94,6 +94,7 @@ ifdef CONFIG_DEBUG_FS
> hid-picolcd-y                   += hid-picolcd_debugfs.o
> endif
>
> +obj-$(CONFIG_HID_PLANTRONICS)  += hid-plantronics.o
> obj-$(CONFIG_HID_PRIMAX)        += hid-primax.o
> obj-$(CONFIG_HID_ROCCAT)        += hid-roccat.o hid-roccat-common.o \
>         hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 73bd9e2..d50313c 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1886,6 +1886,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
> #if IS_ENABLED(CONFIG_HID_ROCCAT)
>         { HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_ARVO) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index e23ab8b..f9f476d 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -715,6 +715,8 @@
> #define USB_DEVICE_ID_ORTEK_PKB1700     0x1700
> #define USB_DEVICE_ID_ORTEK_WKB2000     0x2000
>
> +#define USB_VENDOR_ID_PLANTRONICS      0x047f
> +
> #define USB_VENDOR_ID_PANASONIC         0x04da
> #define USB_DEVICE_ID_PANABOARD_UBT780  0x1044
> #define USB_DEVICE_ID_PANABOARD_UBT880  0x104d
> diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
> new file mode 100644
> index 0000000..215cdbd
> --- /dev/null
> +++ b/drivers/hid/hid-plantronics.c
> @@ -0,0 +1,78 @@
> +/*
> + *  Plantronics USB HID Driver
> + *
> + *  Copyright (c) 2014 JD Cole <jd.cole@plantronics.com>
> + *  Copyright (c) 2014 Terry Junge <terry.junge@plantronics.com>
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include "hid-ids.h"
> +
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +static int plantronics_input_mapping(struct hid_device *hdev,
> +                                    struct hid_input *hi,
> +                                    struct hid_field *field,
> +                                    struct hid_usage *usage,
> +                                    unsigned long **bit, int *max)
> +{
> +       if (field->application == HID_CP_CONSUMERCONTROL
> +           && (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
> +               hid_dbg(hdev, "usage: %08x (appl: %08x) - defaulted\n",
> +                        usage->hid, field->application);
> +               return 0;
> +       }
> +
> +       hid_dbg(hdev, "usage: %08x (appl: %08x) - ignored\n",
> +               usage->hid, field->application);
> +
> +       return -1;
> +}
> +
> +static int plantronics_probe(struct hid_device *hdev,
> +                            const struct hid_device_id *id)
> +{
> +       int ret;
> +
> +       ret = hid_parse(hdev);
> +       if (ret) {
> +               hid_err(hdev, "parse failed\n");
> +               goto err;
> +       }
> +
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(hdev, "hw start failed\n");
> +               goto err;
> +       }
> +
> +       return 0;
> + err:
> +       return ret;
> +}

Actually, in your case, you can even remove the probe function.
hid-core will do open the report and start the hardware for you.

Cheers,
Benjamin

> +
> +static const struct hid_device_id plantronics_devices[] = {
> +       { HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(hid, plantronics_devices);
> +
> +static struct hid_driver plantronics_driver = {
> +       .name = "plantronics",
> +       .id_table = plantronics_devices,
> +       .input_mapping = plantronics_input_mapping,
> +       .probe = plantronics_probe,
> +};
> +module_hid_driver(plantronics_driver);
> +
> +MODULE_AUTHOR("JD Cole <jd.cole@plantronics.com>");
> +MODULE_AUTHOR("Terry Junge <terry.junge@plantronics.com>");
> +MODULE_DESCRIPTION("Plantronics USB HID Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 78ea9bf..a63f2aa 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -234,6 +234,9 @@ struct hid_item {
> #define HID_DG_BARRELSWITCH     0x000d0044
> #define HID_DG_ERASER           0x000d0045
> #define HID_DG_TABLETPICK       0x000d0046
> +
> +#define HID_CP_CONSUMERCONTROL 0x000c0001
> +
> #define HID_DG_CONFIDENCE       0x000d0047
> #define HID_DG_WIDTH            0x000d0048
> #define HID_DG_HEIGHT           0x000d0049
> --
> 1.7.9.5
>
>
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain information that is confidential and/or legally privileged. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, please DO NOT disclose the contents to another person, store or copy the information in any medium, or use any of the information contained in or attached to this transmission for any purpose. If you have received this transmission in error, please immediately notify the sender by reply email or at privacy@plantronics.com, and destroy the original transmission and its attachments without reading or saving in any manner.
>
> For further information about Plantronics - the Company, its products, brands, partners, please visit our website www.plantronics.com.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
