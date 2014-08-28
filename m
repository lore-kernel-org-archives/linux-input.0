From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH] HID: add support for PenMount HID TouchScreen Driver v3
Date: Thu, 28 Aug 2014 09:04:21 +0200
Message-ID: <CAH9NwWeDLNYtmMpVsFZvA6YACefjz2RTYRwj__ArtGGjWZL+aQ@mail.gmail.com>
References: <1409132115-31707-1-git-send-email-christian.gmeiner@gmail.com> <CAN+gG=HpA2ZmqqWAEBbrsOhaieHdvBcbvfmia1WKxeaV_8LHDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:56799 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbaH1HEm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Aug 2014 03:04:42 -0400
Received: by mail-wg0-f46.google.com with SMTP id x13so302830wgg.5
        for <linux-input@vger.kernel.org>; Thu, 28 Aug 2014 00:04:41 -0700 (PDT)
In-Reply-To: <CAN+gG=HpA2ZmqqWAEBbrsOhaieHdvBcbvfmia1WKxeaV_8LHDw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

2014-08-27 16:27 GMT+02:00 Benjamin Tissoires <benjamin.tissoires@gmail.com>:
> On Wed, Aug 27, 2014 at 5:35 AM, Christian Gmeiner
> <christian.gmeiner@gmail.com> wrote:
>> This patch adds a seperate hid-penmount driver to work
>> around an issue with the HID report descriptor. The
>> descriptor does not contain the ContactID usage and as
>> result the touchscreen is represented as normal mouse
>> to the system.
>>
>> This driver maps the button 0 emitted by the touchscreen
>> to BTN_TOUCH. This makes it possible to use touch events
>> in userspace.
>>
>> changes from v1 to v2
>>  - incorporated feedback from Benjamin Tissoires
>> changes from v2 to v3
>>  - add missing hid-core.c and hid-ids.h changes
>
> scripts/check_patch.pl complains about DOS line ending, and I agree.
> This script also complains about 2 other warnings, which should not be
> much of a problem.

Funny.. the whole patch creation process has never left my fedora box.
Also this is
not the first time I did a patch. I will have a closer look at this in v4.

>
>>
>> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>> ---
>>  drivers/hid/Kconfig        |  6 ++++++
>>  drivers/hid/Makefile       |  1 +
>>  drivers/hid/hid-core.c     |  1 +
>>  drivers/hid/hid-ids.h      |  1 +
>>  drivers/hid/hid-penmount.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 60 insertions(+)
>>  create mode 100644 drivers/hid/hid-penmount.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index c18d5d7..0351b66 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -530,6 +530,12 @@ config PANTHERLORD_FF
>>           Say Y here if you have a PantherLord/GreenAsia based game controller
>>           or adapter and want to enable force feedback support for it.
>>
>> +config HID_PENMOUNT
>> +       tristate "Penmount touch device"
>> +       depends on USB_HID
>> +       ---help---
>> +         Say Y here if you have a Penmount based touch controller.
>> +
>>  config HID_PETALYNX
>>         tristate "Petalynx Maxter remote control"
>>         depends on HID
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index 4dbac7f..e2850d8 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -71,6 +71,7 @@ obj-$(CONFIG_HID_NTRIG)               += hid-ntrig.o
>>  obj-$(CONFIG_HID_ORTEK)                += hid-ortek.o
>>  obj-$(CONFIG_HID_PRODIKEYS)    += hid-prodikeys.o
>>  obj-$(CONFIG_HID_PANTHERLORD)  += hid-pl.o
>> +obj-$(CONFIG_HID_PENMOUNT)     += hid-penmount.o
>>  obj-$(CONFIG_HID_PETALYNX)     += hid-petalynx.o
>>  obj-$(CONFIG_HID_PICOLCD)      += hid-picolcd.o
>>  hid-picolcd-y                  += hid-picolcd_core.o
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 12b6e67..6827196 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1880,6 +1880,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>>         { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_18) },
>>         { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_PKB1700) },
>>         { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
>> +       { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
>>         { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
>>         { HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
>>  #if IS_ENABLED(CONFIG_HID_ROCCAT)
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 25cd674..3943ffe 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -722,6 +722,7 @@
>>  #define USB_DEVICE_ID_PENMOUNT_PCI     0x3500
>>  #define USB_DEVICE_ID_PENMOUNT_1610    0x1610
>>  #define USB_DEVICE_ID_PENMOUNT_1640    0x1640
>> +#define USB_DEVICE_ID_PENMOUNT_6000    0x6000
>>
>>  #define USB_VENDOR_ID_PETALYNX         0x18b1
>>  #define USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE   0x0037
>> diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
>> new file mode 100644
>> index 0000000..02de4b8
>> --- /dev/null
>> +++ b/drivers/hid/hid-penmount.c
>> @@ -0,0 +1,51 @@
>> +/*
>> + *  HID driver for PenMount touchscreens
>> + *
>> + *  Copyright (c) 2014 Christian Gmeiner <christian.gmeiner@gmail.com>
>> + *
>> + *  based on hid-penmount copyrighted by
>> + *    PenMount Touch Solutions <penmount@seed.net.tw>
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the Free
>> + * Software Foundation; either version 2 of the License, or (at your option)
>> + * any later version.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/hid.h>
>> +#include "hid-ids.h"
>> +
>> +static int penmount_input_mapping(struct hid_device *hdev,
>> +               struct hid_input *hi, struct hid_field *field,
>> +               struct hid_usage *usage, unsigned long **bit, int *max)
>> +{
>> +       int mapped = 0;
>
> I would have simply removed that...
>
>> +
>> +       if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
>> +               hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
>> +               mapped = 1;
>
> ... "return 1;" here...
>
>> +       }
>> +
>> +       return mapped;
>
> ... and "return 0;" here.
>

ok

>> +}
>> +
>> +static const struct hid_device_id penmount_devices[] = {
>> +       { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(hid, penmount_devices);
>> +
>> +static struct hid_driver penmount_driver = {
>> +       .name = "hid-penmount",
>> +       .id_table = penmount_devices,
>> +       .input_mapping = penmount_input_mapping,
>> +};
>> +
>> +module_hid_driver(penmount_driver);
>> +
>> +MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner@gmail.com>");
>> +MODULE_DESCRIPTION("PenMount HID TouchScreen driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 1.9.3
>>
>
> The rest is pretty straightforward.
> With the small change here + the remove of DOS line endings, the patch
> is Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>

Great.

> Then comes the question to know if this is _really_ necessary and if
> there is no other way to achieve the same.

The other thing would patch the report descriptor. I do not want to
handle this case
in userspace as things are getting quite complex there. I am happy that chromium
sees touch events :)

>
> BTW, you should also put Jiri (the HID maintainer) in CC of your
> submissions if you ever want it to get into the main tree :)
>

Thanks for this hint.

greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
