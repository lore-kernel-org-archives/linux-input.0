From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Tue, 8 Mar 2011 09:55:24 +0100
Message-ID: <AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
References: <1299417912.9645.495.camel@itzy>
	<AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
	<1299564524.2306.18.camel@itzy>
	<20110308080414.GA2888@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52696 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab1CHIz0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2011 03:55:26 -0500
Received: by wwa36 with SMTP id 36so773758wwa.1
        for <linux-input@vger.kernel.org>; Tue, 08 Mar 2011 00:55:25 -0800 (PST)
In-Reply-To: <20110308080414.GA2888@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Hi Richard,

thanks for this new version. Just some more comments on top of Henrik's=
 ones.

On Tue, Mar 8, 2011 at 09:04, Henrik Rydberg <rydberg@euromail.se> wrot=
e:
> Hi Richard,
>
>> Hi Benjamin, Hendrick, Jiri and St=E9phan,
>
> The name is Henrik.
>
>> I would like to give this patch another shot, after Benjamin reviewe=
d it (thanks for that!).
>> As he pointed out, testing for the capacitive kind of egalax devices=
 is needed. Maybe St=E9phan,
>> has the hardware and would be so kind to test it? I have tried it wi=
th my Samsung MB30 display
>> and it worked:
>> Bus 002 Device 002: ID 0eef:480e D-WAV Scientific Co., Ltd
>> (thats USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3)
>>
>> I am looking forward to your comments,
>> Richard
>>
>>
>> PS: The patch should apply to 2fa403e8b49 of Jiris for-next branch, =
although I had to cheat
>> a little and rebase his tree to 2.6.38-rc7 because of some unrelated=
 breakage (ecryptfs).
