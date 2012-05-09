From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/5] HID: hid-multitouch: fix wrong protocol detection
Date: Wed, 9 May 2012 21:04:09 +0200
Message-ID: <CAN+gG=G9y_0Le-Mja2z68r76nBmz0De95Lc6671EkrrMZRSEHw@mail.gmail.com>
References: <1336136030-18503-1-git-send-email-benjamin.tissoires@gmail.com>
	<1336136030-18503-2-git-send-email-benjamin.tissoires@gmail.com>
	<20120506190146.GA12571@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64834 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758575Ab2EITEK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 15:04:10 -0400
In-Reply-To: <20120506190146.GA12571@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

thanks for the review.
Some comments inlined:

On Sun, May 6, 2012 at 9:01 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> Hi Benjamin,
>
>> The previous implementation introduced a randomness in the splitting
>> of the different touches reported by the device. This version is mor=
e
>> robust as we don't rely on hi->input->absbit, but on our own structu=
re.
>>
>> This also prepares hid-multitouch to better support Win8 devices.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>> =A0drivers/hid/hid-multitouch.c | =A0 58 +++++++++++++++++++++++++++=
++++++--------
>> =A01 files changed, 46 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 84bb32e..c6ffb05 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -70,9 +70,16 @@ struct mt_class {
>> =A0 =A0 =A0 bool is_indirect; =A0 =A0 =A0 /* true for touchpads */
>> =A0};
>>
>> +struct mt_fields {
>> + =A0 =A0 unsigned usages[HID_MAX_FIELDS];
>> + =A0 =A0 unsigned int length;
>> +};
>> +
>> =A0struct mt_device {
>> =A0 =A0 =A0 struct mt_slot curdata; /* placeholder of incoming data =
*/
>> =A0 =A0 =A0 struct mt_class mtclass; =A0 =A0 =A0 =A0/* our mt device=
 class */
>> + =A0 =A0 struct mt_fields *fields; =A0 =A0 =A0 /* temporary placeho=
lder for storing the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0multitouch fields */
>
> Why not skip the pointer here?

well, the idea was to keep the memory footprint low. As these values
are only needed at init, then I freed them once I finished using them.
I can of course skip the pointer, but in that case, wouldn't the
struct declaration be worthless?

>
>> =A0 =A0 =A0 unsigned last_field_index; =A0 =A0 =A0/* last field inde=
x of the report */
>> =A0 =A0 =A0 unsigned last_slot_field; =A0 =A0 =A0 /* the last field =
of a slot */
>> =A0 =A0 =A0 __s8 inputmode; =A0 =A0 =A0 =A0 /* InputMode HID feature=
, -1 if non-existent */
>> @@ -275,11 +282,15 @@ static void set_abs(struct input_dev *input, u=
nsigned int code,
>> =A0 =A0 =A0 input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
>> =A0}
>>
>> -static void set_last_slot_field(struct hid_usage *usage, struct mt_=
device *td,
>> +static void mt_store_field(struct hid_usage *usage, struct mt_devic=
e *td,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hi)
>
> How about adding the last_field_index here also, using a function lik=
e

I'm not a big fan of this idea.
last_field_index represent the last mt field, was it local or global
(i.e. per touch or global to the report).
mt_store_field stores only the local (per-touch) information to be
able to divide the array by the number of touch. Adding the global
items there too will force us to introduce a switch to exclude global
items.

Cheers,
Benjamin

>
> static void mt_store_field(struct mt_device *td, struct hid_input *hi=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct hid_field *fiel=
d, struct hid_usage *usage)
>
>> =A0{
>> - =A0 =A0 if (!test_bit(usage->hid, hi->input->absbit))
>> - =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D usage->hid;
>> + =A0 =A0 struct mt_fields *f =3D td->fields;
>
> And inserting td->last_field_index =3D field->index here.
>
>> +
>> + =A0 =A0 if (f->length >=3D HID_MAX_FIELDS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 f->usages[f->length++] =3D usage->hid;
>> =A0}
>>
>> =A0static int mt_input_mapping(struct hid_device *hdev, struct hid_i=
nput *hi,
>> @@ -330,7 +341,7 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_=
move);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulation=
 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_X=
, field, cls->sn_move);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usage,=
 td, hi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_store_field(usage, td, =
hi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D=
 field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_GD_Y:
>> @@ -340,7 +351,7 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_=
move);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulation=
 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_Y=
, field, cls->sn_move);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usage,=
 td, hi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_store_field(usage, td, =
hi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D=
 field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> @@ -349,24 +360,24 @@ static int mt_input_mapping(struct hid_device =
*hdev, struct hid_input *hi,
>> =A0 =A0 =A0 case HID_UP_DIGITIZER:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_INRANGE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usage,=
 td, hi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_store_field(usage, td, =
hi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D=
 field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONFIDENCE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usage,=
 td, hi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_store_field(usage, td, =
hi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D=
 field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage,=
 bit, max, EV_KEY, BTN_TOUCH);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(hi-=
>input, EV_KEY, BTN_TOUCH);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usage,=
 td, hi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_store_field(usage, td, =
hi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D=
 field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTID:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!td->maxcontacts)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->maxc=
ontacts =3D MT_DEFAULT_MAXCONTACT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(hi->=
input, td->maxcontacts);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D us=
age->hid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_store_field(usage, td, =
hi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D=
 field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->touches_by_report++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> @@ -375,7 +386,7 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 EV_ABS, ABS_MT_TOUCH_MAJOR);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_M=
T_TOUCH_MAJOR, field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_=
width);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usage,=
 td, hi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_store_field(usage, td, =
hi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D=
 field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_HEIGHT:
>> @@ -385,7 +396,7 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_=
height);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(hi-=
>input,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 ABS_MT_ORIENTATION, 0, 1, 0, 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usage,=
 td, hi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_store_field(usage, td, =
hi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D=
 field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPPRESSURE:
>> @@ -396,7 +407,7 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulation=
 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_abs(hi->input, ABS_P=
RESSURE, field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls->sn_=
pressure);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usage,=
 td, hi);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_store_field(usage, td, =
hi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_field_index =3D=
 field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTCOUNT:
>> @@ -650,6 +661,16 @@ static void mt_post_parse_default_settings(stru=
ct mt_device *td)
>> =A0 =A0 =A0 td->mtclass.quirks =3D quirks;
>> =A0}
>>
>> +static void mt_post_parse(struct mt_device *td)
>> +{
>> + =A0 =A0 struct mt_fields *f =3D td->fields;
>> +
>> + =A0 =A0 if (td->touches_by_report > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int field_count_per_touch =3D f->length / =
td->touches_by_report;
>> + =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D f->usages[field_co=
unt_per_touch - 1]->hid;
>> + =A0 =A0 }
>> +}
>> +
>> =A0static int mt_probe(struct hid_device *hdev, const struct hid_dev=
ice_id *id)
>> =A0{
>> =A0 =A0 =A0 int ret, i;
>> @@ -680,6 +701,13 @@ static int mt_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>> =A0 =A0 =A0 td->maxcontact_report_id =3D -1;
>> =A0 =A0 =A0 hid_set_drvdata(hdev, td);
>>
>> + =A0 =A0 td->fields =3D kzalloc(sizeof(struct mt_fields), GFP_KERNE=
L);
>> + =A0 =A0 if (!td->fields) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev, "cannot allocate multi=
touch fields data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> + =A0 =A0 }
>> +
>
> This can be skipped.
>
>> =A0 =A0 =A0 ret =3D hid_parse(hdev);
>> =A0 =A0 =A0 if (ret !=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> @@ -688,6 +716,8 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>>
>> + =A0 =A0 mt_post_parse(td);
>> +
>> =A0 =A0 =A0 if (id->vendor =3D=3D HID_ANY_ID && id->product =3D=3D H=
ID_ANY_ID)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt_post_parse_default_settings(td);
>>
>> @@ -705,9 +735,13 @@ static int mt_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>> =A0 =A0 =A0 mt_set_maxcontacts(hdev);
>> =A0 =A0 =A0 mt_set_input_mode(hdev);
>>
>> + =A0 =A0 kfree(td->fields);
>> + =A0 =A0 td->fields =3D NULL;
>> +
>
> Ditto.
>
>> =A0 =A0 =A0 return 0;
>>
>> =A0fail:
>> + =A0 =A0 kfree(td->fields);
>
> Ditto.
>
>> =A0 =A0 =A0 kfree(td);
>> =A0 =A0 =A0 return ret;
>> =A0}
>> --
>> 1.7.7.6
>>
>
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
