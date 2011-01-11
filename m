From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v3 3/5] hid-multitouch: support for PixCir-based panels
Date: Tue, 11 Jan 2011 14:53:45 +0100
Message-ID: <AANLkTikqApgrHEh90dvw+8zUne1HA3FmDQYGeEnqZ2W6@mail.gmail.com>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294425762-29730-4-git-send-email-benjamin.tissoires@enac.fr>
	<20110107194918.GB29913@polaris.bitmath.org>
	<AANLkTin8tHO5x2SBugSaEQ6mJ-7upS2YX9OANK1phmdM@mail.gmail.com>
	<20110111130055.GB1961@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36384 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab1AKNxr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 08:53:47 -0500
In-Reply-To: <20110111130055.GB1961@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 11, 2011 at 2:00 PM, Henrik Rydberg <rydberg@bitmath.org> w=
rote:
>> >> +static int mt_compute_slot(struct mt_device *td)
>> >> +{
>> >> + =A0 =A0 struct mt_class *cls =3D td->mtclass;
>> >> +
>> >> + =A0 =A0 if (cls->quirks & MT_QUIRK_SLOT_IS_CONTACTID)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return slot_is_contactid(td);
>> >
>> > No real need for a function call here...
>>
>> just to prepare for the other patches
>
> I mean the line could simply read
>
> =A0 =A0 =A0 =A0return td->curdata.contactid;

If you want, but we will loose consistency in between the different
slot computation functions.

>
> [...]
>> >> +static int mt_event(struct hid_device *hid, struct hid_field *fi=
eld,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
hid_usage *usage, __s32 value)
>> >> +{
>> >> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hid);
>> >> +
>> >> + =A0 =A0 if (hid->claimed & HID_CLAIMED_INPUT) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 switch (usage->hid) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_INRANGE:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curvalid =3D value;
>> >
>> > I do not think curvalid should depend on the touch state (which is
>> > what tipswitch is). Either move to INRANGE, or simply set to true.
>>
>> INRANGE is not all the time used as curvalid as you are saying.
>> At least for Stantum, curvalid is given by CONFIDENCE.
>
> Yes.
>
>> The solution of giving the value true to curvalid is not working too=
:
>> Cypress devices can send their touches over 2 reports of 7 touches,
>> even if it handles 10 touches.
>
> Yes.
>
>> Solution:
>> 1) td->curvalid =3D td->num_received < td->mtclass->maxcontacts;
>> (not sure it will work for all devices)
>
> For the ones where NOT_SEEN_MEANS_UP, it ought to be true. For egalax=
,
> it is not true.

After thinking about it, this case doesn't work at all. It's working
for cypress devices only because we are not using the default slot
retrieval function.
This device sends contactid=3D0 when the touch is not in range, and
starts for the in range touches at 0 too. The MT_CLS_CYPRESS saved us
here, but it won't save other devices.

>
>>
>> or 2) introduce MT_QUIRK_VALID_IS_INRANGE and MT_QUIRK_VALID_IS_CONF=
IDENCE
>
> Yes, I believe this is a good way to go.

Will do this way, but it might implies another patch for generaltouch
devices as I don't know if inrange or confidence is used.

>
>> or 3) let curvalid=3Dvalue and disable the quirk
>> MT_QUIRK_NOT_SEEN_MEANS_UP (adding a FixMe comment above)
>
> This would mean setting curvalid =3D touch_state again, which accordi=
ng
> to the discussion is precisely what we should not do. We know we need
> to check whether the incoming packet represents data is whether it is
> just filling up the transfer protocol size. We just need to identify,
> per device, how that is done.
>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->num=
_expected =3D value - 1;
>> >
>> > The - 1 should be dropped here.
>>
>> Here is the really tricky one:
>>
>> if I drop -1,
>>
>> the test below will be:
>> =A0if (field->index =3D=3D td->last_field_index
>> =A0 =A0 =A0 && td->num_received >=3D td->num_expected)
>>
>> but during the init of the device, the kernel receive 1 event though
>> the driver is not ready.
>
> So the current code really needs to also check whether the driver is
> ready to events. Adding a state for it would be appropriate. As it
> stands, an unrelated syntatic oddity is covering up this fact.
>
>>
>> During this time, num_expected is at 0, and when we receive the
>> last_field_index: segfault!
>>
>> To sum up, no, we can't.
>
> Yes we can. :-)

I'll look into it but I promise nothing.

Thanks,
Benjamin

>
>> >> + =A0 =A0 if (field->index =3D=3D td->last_field_index
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 && td->num_received > td->num_expected)
>> >
>> > A ">=3D" here.
>
> still applies then.
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
