From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v3 3/5] hid-multitouch: support for PixCir-based panels
Date: Mon, 10 Jan 2011 20:10:33 +0100
Message-ID: <AANLkTin8tHO5x2SBugSaEQ6mJ-7upS2YX9OANK1phmdM@mail.gmail.com>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294425762-29730-4-git-send-email-benjamin.tissoires@enac.fr>
	<20110107194918.GB29913@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32879 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab1AJTKf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 14:10:35 -0500
In-Reply-To: <20110107194918.GB29913@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 7, 2011 at 8:49 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> On Fri, Jan 07, 2011 at 07:42:40PM +0100, Benjamin Tissoires wrote:
>> Created a driver for PixCir based dual-touch panels, including the o=
ne
>> in the Hanvon tablet. =A0This is done in a code structure aimed at u=
nifying
>> support for several existing HID multitouch panels.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> Signed-off-by: St=E9phane Chatty <chatty@enac.fr>
>> ---
>
> It looks much better now. Just a few comments and some nit-picks inli=
ne.
>
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A09 +
>> =A0drivers/hid/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 =A02 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A04 +
>> =A0drivers/hid/hid-multitouch.c | =A0468 +++++++++++++++++++++++++++=
+++++++++++++++
>> =A05 files changed, 484 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hid/hid-multitouch.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 401acec..511554d 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -285,6 +285,15 @@ config HID_MONTEREY
>> =A0 =A0 =A0 ---help---
>> =A0 =A0 =A0 Support for Monterey Genius KB29E.
>>
>> +config HID_MULTITOUCH
>> + =A0 =A0 tristate "HID Multitouch panels"
>> + =A0 =A0 depends on USB_HID
>> + =A0 =A0 ---help---
>> + =A0 =A0 =A0 Generic support for HID multitouch panels.
>> +
>> + =A0 =A0 =A0 Say Y here if you have one of the following devices:
>> + =A0 =A0 =A0 - PixCir touchscreen
>
> Should also mention how to compile as module, and what the module wil=
l be called.

ok, will do in v4

>
>> +
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
>> index 0000000..3b05dfe
>> --- /dev/null
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -0,0 +1,468 @@
>> +/*
>> + * =A0HID driver for multitouch panels
>> + *
>> + * =A0Copyright (c) 2010-2011 Stephane Chatty <chatty@enac.fr>
>> + * =A0Copyright (c) 2010-2011 Benjamin Tissoires <benjamin.tissoire=
s@gmail.com>
>> + * =A0Copyright (c) 2010-2011 Ecole Nationale de l'Aviation Civile,=
 France
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
>> +/* quirks to control the device */
>> +#define MT_QUIRK_NOT_SEEN_MEANS_UP =A0 (1 << 0)
>> +#define MT_QUIRK_SLOT_IS_CONTACTID =A0 (1 << 1)
>> +
>> +struct mt_slot {
>> + =A0 =A0 __s32 x, y, p, w, h;
>> + =A0 =A0 __s32 contactid; =A0 =A0 =A0 =A0/* the device ContactID as=
signed to this slot */
>> + =A0 =A0 bool touch_state; =A0 =A0 =A0 /* is the touch valid? */
>> + =A0 =A0 bool seen_in_this_frame;/* has this slot been updated */
>> +};
>> +
>> +struct mt_device {
>> + =A0 =A0 struct mt_slot curdata; /* placeholder of incoming data */
>> + =A0 =A0 struct mt_class *mtclass; =A0 =A0 =A0 /* our mt device cla=
ss */
>> + =A0 =A0 unsigned last_field_index; =A0 =A0 =A0/* last field index =
of the report */
>> + =A0 =A0 unsigned last_slot_field; =A0 =A0 =A0 /* the last field of=
 a slot */
>> + =A0 =A0 __s8 inputmode; =A0 =A0 =A0 =A0 /* InputMode HID feature, =
-1 if non-existent */
>> + =A0 =A0 __u8 num_received; =A0 =A0 =A0/* how many contacts we rece=
ived */
>> + =A0 =A0 __u8 num_expected; =A0 =A0 =A0/* expected last contact ind=
ex */
>
> Any particular reason these are u8?

Just because we don't need s32 here.

>
>> + =A0 =A0 bool curvalid; =A0 =A0 =A0 =A0 =A0/* is the current contac=
t valid? */
>> + =A0 =A0 struct mt_slot slots[0]; =A0 =A0 =A0 =A0/* first slot */
>> +};
>> +
>> +struct mt_class {
>> + =A0 =A0 __s32 quirks;
>> + =A0 =A0 __s32 sn_move; =A0/* Signal/noise ratio for move events */
>> + =A0 =A0 __s32 sn_pressure; =A0 =A0 =A0/* Signal/noise ratio for pr=
essure events */
>> + =A0 =A0 __u8 maxcontacts;
>
> Same here - its not like we allocate a million of these anyways. Simp=
le ints should do fine.
>
>> +};
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (td->slots[i].contactid =3D=3D td->curd=
ata.contactid &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->slots[i].touch_state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
>> + =A0 =A0 }
>> + =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!td->slots[i].seen_in_this_frame &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !td->slots[i].touch_state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
>> + =A0 =A0 }
>> + =A0 =A0 return -1;
>> + =A0 =A0 /* should not occurs. If this happens that means
>> + =A0 =A0 =A0* that the device sent more touches that it says
>> + =A0 =A0 =A0* in the report descriptor. It is ignored then. */
>
> I would put the comment above the return statement.

