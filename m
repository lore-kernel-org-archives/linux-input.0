From: Vincent Jaubert <vjaubert@gmail.com>
Subject: Re: input: elantech.c: adding more Fujtisu notebooks to force crc_enabled
Date: Tue, 3 Feb 2015 18:17:28 +0100
Message-ID: <CANWhK-ioE7u9H8rSR9t_m8oPJp+KUeN=VDMQ1auC=dC2yrp3Yg@mail.gmail.com>
References: <54C74A69.7060105@ts.fujitsu.com>
	<20150127232752.GA24529@dtor-ws>
	<CEAEAFEECC474A8ABBE703BECE8C37CF@elan.corp>
	<000801d03f4c$c7c33d70$5749b850$@emc.com.tw>
	<54D0BEE4.10906@ts.fujitsu.com>
	<001a01d03faf$fc9d7a70$f5d86f50$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:51718 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965829AbbBCRRa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2015 12:17:30 -0500
Received: by mail-lb0-f178.google.com with SMTP id u10so39837629lbd.9
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2015 09:17:28 -0800 (PST)
In-Reply-To: <001a01d03faf$fc9d7a70$f5d86f50$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?5rSq5LiA56u5?= <sam.hung@emc.com.tw>
Cc: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>, duson <dusonlin@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, jeff.chuang7178@gmail.com, james.chen@emc.com.tw, herman.lin@emc.com.tw

My Laptop is a Fujitsu E554 with Elantech Touchpad and trackpoint.
The touchpad works correctly since Rainer's patch.
Do you still need the boot dmesg ?
With or without the patch ?

On Tue, Feb 3, 2015 at 1:50 PM, =E6=B4=AA=E4=B8=80=E7=AB=B9 <sam.hung@e=
mc.com.tw> wrote:
> Dear Rainer:
>
> This information is useful.
> I really appreciate your help!
>
> BR,
> Sam
> -----Original Message-----
> From: Rainer Koenig [mailto:Rainer.Koenig@ts.fujitsu.com]
> Sent: Tuesday, February 03, 2015 8:28 PM
> To: =E6=B4=AA=E4=B8=80=E7=AB=B9; 'duson'; 'Dmitry Torokhov'
> Cc: linux-input@vger.kernel.org; jeff.chuang7178@gmail.com; james.che=
n@emc.com.tw; herman.lin@emc.com.tw
> Subject: Re: input: elantech.c: adding more Fujtisu notebooks to forc=
e crc_enabled
>
> Dear Sam,
>
> unfortunately I'm on sick leave this week so far away from my lab and=
 with no access to the system. What data do you need?
> On request of Ulrik I had a look at the firmware and capabilities and=
 posted another "patch" last week, maybe this already answers your ques=
