From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Wed, 9 Mar 2011 09:54:02 +0100
Message-ID: <AANLkTikDBTFNWhYoR5B-kfZ8Ud_aiW36qrTNJsJgHdTJ@mail.gmail.com>
References: <1299417912.9645.495.camel@itzy>
	<AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
	<1299564524.2306.18.camel@itzy>
	<20110308080414.GA2888@polaris.bitmath.org>
	<AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
	<20110308091434.GA3282@polaris.bitmath.org>
	<AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
	<20110308094630.GA3396@polaris.bitmath.org>
	<1299627518.2306.47.camel@itzy>
	<20110309082455.GA3166@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56053 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab1CIIyE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2011 03:54:04 -0500
Received: by wya21 with SMTP id 21so238661wya.19
        for <linux-input@vger.kernel.org>; Wed, 09 Mar 2011 00:54:02 -0800 (PST)
In-Reply-To: <20110309082455.GA3166@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Hi Henrik,

On Wed, Mar 9, 2011 at 09:24, Henrik Rydberg <rydberg@euromail.se> wrot=
e:
> Hi Richard,
>
>> here is the third version of this patch, improved according to your =
suggestions.
>>
>> > What I meant is that (min_x < max_x) is the proper test.
>> >
>> > > No need for a quirk that will be redundant with the hand-provide=
d values.
>> >
>> > Yes, but I think we might be better off using a quirk than a gener=
ic
>> > way to replace the values provided by the hardware.
>>
>> My personal opinion is that the override should be triggered by your
>> (min_x < max_x) test, which is safe, because the (min_x =3D=3D max_x=
) case
>> makes no sense for a device and we are allowed to attach a special
>> meaning to it. Additionally this enables us to conveniently extend t=
he
>> mechanism to more axis, whose could be individually enabled without =
a
>> bloat of quirk defines.
>>
>> So tell me what you think of this...
>
> Having a mechanism to override device limits suggests this is
> generally needed, which is not the case. Adding a specific quirk for
> this specific hardware seems more appropriate. Also, it seems the
> special behavior of the newer firmwares can be autodetected, so there
> is no need for more than one class. I have added two patches below,
> tested on a joojoo. Do you concur with the changes, and do they still
> work for you?
>

I really like your approach:
for the newer firmwares, it can be autodetected -> no quirk
for the fixes in ranges, as it is autodetected in the previous patch
by the values given by the programmer -> insert a quirk.

You really know what you want! ;)

> From 67fd1e768341a8f67cd882b7603de62b5f250970 Mon Sep 17 00:00:00 200=
1
> From: Henrik Rydberg <rydberg@euromail.se>
> Date: Wed, 9 Mar 2011 06:35:25 +0100
> Subject: [PATCH 1/2] HID: hid-multitouch: Send events per slot if CON=
TACTCOUNT is missing
>
> The recent capacitive DWAV firmwares do not use the CONTACTCOUNT
> field, and the touch frame boundary can therefore not be determined.
> This patch makes the driver report the touch frame at each completed
> slot instead.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/hid/hid-multitouch.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 69f8744..4518006 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -364,8 +364,11 @@ static int mt_event(struct hid_device *hid, stru=
ct hid_field *field,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (usage->hid =3D=3D td->last_slot_fie=
ld)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (usage->hid =3D=3D td->last_slot_fie=
ld) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mt_complete_slot(td);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!td->last_field_ind=
ex)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_emit=
_event(td, field->hidinput->input);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

=46ine with me

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (field->index =3D=3D td->last_field=
_index
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& td->num_received >=3D=
 td->num_expected)
