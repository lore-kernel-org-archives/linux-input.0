From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH v2 4/4] hid-multitouch: migrate 3M PCT touch screens to hid-multitouch
Date: Fri, 11 Mar 2011 08:26:39 +0100
Message-ID: <AANLkTi=jnd_gq8U+Fv7YSNk1iqt19paFQ3do=f5VrcSC@mail.gmail.com>
References: <1299686450-5475-1-git-send-email-benjamin.tissoires@enac.fr>
	<1299686450-5475-5-git-send-email-benjamin.tissoires@enac.fr>
	<20110310155225.GA23034@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46617 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1CKH0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 02:26:41 -0500
In-Reply-To: <20110310155225.GA23034@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Thu, Mar 10, 2011 at 16:52, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Benjamin,
>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 02a77f9..0b92dfc 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -5,6 +5,11 @@
>> =A0 * =A0Copyright (c) 2010-2011 Benjamin Tissoires <benjamin.tissoi=
res@gmail.com>
>> =A0 * =A0Copyright (c) 2010-2011 Ecole Nationale de l'Aviation Civil=
e, France
>> =A0 *
>> + * =A0based on hid-3m-pct.c copyrighted as follows:
>> + * =A0 =A0Copyright (c) 2009-2010 Stephane Chatty <chatty@enac.fr>
>> + * =A0 =A0Copyright (c) 2010 =A0 =A0 =A0Henrik Rydberg <rydberg@eur=
omail.se>
>> + * =A0 =A0Copyright (c) 2010 =A0 =A0 =A0Canonical, Ltd.
>> + *
>> =A0 */
>>
>> =A0/*
>> @@ -62,6 +67,8 @@ struct mt_class {
>> =A0 =A0 =A0 __s32 name; =A0 =A0 /* MT_CLS */
>> =A0 =A0 =A0 __s32 quirks;
>> =A0 =A0 =A0 __s32 sn_move; =A0/* Signal/noise ratio for move events =
*/
>> + =A0 =A0 __s32 sn_width; /* Signal/noise ratio for width events */
>> + =A0 =A0 __s32 sn_height; =A0 =A0 =A0 =A0/* Signal/noise ratio for =
height events */
>> =A0 =A0 =A0 __s32 sn_pressure; =A0 =A0 =A0/* Signal/noise ratio for =
pressure events */
>> =A0 =A0 =A0 __u8 maxcontacts;
>> =A0};
>> @@ -72,6 +79,7 @@ struct mt_class {
>> =A0#define MT_CLS_DUAL_INRANGE_CONTACTNUMBER =A0 =A03
>> =A0#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 4
>> =A0#define MT_CLS_STANTUM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 5
>> +#define MT_CLS_3M =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A06
>>
>> =A0/*
>> =A0 * these device-dependent functions determine what slot correspon=
ds
>> @@ -123,6 +131,12 @@ struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 10 },
>> =A0 =A0 =A0 { .name =3D MT_CLS_STANTUM,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_VALID_IS_CONFIDENCE=
 },
>
> I realize several of the entries are missing maxcontacts now, so all
> patches needs to be checked...

This is really annoying. The idea behind the auto-detection was to
simplify the writing of the driver and to let the device inform us on
its capabilities.
It's not a bug, it's a feature in this particular case. My idea was to
remove all those .maxcontact (for instance, I know that it works for
cypress, stantum and 3M) but I didn't want to bother my testers about
such a little change.

Can I remember you that you where the first complaining about the
maxcontact? You asked if it could not be given by the device. And as
we where in a hurry, we didn't include it and said that we will do it
later.

>
>> + =A0 =A0 { .name =3D MT_CLS_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_VALID_IS_CONFIDENCE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_SLOT_IS_CONTACTID=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 2048,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_width =3D 128,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_height =3D 128 },
>
> And this one does too

And this one would be false: should I write 10 or 60? As it depends on
the device, we'll have to let the device decide.
If you remember the commit message of the auto-detection patch, I have
written that we keep the .maxcontact field in case the device _lies_.
And 3M does not lie.

>>
>> =A0 =A0 =A0 { }
>> =A0};
>> @@ -206,11 +220,15 @@ static int mt_input_mapping(struct hid_device =
*hdev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_WIDTH:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage,=
 bit, max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 EV_ABS, ABS_MT_TOUCH_MAJOR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_MT_=
TOUCH_MAJOR, field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_wi=
dth);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D =
usage->hid;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_HEIGHT:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage,=
 bit, max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 EV_ABS, ABS_MT_TOUCH_MINOR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_MT_=
TOUCH_MINOR, field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_he=
ight);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_maximum =3D=
 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_minimum =3D=
 0;
>
> These limits are not right - I doubt they are for any device.

I was a little surprise too while looking at these. But This is not
related to ABS_MT_TOUCH_MINOR, but ABS_MT_ORIENTATION.
And if I'm forced to modify those values this way it's because _you_
made me introduce the set_abs function which takes in parameter the
field. Thus, it's more complicated to introduce new fields and usages.

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_M=
T_ORIENTATION, field, 0);
>> @@ -307,11 +325,18 @@ static void mt_emit_event(struct mt_device *td=
, struct input_dev *input)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TOO=
L_FINGER,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->touch_state);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->touch_state) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this finger is on the s=
creen */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int wide =3D (s->w > s->h)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* divided by two to match=
 visual scale of touch */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int major =3D max(s->w, s-=
>h) >> 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int minor =3D min(s->w, s-=
>h) >> 1;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_AB=
S, ABS_MT_POSITION_X, s->x);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_AB=
S, ABS_MT_POSITION_Y, s->y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS,=
 ABS_MT_ORIENTATION, wide);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_AB=
S, ABS_MT_PRESSURE, s->p);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS,=
 ABS_MT_TOUCH_MAJOR, s->w);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS,=
 ABS_MT_TOUCH_MINOR, s->h);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS,=
 ABS_MT_TOUCH_MAJOR, major);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS,=
 ABS_MT_TOUCH_MINOR, minor);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->seen_in_this_frame =3D false;
>>
>> @@ -481,6 +506,14 @@ static void mt_remove(struct hid_device *hdev)
>>
>> =A0static const struct hid_device_id mt_devices[] =3D {
>>
>> + =A0 =A0 /* 3M panels */
>> + =A0 =A0 { .driver_data =3D MT_CLS_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_3M1968) },
>> + =A0 =A0 { .driver_data =3D MT_CLS_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_3M2256) },
>> +
>> =A0 =A0 =A0 /* Cando panels */
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
>> --
>> 1.7.4
>>
>
> Also, this line needs to be added in case no feature reports are sent=
:
>
> @@ -481,6 +481,7 @@ static int mt_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0td->mtclass =3D mtclass;
> + =A0 =A0 =A0 td->maxcontacts =3D mtclass->maxcontacts;
> =A0 =A0 =A0 =A0td->inputmode =3D -1;
> =A0 =A0 =A0 =A0hid_set_drvdata(hdev, td);
>

So:
1) If a device does not send the feature report related to maxcontact,
then it won't pass the Win7 certification, then we will need to write
a special driver for it.
2) This is wrong because I do not want to add in all those classes the
field maxcontact. So I'll revert the MT_DEFAULT_MAXCONTACT, and I will
add this sort of line just before allocating the slots.
Oh, and I'll remove the .maxcontact =3D 2 for MT_CLS_DEFAULT.

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
