From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Fri, 05 Dec 2008 20:32:26 +0200
Message-ID: <493973BA.1010902@gmail.com>
References: <200811262333.45245.lukasz@lubojanski.info>	 <alpine.LNX.1.10.0811281514210.19853@jikos.suse.cz>	 <49303827.4050907@gmail.com>	 <200811282008.41601.lukasz@lubojanski.info>	 <alpine.LNX.1.10.0811292327470.19853@jikos.suse.cz>	 <92cd8c320812041235u6bf501d9ta473398bc1374aac@mail.gmail.com> <92cd8c320812041255i1a8bb4ces9468d2821ab7c620@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:59726 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbYLESkE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Dec 2008 13:40:04 -0500
In-Reply-To: <92cd8c320812041255i1a8bb4ces9468d2821ab7c620@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?xYF1a2FzeiBMdWJvamHFhHNraQ==?= <lukasz@lubojanski.info>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

=C5=81ukasz Luboja=C5=84ski wrote:
> On Thu, Dec 4, 2008 at 9:35 PM, =C5=81ukasz Luboja=C5=84ski
> <lukasz@lubojanski.info> wrote:
>> 2008/11/29 Jiri Kosina <jkosina@suse.cz>:
>>> On Fri, 28 Nov 2008, =C5=81ukasz Luboja=C5=84ski wrote:
>>>
>>>>> It seems the protocol resembles more the hid-lg2ff one. The diffe=
rences
>>>>> are the additional 0xfa 0xfe 0x0 report sent to the device, and t=
he
>>>>> missing 0xf3 stop command.
>>>> Yep - different reports are send in case of Pantherlord and GreenA=
sia
>>>> 0x12 - It could be implemented in it but it will require checking =
what
>>>> hardware is used and send different reports.
>>> OK, so as the reports are not really identical, and in the future w=
e might
>>> discover that there are many more other Greenasia devices which req=
uire a
>>> slightly different handling as well, I would rather prefer to have =
it as a
>>> separate driver, to avoid additions of here-and-there device-specif=
ic
>>> quirks to random places in the code. That's exactly what we are try=
ing to
>>> avoid with the HID bus approach in the first place.
>>>
>>> So I think separate driver is fine.
>>>
>>> Thanks to both of you.
>>>
>>> --
>>> Jiri Kosina
>>> SUSE Labs
>> Hi,
>>
>> Here is new version of the GreenAsia patch - I hope this time
>> everything will be OK. It is based on the Pantherlord.
>>
>> Sorry to take so long but I have problems with the 2.6.28 (2.6.28-rc=
6
>> was not loading my driver and 2.6.28-rc7 is crashing when IO APIC is
>> enabled). Anyway I done it and I'm waiting for your feedback :D


> +static const signed short ff_rumble[] =3D {
> +	FF_RUMBLE,
> +	-1
> +};

This seems unnecessary.

> +
> +	list_for_each_entry(hidinput, &hid->inputs, list) {
> +
> +		report_ptr =3D report_ptr->next;
> +
> +		if (report_ptr =3D=3D report_list) {
> +			dev_err(&hid->dev, "required output report is "
> +					"missing\n");
> +			return -ENODEV;
> +		}
[...]
> +	if (id->driver_data)
> +		hdev->quirks |=3D HID_QUIRK_MULTI_INPUT;
>

Is this really a HID_QUIRK_MULTI_INPUT device (Multiple controllers on=20
one device, for example a 2-in-1 adapter)? Just asking because your=20
previous patch didn't have this.

If this is not the case, there is also no need to have 2 new Kconfig=20
entries, but a simple FF-only entry (see ZEROPLUS_FF / hid-zpff.c).

--=20
Anssi Hannula

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