>
> Thanks for making this patch. Please find some comments inline. Also,
> since you are removing copyright from something that was largely
> copied into this driver, perhaps something should be done about that.
>
>> [PATCH] [input-hid] Add hid-egalax driver to the unified hid-multito=
uch framework.
>>
>> This patch merges the hid-egalax driver into hid-multitouch and
>> therefore adds two device classes (MT_CLS_EGALAX_CAPACITIVE/RESISTIV=
E).
>> It also gains the capability to work around broken hid reports by
>> overriding X/Y limits and emitting events for each finger
>> (MT_QUIRK_SEND_AT_EACH_REPORT). As a side effect, this patch
>> fixes the broken suspend/resume behavior with the old driver.
>>
>> Signed-off-by: Richard Nauber <Richard.Nauber@gmail.com>
>> ---
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A09 +-
>> =A0drivers/hid/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 -
>> =A0drivers/hid/hid-egalax.c =A0 =A0 | =A0279 -----------------------=
-------------------
>> =A0drivers/hid/hid-multitouch.c | =A0 68 ++++++++++-
>> =A04 files changed, 68 insertions(+), 289 deletions(-)
>> =A0delete mode 100644 drivers/hid/hid-egalax.c
>>
> [...]
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 65e7f20..a00f3d8 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
>> =A0#define MT_QUIRK_SLOT_IS_CONTACTNUMBER =A0 =A0 =A0 (1 << 3)
>> =A0#define MT_QUIRK_VALID_IS_INRANGE =A0 =A0(1 << 4)
>> =A0#define MT_QUIRK_VALID_IS_CONFIDENCE (1 << 5)
>> +#define MT_QUIRK_SEND_AT_EACH_REPORT (1 << 6)
>>
>> =A0struct mt_slot {
>> =A0 =A0 =A0 __s32 x, y, p, w, h;
>> @@ -63,6 +64,9 @@ struct mt_class {
>> =A0 =A0 =A0 __s32 sn_move; =A0/* Signal/noise ratio for move events =
*/
>> =A0 =A0 =A0 __s32 sn_pressure; =A0 =A0 =A0/* Signal/noise ratio for =
pressure events */
>> =A0 =A0 =A0 __u8 maxcontacts;
>> + =A0 =A0 __u8 override_logical_limits; =A0/* correct the reported X=
/Y range */
>> + =A0 =A0 __u32 logical_min[2];
>> + =A0 =A0 __u32 logical_max[2];
>
> Please think about byte alignment here, keeping elements of the same
> size together. Also, the override needs a specific name, given that i=
t
> applies to the whole class, not just the x and y positions. Perhaps
> the override should be triggered with a quirk instead?

I'm not in favor of a quirk in this particular case: the information
is already here: max > 0.

=46or the specific name, the too fields logical_min/max are not well ch=
osen:
either use an anonymous struct to have .x, .y so we can add .pressure,
=2Ewidth, etc...
or rename logical_min to logical_min_xy.

I just saw that Henrik suggested max_x, max_y, etc... chose this one, p=
lease.

The alignment makes sense!

>
>> =A0};
>>
>> =A0/* classes of device behavior */
>> @@ -70,6 +74,8 @@ struct mt_class {
>> =A0#define MT_CLS_DUAL_INRANGE_CONTACTID =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A02
>> =A0#define MT_CLS_DUAL_INRANGE_CONTACTNUMBER =A0 =A03
>> =A0#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 4
>> +#define MT_CLS_EGALAX_CAPACITIVE =A0 =A0 =A0 =A0 =A0 =A0 5
>> +#define MT_CLS_EGALAX_RESISTIVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A06
>>
>> =A0/*
>> =A0 * these device-dependent functions determine what slot correspon=
ds
>> @@ -119,7 +125,25 @@ struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_CYPRESS,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 10 },
>> -
>> + =A0 =A0 { .name =3D MT_CLS_EGALAX_CAPACITIVE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D =A0MT_QUIRK_SLOT_IS_CONTACTID =
|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_VALID_IS_INRANGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 4096,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 32,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .override_logical_limits =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .logical_min =3D { 0, 0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 .logical_max =3D { 32760, 32760 } },
>> + =A0 =A0 { .name =3D MT_CLS_EGALAX_RESISTIVE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D =A0MT_QUIRK_SLOT_IS_CONTACTID =
|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_VALID_IS_INRANGE =
|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_SEND_AT_EACH_REPO=
RT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 4096,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 32,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .override_logical_limits =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .logical_min =3D { 0, 0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 .logical_max =3D { 32760, 32760 } },
>> =A0 =A0 =A0 { }
>> =A0};
>>
>> @@ -147,11 +171,19 @@ static int mt_input_mapping(struct hid_device =
*hdev, struct hid_input *hi,
>> =A0{
>> =A0 =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> =A0 =A0 =A0 struct mt_class *cls =3D td->mtclass;
>> +
>
> Please check for patch for unrelated changes like this.
>
>> =A0 =A0 =A0 switch (usage->hid & HID_USAGE_PAGE) {
>>
>> =A0 =A0 =A0 case HID_UP_GENDESK:
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_X:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fix up the reported X l=
imits if necessary*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cls->override_logical_=
limits) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->log=
ical_minimum =3D cls->logical_min[0];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->log=
ical_maximum =3D cls->logical_max[0];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>
> Something like "if (quirks & MT_QUIRK_FIX_X)", and then on next line =
"field->logical_maximum =3D cls->max_x".

or just "if (cls->max_x)" and then the two "field->logical_maximum =3D
cls->max_x" and "field->logical_minimum =3D cls->min_x".

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage,=
 bit, max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 EV_ABS, ABS_MT_POSITION_X);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_M=
T_POSITION_X, field,
>> @@ -161,6 +193,11 @@ static int mt_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D =
usage->hid;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_Y:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fix up the reported Y l=
imits if nessecary*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cls->override_logical_=
limits) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->log=
ical_minimum =3D cls->logical_min[1];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->log=
ical_maximum =3D cls->logical_max[1];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Ditto.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage,=
 bit, max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 EV_ABS, ABS_MT_POSITION_Y);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_M=
T_POSITION_Y, field,
>> @@ -204,6 +241,10 @@ static int mt_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D =
usage->hid;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPPRESSURE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fix up the pressure ran=
ge for some devices
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 with broken report */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_minimum =3D=
 0;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage,=
 bit, max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 EV_ABS, ABS_MT_PRESSURE);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_M=
T_PRESSURE, field,
>> @@ -367,8 +408,12 @@ static int mt_event(struct hid_device *hid, str=
uct hid_field *field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (usage->hid =3D=3D td->last_slot_fiel=
d)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_complete_slot(td);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (field->index =3D=3D td->last_field_ind=
ex
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((field->index =3D=3D td->last_field_in=
dex
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && td->num_received >=3D=
 td->num_expected)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || ((quirks & MT_QUIRK_SEN=
D_AT_EACH_REPORT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (usage-=
>hid =3D=3D td->last_slot_field)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* emit an event for every=
 finger to work around
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a corrupt last_field_index=
 in the hid report*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_emit_event(td, field-=
>hidinput->input);
>>
>> =A0 =A0 =A0 }
>> @@ -484,6 +529,25 @@ static const struct hid_device_id mt_devices[] =
=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_CANDO_PIXC=
IR_MULTI_TOUCH) },
>>
>> + =A0 =A0 /* Resistive eGalax devices */
>> + =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX_RESISTIVE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALAX_=
MULTITOUCH) },
>> + =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX_RESISTIVE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALAX_=
MULTITOUCH3) },
>> +
>> + =A0 =A0 /* Capacitive eGalax devices */
>> + =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX_CAPACITIVE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALAX_=
MULTITOUCH1) },
>> + =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX_CAPACITIVE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALAX_=
MULTITOUCH2) },
>> + =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX_CAPACITIVE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALAX_=
MULTITOUCH4) },
>> +
>> =A0 =A0 =A0 { }
>> =A0};
>> =A0MODULE_DEVICE_TABLE(hid, mt_devices);
>> --
>> 1.7.1
>>
>
> Thanks,
> Henrik
>

Thanks,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
