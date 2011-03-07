From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Mon, 7 Mar 2011 11:07:00 +0100
Message-ID: <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
References: <1299417912.9645.495.camel@itzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49971 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747Ab1CGKHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2011 05:07:02 -0500
Received: by bwz15 with SMTP id 15so3682837bwz.19
        for <linux-input@vger.kernel.org>; Mon, 07 Mar 2011 02:07:01 -0800 (PST)
In-Reply-To: <1299417912.9645.495.camel@itzy>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <richard.nauber@googlemail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Hi Richard,

On Sun, Mar 6, 2011 at 14:25, Richard Nauber
<richard.nauber@googlemail.com> wrote:
> This patch merges the egalax devices to hid-multitouch and
> therefore adds an MT_QUIRK_EGALAX to work around the broken hid repor=
t.
> It also fixes suspend/resume issues with the old driver.
>
>
> Signed-off-by: Richard Nauber <Richard.Nauber@gmail.com>
> ---
> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A09 +-
> =A0drivers/hid/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0drivers/hid/hid-egalax.c =A0 =A0 | =A0279 ------------------------=
------------------
> =A0drivers/hid/hid-multitouch.c | =A0 48 +++++++-
> =A04 files changed, 47 insertions(+), 290 deletions(-)
> =A0delete mode 100644 drivers/hid/hid-egalax.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2560f01..34959a2 100644
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
> @@ -306,6 +299,8 @@ config HID_MULTITOUCH
> =A0 =A0 =A0 =A0 =A0- Hanvon dual touch panels
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
> index 07d3183..58df924 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -36,6 +36,8 @@ MODULE_LICENSE("GPL");
> =A0#define MT_QUIRK_SLOT_IS_CONTACTNUMBER (1 << 3)
> =A0#define MT_QUIRK_VALID_IS_INRANGE =A0 =A0 =A0(1 << 4)
> =A0#define MT_QUIRK_VALID_IS_CONFIDENCE =A0 (1 << 5)
> +#define MT_QUIRK_EGALAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 6)
> +

Please rebase against the branch for-next of Jiri's tree (at
http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dsummary)

Also, I'm not in favor of this quirk. I know that I first introduced
MT_QUIRK_CYPRESS, but I was in a hurry and did not took the time to
find a better name. The problem here is that QUIRK_EGALAX infers a lot
of changes in the driver (X, Y, Z corrections, etc)

>
> =A0struct mt_slot {
> =A0 =A0 =A0 =A0__s32 x, y, p, w, h;
> @@ -69,6 +71,7 @@ struct mt_class {
> =A0#define MT_CLS_DUAL1 =A0 2
> =A0#define MT_CLS_DUAL2 =A0 3
> =A0#define MT_CLS_CYPRESS 4
> +#define MT_CLS_EGALAX =A05

please define MT_CLS_EGALAX_CAPACITIVE and MT_CLS_EGALAX_RESISTIVE

>
> =A0/*
> =A0* these device-dependent functions determine what slot corresponds
> @@ -118,7 +121,13 @@ struct mt_class mt_classes[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP=
 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MT_QUIRK_CYPRESS,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.maxcontacts =3D 10 },
> -
> + =A0 =A0 =A0 { .name =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D =A0MT_QUIRK_SLOT_IS_CONTACT=
ID |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_VALID_IS_INRAN=
GE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2 ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 4096,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 32},

MT_CLS_EGALAX_CAPACITIVE and MT_CLS_EGALAX_RESISTIVE
The differences are in the quirks (see later in the review)

> =A0 =A0 =A0 =A0{ }
> =A0};
>
> @@ -146,9 +155,16 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
> =A0{
> =A0 =A0 =A0 =A0struct mt_device *td =3D hid_get_drvdata(hdev);
> =A0 =A0 =A0 =A0struct mt_class *cls =3D td->mtclass;
> +
> =A0 =A0 =A0 =A0switch (usage->hid & HID_USAGE_PAGE) {
>
> =A0 =A0 =A0 =A0case HID_UP_GENDESK:
> +
> + =A0 =A0 =A0 /* fix up the X/Y limits for egalax devices*/
> + =A0 =A0 =A0 if ((cls->quirks & MT_QUIRK_EGALAX)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && ((usage->hid =3D=3D HID_GD_X) || (us=
age->hid =3D=3D HID_GD_Y)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_maximum =
=3D 32760;
> +

This should not be treated by a quirk. You should add fields in the
struct mt_class so that any other devices can expect the benefice. It
also removes the numerical constants in the code.

Also, this should go in the switch below.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (usage->hid) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_GD_X:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_map_usage(hi, usag=
e, bit, max,
> @@ -203,6 +219,10 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_slot_field =3D=
 usage->hid;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_TIPPRESSURE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fix up the pressure =
range for egalax devices*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cls->quirks & MT_QU=
IRK_EGALAX)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->=
logical_minimum =3D 0;
> +

You can avoid the test here. Except eGalax, no known drivers set the
logical minimum for Pressure to a different value than 0.


> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_map_usage(hi, usag=
e, bit, max,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0EV_ABS, ABS_MT_PRESSURE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_abs(hi->input, ABS=
_MT_PRESSURE, field,
> @@ -269,8 +289,10 @@ static void mt_complete_slot(struct mt_device *t=
d)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (slotnum >=3D 0 && slotnum < td->mt=
class->maxcontacts)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->slots[slotnum] =3D=
 td->curdata;
> +

Please avoid adding blank lines, this complicates the reading of the pa=
tch.

> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0td->num_received++;
> +

same here.

> =A0}
>
>
> @@ -366,12 +388,15 @@ static int mt_event(struct hid_device *hid, str=
uct hid_field *field,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (usage->hid =3D=3D td->last_slot_fi=
eld)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mt_complete_slot(td);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (field->index =3D=3D td->last_field_=
index
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((field->index =3D=3D td->last_field=
_index
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& td->num_received >=3D=
 td->num_expected)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || ((quirks & MT_QUIRK_=
EGALAX)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (usa=
ge->hid =3D=3D td->last_slot_field)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* for egalax devices: =
emit an event for every finger
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 to work around the wron=
g last_field_index in the report*/

checkpatch.pl warns here for a line over 80 characters.

Please use another quirk here for that. Maybe
MT_QUIRK_SEND_AT_EACH_REPORT. Henrik, any suggestions?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mt_emit_event(td, fiel=
d->hidinput->input);
>
> =A0 =A0 =A0 =A0}
> -

Please keep the jump ;)

> =A0 =A0 =A0 =A0/* we have handled the hidinput part, now remains hidd=
ev */
> =A0 =A0 =A0 =A0if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_h=
id_event)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid->hiddev_hid_event(hid, field, usag=
e, value);
> @@ -478,6 +503,23 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_CANDO_PI=
XCIR_MULTI_TOUCH) },
>
> + =A0 =A0 =A0 /* eGalax devices */
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH) },
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
AX_MULTITOUCH3) },
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH4) },
> +

Separate this list in two sections: one for resistive, 0x48xx, and one
for capacitive, 0x72xx.

Maybe we can also change them in the hid-ids.h? Jiri?


Now, we need testings for both types of hardware!


One last thing. When submitting patches, it's common use to add in CC
the authors, in case they do not read very carefully the mailing list.

Thanks,
Benjamin


> =A0 =A0 =A0 =A0{ }
> =A0};
> =A0MODULE_DEVICE_TABLE(hid, mt_devices);
> --
> 1.7.1
>
>
>
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
