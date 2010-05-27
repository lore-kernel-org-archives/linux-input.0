From: Benjamin Tissoires <tissoire@cena.fr>
Subject: Re: [PATCH 0/2] input: mt: Add EVIOC mechanism for MT slots
Date: Thu, 27 May 2010 13:17:43 +0200
Message-ID: <4BFE54D7.3090300@cena.fr>
References: <1274788379-11026-1-git-send-email-rydberg@euromail.se> <20100525173446.GA4634@core.coreip.homeip.net> <4BFC2A7D.50501@euromail.se> <20100525202340.GD4455@core.coreip.homeip.net> <AANLkTimR3VN21URkandBGhPjWYdkdFP2zmAVscyRbqtW@mail.gmail.com> <20100527070310.GC17625@core.coreip.homeip.net> <4BFE1A5A.8010802@cena.fr> <20100527072438.GA13188@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fw.tls.cena.fr ([195.83.98.200]:40444 "EHLO
	mailhost.tls.cena.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051Ab0E0LZE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 May 2010 07:25:04 -0400
In-Reply-To: <20100527072438.GA13188@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>



Le 27/05/2010 09:24, Dmitry Torokhov a =E9crit :
> On Thu, May 27, 2010 at 09:08:10AM +0200, Benjamin Tissoires wrote:
>> Le 27/05/2010 09:03, Dmitry Torokhov a =E9crit :
>>> On Wed, May 26, 2010 at 08:59:35AM -0700, Ping Cheng wrote:
>>>> On Tue, May 25, 2010 at 1:23 PM, Dmitry Torokhov
>>>> <dmitry.torokhov@gmail.com>   wrote:
>>>>> On Tue, May 25, 2010 at 09:52:29PM +0200, Henrik Rydberg wrote:
>>>>>> Dmitry Torokhov wrote:
>>>>>>> Hi Henrik,
>>>>>>>
>>>>>>> On Tue, May 25, 2010 at 01:52:57PM +0200, Henrik Rydberg wrote:
>>>>>>>> These patches are in response to the discussion about input st=
ate
>>>>>>>> retrieval.
>>>>>>>>
>>>>>>>> The current EVIOCGABS method does not work with MT slots.  The=
se
>>>>>>>> patches provides a mechanism where a slot is first selected vi=
a a call
>>>>>>>> to EVIOCSABS, after which the corresponding MT events can be e=
xtracted
>>>>>>>> with calls to EVIOCGABS.
>>>>>>>>
>>>>>>>> The symmetric operation, to set the MT state via EVIOCSABS, se=
ems to
>>>>>>>> violate input data integrity, and is therefore not implemented=
=2E
>>>>>>>>
>>>>>>>
>>>>>>> This looks sane, however the question remains - is there any us=
ers for
>>>>>>> this data? Like I mentioned, I can see the need to fetch state =
of
>>>>>>> switches and ranges of absolute axis, and even non-multitouch A=
BS values
>>>>>>> (due to the fact that some input devices, like sliders, may sta=
y in a
>>>>>>> certain position for long periods of time), but I expect multit=
ouch data
>>>>>>> to be "refreshed" very quickly.
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>
>>>>>> There were some voices addressing this issue, and the patches ar=
e here,
>>>>>> available for whomever to pick up. Drop them if you wish, I will=
 not send them anew.
>>>>>>
>>>>>
>>>>> I'll save them in my queue but will hold off applying until I hea=
r
>>>>> userspace folks requesting such functionality.
>>>>
>>>> Hi Dmitry,
>>>>
>>>> You do have a valid point - the (x,y) from a touch object would mo=
st
>>>> likely change all the time. Even if the object itself is in a stea=
dy
>>>> state on the digitizer, i.e., without any intentional movement, th=
e
>>>> electronic noise would most likely lead to some (x,y) changes. So,=
 the
>>>> chance that we need to retrieve (x,y) is rare.
>>>>
>>>> However, it is possibe that when X driver starts, an object was
>>>> already on the digitizer. And the digitizer is of such a high qual=
ity
>>>> :), it filtered all the noises so we can not locate the touch with=
out
>>>> a EVIOCGABS call.
>>>>
>>>> Plus, from a pure coding/development point of view, it is not a ba=
d
>>>> practice to provide the equivalent features for _MT_ support as we=
 did
>>>> for the existing input devices. At least, it doesn't hurt to make =
the
>>>> support consistent across devices/tools (considering touch as a ne=
w
>>>> input device/tool).
>>>
>>> Ping,
>>>
>>> I did not say that there was a problem with the patch, I agree with=
 it.
>>> However if no one using this - why should we bother? Will _you_ uti=
lize
>>> this functionality in Wacom X driver? If so let me know and I will =
merge
>>> it.
>>>
>>
>> Hi Dmitry,
>>
>> I'm the guy who submitted some patchs to enable multitouch in the
>> xf86-input-evdev driver. And I think that I will use the MT_SLOTS as
>> soon as they are available. It is much easier for the upper part to
>> have this protocol instead of the protocol type A.
>>
>
> This is not the question about slotted protocol (which is everyone
> agrees is needed), the question is whether anyone will use EIVICGABS =
to
> retrieve the initial MT values in case someone started touching the
> device before X opened the corresponding /dev/input/eventX.
>

Sorry for the misunderstanding.

I can see at least 2 scenarios where such feature is interesting.

Scenario n=B01:
Imagine a mt-enabled surface, like the Microsoft Surface or other big=20
devices. On these tables, we can put static objects that can be=20
recognized by a tag or just by their weight, size, etc. These objects=20
can be put before the X server starts and may be of interest. But since=
=20
these objects are "statics" the kernel driver does not send new values=20
and the X server does not see them, until they are moved by a human.

Here, I did not understood if the patch allows us to retrieve all slots=
=20
that are currently present on the surface or if we can have only the=20
last one.

Scenario n=B02:
The Apple Magicmouse. This device is a mouse with a mt-surface on top o=
f=20
it. If the filter is good enough, the device won't send the positions o=
f=20
the fingers that are on the surface as we have quite a static position=20
while handling a mouse. In the case a user starts X and has a hand on=20
the mouse, the X server won't see them until they are actually moved.=20
This may not be a problem but if we need to know the mt-state while=20
sending the clicks, the driver can misunderstand the user aim.
But from what I understood, if the user has only one contact on the=20
surface, the slot will not be send and the X driver will be a little bi=
t=20
lost concerning the slot in use.

So, I don't know if those patches will fit my needs, but for me, it is=20
clear that the X server will need to retrieve the state of the=20
mt-surface when the device is initialized.

I hope I'm not too far from the topic....

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
