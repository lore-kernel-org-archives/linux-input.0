From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Wed, 9 Mar 2011 11:06:35 +0100
Message-ID: <AANLkTi=TJ3RPOSP3XyqOfX8Aeep3-uFcHmcia6+a2Wxy@mail.gmail.com>
References: <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
	<1299564524.2306.18.camel@itzy>
	<20110308080414.GA2888@polaris.bitmath.org>
	<AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
	<20110308091434.GA3282@polaris.bitmath.org>
	<AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
	<20110308094630.GA3396@polaris.bitmath.org>
	<1299627518.2306.47.camel@itzy>
	<20110309082455.GA3166@polaris.bitmath.org>
	<AANLkTikDBTFNWhYoR5B-kfZ8Ud_aiW36qrTNJsJgHdTJ@mail.gmail.com>
	<20110309092337.GC3824@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41368 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757096Ab1CIKGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2011 05:06:38 -0500
Received: by wya21 with SMTP id 21so280540wya.19
        for <linux-input@vger.kernel.org>; Wed, 09 Mar 2011 02:06:36 -0800 (PST)
In-Reply-To: <20110309092337.GC3824@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

On Wed, Mar 9, 2011 at 10:23, Henrik Rydberg <rydberg@euromail.se> wrot=
e:
>> > @@ -147,11 +163,15 @@ static int mt_input_mapping(struct hid_devic=
e *hdev, struct hid_input *hi,
>> > =A0{
>> > =A0 =A0 =A0 =A0struct mt_device *td =3D hid_get_drvdata(hdev);
>> > =A0 =A0 =A0 =A0struct mt_class *cls =3D td->mtclass;
>> > + =A0 =A0 =A0 __s32 quirks =3D cls->quirks;
>> > +
>> > =A0 =A0 =A0 =A0switch (usage->hid & HID_USAGE_PAGE) {
>> >
>> > =A0 =A0 =A0 =A0case HID_UP_GENDESK:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (usage->hid) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_GD_X:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quirks & MT_QUIR=
K_EGALAX_XYZ_FIXUP)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fiel=
d->logical_maximum =3D 32760;
>>
>> Please do not add numerical constants in a generic code. If I want t=
o
>> override the values for another device, I'll have to rename your qui=
rk
>> to MT_QUIRK_EGALAX_XYZ_FIXUP_WITH_0_32760_0_32760_0_x and add mine.
>> These values have to be moved in the MT_CLS.
>
> It is a specific value used for a specific code path, no need to
> over-generalize. =A0The quirk name could be specialized even more, i
> suppose, but the point is that it makes the hid-multitouch driver do
> exactly what is done in the hid-egalax driver, and it is easy to prov=
e
> that there are no side effects for other devices.

Or it's a generic code path for generic devices: if someone want to do
the same thing that have been done in hid-egalax (correct the logical
min/max reported by the device), this could be done.

Concerning the prove, I'm pretty sure we can manage to prove that both
solutions are equivalent as the current code already relies on the
fact that static struct are null initialized.

>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_TIPPRESSURE:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quirks & MT_QUIR=
K_EGALAX_XYZ_FIXUP)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fiel=
d->logical_minimum =3D 0;
>>
>> No really need for the test and the quirk. In addition, here you do
>> not override logical_max. This shows that the quirk is not
>> MT_QUIRK_EGALAX_XYZ_FIXUP but the combination of
>> MT_QUIRK_EGALAX_XY_FIXUP and =A0MT_QUIRK_EGALAX_Z_MIN_FIXUP.
>> Just drop it here.
>
> The added code path simply reflects what is in the hid-egalax
> driver. It is true that the statement _probably_ works for other
> devices as well, but it cannot be proven just by looking at the
> code. Also, we have no known additional case where it is needed.

I didn't told to remove the test just by looking at the code. I'm
taking in account all the devices that have been reported to us:
http://lii-enac.fr/en/architecture/linux-input/multitouch-devices.html
Among all of them, only asus, egalax (capacitive and resistive),
mosart (the same as asus), and stantum reports pressure.
Asus and mosart set only the logical maximum -> logical minimum is
therefore at 0.
Stantum does not set the min/max -> logical minimum is at 0 too.
EGalax set the minimum at 1 -> in your patch, you explained that was a
bug for the upper layers.


>
> I am trying to think of a better name for the quirk, but frankly, I
> think it already says what it needs to say.

What about MT_QUIRK_XYZ_CORRECTIONS_FOR_SPECIAL_EGALAX_DEVICES?


Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
