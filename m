From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 2/3] hid-multitouch: Filter collections by application usage.
Date: Mon, 25 Jul 2011 11:29:25 +0200
Message-ID: <CAN+gG=FAFX-N-3FpAmgkE+im4oT9h657Rk9h3=-17sCBwVx35A@mail.gmail.com>
References: <1311545261-34067-1-git-send-email-jeffbrown@android.com>
	<1311545261-34067-2-git-send-email-jeffbrown@android.com>
	<13989665-31A9-4C70-B578-5559987CC9F5@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46028 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab1GYJ31 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 05:29:27 -0400
In-Reply-To: <13989665-31A9-4C70-B578-5559987CC9F5@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: jeffbrown@android.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, Jeff Brown <jeffbrown@google.com>

Hi Jeff,

I like the patch as it partially solves the problems left by
b84bd27fe70206f9253c395958134e4e4b7e55f0 (fix broken egalax). The
previous patch mapped buttons but now it should be ok.
Though, we still have the problem of the distinction between stylus and=
 finger.

It would worth the effort to know if reverting
b84bd27fe70206f9253c395958134e4e4b7e55f0 and apply this one instead
still works for eGalax 480d owners (and mosart too IIRC).


On Mon, Jul 25, 2011 at 11:16, St=E9phane Chatty <chatty@enac.fr> wrote=
:
>
> Le 25 juil. 2011 =E0 00:07, jeffbrown@android.com a =E9crit :
>
>> From: Jeff Brown <jeffbrown@google.com>
>>
>> This change fixes two problems.
>>
>> First, it ensures that the hid-multitouch driver does not incorrectl=
y
>> map GenericDesktop usages that are intended for other applications,
>> such as a Mouse.
>>
>> Second, it sets the appropriate input properties so that user-space
>> can distinguish TouchScreen devices (INPUT_PROP_DIRECT) from
>> TouchPad devices (INPUT_PROP_POINTER) and configure them accordingly=
=2E
>>
>> Signed-off-by: jeffbrown@android.com
>> ---
>> drivers/hid/hid-multitouch.c | =A0 10 ++++++++++
>> 1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 58d0e7a..4ee21ac 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -213,6 +213,16 @@ static int mt_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
>> =A0 =A0 =A0 struct mt_class *cls =3D td->mtclass;
>> =A0 =A0 =A0 __s32 quirks =3D cls->quirks;
>>
>> + =A0 =A0 /* Only map fields from TouchScreen or TouchPad collection=
s.
>> + =A0 =A0 =A0 =A0 * We need to ignore fields that belong to other co=
llections
>> + =A0 =A0 =A0 =A0 * such as Mouse that might have the same GenericDe=
sktop usages. */
>> + =A0 =A0 if (field->application =3D=3D HID_DG_TOUCHSCREEN)
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_bit(INPUT_PROP_DIRECT, hi->input->prop=
bit);
>> + =A0 =A0 else if (field->application =3D=3D HID_DG_TOUCHPAD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_bit(INPUT_PROP_POINTER, hi->input->pro=
pbit);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;

Maybe I'm wrong, but 0 means that hid-input will decide what to do.
Maybe we should return -1 instead, to be sure not handling this part.

>> +
>> =A0 =A0 =A0 switch (usage->hid & HID_USAGE_PAGE) {
>>
>> =A0 =A0 =A0 case HID_UP_GENDESK:
>> --
>> 1.7.0.4
>>
>
>
> Looks clever to me. Still, in principle we should check that all (or =
at least most) known devices fill the application field properly. I'll =
try to have a look at the report descriptors we have here.

I checked (with some greps) the reports we have, and it seems that all
the device we know provide this application. So it should be safe, but
I'm not able to test it.
St=E9phane, if you have the time to test it on our lab's devices that
would be great.

Cheers,
Benjamin

>
> St.
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