tion.
>
>
> + * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw butt=
ons
> + * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw butt=
ons
>
> If this doesn't help then please be patient until next week when I'm =
back in the lab.
>
> Regards
> Rainer
>
> Am 03.02.2015 um 02:00 schrieb =E6=B4=AA=E4=B8=80=E7=AB=B9 :
>> Dear Rainer:
>>
>> Please help us get the computer records.
>> as below steps:
>>
>> Step1.open terminal.
>> Step2.reboot pc
>> Step3.dmesg > elanTouch.txt
>> Step4.send elanTouch.txt to me.
>>
>> **Keeping mount elan Touchpad on PC.
>>
>> Thanks!
>>
>> BR,
>> Sam
>> -----Original Message-----
>> From: duson [mailto:dusonlin@emc.com.tw]
>> Sent: Wednesday, January 28, 2015 11:38 AM
>> To: 'Dmitry Torokhov'; 'Rainer Koenig'; sam.hung@emc.com.tw
>> Cc: linux-input@vger.kernel.org; jeff.chuang7178@gmail.com;
>> james.chen@emc.com.tw; herman.lin@emc.com.tw
>> Subject: RE: input: elantech.c: adding more Fujtisu notebooks to for=
ce
>> crc_enabled
>>
>>  Loop Sam
>>
>> Hi Sam,
>> Please help to take care this.
>>
>> Duson
>>
>>> -----Original Message-----
>>> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>>> Sent: Wednesday, January 28, 2015 7:28 AM
>>> To: Rainer Koenig
>>> Cc: linux-input@vger.kernel.org; jeff.chuang7178@gmail.com;
>>> james.chen@emc.com.tw; herman.lin@emc.com.tw; Duson Lin
>>> Subject: Re: input: elantech.c: adding more Fujtisu notebooks to
>>> force crc_enabled
>>>
>>> On Tue, Jan 27, 2015 at 09:20:57AM +0100, Rainer Koenig wrote:
>>>> Extending the patch from November 2014 with two more
>>> Fujitsu LIFEBOOK
>>>> models that also ship the Elantech touchpad and don't work with
>>>> crc_disabled.
>>>>
>>>> Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
>>>
>>> Applied, thank you.
>>>
>>> However I am not happy with the direction we are going - the fact
>>> that we need to add more and more laptops to the quirk.  It would b=
e
>>> better if we could detect whether we need CRC or not by querying th=
e
>>> touchpad somehow. Elantech folks, could you help us here?
>>>
>>> Thanks!
>>>
>>>>
>>>> ---
>>>> My responsibility is enabling Linux on Fujitsu desktops and
>>> sometimes
>>>> also notebooks. Stumbled into this issue during investigation of a
>>>> customer project and successfully tested the patch on both machine=
s.
>>>>
>>>> diff -uNr old/drivers/input/mouse/elantech.c
>>> new/drivers/input/mouse/elantech.c
>>>> --- old/drivers/input/mouse/elantech.c      2015-01-27
>>> 08:51:18.101122218 +0100
>>>> +++ new/drivers/input/mouse/elantech.c      2015-01-27
>>> 08:51:00.880921663 +0100
>>>> @@ -1475,6 +1475,20 @@
>>>>                     DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
>>>>             },
>>>>     },
>>>> +   {
>>>> +           /* Fujitsu LIFEBOOK E554  does not work with
>>> crc_enabled =3D=3D 0 */
>>>> +           .matches =3D {
>>>> +                   DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
>>>> +                   DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E554"),
>>>> +           },
>>>> +   },
>>>> +   {
>>>> +           /* Fujitsu LIFEBOOK E544  does not work with
>>> crc_enabled =3D=3D 0 */
>>>> +           .matches =3D {
>>>> +                   DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
>>>> +                   DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E544"),
>>>> +           },
>>>> +   },
>>>>  #endif
>>>>     { }
>>>>  };
>>>>
>>>> --
>>>> Dipl.-Inf. (FH) Rainer Koenig
>>>> Project Manager Linux Clients
>>>> Dept. PDG WPS R&D SW OSE
>>>>
>>>> Fujitsu Technology Solutions
>>>> B=C3=BCrgermeister-Ullrich-Str. 100
>>>> 86199 Augsburg
>>>> Germany
>>>>
>>>> Telephone: +49-821-804-3321
>>>> Telefax:   +49-821-804-2131
>>>> Mail:      mailto:Rainer.Koenig@ts.fujitsu.com
>>>>
>>>> Internet         ts.fujtsu.com
>>>> Company Details  ts.fujitsu.com/imprint.html
>>>
>>> --
>>> Dmitry
>>>
>>
>>
>>
>
>
> --
> Dipl.-Inf. (FH) Rainer Koenig
> Project Manager Linux Business Clients
> Dept. TSP WPS R&D SW OSE
>
> Fujitsu Technology Solutions
> B=C3=BCrgermeister-Ullrich-Str. 100
> 86199 Augsburg
> Germany
>
> Telephone: +49-821-804-3321
> Telefax:   +49-821-804-2131
> Mail:      mailto:Rainer.Koenig@ts.fujitsu.com
>
> Internet         ts.fujitsu.com
> Company Details  ts.fujitsu.com/imprint.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
