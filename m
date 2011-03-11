From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH v2 1/4] hid-multitouch: Auto detection of maxcontacts
Date: Fri, 11 Mar 2011 08:07:18 +0100
Message-ID: <AANLkTinL4TL_BMv_1KwCjKwbEthj6Ho1L8UvM2ad1t0x@mail.gmail.com>
References: <1299686450-5475-1-git-send-email-benjamin.tissoires@enac.fr>
	<1299686450-5475-2-git-send-email-benjamin.tissoires@enac.fr>
	<20110310124530.GA3378@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49754 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab1CKHHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 02:07:20 -0500
In-Reply-To: <20110310124530.GA3378@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

thanks for the review.

On Thu, Mar 10, 2011 at 13:45, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Benjamin,
>
> thanks for this, just a couple of things...
>
>> @@ -126,9 +127,19 @@ struct mt_class mt_classes[] =3D {
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
>
> field->value[0] seems more standard-ish

If you want

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (td->mtclass->maxcontacts > td->maxcont=
acts)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if the maxcontact=
s is given by the class */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->maxcontacts =3D td->mt=
class->maxcontacts;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -317,7 +327,7 @@ static int mt_event(struct hid_device *hid, stru=
ct hid_field *field,
>> =A0 =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hid);
>> =A0 =A0 =A0 __s32 quirks =3D td->mtclass->quirks;
>>
>> - =A0 =A0 if (hid->claimed & HID_CLAIMED_INPUT) {
>> + =A0 =A0 if (hid->claimed & HID_CLAIMED_INPUT && td->slots) {
>
> The extra test could in principle be placed after the usage switch, w=
hich would prevent partially filled contact data, should this ever occu=
r. Something like
>
> if (!td->slots)
> =A0 break;

I don't know where these "break" comes from. We can add the test after
the switch before the mt_complete_slot and mt_emit_event. But please
note than it can in all cases introduce truncated slots reports as all
the slots in the report may not have been completed. To be honest, I'm
not sure this will ever matter as it's a race at the connection of the
device, and the reports will come to correct anything wrong.

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_INRANGE:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quirks & MT_QUIRK_VA=
LID_IS_INRANGE)
>> @@ -415,9 +425,7 @@ static int mt_probe(struct hid_device *hdev, con=
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
>> @@ -434,6 +442,14 @@ static int mt_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>>
>> + =A0 =A0 td->slots =3D kzalloc(td->maxcontacts * sizeof(struct mt_s=
lot),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL=
);
>> + =A0 =A0 if (!td->slots) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev, "cannot allocate multi=
touch slots\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>
> This exit leaves the device running.

Yep, will do sth.

Thanks
Benjamin

>
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 mt_set_input_mode(hdev);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -455,6 +471,7 @@ static void mt_remove(struct hid_device *hdev)
>> =A0{
>> =A0 =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> =A0 =A0 =A0 hid_hw_stop(hdev);
>> + =A0 =A0 kfree(td->slots);
>> =A0 =A0 =A0 kfree(td);
>> =A0 =A0 =A0 hid_set_drvdata(hdev, NULL);
>> =A0}
>> --
>> 1.7.4
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
