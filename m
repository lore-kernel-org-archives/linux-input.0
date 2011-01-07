From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v2 03/10] hid-multitouch: support for PixCir-based panels
Date: Fri, 7 Jan 2011 10:38:57 +0100
Message-ID: <AANLkTimhk80b+jkqsNrxmFzSgmHX=_wdzbwE09NoFgV1@mail.gmail.com>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294248468-19979-4-git-send-email-benjamin.tissoires@enac.fr>
	<20110106172528.GD1790@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40750 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab1AGJi7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 04:38:59 -0500
In-Reply-To: <20110106172528.GD1790@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 6, 2011 at 6:25 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> On Wed, Jan 05, 2011 at 06:27:41PM +0100, Benjamin Tissoires wrote:
>> Created a driver for PixCir based dual-touch panels, including the o=
ne
>> in the Hanvon tablet. =A0This is done in a code structure aimed at u=
nifying
>> support for several existing HID multitouch panels.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> Signed-off-by: St=E9phane Chatty <chatty@enac.fr>
>> ---
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A06 +
>> =A0drivers/hid/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 =A02 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A04 +
>> =A0drivers/hid/hid-multitouch.c | =A0434 +++++++++++++++++++++++++++=
+++++++++++++++
>> =A05 files changed, 447 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hid/hid-multitouch.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 401acec..6519981 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -285,6 +285,12 @@ config HID_MONTEREY
>> =A0 =A0 =A0 ---help---
>> =A0 =A0 =A0 Support for Monterey Genius KB29E.
>>
>> +config HID_MULTITOUCH
>> + =A0 =A0 tristate "HID Multitouch panels"
>> + =A0 =A0 depends on USB_HID
>> + =A0 =A0 ---help---
>> + =A0 =A0 Generic support for HID multitouch panels.
>> +
>
> Please provide a bit more information under this config option. The
> usual "what should I do", and roughly what devices are supported.

Will try, but don't hesitate to send one if you feel in a good mood for=
 writing.

I can propose:

+        ---help---
+          Generic support for HID multitouch panels.
+          Currently supported panels are:
+          - PixCir touchscreen
+          - Cypress TrueTouch
+          - 'Sensing Win7-TwoFinger' panel by GeneralTouch

