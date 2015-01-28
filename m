From: =?UTF-8?Q?Simon_W=c3=b6rner?= <linux@simon-woerner.de>
Subject: Re: [PATCH] HID: Add driver for synaptics keybard with broken rdesc
Date: Wed, 28 Jan 2015 05:04:05 +0100
Message-ID: <54C85FB5.9050404@simon-woerner.de>
References: <1422039810-26327-1-git-send-email-linux@simon-woerner.de>
 <1422039810-26327-2-git-send-email-linux@simon-woerner.de>
 <CAN+gG=FWsAqM-UZS0_1j1-5qdqTw93=ccjpe-kRf3knYwm43Kw@mail.gmail.com>
 <54C7AA5A.9020508@simon-woerner.de>
 <CAN+gG=EHHtZSN4zu6p+cv3WFdnDF9_QFr-sqMzvhR28C0htMyw@mail.gmail.com>
 <CAE7eX3JZPX70i6rpZpoekB-NrCTqe9MQ2rusrjtCQAGgeZXrWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from brief.guru ([176.9.109.100]:46016 "EHLO brief.guru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbbA1EEO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 23:04:14 -0500
in-reply-to: <CAE7eX3JZPX70i6rpZpoekB-NrCTqe9MQ2rusrjtCQAGgeZXrWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <andrew.duggan@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, =?UTF-8?Q?Simon_W=c3=b6rner?= <mail@simon-woerner.de>

The new version is nearly finished, I will send it later today.
See below for additional changes not in the other mails.

Am 28.01.15 um 00:46 schrieb Andrew Duggan:
> On Tue, Jan 27, 2015 at 8:13 AM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> On Tue, Jan 27, 2015 at 10:10 AM, Simon W=C3=B6rner <linux@simon-woe=
rner.de> wrote:
>>> Thanks for the feedback, this is my first commit to the linux kerne=
l so
>>> I don't know much about how the input / hid is working.
>>>
>>> I will add the changelog to the patch email, just need to find out =
how
>>> this works.
>>>
>>> Am 27.01.15 um 15:16 schrieb Benjamin Tissoires:
>>>> On Fri, Jan 23, 2015 at 2:03 PM, Simon W=C3=B6rner <linux@simon-wo=
erner.de> wrote:
>>>>> From: Simon W=C3=B6rner <mail@simon-woerner.de>
>>>>>
>>>>> Signed-off-by: Simon W=C3=B6rner <mail@simon-woerner.de>
>>>>> ---
>>>>>  drivers/hid/Kconfig         |   6 ++
>>>>>  drivers/hid/Makefile        |   1 +
>>>>>  drivers/hid/hid-ids.h       |   1 +
>>>>>  drivers/hid/hid-synaptics.c | 190 ++++++++++++++++++++++++++++++=
++++++++++++++
>>>>>  4 files changed, 198 insertions(+)
>>>>>  create mode 100644 drivers/hid/hid-synaptics.c
>=20
> This isn't actually a Synaptics keyboard. The product id matches a
> touchpad so it appears that this is another situation where a vendor
> is using our touchpad's VID and PID to describe a composite USB devic=
e
> in a dock, even though our touchpad is only one of the devices in the
> dock. This is similar to what happened on the Dell Venue Pro 11. I
> think Synaptics should be removed from the name since it will be
> confusing should Synaptics release a keyboard.
>

Thanks for pointing this out. I disassembled it and it seems to be a
acer keyboard, at least there is a acer part number on it and acer
assembled it with the stolen USB ID.

So I renamed the module to 'hid_acer'.

>>>>
>>>> I am pretty sure you are missing a change in hid-core.c to add you=
r
>>>> device to hid_have_special_driver.
>>>>
>>>
>>> So I need to add this?
>>>
>>>> static const struct hid_device_id hid_have_special_driver[] =3D {
>>>>       ...
>>>>       { HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_VENDOR_ID_SYNA=
PTICS_KBD) },
>>>>       ...
>>
>> yep, seems fine.
>=20
> Adding the VID and PID to the hid_have_special_driver will cause the
> touchpad to stop working since it will prevent hid-multitouch from
> binding to it. Maybe in hid-core.c add a new hid group and a new scan
> flag for HID_GD_KEYBOARD and look for it in hid_scan_report()? But,
> this would also match the keyboard in the Dell Venue Pro 11 and
> potentially others, so the driver would need to check to see if the
> report descriptor needs this fix or not.
>

I removed it from 'hid_have_special_driver' as in the first patch mail.
If the USB ID isn't reliable and used by multiple devices then letting
hid-core fail (on the acer keyboards) and claim the device afterwards
with a check for the defect rdesc would have minimum impact on other
devices and seems the be an acceptable solution to me.

>>>
>>> do I also need to add
>>>
>>>> #if IS_ENABLED(HID_SYNAPTICS)
>>>> ...
>>>> #endif
>>>
>>> or will hid-core handle that for me?
>>
>> no, the rule here is that we just blacklist the device, and if the
>> module is not compiled, then... too bad :)
>>
>>>
>>>> Other than that (and the 2comments Jiri made), I am not very happy
>>>> with adding a hid-synaptics while we already have a hid-rmi for
>>>> synaptics devices. However, the keyboard must not follow the rmi s=
pec,
>>>> so this might be just fine.
>>>>
>>>
>>> I have seen the rmi module and haven't found anything they have in
>>> common. The USB device of the keyboard has also attached a mouse /
>>> trackpad, but it also doens't make use of the rmi module.
>>>
>>> I don't see any reason for putting both together, e.g. hid-holtek-*=
 has