ack.

>
>> +}
>> +
>> +struct mt_class mt_classes[] =3D {
>> + =A0 =A0 { 0, 0, 0, 10 }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 /* MT_CLS_DEFAULT */
>> + =A0 =A0 { MT_QUIRK_SLOT_IS_CONTACTID, 0, 0, 2 }, =A0 =A0 /* MT_CLS=
_DUAL1 */
>> +};
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
>> +static void set_abs(struct input_dev *input, unsigned int code,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, int snratio)
>> +{
>> + =A0 =A0 int fmin =3D field->logical_minimum;
>> + =A0 =A0 int fmax =3D field->logical_maximum;
>> + =A0 =A0 int fuzz =3D snratio ? (fmax - fmin) / snratio : 0;
>> + =A0 =A0 input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
>> +}
>> +
>> +static int mt_input_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, struct hid_usage =
*usage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long **bit, int *max)
>> +{
>> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> + =A0 =A0 struct mt_class *cls =3D td->mtclass;
>> + =A0 =A0 switch (usage->hid & HID_USAGE_PAGE) {
>> +
>> + =A0 =A0 case HID_UP_GENDESK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_X:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EV_ABS, ABS_MT_POSITION_X);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_MT_=
POSITION_X, field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_mo=
ve);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulation *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_X, =
field, cls->sn_move);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_Y:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EV_ABS, ABS_MT_POSITION_Y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_MT_=
POSITION_Y, field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_mo=
ve);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulation *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_Y, =
field, cls->sn_move);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 case HID_UP_DIGITIZER:
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_INRANGE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONFIDENCE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max, EV_KEY, BTN_TOUCH);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(hi->i=
nput, EV_KEY, BTN_TOUCH);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTID:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(hi->in=
put,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 td->mtclass->maxcontacts);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_WIDTH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EV_ABS, ABS_MT_TOUCH_MAJOR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_HEIGHT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EV_ABS, ABS_MT_TOUCH_MINOR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_maximum =3D=
 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_minimum =3D=
 1;
>
> minimum should be zero here.

Maybe a typo in the original code: we hade set_abs_input_param(..., 1,1=
,0,0).
I just reorganized.