>
>> =A0config HID_NTRIG
>> =A0 =A0 =A0 tristate "N-Trig touch screen"
>> =A0 =A0 =A0 depends on USB_HID
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index c335605..ec991d4 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -46,6 +46,7 @@ obj-$(CONFIG_HID_MAGICMOUSE) =A0 =A0+=3D hid-magic=
mouse.o
>> =A0obj-$(CONFIG_HID_MICROSOFT) =A0+=3D hid-microsoft.o
>> =A0obj-$(CONFIG_HID_MONTEREY) =A0 +=3D hid-monterey.o
>> =A0obj-$(CONFIG_HID_MOSART) =A0 =A0 +=3D hid-mosart.o
>> +obj-$(CONFIG_HID_MULTITOUCH) +=3D hid-multitouch.o
>> =A0obj-$(CONFIG_HID_NTRIG) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D hid-ntrig=
=2Eo
>> =A0obj-$(CONFIG_HID_ORTEK) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D hid-ortek=
=2Eo
>> =A0obj-$(CONFIG_HID_PRODIKEYS) =A0+=3D hid-prodikeys.o
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 88668ae..2b4d9b9 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1286,6 +1286,7 @@ static const struct hid_device_id hid_blacklis=
t[] =3D {
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLI=
P_KVM) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EM=
PREX_REMOTE) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EM=
PREX_REMOTE_2) },
>> + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_=
PIXCIR_MULTI_TOUCH) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CAND=
O_MULTI_TOUCH) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CAND=
O_MULTI_TOUCH_11_6) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CAND=
O_MULTI_TOUCH_15_6) },
>> @@ -1312,6 +1313,7 @@ static const struct hid_device_id hid_blacklis=
t[] =3D {
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_G=
YRATION_REMOTE) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_G=
YRATION_REMOTE_2) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_G=
YRATION_REMOTE_3) },
>> + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_HANVON, USB_DEVICE_ID_HANVO=
N_MULTITOUCH) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID=
_KS_SLIMBLADE) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ER=
GO_525V) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LAB=
TEC_WIRELESS_KEYBOARD) },
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 0f150c7..17b444b 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -134,6 +134,7 @@
>> =A0#define USB_DEVICE_ID_BTC_EMPREX_REMOTE_2 =A0 =A00x5577
>>
>> =A0#define USB_VENDOR_ID_CANDO =A0 =A0 =A0 =A0 =A00x2087
>> +#define USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH 0x0703
>> =A0#define USB_DEVICE_ID_CANDO_MULTI_TOUCH =A0 =A0 =A00x0a01
>> =A0#define USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6 0x0b03
>> =A0#define USB_DEVICE_ID_CANDO_MULTI_TOUCH_15_6 0x0f01
>> @@ -306,6 +307,9 @@
>> =A0#define USB_DEVICE_ID_HANWANG_TABLET_FIRST =A0 0x5000
>> =A0#define USB_DEVICE_ID_HANWANG_TABLET_LAST =A0 =A00x8fff
>>
>> +#define USB_VENDOR_ID_HANVON =A0 =A0 =A0 =A0 0x20b3
>> +#define USB_DEVICE_ID_HANVON_MULTITOUCH =A0 =A0 =A00x0a18
>> +
>> =A0#define USB_VENDOR_ID_HAPP =A0 =A0 =A0 =A0 =A0 0x078b
>> =A0#define USB_DEVICE_ID_UGCI_DRIVING =A0 0x0010
>> =A0#define USB_DEVICE_ID_UGCI_FLYING =A0 =A00x0020
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> new file mode 100644
>> index 0000000..aea0e32
>> --- /dev/null
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -0,0 +1,434 @@
>> +/*
>> + * =A0HID driver for multitouch panels
>> + *
>> + * =A0Copyright (c) 2010-2011 Stephane Chatty <chatty@enac.fr>
>> + * =A0Copyright (c) 2010-2011 Benjamin Tissoires <benjamin.tissoire=
s@gmail.com>
>> + * =A0Copyright (c) 2010-2011 Enac
>> + *
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License as published b=
y the Free
>> + * Software Foundation; either version 2 of the License, or (at you=
r option)
>> + * any later version.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/hid.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/usb.h>
>> +#include <linux/input/mt.h>
>> +#include "usbhid/usbhid.h"
>> +
>> +
>> +MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
>> +MODULE_DESCRIPTION("HID multitouch panels");
>> +MODULE_LICENSE("GPL");
>> +
>> +#include "hid-ids.h"
>> +
>> +
>> +struct mt_slot {
>> + =A0 =A0 __s32 x, y, p;
>> + =A0 =A0 __s32 contactid; =A0 =A0 =A0 =A0/* the device ContactID as=
signed to this slot */
>> + =A0 =A0 __u16 trkid; =A0 =A0/* the tracking ID that was assigned t=
o this slot */
>> + =A0 =A0 bool valid; =A0 =A0 /* did we just get valid contact data =
for this slot? */
>> + =A0 =A0 bool prev_valid;/* was this slot previously valid/active? =
*/
>> +};
>
> The trkid and prev_valid are no longer needed. The touch state seems =
to be missing.

Concerning the trkid, agree.
I can assure you that prev_valid is needed by at least the Cypress
device. In a sense, it has the same problem than mt protocol A: it
does not send the release information except when the last finger has
been released. This gymnastic is thus required.

I think that the misunderstanding comes from the name. We have this 2
flags (valid and prev_valid) to tell whether the device sent data
during this report or the previous one. It's not the same meaning that
the touch you're talking about. For Cypress device, those 2 flags are
mandatory.

Maybe introducing data + prev_data + touch (3 flags instead of 2->
touch can go into mt_buffer, and data and prev_data only in mt_slot as
they are not given by the device) is clearer.


>
>> +
>> +struct mt_buffer {
>> + =A0 =A0 __s32 x, y, p;
>> + =A0 =A0 __s32 contactid; =A0 =A0 =A0 =A0/* the device ContactID as=
signed to this slot */
>> +};
>
> The only different to mt_slot are the valid and touch field, which is
> also needed for incoming data. I'd say those should be merged.
>