> --
> 1.7.4.1
>
> From cd625e954a7f9774ae8f84a9eb2315c6da8b387c Mon Sep 17 00:00:00 200=
1
> From: Richard Nauber <richard.nauber@googlemail.com>
> Date: Wed, 9 Mar 2011 06:20:57 +0100
> Subject: [PATCH 2/2] HID: merge hid-egalax into hid-multitouch
>
> This patch merges the hid-egalax driver into hid-multitouch. =A0There
> are two types of devices support by the hid-egalax driver: resistive
> and capacitive. Here, they are implicitly distinguished by the absenc=
e
> of a HID_DG_CONTACTCOUNT field in the latter, so no special code path
> needs to be introduced.
>
> As a side effect, this patch fixes the broken suspend/resume behavior
> in the old driver.
>
> [rydberg@euromail.se: minor fixups]
> Not-yet-Signed-off-by: Richard Nauber <Richard.Nauber@gmail.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A09 +-
> =A0drivers/hid/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0drivers/hid/hid-egalax.c =A0 =A0 | =A0279 ------------------------=
------------------
> =A0drivers/hid/hid-multitouch.c | =A0 43 +++++++
> =A04 files changed, 45 insertions(+), 287 deletions(-)
> =A0delete mode 100644 drivers/hid/hid-egalax.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index a0b117d..b4b8b21 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -160,13 +160,6 @@ config HID_EMS_FF
> =A0 =A0 =A0 =A0Currently the following devices are known to be suppor=
ted:
> =A0 =A0 =A0 =A0 - Trio Linker Plus II
>
> -config HID_EGALAX
> - =A0 =A0 =A0 tristate "eGalax multi-touch panel"
> - =A0 =A0 =A0 depends on USB_HID
> - =A0 =A0 =A0 ---help---
> - =A0 =A0 =A0 Support for the eGalax dual-touch panels, including the
> - =A0 =A0 =A0 Joojoo and Wetab tablets.
> -
> =A0config HID_ELECOM
> =A0 =A0 =A0 =A0tristate "ELECOM BM084 bluetooth mouse"
> =A0 =A0 =A0 =A0depends on BT_HIDP
> @@ -307,6 +300,8 @@ config HID_MULTITOUCH
> =A0 =A0 =A0 =A0 =A0- IrTouch Infrared USB panels
> =A0 =A0 =A0 =A0 =A0- Pixcir dual touch panels
> =A0 =A0 =A0 =A0 =A0- 'Sensing Win7-TwoFinger' panel by GeneralTouch
> + =A0 =A0 =A0 =A0 =A0- eGalax dual-touch panels, including the
> + =A0 =A0 =A0 =A0 =A0 Joojoo and Wetab tablets
>
> =A0 =A0 =A0 =A0 =A0If unsure, say N.
>
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 6efc2a0..29e9898 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -36,7 +36,6 @@ obj-$(CONFIG_HID_CHICONY) =A0 =A0 +=3D hid-chicony.=
o
> =A0obj-$(CONFIG_HID_CYPRESS) =A0 =A0 =A0+=3D hid-cypress.o
> =A0obj-$(CONFIG_HID_DRAGONRISE) =A0 +=3D hid-drff.o
> =A0obj-$(CONFIG_HID_EMS_FF) =A0 =A0 =A0 +=3D hid-emsff.o
> -obj-$(CONFIG_HID_EGALAX) =A0 =A0 =A0 +=3D hid-egalax.o
> =A0obj-$(CONFIG_HID_ELECOM) =A0 =A0 =A0 +=3D hid-elecom.o
> =A0obj-$(CONFIG_HID_EZKEY) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D hid-ez=
key.o
> =A0obj-$(CONFIG_HID_GYRATION) =A0 =A0 +=3D hid-gyration.o
> diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
> deleted file mode 100644
> index 03bee19..0000000
> --- a/drivers/hid/hid-egalax.c
> +++ /dev/null
> @@ -1,279 +0,0 @@
> -/*
> - * =A0HID driver for eGalax dual-touch panels
> - *
> - * =A0Copyright (c) 2010 Stephane Chatty <chatty@enac.fr>
> - * =A0Copyright (c) 2010 Henrik Rydberg <rydberg@euromail.se>
> - * =A0Copyright (c) 2010 Canonical, Ltd.
> - *
> - */
> -
> -/*
> - * This program is free software; you can redistribute it and/or mod=
ify it
> - * under the terms of the GNU General Public License as published by=
 the Free
> - * Software Foundation; either version 2 of the License, or (at your=
 option)
> - * any later version.
> - */
> -
> -#include <linux/device.h>
> -#include <linux/hid.h>
> -#include <linux/module.h>
> -#include <linux/usb.h>
> -#include <linux/input/mt.h>
> -#include <linux/slab.h>
> -#include "usbhid/usbhid.h"
> -
> -MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
> -MODULE_DESCRIPTION("eGalax dual-touch panel");
> -MODULE_LICENSE("GPL");
> -
> -#include "hid-ids.h"
> -
> -#define MAX_SLOTS =A0 =A0 =A0 =A0 =A0 =A0 =A02
> -
> -/* estimated signal-to-noise ratios */
> -#define SN_MOVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04096
> -#define SN_PRESSURE =A0 =A0 =A0 =A0 =A0 =A032
> -
> -struct egalax_data {
> - =A0 =A0 =A0 int valid;
> - =A0 =A0 =A0 int slot;
> - =A0 =A0 =A0 int touch;
> - =A0 =A0 =A0 int x, y, z;
> -};
> -
> -static void set_abs(struct input_dev *input, unsigned int code,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, int sn=
ratio)
> -{
> - =A0 =A0 =A0 int fmin =3D field->logical_minimum;
> - =A0 =A0 =A0 int fmax =3D field->logical_maximum;
> - =A0 =A0 =A0 int fuzz =3D snratio ? (fmax - fmin) / snratio : 0;
> - =A0 =A0 =A0 input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
> -}
> -
> -static int egalax_input_mapping(struct hid_device *hdev, struct hid_=
input *hi,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, struct hid_usa=
ge *usage,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long **bit, int *max)
> -{
> - =A0 =A0 =A0 struct input_dev *input =3D hi->input;
> -
> - =A0 =A0 =A0 switch (usage->hid & HID_USAGE_PAGE) {
> -
> - =A0 =A0 =A0 case HID_UP_GENDESK:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_X:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_maximum =
=3D 32760;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage=
, bit, max,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EV_ABS, ABS_MT_POSITION_X);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(input, ABS_MT_P=
OSITION_X, field, SN_MOVE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulatio=
n */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(input, ABS_X, f=
ield, SN_MOVE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_Y:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_maximum =
=3D 32760;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage=
, bit, max,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EV_ABS, ABS_MT_POSITION_Y);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(input, ABS_MT_P=
OSITION_Y, field, SN_MOVE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulatio=
n */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(input, ABS_Y, f=
ield, SN_MOVE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 case HID_UP_DIGITIZER:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulatio=
n */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage=
, bit, max, EV_KEY, BTN_TOUCH);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(in=
put, EV_KEY, BTN_TOUCH);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_INRANGE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONFIDENCE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTCOUNT:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTMAX:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTID:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(inp=
ut, MAX_SLOTS);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPPRESSURE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_minimum =
=3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage=
, bit, max,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EV_ABS, ABS_MT_PRESSURE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(input, ABS_MT_P=
RESSURE, field, SN_PRESSURE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulatio=
n */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(input, ABS_PRES=
SURE, field, SN_PRESSURE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* ignore others (from other reports we won't get anywa=
y) */
> - =A0 =A0 =A0 return -1;
> -}
> -
> -static int egalax_input_mapped(struct hid_device *hdev, struct hid_i=
nput *hi,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, struct hid_usa=
ge *usage,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long **bit, int *max)
> -{
> - =A0 =A0 =A0 /* tell hid-input to skip setup of these event types */
> - =A0 =A0 =A0 if (usage->type =3D=3D EV_KEY || usage->type =3D=3D EV_=
ABS)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(usage->type, hi->input->evbit);
> - =A0 =A0 =A0 return -1;
> -}
> -
> -/*
> - * this function is called when a whole finger has been parsed,
> - * so that it can decide what to send to the input layer.
> - */
> -static void egalax_filter_event(struct egalax_data *td, struct input=
_dev *input)
> -{
> - =A0 =A0 =A0 input_mt_slot(input, td->slot);
> - =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TOOL_FINGER, td->t=
ouch);
> - =A0 =A0 =A0 if (td->touch) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_POSIT=
ION_X, td->x);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_POSIT=
ION_Y, td->y);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_PRESS=
URE, td->z);
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 input_mt_report_pointer_emulation(input, true);
> -}
> -
> -static int egalax_event(struct hid_device *hid, struct hid_field *fi=
eld,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
hid_usage *usage, __s32 value)
> -{
> - =A0 =A0 =A0 struct egalax_data *td =3D hid_get_drvdata(hid);
> -
> - =A0 =A0 =A0 /* Note, eGalax has two product lines: the first is res=
istive and
> - =A0 =A0 =A0 =A0* uses a standard parallel multitouch protocol (prod=
uct ID =3D=3D
> - =A0 =A0 =A0 =A0* 48xx). =A0The second is capacitive and uses an unu=
sual "serial"
> - =A0 =A0 =A0 =A0* protocol with a different message for each multito=
uch finger
> - =A0 =A0 =A0 =A0* (product ID =3D=3D 72xx).
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (hid->claimed & HID_CLAIMED_INPUT) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct input_dev *input =3D field->hidi=
nput->input;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_INRANGE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->valid =3D value;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONFIDENCE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* avoid interference f=
rom generic hidinput handling */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->touch =3D value;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPPRESSURE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->z =3D value;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTID:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->slot =3D clamp_val(=
value, 0, MAX_SLOTS - 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_X:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->x =3D value;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_Y:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->y =3D value;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this is the last fie=
ld in a finger */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (td->valid)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 egalax_=
filter_event(td, input);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTCOUNT:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touch emulation: thi=
s is the last field in a frame */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fallback to the gene=
ric hidinput handling */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* we have handled the hidinput part, now remains hidde=
v */
> - =A0 =A0 =A0 if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hi=
d_event)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid->hiddev_hid_event(hid, field, usage=
, value);
> -
> - =A0 =A0 =A0 return 1;
> -}
> -
> -static int egalax_probe(struct hid_device *hdev, const struct hid_de=
vice_id *id)
> -{
> - =A0 =A0 =A0 int ret;
> - =A0 =A0 =A0 struct egalax_data *td;
> - =A0 =A0 =A0 struct hid_report *report;
> -
> - =A0 =A0 =A0 td =3D kzalloc(sizeof(struct egalax_data), GFP_KERNEL);
> - =A0 =A0 =A0 if (!td) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_err(hdev, "cannot allocate eGalax d=
ata\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 hid_set_drvdata(hdev, td);
> -
> - =A0 =A0 =A0 ret =3D hid_parse(hdev);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> -
> - =A0 =A0 =A0 ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> -
> - =A0 =A0 =A0 report =3D hdev->report_enum[HID_FEATURE_REPORT].report=
_id_hash[5];
> - =A0 =A0 =A0 if (report) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 report->field[0]->value[0] =3D 2;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbhid_submit_report(hdev, report, USB_=
DIR_OUT);
> - =A0 =A0 =A0 }
> -
> -end:
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(td);
> -
> - =A0 =A0 =A0 return ret;
> -}
> -
> -static void egalax_remove(struct hid_device *hdev)
> -{
> - =A0 =A0 =A0 hid_hw_stop(hdev);
> - =A0 =A0 =A0 kfree(hid_get_drvdata(hdev));
> - =A0 =A0 =A0 hid_set_drvdata(hdev, NULL);
> -}
> -
> -static const struct hid_device_id egalax_devices[] =3D {
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH1) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH2) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH3) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH4) },
> - =A0 =A0 =A0 { }
> -};
> -MODULE_DEVICE_TABLE(hid, egalax_devices);
> -
> -static const struct hid_usage_id egalax_grabbed_usages[] =3D {
> - =A0 =A0 =A0 { HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
> - =A0 =A0 =A0 { HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
> -};
> -
> -static struct hid_driver egalax_driver =3D {
> - =A0 =A0 =A0 .name =3D "egalax-touch",
> - =A0 =A0 =A0 .id_table =3D egalax_devices,
> - =A0 =A0 =A0 .probe =3D egalax_probe,
> - =A0 =A0 =A0 .remove =3D egalax_remove,
> - =A0 =A0 =A0 .input_mapping =3D egalax_input_mapping,
> - =A0 =A0 =A0 .input_mapped =3D egalax_input_mapped,
> - =A0 =A0 =A0 .usage_table =3D egalax_grabbed_usages,
> - =A0 =A0 =A0 .event =3D egalax_event,
> -};
> -
> -static int __init egalax_init(void)
> -{
> - =A0 =A0 =A0 return hid_register_driver(&egalax_driver);
> -}
> -
> -static void __exit egalax_exit(void)
> -{
> - =A0 =A0 =A0 hid_unregister_driver(&egalax_driver);
> -}
> -
> -module_init(egalax_init);
> -module_exit(egalax_exit);
> -
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 4518006..c2e79dc 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -5,6 +5,12 @@
> =A0* =A0Copyright (c) 2010-2011 Benjamin Tissoires <benjamin.tissoire=
s@gmail.com>
> =A0* =A0Copyright (c) 2010-2011 Ecole Nationale de l'Aviation Civile,=
 France
> =A0*
> + * =A0This code is partly based on hid-egalax.c:
> + *
> + * =A0Copyright (c) 2010 Stephane Chatty <chatty@enac.fr>
> + * =A0Copyright (c) 2010 Henrik Rydberg <rydberg@euromail.se>
> + * =A0Copyright (c) 2010 Canonical, Ltd.
> + *
> =A0*/
>
> =A0/*
> @@ -37,6 +43,7 @@ MODULE_LICENSE("GPL");
> =A0#define MT_QUIRK_SLOT_IS_CONTACTNUMBER (1 << 3)
> =A0#define MT_QUIRK_VALID_IS_INRANGE =A0 =A0 =A0(1 << 4)
> =A0#define MT_QUIRK_VALID_IS_CONFIDENCE =A0 (1 << 5)
> +#define MT_QUIRK_EGALAX_XYZ_FIXUP =A0 =A0 =A0(1 << 6)
>
> =A0struct mt_slot {
> =A0 =A0 =A0 =A0__s32 x, y, p, w, h;
> @@ -70,6 +77,7 @@ struct mt_class {
> =A0#define MT_CLS_DUAL_INRANGE_CONTACTID =A0 =A0 =A0 =A0 =A02
> =A0#define MT_CLS_DUAL_INRANGE_CONTACTNUMBER =A0 =A0 =A03
> =A0#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 4
> +#define MT_CLS_EGALAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A05
>
> =A0/*
> =A0* these device-dependent functions determine what slot corresponds
> @@ -120,6 +128,14 @@ struct mt_class mt_classes[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MT_QUIRK_CYPRESS,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.maxcontacts =3D 10 },
>
> + =A0 =A0 =A0 { .name =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D =A0MT_QUIRK_SLOT_IS_CONTACT=
ID |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_VALID_IS_INRAN=
GE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_EGALAX_XYZ_FIX=
UP
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 4096,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 32,
> + =A0 =A0 =A0 },
> =A0 =A0 =A0 =A0{ }
> =A0};
>
> @@ -147,11 +163,15 @@ static int mt_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
> =A0{
> =A0 =A0 =A0 =A0struct mt_device *td =3D hid_get_drvdata(hdev);
> =A0 =A0 =A0 =A0struct mt_class *cls =3D td->mtclass;
> + =A0 =A0 =A0 __s32 quirks =3D cls->quirks;
> +
> =A0 =A0 =A0 =A0switch (usage->hid & HID_USAGE_PAGE) {
>
> =A0 =A0 =A0 =A0case HID_UP_GENDESK:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (usage->hid) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_GD_X:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quirks & MT_QUIRK_E=
GALAX_XYZ_FIXUP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->=
logical_maximum =3D 32760;

Please do not add numerical constants in a generic code. If I want to
override the values for another device, I'll have to rename your quirk
to MT_QUIRK_EGALAX_XYZ_FIXUP_WITH_0_32760_0_32760_0_x and add mine.
These values have to be moved in the MT_CLS.


> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_map_usage(hi, usag=
e, bit, max,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0EV_ABS, ABS_MT_POSITION_X);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_abs(hi->input, ABS=
_MT_POSITION_X, field,
> @@ -161,6 +181,8 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_slot_field =3D=
 usage->hid;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_GD_Y:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quirks & MT_QUIRK_E=
GALAX_XYZ_FIXUP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->=
logical_maximum =3D 32760;

ditto

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_map_usage(hi, usag=
e, bit, max,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0EV_ABS, ABS_MT_POSITION_Y);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_abs(hi->input, ABS=
_MT_POSITION_Y, field,
> @@ -204,6 +226,8 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_slot_field =3D=
 usage->hid;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_TIPPRESSURE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quirks & MT_QUIRK_E=
GALAX_XYZ_FIXUP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->=
logical_minimum =3D 0;

No really need for the test and the quirk. In addition, here you do
not override logical_max. This shows that the quirk is not
MT_QUIRK_EGALAX_XYZ_FIXUP but the combination of
MT_QUIRK_EGALAX_XY_FIXUP and  MT_QUIRK_EGALAX_Z_MIN_FIXUP.
Just drop it here.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_map_usage(hi, usag=
e, bit, max,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0EV_ABS, ABS_MT_PRESSURE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_abs(hi->input, ABS=
_MT_PRESSURE, field,
> @@ -487,6 +511,25 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_CANDO_PI=
XCIR_MULTI_TOUCH) },
>
> + =A0 =A0 =A0 /* Resistive eGalax devices */
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH) },
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH3) },
> +
> + =A0 =A0 =A0 /* Capacitive eGalax devices */
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH1) },
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH2) },
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH4) },
> +
> =A0 =A0 =A0 =A0{ }
> =A0};
> =A0MODULE_DEVICE_TABLE(hid, mt_devices);
> --
> 1.7.4.1
>

Thanks,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
