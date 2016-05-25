From: <Allen_Hung@Dell.com>
Subject: RE: Dell Latitude E7470 touchpad status
Date: Wed, 25 May 2016 12:38:15 +0800
Message-ID: <23E0F704395E694FA4710C833FA087E50D40D0723A@TPEX7ADC101.APAC.DELL.COM>
References: <87eg9j6zf7.fsf@smart-cactus.org>
 <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM>
 <87bn45gr0e.fsf@smart-cactus.org> <20160517082309.GZ29844@pali>
 <877fet10a9.fsf@smart-cactus.org> <20160517131629.GE29844@pali>
 <23E0F704395E694FA4710C833FA087E50D40B8C592@TPEX7ADC101.APAC.DELL.COM>
 <20160517152239.GF29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207]:52429 "EHLO
	ausxippc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbcEYEiV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 00:38:21 -0400
In-Reply-To: <20160517152239.GF29844@pali>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pali.rohar@gmail.com
Cc: ben@smart-cactus.org, Mario_Limonciello@Dell.com, linux-input@vger.kernel.org

Dell - Internal Use - Confidential=20

On 05/17/2016 11:22 PM, Pali Roh=E1r wrote:
> On Tuesday 17 May 2016 22:46:31 Allen_Hung@Dell.com wrote:
>> Dell - Internal Use - Confidential=20
>>
>> On 05/17/2016 09:16 PM, Pali Roh=E1r wrote:
>>> On Tuesday 17 May 2016 11:50:06 Ben Gamari wrote:
>>>> Pali Roh=E1r <pali.rohar@gmail.com> writes:
>>>>
>>>>> Hi Ben!
>>>>>
>>>>> Maybe it could help you, look at my email sent to linux-input ML =
year
>>>>> ago: http://thread.gmane.org/gmane.linux.kernel.input/41210
>>>> Hi Pali!
>>>>
>>>> Thanks, this looks great (assuming this is in fact the protocol sp=
oken
>>>> by the E7470 hardware; perhaps Allen could confirm this?). I'll ha=
ve a
>>>> go at rebasing this sometime soon, although it looks like this may=
 take
>>>> a fair bit of work as the patch is of the usual... questionable qu=
ality
>>>> that you'd expect from a hardware vendor and on top of that the dr=
iver
>>>> itself seems to have evolved significantly.
>>> First you need to identify if your touchpad is ALPS or not. If not =
then
>>> work on rebasing is useless.
>>>
>>> To identify your touchpad there are two ways:
>>>
>>> 1) Disassemble laptop and look what is under palmrest/keyboard. Lat=
itude
>>> laptops used to have good documentation how to do it (on official d=
ell
>>> site) and older Exx40 series is not hard to detect it...
>>>
>>> 2) Look at ALPS detection code. Basically all (known) ALPS touchpad
>>> response to some PS/2 sequence with specific answer. So you can com=
pile
>>> psmouse.ko/alps.c in debug mode and look if it fit detection or not=
=2E
>>>
>>> I suggest you to do this first investigation step. If touchpad is A=
LPS
>>> or not. I read that some Dell laptops uses synaptics touchpads, so =
there
>>> is non zero chance that touchpad could not be ALPS.
>>>
>>>>> Also try to look at dell drivers page, there could be linux packa=
ge for
>>>>> your laptop with drivers. Lot of them used to be in dkms format
>>>>> (upstream source code with dell changes).
>>>>>
>>>> I've been unable to find a support package for my machine on the w=
eb
>>>> site. However, I'm also in touch with Dell through the usual suppo=
rt
>>>> channel so perhaps they'll be able to provide a more up-to-date co=
de
>>>> drop.
>>> IIRC All (new) Latitude laptops can be configured with Ubuntu and i=
n
>>> this case they come with preinstalled Ubuntu with that support pack=
age.
>>>
>>> So for sure contact Dell support and ask for it! You can also see U=
buntu
>>> as supported system in PDF material about those Latitudes...
>>>
>>>>> ALPS code from Dell were open source, it was just hard to find it=
 and
>>>>> compile it on other then one kernel version. And harder to genera=
te
>>>>> patch (like I did in above email)...
>>>>>
>>>> Right, as I said it looks like rebasing this code drop onto a rece=
nt
>>>> kernel might require quite some effort.
>>> Yes, it would not be simple. Plus for including into mainline kerne=
l
>>> needs lot of cleaning (see that email thread).
>>>
>>>> I do wish that Dell would apply more pressure on their input devic=
e
>>>> vendors to take upstream support (or open protocol documentation)
>>>> seriously. It's very frustrating that we need to go through this s=
ame
>>>> process with every hardware iteration.
>>> If you will be 100% sure that touchpad is ALPS, I could contact ALP=
S
>>> people. They helped me a lot with fixing ALPS touchpad support for =
my
>>> E6440...
>>>
>>>> Thanks again for the reference, Pali!
>>>>
>>>> Cheers,
>>>>
>>>> - Ben
>>>>
>> I am confirming with Alps team for what protocol version the E7470
> Great!
>
>> device is speaking. In fact, they sent me the alps.c which support u=
p
>> to V8 and they said it's their latest one.
> Currently alps.c in mainline kernel supports protocol versions V1 to =
V8.
> So V9 is missing.
>
>> It seems the driver is older than the patch provided in Pali's link
>> (that support up to V9) so I didn't put it here.
> That patch which I sent was generated from Ubuntu support package
> provided by Dell drivers download package. So somebody in Dell should
> know more about it...
>
>> Will get the answer back to you once they confirm with me.
>>
>> - Allen
> Ok, thanks!
>

I got responds from Alps and they confirmed that the Alps devices in De=
ll systems are speaking in protocol V8. The devices that speak in proto=
col V9 are using different ASIC hardware and they are not used in Dell =
systems..

- Allen
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
