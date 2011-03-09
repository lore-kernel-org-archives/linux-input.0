From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 1/4] hid-multitouch: Auto detection of maxcontacts
Date: Wed, 9 Mar 2011 13:35:57 +0100
Message-ID: <AANLkTimU0dt_XJVvnD+-JxEhVXMb0pzar0kip56zs11u@mail.gmail.com>
References: <1299601979-4871-1-git-send-email-benjamin.tissoires@enac.fr>
	<1299601979-4871-2-git-send-email-benjamin.tissoires@enac.fr>
	<20110309112255.GA9020@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110309112255.GA9020@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 9, 2011 at 12:22, Henrik Rydberg <rydberg@euromail.se> wrot=
e:
> On Tue, Mar 08, 2011 at 05:32:56PM +0100, Benjamin Tissoires wrote:
>> This patch enables support of autodetection of maxcontacts.
>> We can still manually provide maxcontact in case the device
>> lies on it.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>> =A0drivers/hid/hid-multitouch.c | =A0 43 +++++++++++++++++++++++++++=
+-------------
>> =A01 files changed, 29 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 65e7f20..363ca08 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -38,6 +38,8 @@ MODULE_LICENSE("GPL");
>> =A0#define MT_QUIRK_VALID_IS_INRANGE =A0 =A0(1 << 4)
>> =A0#define MT_QUIRK_VALID_IS_CONFIDENCE (1 << 5)
>>
>> +#define MT_CONTACTMAX_DEFAULT =A0 =A0 =A0 =A011
>> +
>
> I think this one can be removed, se below.
>
>> =A0struct mt_slot {
>> =A0 =A0 =A0 __s32 x, y, p, w, h;
>> =A0 =A0 =A0 __s32 contactid; =A0 =A0 =A0 =A0/* the device ContactID =
assigned to this slot */
>> @@ -53,8 +55,9 @@ struct mt_device {
>> =A0 =A0 =A0 __s8 inputmode; =A0 =A0 =A0 =A0 /* InputMode HID feature=
, -1 if non-existent */
>> =A0 =A0 =A0 __u8 num_received; =A0 =A0 =A0/* how many contacts we re=
ceived */
>> =A0 =A0 =A0 __u8 num_expected; =A0 =A0 =A0/* expected last contact i=
ndex */
>> + =A0 =A0 __u8 maxcontacts;
>> =A0 =A0 =A0 bool curvalid; =A0 =A0 =A0 =A0 =A0/* is the current cont=
act valid? */
>> - =A0 =A0 struct mt_slot slots[0]; =A0 =A0 =A0 =A0/* first slot */
>> + =A0 =A0 struct mt_slot *slots;
>> =A0};
>>
>> =A0struct mt_class {
>> @@ -87,12 +90,12 @@ static int cypress_compute_slot(struct mt_device=
 *td)
>> =A0static int find_slot_from_contactid(struct mt_device *td)
>> =A0{
>> =A0 =A0 =A0 int i;
>> - =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
>> + =A0 =A0 for (i =3D 0; i < td->maxcontacts; ++i) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (td->slots[i].contactid =3D=3D td->cu=
rdata.contactid &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->slots[i].touch_state=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
>> =A0 =A0 =A0 }
>> - =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
>> + =A0 =A0 for (i =3D 0; i < td->maxcontacts; ++i) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!td->slots[i].seen_in_this_frame &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !td->slots[i].touch_stat=
e)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
>> @@ -105,8 +108,7 @@ static int find_slot_from_contactid(struct mt_de=
vice *td)
>>
>> =A0struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 { .name =3D MT_CLS_DEFAULT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 10 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP },
>
> Keeping .maxcontacts at two here seems sensible
>
>> =A0 =A0 =A0 { .name =3D MT_CLS_DUAL_INRANGE_CONTACTID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_VALID_IS_INRANGE |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_SLOT_IS_CONTACT=
ID,
>> @@ -126,9 +128,22 @@ struct mt_class mt_classes[] =3D {
>> =A0static void mt_feature_mapping(struct hid_device *hdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, struct hid_usag=
e *usage)
>> =A0{
>> - =A0 =A0 if (usage->hid =3D=3D HID_DG_INPUTMODE) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct mt_device *td =3D hid_get_drvdata(h=
dev);
>> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> +
>> + =A0 =A0 switch (usage->hid) {
>> + =A0 =A0 case HID_DG_INPUTMODE:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->inputmode =3D field->report->id;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case HID_DG_CONTACTMAX:
>> + =A0 =A0 =A0 =A0 =A0 =A0 td->maxcontacts =3D *(field->value);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (td->mtclass->maxcontacts)
>
> if (td->mtclass->maxcontacts > td->maxcontacts)
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if the maxcontact=
s is given by the class */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->maxcontacts =3D td->mt=
class->maxcontacts;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!td->maxcontacts)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->maxcontacts =3D MT_CON=
TACTMAX_DEFAULT;
>
> this part can be then dropped

Well, it works the way you are suggesting. BTW this let the corner
case where someone adds a device (MT_CLS) that does not send the
contact max and does not initialize the .maxcontact field.

>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -186,8 +201,7 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D =
usage->hid;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTID:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(hi->in=
put,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 td->mtclass->maxcontacts);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(hi->in=
put, td->maxcontacts);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D =
usage->hid;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_WIDTH:
>> @@ -268,7 +282,7 @@ static void mt_complete_slot(struct mt_device *t=
d)
>> =A0 =A0 =A0 if (td->curvalid) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int slotnum =3D mt_compute_slot(td);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (slotnum >=3D 0 && slotnum < td->mtclas=
s->maxcontacts)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (slotnum >=3D 0 && slotnum < td->maxcon=
tacts)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->slots[slotnum] =3D t=
d->curdata;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 td->num_received++;
>> @@ -283,7 +297,7 @@ static void mt_emit_event(struct mt_device *td, =
struct input_dev *input)
>> =A0{
>> =A0 =A0 =A0 int i;
>>
>> - =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
>> + =A0 =A0 for (i =3D 0; i < td->maxcontacts; ++i) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mt_slot *s =3D &(td->slots[i]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((td->mtclass->quirks & MT_QUIRK_NOT_=
SEEN_MEANS_UP) &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !s->seen_in_this_frame) =
{
>> @@ -415,9 +429,7 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 hdev->quirks |=3D HID_QUIRK_NO_INPUT_SYNC;
>>
>> - =A0 =A0 td =3D kzalloc(sizeof(struct mt_device) +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtclass->m=
axcontacts * sizeof(struct mt_slot),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL=
);
>> + =A0 =A0 td =3D kzalloc(sizeof(struct mt_device), GFP_KERNEL);
>> =A0 =A0 =A0 if (!td) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev, "cannot allocate mul=
titouch data\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> @@ -434,6 +446,9 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>>
>> + =A0 =A0 td->slots =3D kzalloc(td->maxcontacts * sizeof(struct mt_s=
lot),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL=
);
>> +
>
> Don't we have a race problem here? =A0It seems the device is started =
at
> this point, so I worry that events will be handled when slots is stil=
l
> NULL.

I tried again yesterday: if I put this line above the hid_hw_start ->
kernel oops at first touch.
The point is that hid_hw_start calls hid_connect that do the actual
calls to input_mapping and feature_mapping.

Cheers,
Benjamin

>
>> =A0 =A0 =A0 mt_set_input_mode(hdev);
>>
>> =A0 =A0 =A0 return 0;
>> --
>> 1.7.4
>>
>
> Thanks,
> Henrik
>
