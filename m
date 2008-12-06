From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Sat, 06 Dec 2008 17:50:49 +0200
Message-ID: <493A9F59.2090105@gmail.com>
References: <200811262333.45245.lukasz@lubojanski.info>	 <alpine.LNX.1.10.0811281514210.19853@jikos.suse.cz>	 <49303827.4050907@gmail.com>	 <200811282008.41601.lukasz@lubojanski.info>	 <alpine.LNX.1.10.0811292327470.19853@jikos.suse.cz>	 <92cd8c320812041235u6bf501d9ta473398bc1374aac@mail.gmail.com>	 <92cd8c320812041255i1a8bb4ces9468d2821ab7c620@mail.gmail.com>	 <493973BA.1010902@gmail.com> <92cd8c320812051249m39bcd8d6mb03e15e14398f01c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:52440 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbYLFPvE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Dec 2008 10:51:04 -0500
In-Reply-To: <92cd8c320812051249m39bcd8d6mb03e15e14398f01c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?xYF1a2FzeiBMdWJvamHFhHNraQ==?= <lukasz@lubojanski.info>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

=C5=81ukasz Luboja=C5=84ski wrote:
> On Fri, Dec 5, 2008 at 7:32 PM, Anssi Hannula <anssi.hannula@gmail.co=
m> wrote:
>> =C5=81ukasz Luboja=C5=84ski wrote:
>>> On Thu, Dec 4, 2008 at 9:35 PM, =C5=81ukasz Luboja=C5=84ski
>>> <lukasz@lubojanski.info> wrote:
>>>> 2008/11/29 Jiri Kosina <jkosina@suse.cz>:
>>>>> On Fri, 28 Nov 2008, =C5=81ukasz Luboja=C5=84ski wrote:
>>>>>
>>>>>>> It seems the protocol resembles more the hid-lg2ff one. The
>>>>>>> differences
>>>>>>> are the additional 0xfa 0xfe 0x0 report sent to the device, and=
 the
>>>>>>> missing 0xf3 stop command.
>>>>>> Yep - different reports are send in case of Pantherlord and Gree=
nAsia
>>>>>> 0x12 - It could be implemented in it but it will require checkin=
g what
>>>>>> hardware is used and send different reports.
>>>>> OK, so as the reports are not really identical, and in the future=
 we
>>>>> might
>>>>> discover that there are many more other Greenasia devices which r=
equire
>>>>> a
>>>>> slightly different handling as well, I would rather prefer to hav=
e it as
>>>>> a
>>>>> separate driver, to avoid additions of here-and-there device-spec=
ific
>>>>> quirks to random places in the code. That's exactly what we are t=
rying
>>>>> to
>>>>> avoid with the HID bus approach in the first place.
>>>>>
>>>>> So I think separate driver is fine.
>>>>>
>>>>> Thanks to both of you.
>>>>>
>>>>> --
>>>>> Jiri Kosina
>>>>> SUSE Labs
>>>> Hi,
>>>>
>>>> Here is new version of the GreenAsia patch - I hope this time
>>>> everything will be OK. It is based on the Pantherlord.
>>>>
>>>> Sorry to take so long but I have problems with the 2.6.28 (2.6.28-=
rc6
>>>> was not loading my driver and 2.6.28-rc7 is crashing when IO APIC =
is
>>>> enabled). Anyway I done it and I'm waiting for your feedback :D
>>
>> Is this really a HID_QUIRK_MULTI_INPUT device (Multiple controllers =
on one
>> device, for example a 2-in-1 adapter)? Just asking because your prev=
ious
>> patch didn't have this.
>>
>> If this is not the case, there is also no need to have 2 new Kconfig
>> entries, but a simple FF-only entry (see ZEROPLUS_FF / hid-zpff.c).
>>
>=20
> In case of both devices that I have the HID_QUIRK_MULTI_INPUT is not
> set - so I think the multi input code can be removed. I did that and
> it still works properly in my test :D
>=20
> I have seen that hid-zpff and hid-tmff are modules for FF only and
> hid-pl is "dummy" support for the device and if selected also for the
> FF. I was confused about it so I have chosen way of hid-pl because I
> based on it.

hid-pl just sets HID_QUIRK_MULTI_INPUT when FF is disabled. For gaff we=
=20
do not need that.

> Because the module supports only the FF now - I have changed module
> name to hid-gaff.
[...]
> +	gaff->report->field[0]->value[0] =3D 0x51;
> +	gaff->report->field[0]->value[1] =3D 0x0;
> +	gaff->report->field[0]->value[2] =3D right;
> +	gaff->report->field[0]->value[3] =3D 0;
> +	gaff->report->field[0]->value[4] =3D left;
> +	gaff->report->field[0]->value[5] =3D 0;

[...]
> +	if (list_empty(report_list)) {
> +		dev_err(&hid->dev, "no output reports found\n");
> +		return -ENODEV;
> +	}
> +
> +	report_ptr =3D report_ptr->next;

> +	if (report_ptr =3D=3D report_list) {
> +		dev_err(&hid->dev, "required output report is "
> +				"missing\n");
> +		return -ENODEV;
> +	}

Unneeded test. list_empty() call above already confirmed that there are=
=20
output reports.

> +	report =3D list_entry(report_ptr, struct hid_report, list);
> +	if (report->maxfield < 1) {
> +		dev_err(&hid->dev, "no fields in the report\n");
> +		return -ENODEV;
> +	}
> +
> +	if (report->field[0]->report_count < 4) {
> +		dev_err(&hid->dev, "not enough values in the field\n");

Here you test for only 4, while in hid_gaff_play() you use 6.

--=20
Anssi Hannula

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
