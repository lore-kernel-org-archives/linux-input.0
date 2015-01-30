From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: Re: input: elantech.c: adding comment lines for Fujitsu notebooks
Date: Fri, 30 Jan 2015 08:13:34 +0100
Message-ID: <54CB2F1E.3010703@ts.fujitsu.com>
References: <54CA259B.8050602@ts.fujitsu.com> <20150129223521.GA7563@lantern>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:46315 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbA3HNf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 02:13:35 -0500
In-Reply-To: <20150129223521.GA7563@lantern>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "ulrik.debie-os@e2big.org" <ulrik.debie-os@e2big.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Hi Ulrik,

That trackpoint thing is correct, but its because of what happened with
the machines. I got them for a problem analysis out of a customer
project. Customer complained that touchpad is not working, so in the
first attempt we found out that you can make it somehow work by
submitting the kernel parameter "psmouse.proto=3Dimps".

Customer didn't accept this parameter stuff, so I digged deeper into th=
e
problem. And we suspected that maybe the trackpoint device is
influencing the behaviour of the touchpad, so we changed keyboards on
both notebooks so that we had no trackpoint devices on both of them.

The E554 data comes from a dmesg-file I recorded at that time. Then
after fixing the bug I returned the machines to the consultants. Next
day your question about the capability bits arrived and I went back to
our consultants to record data from the E544 as well. But meanwhile the=
y
replaced the keyboard again, so now we have a trackpoint. So the kernel
correctly reports it:
input: Elantech PS/2 TrackPoint as /devices/platform/i8042/serio2
/input/input20

Maybe next week I will get an extra E554 with trackpoint device, so I
can see what happens. BTW: We have another notebook with a Synaptics
touchpad (LIFEBOOK E754) that is causing me headaches because the
touchpad doesn't work when the keyboard has the trackpoint, but it work=
s
without problems when there is no trackpoint device. I guess I have to
spend some more effort on understanding and analyzing this issues. Just
needs some time and the availability of the test machines (working on t=
hat).

Best regards
Rainer

Am 29.01.2015 um 23:35 schrieb ulrik.debie-os@e2big.org:
>=20
> Thanks Rainer,
>=20
> According to the top bit of the first byte of the caps, the Fujitsu L=
IFEBOOK
> E544 reports a trackpoint, the Fujitsu LIFEBOOK E554 does not.
>=20
> This would mean that if you equip the E544 with a trackpoint, the tra=
ckpoint=20
> will work with the next kernel release, but the trackpoint of the E55=
4, when=20
> the laptop is equipped with a trackpoint, will not.
>=20
> I wonder if you can make the trackpoint work on the E554 when equippe=
d
> with trackpoint when you force the if test=20
>        /* The MSB indicates the presence of the trackpoint */
>         if ((etd->capabilities[0] & 0x80) =3D=3D 0x80) {
> to always succeed ?
>=20
> Thanks,
> Kind regards,
> Ulrik
>=20
> On Thu, Jan 29, 2015 at 01:20:43PM +0100, Rainer Koenig wrote:
>> Ulrik asked me to add some comment lines for the patch I submitted o=
n January 27.
>>
>> Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
>> ---
>>
>> diff -uNr old/drivers/input/mouse/elantech.c new/drivers/input/mouse=
/elantech.c
>> --- old/drivers/input/mouse/elantech.c	2015-01-29 13:10:04.628549594=
 +0100
>> +++ new/drivers/input/mouse/elantech.c	2015-01-29 13:12:38.574624972=
 +0100
>> @@ -1097,6 +1097,8 @@
>>   * Asus UX31               0x361f00        20, 15, 0e      clickpad
>>   * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
>>   * Avatar AVIU-145A2       0x361f00        ?               clickpad
>> + * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw but=
tons
>> + * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw but=
tons
>>   * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw but=
tons (**)
>>   * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw but=
tons
>>   * Lenovo L430             0x350f02        b9, 15, 0c      2 hw but=
tons (*)
>>
>> --=20
>> Dipl.-Inf. (FH) Rainer Koenig
>> Project Manager Linux Clients
>> Dept. PDG WPS R&D SW OSE
>>
>> Fujitsu Technology Solutions
>> B=FCrgermeister-Ullrich-Str. 100
>> 86199 Augsburg
>> Germany
>>
>> Telephone: +49-821-804-3321
>> Telefax:   +49-821-804-2131
>> Mail:      mailto:Rainer.Koenig@ts.fujitsu.com
>>
>> Internet         ts.fujtsu.com
>> Company Details  ts.fujitsu.com/imprint.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
Dept. PDG WPS R&D SW OSE

=46ujitsu Technology Solutions
B=FCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujtsu.com
Company Details  ts.fujitsu.com/imprint.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