Well, the point is that the buffer and the slot have 2 different meanin=
gs:
one is the incoming data, the other is the processed data. It strikes
us to have only one struct as the slot contains extra information for
it to be processed.

>> +
>> +struct mt_device {
>> + =A0 =A0 struct mt_buffer curdata; =A0 =A0 =A0 /* placeholder of in=
coming data */
>> + =A0 =A0 struct mt_class *mtclass; =A0 =A0 =A0 /* our mt device cla=
ss */
>> + =A0 =A0 unsigned last_field_index; =A0 =A0 =A0/* last field index =
of the report */
>> + =A0 =A0 unsigned last_slot_field; =A0 =A0 =A0 /* the last field of=
 a slot */
>> + =A0 =A0 __u16 lasttrkid; =A0 =A0 =A0 =A0/* the last tracking ID we=
 assigned */
>
> No longer needed.

agree (I must have read your patch too quickly).

>
>> + =A0 =A0 __s8 inputmode; =A0 =A0 =A0 =A0 /* InputMode HID feature, =
-1 if non-existent */
>> + =A0 =A0 __u8 num_received; =A0 =A0 =A0/* how many contacts we rece=
ived */
>> + =A0 =A0 __u8 maxcontact; =A0 =A0 =A0 =A0/* expected last contact i=
ndex */
>> + =A0 =A0 bool curvalid; =A0 =A0 =A0 =A0 =A0/* is the current contac=
t valid? */
>
> This value should probably be a mt_slot struct as well.

I was bothering too. Renaming the field (see above) may solve the
problem: we have curvalid (or curdata with the name I propose) which
is only needed for algorithm reasons, and touch that goes into
mt_buffer as it comes from the device.

>
>> + =A0 =A0 struct mt_slot slots[0]; =A0 =A0 =A0 =A0/* first slot */
>> +};
>> +
>> +struct mt_class {
>> + =A0 =A0 int (*compute_slot)(struct mt_device *);
>> + =A0 =A0 __u8 maxcontacts;
>> +};
>
> I imagine maxcontacts could be variable for devices within the same
> class. Perhaps it should be a member of the device instead? The
> resolution and fuzz could be added here as well.

resolution and fuzz: I let you implement it (when adding egalax or
3m). But isn't it something we can't get from the report descriptors?

concerning the device vs. class, currently, we have only seen classes
(one or more device sharing the same behavior), but we didn't bother
about resolution and fuzz.
It would be a shame to have to duplicate the mt_class (or mt_device),
one by vendorID/deviceID, as many devices may share the same
properties (at least those that have been manufactured by the same
company and that behave the same way: cando, stantum, etc...).
I also like the concept of default class as it will help people easily
adding devices.

>
>> +
>> +/* classes of device behavior */
>> +#define MT_CLS_DEFAULT 0
>> +#define MT_CLS_DUAL1 1
>> +
>> +/*
>> + * these device-dependent functions determine what slot corresponds
>> + * to a valid contact that was just read.
>> + */
>> +
>> +static int slot_is_contactid(struct mt_device *td)
>> +{
>> + =A0 =A0 return td->curdata.contactid;
>> +}
>> +
>> +static int find_slot_from_contactid(struct mt_device *td)
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (td->slots[i].prev_valid &&
>
> Why prev_valid? Ought to be valid, right?

Because the code resets valid after each sending -> implementation depe=
ndent.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->slots[i].contactid =3D=
=3D td->curdata.contactid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
>> + =A0 =A0 }
>> + =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!td->slots[i].valid && !td->slots[i].p=
rev_valid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
>
> Simplifaction here too without the prev_valid.

Related to current implementation too

>
>> + =A0 =A0 }
>> + =A0 =A0 return -1; /* should not occurs */
>
> And what should happen if it does?

good question. This would means that the device sent more touches that
it says in the report descriptor. It is ignored then.
Will add a comment.

