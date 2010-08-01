From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [PATCH 13/13] IR: Port ene driver to new IR subsystem and enable  it.
Date: 01 Aug 2010 11:43:00 +0200
Message-ID: <BU0OY67ZjFB@christoph>
References: <AANLkTi=tZaSGp3V8+4FHupzegmVrgM4-dzJb-y8YazOh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54100 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab0HAJv1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Aug 2010 05:51:27 -0400
In-Reply-To: <AANLkTi=tZaSGp3V8+4FHupzegmVrgM4-dzJb-y8YazOh@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jonsmirl@gmail.com
Cc: awalls@md.metrocast.net, jarod@wilsonet.com, linux-input@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, maximlevitsky@gmail.com, mchehab@redhat.com

Hi Jon,

on 31 Jul 10 at 17:53, Jon Smirl wrote:
> On Sat, Jul 31, 2010 at 2:51 PM, Andy Walls <awalls@md.metrocast.net>=
 wrote:
>> On Sat, 2010-07-31 at 14:14 -0400, Jon Smirl wrote:
>>> On Sat, Jul 31, 2010 at 1:47 PM, Christoph Bartelmus <lirc@bartelmu=
s.de>
>>> wrote:
>>>> Hi Jon,
>>>>
>>>> on 31 Jul 10 at 12:25, Jon Smirl wrote:
>>>>> On Sat, Jul 31, 2010 at 11:12 AM, Andy Walls <awalls@md.metrocast=
=2Enet>
>>>>> wrote:
>>>>>> I think you won't be able to fix the problem conclusively either=
 way..
>>>>>> =A0A lot of how the chip's clocks should be programmed depends o=
n how the
>>>>>> GPIOs are used and what crystal is used.
>>>>>>
>>>>>> I suspect many designers will use some reference design layout f=
rom
>>>>>> ENE, but it won't be good in every case. =A0The wire-up of the E=
NE of
>>>>>> various motherboards is likely something you'll have to live wit=
h as
>>>>>> unknowns.
>>>>>>
>>>>>> This is a case where looser tolerances in the in kernel decoders=
 could
>>>>>> reduce this driver's complexity and/or get rid of arbitrary fudg=
e
>>>>>> factors in the driver.
>>>>
>>>>> The tolerances are as loose as they can be. The NEC protocol uses
>>>>> pulses that are 4% longer than JVC. The decoders allow errors up =
to 2%
>>>>> (50% of 4%). =A0The crystals used in electronics are accurate to
>>>>> 0.0001%+.
>>>>
>>>> But the standard IR receivers are far from being accurate enough t=
o allow
>>>> tolerance windows of only 2%.
>>>> I'm surprised that this works for you. LIRC uses a standard tolera=
nce of
>>>> 30% / 100 us and even this is not enough sometimes.
>>>>
>>>> For the NEC protocol one signal consists of 22 individual pulses a=
t
>>>> 38kHz. If the receiver just misses one pulse, you already have an =
error
>>>> of 1/22
>>>>> 4%.
>>>
>>> There are different types of errors. The decoders can take large
>>> variations in bit times. The problem is with cumulative errors. In
>>> this case the error had accumulated up to 450us in the lead pulse.
>>> That's just too big of an error
>>
>> Hi Jon,
>>
>> Hmmm. =A0Leader marks are, by protocol design, there to give time fo=
r the
>> receiver's AGC to settle. =A0We should make it OK to miss somewhat l=
arge
>> portions of leader marks. =A0I'm not sure what the harm is in accept=
ing
>> too long of a leader mark, but I'm pretty sure a leader mark that is=
 too
>> long will always be due to systematic error and not noise errors.
>>
>> However, if we know we have systematic errors caused by unknowns, we
>> should be designing and implementing a decoding system that reasonab=
ly
>> deals with those systematic errors. =A0Again the part of the system =
almost
>> completely out of our control is the remote controls, and we *have n=
o
>> control* over systematic errors introduced by remotes.

> We haven't encountered remotes with systematic errors. If remotes had
> large errors in them they wouldn't be able to reliably control their
> target devices. Find a remote that won't work with the protocol
> engines and a reasonably accurate receiver.

>>
>> Obviously we want to reduce or eliminate systematic errors by
>> determining the unknowns and undoing their effects or by compensatin=
g
>> for their overall effect. =A0But in the case of the ENE receiver dri=
ver,
>> you didn't seem to like the Maxim's software compensation for the
>> systematic receiver errors.

> I would be happier if we could track down the source of the error
> instead of sticking a bandaid on at the end of the process.

>>> and caused the JVC code to be
>>> misclassified as NEC.
>>
>> I still have not heard why we need protocol discrimination/classifca=
tion
>> in the kernel. =A0Doing discrimination between two protocols with su=
ch
>> close timings is whose requirement again?

> If we don't do protocol engines we have to revert back to raw
> recording and having everyone train the system with their remotes. Th=
e
> goal is to eliminate the training step. We would also have to have
> large files (LIRC configs) for building the keymaps and a new API to
> deal with them. With the engines the key presses are identified by
> short strings.

Only 437 of 3486 config files on lirc.org use raw mode (probably what y=
ou =20
mean with large files). Many of them are recorded with an very old =20
irrecord version. Current versions of irrecord wouldn't create a raw mo=
de =20
config file for these remotes.

> A use case: install mythtv, add an IR receiver. Myth UI says to set
> your universal remote to a Motorola DVR profile. Remote works - no
> training step needed.

+ Myth UI reconfigures lircd with an existing Motorola DVR config file.
Where's the difference?

> LIRC has protocol engines too. irrecord first tries to fit the remote
> into a protocol engine.

With the sublte difference to your approach that LIRC does not make any=
 =20
assumptions on any timings in contrast to hardcoded values in the kerne=
l.

> If it can't it reverts to raw mode. Let's
> analyze those cases where lirc ends up in raw mode and see if we can
> figure out what's going wrong.
>
> For example I know of two things that will trip up irrecord that are
> fixed in the kernel system
> 1) the ene driver. we know now it had a 4% error in the reported peri=
ods

Wrong.

> 2) Sony remotes - they mix protocols on a single remote.

This is a long known issue. I didn't care to fix it because in practice=
 it =20
does not matter.

>> Since these two protocols have such close timings that systematic er=
rors
>> can cause misclassification when using simple mark or space measurem=
ents
>> against fixed thresholds, it indicates that a more sophisticated
>> discrimination mechanism would be needed. =A0Perhaps one that takes =
multiple
>> successive measurements into account?

> If we get to the point where we need more sophisticated
> classifications we can build it. But are we at that point yet? I'd
> prefer to initially leave everything pretty strict as a way of
> flushing out driver implementation bugs.
>
> Find some remotes and receivers that break the current system.

>>
>> Regards,
>> Andy
>>
>>


Christoph
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
