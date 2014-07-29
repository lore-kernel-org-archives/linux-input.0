From: "Murphy, Dan" <dmurphy@ti.com>
Subject: Re: [v2] input: drv260x: Add TI drv260x haptics driver
Date: Tue, 29 Jul 2014 13:41:57 +0000
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49DB2A71@DFLE09.ent.ti.com>
References: <1406566403-1436-1-git-send-email-dmurphy@ti.com>
 <5adf0339146a7b655a77053195aa892c.squirrel@mungewell.org>
 <00FC9A978A94B7418C33AFAE8A35ED49DB1A79@DFLE09.ent.ti.com>
 <2696156.zc98nP9bBH@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38114 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbaG2NmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 09:42:06 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: "simon@mungewell.org" <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Elias Vanderstuyft <elias.vds@gmail.com>

Michal

Thanks for the feedback

On 07/29/2014 07:09 AM, Michal Mal=FD wrote:
> On Monday 28 of July 2014 21:21:26 Murphy, Dan wrote:
>> Dmitry
>>
>> On 07/28/2014 12:59 PM, simon@mungewell.org wrote:
>>>>> The initial driver supports the devices
>>>>> real time playback mode.  But the device
>>>>> has additional wave patterns in ROM.
>>>>
>>>> As it presented the device appears to be a memoryless device, howe=
ver
>>>> you present it to the rest of the system as if it can support play=
back
>>>> of multiple effects simultaneously, which is incorrect.
>>>>
>>>> My guess that you need to engage the memoryless input library to s=
chedule
>>>> handling multiple effects for your device, including ramping up, r=
amping
>>>> down, stopping playback when effects runs out, etc.
>>>
>>> Hi Dan,
>>> Elias and Michal (cc'ed) are working on a kernel/userland library t=
o
>>> handle sending multiple force feedback signals to 'simple' devices,
>>> perhaps you should engage with them.
>>>
>>> Simon
>=20
> Hi Dan,
>=20
> since I spent some time trying to improve the memoryless library I ca=
n=20
> hopefully provide you with some hints.
>=20
> If I'm reading this right, your device cannot play more than one effe=
ct at once=20
> but it can operate eihter in RTP mode where the user controls the ope=
ration of=20
> the motors directly on in an automated mode where the device follows =
some pre-
> programmed waveform. These two modes are mutually exclusive.

Actually there is one other mode here, that is the ability to program i=
n a
waveform to be played.  So that makes 3 modes I have to think about sup=
porting.

I know there are products out there that would like to and do customize=
 their feedback
based on certain user actions.

=46or the custom mode I could use the FF_CUSTOM id but not sure
how that fits into the Periodic structure.  If I can get two out of 3 t=
hat would be
great.

>=20
> If my understanding of the problem is correct, you will struggle both=
 with=20
> memoryless library and your own imlementation. The memoryless library=
 is quite=20
> simplistic and it doesn't have any sort of "passthrough" mode so you =
would not=20
> be able to do anything besides RTP that way.
>=20
> On the other hand if you decide to write your own implementation of e=
ffect=20
> handling you will end up duplicating a lot of code that already exist=
s in the=20
> memoryless library and has been proven to work.
>=20
> A possible solution for the problem would be to separate the function=
s that=20
> control effect timing from the memoryless library and make them globa=
lly=20
> accessible. I believe that this would simplify any customized haptic=20
> implementation considerably and it might be a decent interim solution=
 before=20
> the project Simon mentioned is ready.

How far are you on finishing the project?
If it is only a little bit out I can just keep with the memless RTP mod=
e
as a start and then implement the other functions once the solution is =
accepted.

Dan

>=20
> If there is anybody interested in such a solution I can probably whip=
 up a=20
> patch for it quite quickly.
>=20
> Regards,
> Michal
>=20


--=20
------------------
Dan Murphy
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
