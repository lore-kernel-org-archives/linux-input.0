From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 0/2] input: mt: Add EVIOC mechanism for MT slots
Date: Thu, 27 May 2010 14:33:08 +0200
Message-ID: <4BFE6684.5030908@euromail.se>
References: <1274788379-11026-1-git-send-email-rydberg@euromail.se> <20100525173446.GA4634@core.coreip.homeip.net> <4BFC2A7D.50501@euromail.se> <20100525202340.GD4455@core.coreip.homeip.net> <AANLkTimR3VN21URkandBGhPjWYdkdFP2zmAVscyRbqtW@mail.gmail.com> <20100527070310.GC17625@core.coreip.homeip.net> <4BFE1A5A.8010802@cena.fr> <20100527072438.GA13188@core.coreip.homeip.net> <4BFE54D7.3090300@cena.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:48319 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750831Ab0E0Mdp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 May 2010 08:33:45 -0400
In-Reply-To: <4BFE54D7.3090300@cena.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <tissoire@cena.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

Benjamin Tissoires wrote:
>=20
>=20
> Le 27/05/2010 09:24, Dmitry Torokhov a =E9crit :
>> On Thu, May 27, 2010 at 09:08:10AM +0200, Benjamin Tissoires wrote:
>>> Le 27/05/2010 09:03, Dmitry Torokhov a =E9crit :
>>>> On Wed, May 26, 2010 at 08:59:35AM -0700, Ping Cheng wrote:
>>>>> On Tue, May 25, 2010 at 1:23 PM, Dmitry Torokhov
>>>>> <dmitry.torokhov@gmail.com>   wrote:
>>>>>> On Tue, May 25, 2010 at 09:52:29PM +0200, Henrik Rydberg wrote:
>>>>>>> Dmitry Torokhov wrote:
>>>>>>>> Hi Henrik,
>>>>>>>>
>>>>>>>> On Tue, May 25, 2010 at 01:52:57PM +0200, Henrik Rydberg wrote=
:
>>>>>>>>> These patches are in response to the discussion about input s=
tate
>>>>>>>>> retrieval.
>>>>>>>>>
>>>>>>>>> The current EVIOCGABS method does not work with MT slots.  Th=
ese
>>>>>>>>> patches provides a mechanism where a slot is first selected v=
ia
>>>>>>>>> a call
>>>>>>>>> to EVIOCSABS, after which the corresponding MT events can be
>>>>>>>>> extracted
>>>>>>>>> with calls to EVIOCGABS.
>>>>>>>>>
>>>>>>>>> The symmetric operation, to set the MT state via EVIOCSABS,
>>>>>>>>> seems to
>>>>>>>>> violate input data integrity, and is therefore not implemente=
d.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This looks sane, however the question remains - is there any
>>>>>>>> users for
>>>>>>>> this data? Like I mentioned, I can see the need to fetch state=
 of
>>>>>>>> switches and ranges of absolute axis, and even non-multitouch
>>>>>>>> ABS values
>>>>>>>> (due to the fact that some input devices, like sliders, may st=
ay
>>>>>>>> in a
>>>>>>>> certain position for long periods of time), but I expect
>>>>>>>> multitouch data
>>>>>>>> to be "refreshed" very quickly.
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>>
>>>>>>>
>>>>>>> There were some voices addressing this issue, and the patches a=
re
>>>>>>> here,
>>>>>>> available for whomever to pick up. Drop them if you wish, I wil=
l
>>>>>>> not send them anew.
>>>>>>>
>>>>>>
>>>>>> I'll save them in my queue but will hold off applying until I he=
ar
>>>>>> userspace folks requesting such functionality.
>>>>>
>>>>> Hi Dmitry,
>>>>>
>>>>> You do have a valid point - the (x,y) from a touch object would m=
ost
>>>>> likely change all the time. Even if the object itself is in a ste=
ady
>>>>> state on the digitizer, i.e., without any intentional movement, t=
he
>>>>> electronic noise would most likely lead to some (x,y) changes. So=
, the
>>>>> chance that we need to retrieve (x,y) is rare.
>>>>>
>>>>> However, it is possibe that when X driver starts, an object was
>>>>> already on the digitizer. And the digitizer is of such a high qua=
lity
>>>>> :), it filtered all the noises so we can not locate the touch wit=
hout
>>>>> a EVIOCGABS call.
>>>>>
>>>>> Plus, from a pure coding/development point of view, it is not a b=
ad
>>>>> practice to provide the equivalent features for _MT_ support as w=
e did
>>>>> for the existing input devices. At least, it doesn't hurt to make=
 the
>>>>> support consistent across devices/tools (considering touch as a n=
ew
>>>>> input device/tool).
>>>>
>>>> Ping,
>>>>
>>>> I did not say that there was a problem with the patch, I agree wit=
h it.
>>>> However if no one using this - why should we bother? Will _you_ ut=
ilize
>>>> this functionality in Wacom X driver? If so let me know and I will
>>>> merge
>>>> it.
>>>>
>>>
>>> Hi Dmitry,
>>>
>>> I'm the guy who submitted some patchs to enable multitouch in the
>>> xf86-input-evdev driver. And I think that I will use the MT_SLOTS a=
s
>>> soon as they are available. It is much easier for the upper part to
>>> have this protocol instead of the protocol type A.
>>>
>>
>> This is not the question about slotted protocol (which is everyone
>> agrees is needed), the question is whether anyone will use EIVICGABS=
 to
>> retrieve the initial MT values in case someone started touching the
>> device before X opened the corresponding /dev/input/eventX.
>>
>=20
> Sorry for the misunderstanding.
>=20
> I can see at least 2 scenarios where such feature is interesting.
>=20
> Scenario n=B01:
> Imagine a mt-enabled surface, like the Microsoft Surface or other big
> devices. On these tables, we can put static objects that can be
> recognized by a tag or just by their weight, size, etc. These objects
> can be put before the X server starts and may be of interest. But sin=
ce
> these objects are "statics" the kernel driver does not send new value=
s
> and the X server does not see them, until they are moved by a human.
>=20
> Here, I did not understood if the patch allows us to retrieve all slo=
ts
> that are currently present on the surface or if we can have only the
> last one.
>=20
> Scenario n=B02:
> The Apple Magicmouse. This device is a mouse with a mt-surface on top=
 of
> it. If the filter is good enough, the device won't send the positions=
 of
> the fingers that are on the surface as we have quite a static positio=
n
> while handling a mouse. In the case a user starts X and has a hand on
> the mouse, the X server won't see them until they are actually moved.
> This may not be a problem but if we need to know the mt-state while
> sending the clicks, the driver can misunderstand the user aim.
> But from what I understood, if the user has only one contact on the
> surface, the slot will not be send and the X driver will be a little =
bit
> lost concerning the slot in use.
>=20
> So, I don't know if those patches will fit my needs, but for me, it i=
s
> clear that the X server will need to retrieve the state of the
> mt-surface when the device is initialized.
>=20
> I hope I'm not too far from the topic....
>=20
> Cheers,
> Benjamin

Thank you Benjamin, you got it all right. I thought something similar t=
o what
you describe when writing the patches. I agree with Dmitry that in gene=
ral, an
MT contact state is dynamic enough not to need much state initializatio=
n, but I
also agree with you that there are cases where it is indeed needed.

Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
