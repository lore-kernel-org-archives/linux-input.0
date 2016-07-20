From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: Stop mapping touch usages after processing
 HID_DG_CONTACTCOUNT
Date: Wed, 20 Jul 2016 09:36:28 -0700
Message-ID: <a4fa624b-5464-7a6b-52dc-9b370ebdc507@gmail.com>
References: <20160711175950.17121-1-killertofu@gmail.com>
 <20160712073250.GE4663@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33860 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbcGTQgb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 12:36:31 -0400
Received: by mail-pf0-f195.google.com with SMTP id g202so3772199pfb.1
        for <linux-input@vger.kernel.org>; Wed, 20 Jul 2016 09:36:31 -0700 (PDT)
In-Reply-To: <20160712073250.GE4663@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On 07/12/2016 12:32 AM, Benjamin Tissoires wrote:
> Hi Jason,
>=20
> On Jul 11 2016 or thereabouts, Jason Gerecke wrote:
>> If a touchscreen contains both multitouch and single-touch reports i=
n its
>> descriptor in that order, the driver may overwrite information it sa=
ved
>> about the format of the multitouch report. This can cause the report
>> processing code to get tripped up and send an incorrect event stream=
 to
>> userspace.
>>
>> In particular, this can cause last_slot_field to be overwritten with=
 the
>> result that the driver prematurely assumes it has finished processin=
g a
>> slot and sending the ABS_MT_SLOT event at the wrong point in time,
>> associating events for the current contact with the following contac=
t
>> instead.
>>
>> To prevent this from occuring, we stop mapping usages after having s=
een
>> HID_DG_CONTACTCOUNT. This usage is only present in multitouch report=
s,
>> so the format of any following single-touch reports will have no eff=
ect.
>=20
> I had a quick look at the driver, and it looks like the Cintiq Compan=
ion
> 2 has more than one multitouch collection (see 499522c "HID: wacom: T=
ie
> cached HID_DG_CONTACTCOUNT indices to report ID").
>=20
> So if this doesn't break the cintiq companion 2, you have my
> reviewed-by, but I'd rather be sure (and please see if we really need=
 to
> keep 499522c then).
>=20
> Cheers,
> Benjamin
>=20

Thanks for the reminder about 499522c. This patch should supersede it i=
n
terms of functionality, so I can make a patch to remove it instead.

As far as compatibility goes, I don't have a Companion 2 to actually
test, but looking at the descriptor [1], it shouldn't pose any problems=
:
the second report containing HID_DG_CONTACTCOUNT is the single-touch
report that we don't want to use anyway.

[1]:
https://github.com/linuxwacom/wacom-hid-descriptors/blob/master/Wacom%2=
0Cintiq%20Companion%202/0003:056A:0326.0002.hid.txt

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....

>>
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> ---
>>  drivers/hid/wacom_wac.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index fcf2264..e499cdb 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -1560,6 +1560,11 @@ static void wacom_wac_finger_usage_mapping(st=
ruct hid_device *hdev,
>>  	struct input_dev *input =3D wacom_wac->touch_input;
>>  	unsigned touch_max =3D wacom_wac->features.touch_max;
>> =20
>> +	/* stop processing after the first multitouch report */
>> +	if (wacom_wac->hid_data.cc_report &&
>> +	    wacom_wac->hid_data.cc_report !=3D field->report->id)
>> +		return;
>> +
>>  	switch (usage->hid) {
>>  	case HID_GD_X:
>>  		features->last_slot_field =3D usage->hid;
>> --=20
>> 2.9.0
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