>
>> +}
>> +
>> +struct mt_class mt_classes[] =3D {
>> + =A0 =A0 { find_slot_from_contactid, 10 }, =A0 =A0 /* MT_CLS_DEFAUL=
T */
>> + =A0 =A0 { slot_is_contactid, 2 }, =A0 =A0 =A0 =A0 =A0 =A0 /* MT_CL=
S_DUAL1 */
>> +};
>
> It seems likely that this will become a device-specific list, rather =
than classes.

see above. Maybe we should add this patch with classes, and when
resolution and fuzz are added, we may turn it into devices if
required.

>
>> +
>> +static void mt_feature_mapping(struct hid_device *hdev, struct hid_=
input *hi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, struct hid_usage =
*usage)
>> +{
>> + =A0 =A0 if (usage->hid =3D=3D HID_DG_INPUTMODE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct mt_device *td =3D hid_get_drvdata(h=
dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 td->inputmode =3D field->report->id;
>> + =A0 =A0 }
>> +}
>> +
>> +static int mt_input_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, struct hid_usage =
*usage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long **bit, int *max)
>> +{
>> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> + =A0 =A0 switch (usage->hid & HID_USAGE_PAGE) {
>> +
>> + =A0 =A0 case HID_UP_GENDESK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_X:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EV_ABS, ABS_MT_POSITION_X);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(hi->i=
nput, ABS_MT_POSITION_X,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 field->logical_minimum,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 field->logical_maximum, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulation *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(hi->i=
nput, ABS_X,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 field->logical_minimum,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 field->logical_maximum, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_Y:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EV_ABS, ABS_MT_POSITION_Y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(hi->i=
nput, ABS_MT_POSITION_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 field->logical_minimum,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 field->logical_maximum, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulation *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(hi->i=
nput, ABS_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 field->logical_minimum,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 field->logical_maximum, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> Nice solution to the end-of-data issue. It would be good if the input
> setup was abstracted into a function like in hid-egalax, to simplify
> further additions.

thanks.
I was not very happy in making this abstraction for just one line of
code. I thought you could do it when adding the additions.

>
>> +
>> + =A0 =A0 case HID_UP_DIGITIZER:
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_INRANGE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONFIDENCE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>
> The inrange field has meaning for some drivers, I think these should =
be split.

if you want.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max, EV_KEY, BTN_TOUCH);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(hi->i=
nput, EV_KEY, BTN_TOUCH);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTID:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!hi->input->mt)
>
> This test can be dropped now.

will do

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_i=
nit_slots(hi->input,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 td->mtclass->maxcontacts);
>
> Maxcontacts should probably take the hid description into account as =
well.

I don't understand your point here

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPPRESSURE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EV_ABS, ABS_MT_PRESSURE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>
> And ABS_PRESSURE.

I thought that the mouse emulation was restricted to X and Y.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTCOUNT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D f=
ield->report->maxfield - 1;
>
> A fall-through here does not seem very useful.

ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTMAX:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we don't set td->last_s=
lot_field as contactcount and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* contact max are globa=
l to the report */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* let hid-input decide for the others */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 case 0xff000000:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* we do not want to map these: no input-o=
riented meaning */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int mt_input_mapped(struct hid_device *hdev, struct hid_inpu=
t *hi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, struct hid_usage =
*usage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long **bit, int *max)
>> +{
>> + =A0 =A0 if (usage->type =3D=3D EV_KEY || usage->type =3D=3D EV_ABS=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_bit(usage->type, hi->input->evbit);
>> +
>> + =A0 =A0 return -1;
>> +}
>
> There are some hid drivers that need to setup fuzz in order to work
> properly. We should either add it to hid core or use the same bypass =
as
> in hid-egalax and hid-3m-pct.

Can I let you do this in further updates? (for the new devices and
those I sent, this works out of the box)

>
>> +
>> +/*
>> + * this function is called when a whole contact has been processed,
>> + * so that it can assign it to a slot and store the data there
>> + */
>> +static void mt_complete_slot(struct mt_device *td)
>> +{
>> + =A0 =A0 if (td->curvalid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct mt_slot *slot;
>> + =A0 =A0 =A0 =A0 =A0 =A0 int slotnum =3D td->mtclass->compute_slot(=
td);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (slotnum >=3D 0 && slotnum <=3D td->mtc=
lass->maxcontacts - 1) {
>
> Please use "< maxcontacts".

oops

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot =3D td->slots + slotn=
um;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot->valid =3D true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(slot, &(td->curdata=
), sizeof(struct mt_buffer));
>
> Valid is not always true for sure, and touch should be in here as
> well. A simple copy of the current data into the right slot will
> suffice - the validity will be copied too.

see curvalid/valid/prev_valid proposal above

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 td->num_received++;
>> +}
>> +
>> +
>> +/*
>> + * this function is called when a whole packet has been received an=
d processed,
>> + * so that it can decide what to send to the input layer.
>> + */
>> +static void mt_emit_event(struct mt_device *td, struct input_dev *i=
nput)
>> +{
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct mt_slot *s =3D &(td->slots[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!s->valid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* this slot does not co=
ntain useful data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* notify its closure if=
 necessary
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->prev_valid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_s=
lot(input, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_r=
eport_slot_state(input,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 MT_TOOL_FINGER, false);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->prev_va=
lid =3D false;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!s->prev_valid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->trkid =3D td->lasttrkid=
++;
>
> Most of the above can be removed.

Cypress device does not sends touch information when a touch is
released. This piece of code is required for devices that behave the
same way.

>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TOOL_=
=46INGER, true);
>
> "true" here should simply be slot->touch state.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_POSITION=
_X, s->x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_POSITION=
_Y, s->y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_PRESSURE=
, s->p);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s->prev_valid =3D true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 s->valid =3D false;
>
> Invalidating the data of a tracked slots seems wrong. If the device
> sends tracked data properly, no special consideration is needed - it
> will get cleared when appropriate. Other cases could be dealt with
> separately.

already discussed (pb in naming the fields I think)

>
>> +
>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_mt_report_pointer_emulation(input, true);
>> + =A0 =A0 input_sync(input);
>> + =A0 =A0 td->num_received =3D 0;
>> +}
>> +
>> +
>> +
>> +static int mt_event(struct hid_device *hid, struct hid_field *field=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid=
_usage *usage, __s32 value)
>> +{
>> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hid);
>> +
>> + =A0 =A0 if (hid->claimed & HID_CLAIMED_INPUT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_INRANGE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> Egalax uses this field as validity.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curvalid =3D value;
>
> Most drivers seem to use this as touch state.

agree and that is how it is used in the current implementation. We
really should change the name.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONFIDENCE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTID:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curdata.contactid =3D =
value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPPRESSURE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curdata.p =3D value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_X:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curdata.x =3D value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_Y:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curdata.y =3D value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTCOUNT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We must not overwrite=
 the previous value (some
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* devices send one sequ=
ence splitted over several
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* messages)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->maxcon=
tact =3D value - 1;
>
> Is td->maxcontact ever reset? And why not num_expected or something
> instead of maxcontact - odd semantics.

maxcontact is not reset (not needed as it is sent in each report).
Concerning the name, agree.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTMAX:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> This one was filtered already.

ok

>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fallback to the generic=
 hidinput handling */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (usage->hid =3D=3D td->last_slot_field)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mt_complete_slot(td);
>> +
>> + =A0 =A0 if (field->index =3D=3D td->last_field_index
>> + =A0 =A0 =A0 =A0 =A0 =A0 && td->num_received > td->maxcontact) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct input_dev *input =3D field->hidinpu=
t->input;
>
> No need to declare a temp variable for one access.

bad refactoring, will change

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 mt_emit_event(td, input);
>
> Resetting expected countact count here would be good.

if you want, but not really needed.

>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* we have handled the hidinput part, now remains hiddev *=
/
>> + =A0 =A0 if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_e=
vent)
>> + =A0 =A0 =A0 =A0 =A0 =A0 hid->hiddev_hid_event(hid, field, usage, v=
alue);
>> +
>> + =A0 =A0 return 1;
>> +}
>> +
>> +static void mt_set_input_mode(struct hid_device *hdev)
>> +{
>> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> + =A0 =A0 struct hid_report *r;
>> + =A0 =A0 struct hid_report_enum *re;
>> +
>> + =A0 =A0 if (td->inputmode < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 re =3D &(hdev->report_enum[HID_FEATURE_REPORT]);
>> + =A0 =A0 r =3D re->report_id_hash[td->inputmode];
>> + =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 r->field[0]->value[0] =3D 0x02;
>> + =A0 =A0 =A0 =A0 =A0 =A0 usbhid_submit_report(hdev, r, USB_DIR_OUT)=
;
>> + =A0 =A0 }
>> +}
>
> Nice reduction.

thanks ;)

Cheers,
Benjamin

>
>> +
>> +static int mt_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 struct mt_device *td;
>> + =A0 =A0 struct mt_class *mtclass =3D mt_classes + id->driver_data;
>> +
>> + =A0 =A0 /* This allows the driver to correctly support devices
>> + =A0 =A0 =A0* that emit events over several HID messages.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 hdev->quirks |=3D HID_QUIRK_NO_INPUT_SYNC;
>> +
>> + =A0 =A0 td =3D kzalloc(sizeof(struct mt_device) +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtclass->m=
axcontacts * sizeof(struct mt_slot),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL=
);
>> + =A0 =A0 if (!td) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev, "cannot allocate multi=
touch data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> + =A0 =A0 td->mtclass =3D mtclass;
>> + =A0 =A0 td->inputmode =3D -1;
>> + =A0 =A0 hid_set_drvdata(hdev, td);
>> +
>> + =A0 =A0 ret =3D hid_parse(hdev);
>> + =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> +
>> + =A0 =A0 ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>> + =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> +
>> + =A0 =A0 mt_set_input_mode(hdev);
>> +
>> + =A0 =A0 return 0;
>> +
>> +fail:
>> + =A0 =A0 kfree(td);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int mt_reset_resume(struct hid_device *hdev)
>> +{
>> + =A0 =A0 mt_set_input_mode(hdev);
>> + =A0 =A0 return 0;
>> +}
>> +#endif
>> +
>> +static void mt_remove(struct hid_device *hdev)
>> +{
>> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> + =A0 =A0 hid_hw_stop(hdev);
>> + =A0 =A0 kfree(td);
>> + =A0 =A0 hid_set_drvdata(hdev, NULL);
>> +}
>> +
>> +static const struct hid_device_id mt_devices[] =3D {
>> +
>> + =A0 =A0 /* PixCir-based panels */
>> + =A0 =A0 { .driver_data =3D MT_CLS_DUAL1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_HANVON_MULTI=
TOUCH) },
>> + =A0 =A0 { .driver_data =3D MT_CLS_DUAL1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_CANDO_PIXCIR=
_MULTI_TOUCH) },
>> +
>> + =A0 =A0 { }
>> +};
>> +MODULE_DEVICE_TABLE(hid, mt_devices);
>> +
>> +static const struct hid_usage_id mt_grabbed_usages[] =3D {
>> + =A0 =A0 { HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
>> + =A0 =A0 { HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
>> +};
>> +
>> +static struct hid_driver mt_driver =3D {
>> + =A0 =A0 .name =3D "hid-multitouch",
>> + =A0 =A0 .id_table =3D mt_devices,
>> + =A0 =A0 .probe =3D mt_probe,
>> + =A0 =A0 .remove =3D mt_remove,
>> + =A0 =A0 .input_mapping =3D mt_input_mapping,
>> + =A0 =A0 .input_mapped =3D mt_input_mapped,
>> + =A0 =A0 .feature_mapping =3D mt_feature_mapping,
>> + =A0 =A0 .usage_table =3D mt_grabbed_usages,
>> + =A0 =A0 .event =3D mt_event,
>> +#ifdef CONFIG_PM
>> + =A0 =A0 .reset_resume =3D mt_reset_resume,
>> +#endif
>> +};
>> +
>> +static int __init mt_init(void)
>> +{
>> + =A0 =A0 return hid_register_driver(&mt_driver);
>> +}
>> +
>> +static void __exit mt_exit(void)
>> +{
>> + =A0 =A0 hid_unregister_driver(&mt_driver);
>> +}
>> +
>> +module_init(mt_init);
>> +module_exit(mt_exit);
>> --
>> 1.7.3.4
>>
>
> Thanks,
> Henrik
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