Changed in v4.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_MT_=
ORIENTATION, field, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPPRESSURE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, b=
it, max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EV_ABS, ABS_MT_PRESSURE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_MT_=
PRESSURE, field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_pr=
essure);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulation *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_PRE=
SSURE, field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_pr=
essure);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTCOUNT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D f=
ield->report->maxfield - 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
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
>> +
>> +static int mt_compute_slot(struct mt_device *td)
>> +{
>> + =A0 =A0 struct mt_class *cls =3D td->mtclass;
>> +
>> + =A0 =A0 if (cls->quirks & MT_QUIRK_SLOT_IS_CONTACTID)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return slot_is_contactid(td);
>
> No real need for a function call here...

just to prepare for the other patches

>
>> +
>> + =A0 =A0 return find_slot_from_contactid(td);
>> +}
>> +
>> +/*
>> + * this function is called when a whole contact has been processed,
>> + * so that it can assign it to a slot and store the data there
>> + */
>> +static void mt_complete_slot(struct mt_device *td)
>> +{
>
> Adding "td->curdata.seen_in_this_frame =3D true;" here...
>
>> + =A0 =A0 if (td->curvalid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct mt_slot *slot;
>
> Skipping this...
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 int slotnum =3D mt_compute_slot(td);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (slotnum >=3D 0 && slotnum < td->mtclas=
s->maxcontacts) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot =3D td->slots + slotn=
um;
>
> and this...
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(slot, &(td->curdata=
), sizeof(struct mt_slot));
>
> and "td->slots[slotnum] =3D td->curdata" here...
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot->seen_in_this_frame =3D=
 true;
>
> and dropping this... looks simpler, ne?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 td->num_received++;
>> +}
>
> Writing it explicitly here so you can judge for yourself:
>
> =A0 =A0 =A0 =A0td->curdata.seen_in_this_frame =3D true;
> =A0 =A0 =A0 =A0if (td->curvalid) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int slot =3D mt_compute_slot(td);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (slot >=3D 0 && slot < td->mtclass-=
>maxcontacts)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->slots[slot] =3D td=
->curdata;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0td->num_received++;

arg. Elementary C: struct are passed by value. snif.
I'll take your code.

>
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((td->mtclass->quirks & MT_QUIRK_NOT_SE=
EN_MEANS_UP) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !s->seen_in_this_frame) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* this slot does not co=
ntain useful data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* notify its closure
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>
> It does contain useful data, it is just assumed to be in the up
> state. I would drop the comment and the brackets here, the quirk name
> speaks for itself.

We can drop the comment if you want.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->touch_state =3D false;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TOOL_=
=46INGER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->touch_state);
>
> The values below should not be updated for an inactive slot.

ack.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_POSITION=
_X, s->x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_POSITION=
_Y, s->y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_PRESSURE=
, s->p);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_TOUCH_MA=
JOR, s->w);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_TOUCH_MI=
NOR, s->h);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s->seen_in_this_frame =3D false;
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curvalid =3D value;
>
> I do not think curvalid should depend on the touch state (which is
> what tipswitch is). Either move to INRANGE, or simply set to true.

INRANGE is not all the time used as curvalid as you are saying.
At least for Stantum, curvalid is given by CONFIDENCE.

The solution of giving the value true to curvalid is not working too:
Cypress devices can send their touches over 2 reports of 7 touches,
even if it handles 10 touches.

Solution:
1) td->curvalid =3D td->num_received < td->mtclass->maxcontacts;
(not sure it will work for all devices)

or 2) introduce MT_QUIRK_VALID_IS_INRANGE and MT_QUIRK_VALID_IS_CONFIDE=
NCE

or 3) let curvalid=3Dvalue and disable the quirk
MT_QUIRK_NOT_SEEN_MEANS_UP (adding a FixMe comment above)

=46or v4, I'll use solution 3 (safer for 2.6.38 and after)

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curdata.touch_state =3D=
 value;
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_WIDTH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curdata.w =3D value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_HEIGHT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curdata.h =3D value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTCOUNT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We must not overwrite=
 the previous value (some
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* devices send one sequ=
ence splitted over several
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* messages)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>
> How about "Includes multi-packet support where subsequent packets are=
 sent with zero contactcount."

if you want

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->num_ex=
pected =3D value - 1;
>
> The - 1 should be dropped here.

Here is the really tricky one:

if I drop -1,

the test below will be:
 if (field->index =3D=3D td->last_field_index
=A0 =A0 =A0 && td->num_received >=3D td->num_expected)

but during the init of the device, the kernel receive 1 event though
the driver is not ready.

During this time, num_expected is at 0, and when we receive the
last_field_index: segfault!

To sum up, no, we can't.


>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 && td->num_received > td->num_expected)
>
> A ">=3D" here.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 mt_emit_event(td, field->hidinput->input);
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
>
> "if (ret)" is very standard.

ok

>
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
> Thanks!
> Henrik


Thanks for the review,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
