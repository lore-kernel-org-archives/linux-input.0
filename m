From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] hid-multitouch: changes from the review process
Date: Tue, 11 Jan 2011 15:00:26 +0100
Message-ID: <AANLkTimESwHSh-LMdAnb20Ss3OxW=gpTaN0QdTSfEx33@mail.gmail.com>
References: <1294743194-2310-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110111131154.GC1961@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37898 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab1AKOA2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 09:00:28 -0500
In-Reply-To: <20110111131154.GC1961@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 11, 2011 at 2:11 PM, Henrik Rydberg <rydberg@bitmath.org> w=
rote:
> Hi Benjamin,
>
> seems we are cloing in now, although there is still an outstanding
> issue with the setting of curvalid, as replied in your previous
> mail. Some comments on this patch, too.
>
>> =A0struct mt_class mt_classes[] =3D {
>> - =A0 =A0 { 0, 0, 0, 10 }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 /* MT_CLS_DEFAULT */
>> - =A0 =A0 { MT_QUIRK_SLOT_IS_CONTACTID, 0, 0, 2 }, =A0 =A0 /* MT_CLS=
_DUAL1 */
>> - =A0 =A0 { MT_QUIRK_SLOT_IS_CONTACTNUMBER, 0, 0, 10 }, =A0 =A0/* MT=
_CLS_DUAL2 */
>> - =A0 =A0 { MT_QUIRK_CYPRESS | MT_QUIRK_NOT_SEEN_MEANS_UP, 0, 0, 10 =
}, /* MT_CLS_CYPRESS */
>> + =A0 =A0 { .name =3D MT_CLS_DEFAULT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D 0,
>
> Please do not zero-initialize.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 10 },
>> + =A0 =A0 { .name =3D MT_CLS_DUAL1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_SLOT_IS_CONTACTID,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2 },
>> + =A0 =A0 { .name =3D MT_CLS_DUAL2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_SLOT_IS_CONTACTNUMBER=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2 },
>> + =A0 =A0 { .name =3D MT_CLS_CYPRESS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_CYPRESS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 10 },
>> +
>> + =A0 =A0 { }
>> =A0};
>
> So no device is marked as NOT_SEEN_MEANS_UP, although allegedly some =
devices should...

Well, my fault: I was sure that Cypress devices need the
NOT_SEEN_MEANS_UP, but in fact, it was another one. We (with Stephane)
don't recall it at the moment, but Stephane already saw some devices
that required this quirk.

mea culpa

>
>> @@ -282,11 +297,10 @@ static void mt_emit_event(struct mt_device *td=
, struct input_dev *input)
>>
>> =A0 =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mt_slot *s =3D &(td->slots[i]);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((td->mtclass->quirks & MT_QUIRK_NOT_SE=
EN_MEANS_UP) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !s->seen_in_this_frame) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!s->seen_in_this_frame) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* this slot does not co=
ntain useful data,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* notify its closure
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* FixMe: use MT_QUIRK_N=
OT_SEEN_MEANS_UP here.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This requires to chan=
ge the curvalid logic.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->touch_state =3D false=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> If we were to push this broken behavior, simply to avoid changing the
> currently tested code, we would only push the problem of testing onto
> the next cycle, with a larger risk of introducing regressions. I
> really think we need to sort this out now.

I'll do the quirk way

>
>> @@ -392,9 +407,16 @@ static void mt_set_input_mode(struct hid_device=
 *hdev)
>>
>> =A0static int mt_probe(struct hid_device *hdev, const struct hid_dev=
ice_id *id)
>> =A0{
>> - =A0 =A0 int ret;
>> + =A0 =A0 int ret, i;
>> =A0 =A0 =A0 struct mt_device *td;
>> - =A0 =A0 struct mt_class *mtclass =3D mt_classes + id->driver_data;
>> + =A0 =A0 struct mt_class *mtclass =3D mt_classes; /* MT_CLS_DEFAULT=
 */
>> +
>> + =A0 =A0 for (i =3D 0; mt_classes[i].name ; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (id->driver_data =3D=3D mt_classes[i].n=
ame) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtclass =3D &(mt_classes[i=
]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> Nice.
>
Thanks,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
