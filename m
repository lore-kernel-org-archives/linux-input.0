From: =?UTF-8?B?5rSq5LiA56u5IA==?= <sam.hung@emc.com.tw>
Subject: RE: input: elantech.c: adding more Fujtisu notebooks to force crc_enabled
Date: Tue, 3 Feb 2015 20:50:27 +0800
Message-ID: <001a01d03faf$fc9d7a70$f5d86f50$@emc.com.tw>
References: <54C74A69.7060105@ts.fujitsu.com> <20150127232752.GA24529@dtor-ws> <CEAEAFEECC474A8ABBE703BECE8C37CF@elan.corp> <000801d03f4c$c7c33d70$5749b850$@emc.com.tw> <54D0BEE4.10906@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:40105 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933770AbbBCMub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2015 07:50:31 -0500
In-Reply-To: <54D0BEE4.10906@ts.fujitsu.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Rainer Koenig' <Rainer.Koenig@ts.fujitsu.com>, 'duson' <dusonlin@emc.com.tw>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jeff.chuang7178@gmail.com, james.chen@emc.com.tw, herman.lin@emc.com.tw

Dear Rainer:

This information is useful.
I really appreciate your help!

BR,
Sam
-----Original Message-----
=46rom: Rainer Koenig [mailto:Rainer.Koenig@ts.fujitsu.com]=20
Sent: Tuesday, February 03, 2015 8:28 PM
To: =E6=B4=AA=E4=B8=80=E7=AB=B9; 'duson'; 'Dmitry Torokhov'
Cc: linux-input@vger.kernel.org; jeff.chuang7178@gmail.com; james.chen@=
emc.com.tw; herman.lin@emc.com.tw
Subject: Re: input: elantech.c: adding more Fujtisu notebooks to force =
crc_enabled

Dear Sam,

unfortunately I'm on sick leave this week so far away from my lab and w=
ith no access to the system. What data do you need?
On request of Ulrik I had a look at the firmware and capabilities and p=
osted another "patch" last week, maybe this already answers your questi=
on.


+ * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw button=
s
+ * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw button=
s

If this doesn't help then please be patient until next week when I'm ba=
ck in the lab.

Regards
Rainer

Am 03.02.2015 um 02:00 schrieb =E6=B4=AA=E4=B8=80=E7=AB=B9 :
> Dear Rainer:
>=20
> Please help us get the computer records.
> as below steps:
>=20
> Step1.open terminal.
> Step2.reboot pc
> Step3.dmesg > elanTouch.txt
> Step4.send elanTouch.txt to me.
>=20
> **Keeping mount elan Touchpad on PC.
>=20
> Thanks!
>=20
> BR,
> Sam
> -----Original Message-----
> From: duson [mailto:dusonlin@emc.com.tw]
> Sent: Wednesday, January 28, 2015 11:38 AM
> To: 'Dmitry Torokhov'; 'Rainer Koenig'; sam.hung@emc.com.tw
> Cc: linux-input@vger.kernel.org; jeff.chuang7178@gmail.com;=20
> james.chen@emc.com.tw; herman.lin@emc.com.tw
> Subject: RE: input: elantech.c: adding more Fujtisu notebooks to forc=
e=20
> crc_enabled
>=20
>  Loop Sam
>=20
> Hi Sam,
> Please help to take care this.
>=20
> Duson
>=20
>> -----Original Message-----
>> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>> Sent: Wednesday, January 28, 2015 7:28 AM
>> To: Rainer Koenig
>> Cc: linux-input@vger.kernel.org; jeff.chuang7178@gmail.com;=20
>> james.chen@emc.com.tw; herman.lin@emc.com.tw; Duson Lin
>> Subject: Re: input: elantech.c: adding more Fujtisu notebooks to=20
>> force crc_enabled
>>
>> On Tue, Jan 27, 2015 at 09:20:57AM +0100, Rainer Koenig wrote:
>>> Extending the patch from November 2014 with two more
>> Fujitsu LIFEBOOK
>>> models that also ship the Elantech touchpad and don't work with=20
>>> crc_disabled.
>>>
>>> Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
>>
>> Applied, thank you.
>>
>> However I am not happy with the direction we are going - the fact=20
>> that we need to add more and more laptops to the quirk.  It would be=
=20
>> better if we could detect whether we need CRC or not by querying the=
=20
>> touchpad somehow. Elantech folks, could you help us here?
>>
>> Thanks!
>>
>>>
>>> ---
>>> My responsibility is enabling Linux on Fujitsu desktops and
>> sometimes
>>> also notebooks. Stumbled into this issue during investigation of a=20
>>> customer project and successfully tested the patch on both machines=
=2E
>>>
>>> diff -uNr old/drivers/input/mouse/elantech.c
>> new/drivers/input/mouse/elantech.c
>>> --- old/drivers/input/mouse/elantech.c	2015-01-27=20
>> 08:51:18.101122218 +0100
>>> +++ new/drivers/input/mouse/elantech.c	2015-01-27=20
>> 08:51:00.880921663 +0100
>>> @@ -1475,6 +1475,20 @@
>>>  			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
>>>  		},
>>>  	},
>>> +	{
>>> +		/* Fujitsu LIFEBOOK E554  does not work with
>> crc_enabled =3D=3D 0 */
>>> +		.matches =3D {
>>> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
>>> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E554"),
>>> +		},
>>> +	},
>>> +	{
>>> +		/* Fujitsu LIFEBOOK E544  does not work with
>> crc_enabled =3D=3D 0 */
>>> +		.matches =3D {
>>> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
>>> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E544"),
>>> +		},
>>> +	},
>>>  #endif
>>>  	{ }
>>>  };
>>>
>>> --
>>> Dipl.-Inf. (FH) Rainer Koenig
>>> Project Manager Linux Clients
>>> Dept. PDG WPS R&D SW OSE
>>>
>>> Fujitsu Technology Solutions
>>> B=C3=BCrgermeister-Ullrich-Str. 100
>>> 86199 Augsburg
>>> Germany
>>>
>>> Telephone: +49-821-804-3321
>>> Telefax:   +49-821-804-2131
>>> Mail:      mailto:Rainer.Koenig@ts.fujitsu.com
>>>
>>> Internet         ts.fujtsu.com
>>> Company Details  ts.fujitsu.com/imprint.html
>>
>> --
>> Dmitry
>>
>=20
>=20
>=20


--
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Business Clients
Dept. TSP WPS R&D SW OSE

=46ujitsu Technology Solutions
B=C3=BCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujitsu.com
Company Details  ts.fujitsu.com/imprint.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