>>> also two modules for keyboard rdesc fix and mouse rdesc fix.
>>>
>>> Maybe hid-synaptics-kbd would better fit?
>>
>> no hid-synaptics will be fine.
>>
>>>
>>>> Few more comments:
>>>>
>>>>>
>>>>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>>>>> index dfdc269..9f4124e 100644
>>>>> --- a/drivers/hid/Kconfig
>>>>> +++ b/drivers/hid/Kconfig
>>>>> @@ -708,6 +708,12 @@ config HID_SUNPLUS
>>>>>         ---help---
>>>>>         Support for Sunplus wireless desktop.
>>>>>
>>>>> +config HID_SYNAPTICS
>>>>> +       tristate "Synaptics keyboard support"
>>>>> +       depends on HID
>>>>> +       ---help---
>>>>> +       Support for Synaptics keyboard with invalid rdesc
>>>>> +
>>>>>  config HID_RMI
>>>>>         tristate "Synaptics RMI4 device support"
>>>>>         depends on HID
>>>>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>>>>> index debd15b..01bda39 100644
>>>>> --- a/drivers/hid/Makefile
>>>>> +++ b/drivers/hid/Makefile
>>>>> @@ -109,6 +109,7 @@ obj-$(CONFIG_HID_SONY)              +=3D hid-=
sony.o
>>>>>  obj-$(CONFIG_HID_SPEEDLINK)    +=3D hid-speedlink.o
>>>>>  obj-$(CONFIG_HID_STEELSERIES)  +=3D hid-steelseries.o
>>>>>  obj-$(CONFIG_HID_SUNPLUS)      +=3D hid-sunplus.o
>>>>> +obj-$(CONFIG_HID_SYNAPTICS)    +=3D hid-synaptics.o
>>>>>  obj-$(CONFIG_HID_GREENASIA)    +=3D hid-gaff.o
>>>>>  obj-$(CONFIG_HID_THINGM)       +=3D hid-thingm.o
>>>>>  obj-$(CONFIG_HID_THRUSTMASTER) +=3D hid-tmff.o
>>>>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>>>>> index 9243359..976ab39 100644
>>>>> --- a/drivers/hid/hid-ids.h
>>>>> +++ b/drivers/hid/hid-ids.h
>>>>> @@ -873,6 +873,7 @@
>>>>>  #define USB_DEVICE_ID_SYNAPTICS_LTS2   0x1d10
>>>>>  #define USB_DEVICE_ID_SYNAPTICS_HD     0x0ac3
>>>>>  #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD        0x1ac3
>>>>> +#define USB_VENDOR_ID_SYNAPTICS_KBD    0x2968
>>>>>  #define USB_DEVICE_ID_SYNAPTICS_TP_V103        0x5710
>>>>>
>>>>>  #define USB_VENDOR_ID_TEXAS_INSTRUMENTS        0x2047
>>>>> diff --git a/drivers/hid/hid-synaptics.c b/drivers/hid/hid-synapt=
ics.c
>>>>> new file mode 100644
>>>>> index 0000000..3dab405
>>>>> --- /dev/null
>>>>> +++ b/drivers/hid/hid-synaptics.c
>>>>> @@ -0,0 +1,190 @@
>>>>> +/*
>>>>> + *  HID driver for synaptics devices
>>>>> + *
>>>>> + *  Copyright (c) 2015 Simon W=C3=B6rner
>>>>> + */
>>>>> +
>>>>> +/*
>>>>> + * This program is free software; you can redistribute it and/or=
 modify it
>>>>> + * under the terms of the GNU General Public License as publishe=
d by the Free
>>>>> + * Software Foundation; either version 2 of the License, or (at =
your option)
>>>>> + * any later version.
>>>>> + */
>>>>> +
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/hid.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/usb.h>
>>>>
>>>> Please avoid using usb.h in HID drivers. HID should be transport a=
gnostic.
>>>>
>>>
>>> Okay.
>>>
>>>>> +
>>>>> +#include "hid-ids.h"
>>>>> +
>>>>> +/* Synaptics keyboards (USB ID 06cb:2968) e.g. in Acer SW5-012
>>>>> + * have the following issue:
>>>>> + * - The report descriptor specifies an excessively large number=
 of consumer
>>>>> + *   usages (2^15), which is more than HID_MAX_USAGES. This prev=
ents proper
>>>>> + *   parsing of the report descriptor.
>>>>> + *
>>>>> + * The replacement descriptor below fixes the number of consumer=
 usages.
>>>>> + */
>>>>> +
>>>>> +static __u8 synaptics_kbd_rdesc_fixed[] =3D {
>>>>> +       /* Application Collection */
>>>>> +       0x06, 0x85, 0xFF,       /* (GLOBAL) USAGE_PAGE (Vendor-de=
fined)       */
>>>>> +       0x09, 0x95,             /* (LOCAL)  USAGE (0xFF850095)   =
             */
>>>>> +       0xA1, 0x01,             /* (MAIN)   COLLECTION (Applicati=
on)          */
>>>>> +       0x85, 0x5A,             /*   (GLOBAL) REPORT_ID (0x5A (90=
) 'Z')       */
>>>>> +       0x09, 0x01,             /*   (LOCAL)  USAGE (0xFF850001) =
             */
>>>>> +       0x26, 0xFF, 0x00,       /*   (GLOBAL) LOGICAL_MAXIMUM 0x0=
0FF (255)    */
>>>>> +       0x75, 0x08,             /*   (GLOBAL) REPORT_SIZE 0x08 (8=
)            */
>>>>> +       0x95, 0x10,             /*   (GLOBAL) REPORT_COUNT 0x10 (=
16)          */
>>>>> +       0xB1, 0x00,             /*   (MAIN)   FEATURE 0x00       =
             */
>>>>> +       0xC0,                   /* (MAIN)   END_COLLECTION (Appli=
cation)      */
>>>>> +
>>>>> +       /* Application Collection */
>>>>> +       0x05, 0x01,             /* (GLOBAL) USAGE_PAGE (Desktop) =
             */
>>>>> +       0x09, 0x06,             /* (LOCAL)  USAGE 0x06 (Keyboard)=
             */
>>>>> +       0xA1, 0x01,             /* (MAIN)   COLLECTION (Applicati=
on)          */
>>>>> +       0x85, 0x01,             /*   (GLOBAL) REPORT_ID 0x01 (1) =
             */
>>>>> +       0x75, 0x01,             /*   (GLOBAL) REPORT_SIZE 0x01 (1=
)            */
>>>>> +       0x95, 0x08,             /*   (GLOBAL) REPORT_COUNT 0x08 (=
8)           */
>>>>> +       0x05, 0x07,             /*   (GLOBAL) USAGE_PAGE 0x07 (Ke=
yboard)      */
>>>>> +       0x19, 0xE0,             /*   (LOCAL)  USAGE_MINIMUM 0xE0 =
             */
>>>>> +       0x29, 0xE7,             /*   (LOCAL)  USAGE_MAXIMUM 0xE7 =
             */
>>>>> +       0x25, 0x01,             /*   (GLOBAL) LOGICAL_MAXIMUM 0x0=
1 (1)        */
>>>>> +       0x81, 0x02,             /*   (MAIN)   INPUT 0x02         =
             */
>>>>> +       0x95, 0x01,             /*   (GLOBAL) REPORT_COUNT 0x01 (=
1)           */
>>>>> +       0x75, 0x08,             /*   (GLOBAL) REPORT_SIZE 0x08 (8=
)            */
>>>>> +       0x81, 0x03,             /*   (MAIN)   INPUT 0x03         =
             */
>>>>> +       0x95, 0x05,             /*   (GLOBAL) REPORT_COUNT 0x05 (=
5)           */
>>>>> +       0x75, 0x01,             /*   (GLOBAL) REPORT_SIZE 0x01 (1=
)            */
>>>>> +       0x05, 0x08,             /*   (GLOBAL) USAGE_PAGE 0x08 (LE=
D Indicator) */
>>>>> +       0x19, 0x01,             /*   (LOCAL)  USAGE_MINIMUM 0x01 =
             */
>>>>> +       0x29, 0x05,             /*   (LOCAL)  USAGE_MAXIMUM 0x05 =
             */
>>>>> +       0x91, 0x02,             /*   (MAIN)   OUTPUT 0x02        =
             */
>>>>> +       0x95, 0x01,             /*   (GLOBAL) REPORT_COUNT 0x01 (=
1)           */
>>>>> +       0x75, 0x03,             /*   (GLOBAL) REPORT_SIZE 0x03 (3=
)            */
>>>>> +       0x91, 0x03,             /*   (MAIN)   OUTPUT 0x03        =
             */
>>>>> +       0x95, 0x06,             /*   (GLOBAL) REPORT_COUNT 0x06 (=
6)           */
>>>>> +       0x75, 0x08,             /*   (GLOBAL) REPORT_SIZE 0x08 (8=
)            */
>>>>> +       0x26, 0xFF, 0x00,       /*   (GLOBAL) LOGICAL_MAXIMUM 0x0=
0FF (255)    */
>>>>> +       0x05, 0x07,             /*   (GLOBAL) USAGE_PAGE 0x0007 (=
Keyboard)    */
>>>>> +       0x19, 0x00,             /*   (LOCAL)  USAGE_MINIMUM 0x00 =
             */
>>>>> +       0x2A, 0xFF, 0x00,       /*   (LOCAL)  USAGE_MAXIMUM 0xFF =
             */
>>>>> +       0x81, 0x00,             /*   (MAIN)   INPUT 0x00         =
             */
>>>>> +       0xC0,                   /* (MAIN)   END_COLLECTION (Appli=
cation)      */
>>>>> +
>>>>> +       /* Application Collection */
>>>>> +       0x05, 0x0C,             /* (GLOBAL) USAGE_PAGE (Consumer)=
             */
>>>>> +       0x09, 0x01,             /* (LOCAL)  USAGE 0x01 (Consumer =
Control)     */
>>>>> +       0xA1, 0x01,             /* (MAIN)   COLLECTION (Applicati=
on)          */
>>>>> +       0x85, 0x02,             /*   (GLOBAL) REPORT_ID 0x02 (2) =
             */
>>>>> +       0x19, 0x00,             /*   (LOCAL)  USAGE_MINIMUM 0x00 =
             */
>>>>> +       0x2A, 0x3C, 0x02,       /*   (LOCAL)  USAGE_MAXIMUM 0x023=
C            */
>>>>> +       0x26, 0x3C, 0x02,       /*   (GLOBAL) LOGICAL_MAXIMUM 0x0=
23C (572)    */
>>>>> +       0x75, 0x10,             /*   (GLOBAL) REPORT_SIZE 0x10 (1=
6)           */
>>>>> +       0x95, 0x01,             /*   (GLOBAL) REPORT_COUNT 0x01 (=
1)           */
>>>>> +       0x81, 0x00,             /*   (MAIN)   INPUT 0x00         =
             */
>>>>> +       0xC0,                   /* (MAIN)   END_COLLECTION (Appli=
cation)      */
>>>>> +
>>>>> +       /* Application Collection */
>>>>> +       0x05, 0x01,             /* (GLOBAL) USAGE_PAGE (Desktop) =
             */
>>>>> +       0x09, 0x0C,             /* (LOCAL)  USAGE (Wireless Radio=
 Controls)   */
>>>>> +       0xA1, 0x01,             /* (MAIN)   COLLECTION (Applicati=
on)          */
>>>>> +       0x85, 0x03,             /*   (GLOBAL) REPORT_ID 0x03 (3) =
             */
>>>>> +       0x25, 0x01,             /*   (GLOBAL) LOGICAL_MAXIMUM 0x0=
1 (1)        */
>>>>> +       0x09, 0xC6,             /*   (LOCAL)  USAGE 0xC6         =
             */
>>>>> +       0x75, 0x01,             /*   (GLOBAL) REPORT_SIZE 0x01 (1=
)            */
>>>>> +       0x81, 0x06,             /*   (MAIN)   INPUT 0x06         =
             */
>>>>> +       0x75, 0x07,             /*   (GLOBAL) REPORT_SIZE 0x07 (7=
)            */
>>>>> +       0x81, 0x03,             /*   (MAIN)   INPUT 0x03         =
             */
>>>>> +       0xC0,                   /* (MAIN)   END_COLLECTION (Appli=
cation)      */
>>>>> +
>>>>> +       /* Application Collection */
>>>>> +       0x05, 0x88,             /* (GLOBAL) USAGE_PAGE (0x88)    =
             */
>>>>> +       0x09, 0x01,             /* (LOCAL)  USAGE (0x01)         =
             */
>>>>> +       0xA1, 0x01,             /* (MAIN)   COLLECTION (Applicati=
on)          */
>>>>> +       0x85, 0x04,             /*   (GLOBAL) REPORT_ID 0x04 (4) =
             */
>>>>> +       0x19, 0x00,             /*   (LOCAL)  USAGE_MINIMUM 0x00 =
             */
>>>>> +       0x2A, 0xFF, 0x00,       /*   (LOCAL)  USAGE_MAXIMUM 0x00F=
=46            */
>>>>> +       0x26, 0xFF, 0x00,       /*   (GLOBAL) LOGICAL_MAXIMUM 0x0=
0FF          */
>>>>> +       0x75, 0x08,             /*   (GLOBAL) REPORT_SIZE 0x08 (8=
)            */
>>>>> +       0x95, 0x02,             /*   (GLOBAL) REPORT_COUNT 0x02 (=
2)           */
>>>>> +       0x81, 0x02,             /*   (MAIN)   INPUT 0x02         =
             */
>>>>> +       0xC0,                   /* (MAIN)   END_COLLECTION (Appli=
cation)      */
>>>>> +
>>>>> +       /* Application Collection */
>>>>> +       0x05, 0x01,             /* (GLOBAL) USAGE_PAGE (Desktop) =
             */
>>>>> +       0x09, 0x80,             /* (LOCAL)  USAGE (System Control=
)            */
>>>>> +       0xA1, 0x01,             /* (MAIN)   COLLECTION (Applicati=
on)          */
>>>>> +       0x85, 0x05,             /*   (GLOBAL) REPORT_ID 0x05 (5) =
             */
>>>>> +       0x19, 0x81,             /*   (LOCAL)  USAGE_MINIMUM 0x81 =
             */
>>>>> +       0x29, 0x83,             /*   (LOCAL)  USAGE_MAXIMUM 0x83 =
             */
>>>>> +       0x25, 0x01,             /*   (GLOBAL) LOGICAL_MAXIMUM 0x0=
1 (1)        */
>>>>> +       0x95, 0x08,             /*   (GLOBAL) REPORT_COUNT 0x08 (=
8)           */
>>>>> +       0x75, 0x01,             /*   (GLOBAL) REPORT_SIZE 0x01 (1=
)            */
>>>>> +       0x81, 0x02,             /*   (MAIN)   INPUT 0x02         =
             */
>>>>> +       0xC0,                   /* (MAIN)   END_COLLECTION (Appli=
cation)      */
>>>>> +};
>>>>> +
>>>>> +static __u8 *synaptics_kbd_report_fixup(struct hid_device *hdev,=
 __u8 *rdesc,
>>>>> +               unsigned int *rsize)
>>>>> +{
>>>>> +       struct usb_interface *intf =3D to_usb_interface(hdev->dev=
=2Eparent);
>>>>> +
>>>>> +       if (intf->cur_altsetting->desc.bInterfaceNumber =3D=3D 0)=
 {
>>>>
>>>> Please don't. This is too fragile and we can not use uhid to repla=
y
>>>> and test such devices.
>>>> Make a check on the size of the original descriptor, or check whic=
h
>>>> bits you are replacing to know which interface you want to change =
the
>>>> report descriptor.
>>>> You can also check on the HID device .type which may be different
>>>> among the various interfaces.
>>>>
>>>
>>> Is a size check safe enough? Maybe synaptics starts to change the r=
desc.
>>>
>>> I'm just replacing two bytes:
>>>
>>>> 0x2A, 0xFF, 0x00,       /*   (LOCAL)  USAGE_MAXIMUM 0x00FF
>>>> 0x26, 0xFF, 0x00,       /*   (GLOBAL) LOGICAL_MAXIMUM 0x00FF
>>>
>>> used to be
>>>
>>>> 0x2A, 0xFF, 0xFF,       /*   (LOCAL)  USAGE_MAXIMUM 0xFFFF
>>>> 0x26, 0xFF, 0xFF,       /*   (GLOBAL) LOGICAL_MAXIMUM 0xFFFF
>>>
>>> and I removed some unneeded USAGE_MINIMUM which are already set to =
0
>>> globally (which doesn't make any difference).
>>>
>>> The smallest solution would be a byte copy over it, but I think it
>>> wouldn't be readable later if there occur other issue or if synapti=
cs
>>> starts selling devices with changed rdesc and same device id.
>>>
>>> I have seen rdesc fixes with full copy and byte copy in other modul=
es,
>>> are there any suggestions when to use what?
>>
>> there is no rule. In your case, I would prefer a byte copy because t=
he
>> change is small enough and this would prevent any copyright issues.
>> If possible, reuse the same way of fixing that
>> kye_consumer_control_fixup() in hid-kye.c
>>
>> If it is clearly documented, there will not be further mistakes.
>>
>>>
>>>
>>>>> +               rdesc =3D synaptics_kbd_rdesc_fixed;
>>>>> +               *rsize =3D sizeof(synaptics_kbd_rdesc_fixed);
>>>>> +       }
>>>>> +       return rdesc;
>>>>> +}
>>>>> +
>>>>> +static int synaptics_probe(struct hid_device *hdev,
>>>>> +               const struct hid_device_id *id)
>>>>> +{
>>>>> +       int ret;
>>>>> +
>>>>> +       ret =3D hid_parse(hdev);
>>>>> +       if (ret) {
>>>>> +               hid_err(hdev, "parse failed\n");
>>>>> +               goto err_free;
>>>>> +       }
>>>>> +
>>>>> +       ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>>>>> +       if (ret) {
>>>>> +               hid_err(hdev, "hw start failed\n");
>>>>> +               goto err_free;
>>>>> +       }
>>>>> +
>>>>> +       if (ret < 0)
>>>>> +               goto err_stop;
>>>>> +
>>>>> +       return 0;
>>>>> +err_stop:
>>>>> +       hid_hw_stop(hdev);
>>>>> +err_free:
>>>>> +       return ret;
>>>>> +}
>>>
>>> I looked around how other modules handle this and didn't came up wi=
th a
>>> better name for the label, but this obsolete if I remove the
>>> probe/remove (see below).
>>>
>>>>
>>>> I am pretty sure there is no need for a probe here. Hid-core will =
use
>>>> the generic one and you should be fine.
>>>>
>>>
>>> So when I remove the function(s) and reference(s) in hid_driver for=
 the
>>> probe and the remove hid_core will handle that for me?
>>
>> Yeah, your driver does not allocated anything, so probe and remove
>> should not be used. Hid-core will take care of everything.
>>
>> Cheers,
>> Benjamin
>>
>>>
>>>>> +
>>>>> +static void synaptics_remove(struct hid_device *hdev)
>>>>> +{
>>>>> +       hid_hw_stop(hdev);
>>>>> +       kfree(hid_get_drvdata(hdev));
>>>>> +}
>>>>
>>>> Same here, not mandatory.
>>>>
>>>> Cheers,
>>>> Benjamin
>>>>
>>>>> +
>>>>> +static const struct hid_device_id synaptics_devices[] =3D {
>>>>> +       { HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS,
>>>>> +               USB_VENDOR_ID_SYNAPTICS_KBD) },
>>>>> +       { }
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(hid, synaptics_devices);
>>>>> +
>>>>> +static struct hid_driver synaptics_driver =3D {
>>>>> +       .name =3D "synaptics",
>>>>> +       .id_table =3D synaptics_devices,
>>>>> +       .report_fixup =3D synaptics_kbd_report_fixup,
>>>>> +       .probe =3D synaptics_probe,
>>>>> +       .remove =3D synaptics_remove,
>>>>> +};
>>>>> +module_hid_driver(synaptics_driver);
>>>>> +
>>>>> +MODULE_LICENSE("GPL");
>>>>> --
>>>>> 2.2.2
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-i=
nput" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
