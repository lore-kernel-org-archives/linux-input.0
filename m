From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: New "ABS_WHEEL2" axis?
Date: Thu, 1 Dec 2011 14:04:00 -0800
Message-ID: <CANRwn3St0GtrNs8AgqYhaZppRdiC=Rku-MP8VKycPS7p1W4Efg@mail.gmail.com>
References: <CANRwn3SH9VO-1P_zAkDopVJRjApnZWpEZWP3YpuXg3cbiCQffg@mail.gmail.com>
	<201110052034.52397.dmitry.torokhov@gmail.com>
	<CANRwn3S4XJT=KS1yp8YqAT0e3Da7hfBq2Aen2QzsdzdjTiZQXw@mail.gmail.com>
	<20111130221547.GC3108@core.coreip.homeip.net>
	<CAF8JNh+zKrTfZ131JYmZSRZtMKNf9ymuzGuM6ow=QT9cnM_ijg@mail.gmail.com>
	<20111130231910.GA3220@core.coreip.homeip.net>
	<CANRwn3R36zTfxN=M9XxSnfn==jcJY48B3gRdemNyFyS8BNUohA@mail.gmail.com>
	<20111201051102.GA16816@core.coreip.homeip.net>
	<CAGzDe_bVjBv-JkUA7dJe1wGk2eo8R0fA6QL+D12KftauEKtCgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49517 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab1LAWED convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Dec 2011 17:04:03 -0500
Received: by eeaq14 with SMTP id q14so855486eea.19
        for <linux-input@vger.kernel.org>; Thu, 01 Dec 2011 14:04:01 -0800 (PST)
In-Reply-To: <CAGzDe_bVjBv-JkUA7dJe1wGk2eo8R0fA6QL+D12KftauEKtCgQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Thu, Dec 1, 2011 at 9:13 AM, Chris Bagwell <chris@cnpbagwell.com> wr=
ote:
> On Wed, Nov 30, 2011 at 11:11 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Wed, Nov 30, 2011 at 03:52:55PM -0800, Jason Gerecke wrote:
>>> On Wed, Nov 30, 2011 at 3:19 PM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>> > On Wed, Nov 30, 2011 at 02:42:09PM -0800, Ping Cheng wrote:
>>> >> > On Thu, Oct 06, 2011 at 01:31:09PM -0700, Jason Gerecke wrote:
>>> >> >> On Wed, Oct 5, 2011 at 8:34 PM, Dmitry Torokhov
>>> >> >> <dmitry.torokhov@gmail.com> wrote:
>>> >> >> > On Wednesday, October 05, 2011 12:44:40 PM Jason Gerecke wr=
ote:
>>> >> >> >> I'm working on adding support for the recently-announced C=
intiq 24HD,
>>> >> >> >> and am hashing out most of the details on the linuxwacom m=
ailing list.
>>> >> >> >> In the discussions there, it was suggested that we add a n=
ew e.g.
>>> >> >> >> "ABS_WHEEL2" axis to the input.h header to represent the s=
econd touch
>>> >> >> >> ring available on the 24HD. I think it's a good idea, but =
wanted to
>>> >> >> >> get some opinions from over here before making a patch. Th=
e other
>>> >> >> >> option we have available is to use an axis not already in =
use by the
>>> >> >> >> wacom driver (such as ABS_RUDDER), but none have a matchin=
g semantic
>>> >> >> >> meaning.
>>> >> >
>>> >> > Looking at this once more ABS_WHEEL does not semantically matc=
h to what
>>> >> > Wacom driver users it for either. ABS_WHEEL is not "an abstrac=
t
>>> >> > circular-shaped sensor on a device" for rather a "steering whe=
el"-like
>>> >> > control on a game controller. So Wacom needs to move away from=
 using this
>>> >> > event.
>>> >>
>>> >> We can move away from using the WHEEL. But, we do still need to =
use
>>> >> something to report the values. We need a constructive suggestio=
n to
>>> >> "move away" ;).
>>> >>
>>> >> >> The rings are controls built into the "pad" -- the hardware y=
ou bring
>>> >> >> the stylus in proximity to. Along with the touch rings, there=
 are also
>>> >> >> buttons and touch strips. Now, some devices have controls on =
only the
>>> >> >> left-hand side of the pad, while others have the controls on =
both
>>> >> >> sides of the pad. While one could argue that this makes each =
"side" a
>>> >> >> complete context that can be broken apart into separate devic=
es, that
>>> >> >> doesn't really solve anything. What's stopping us from groupi=
ng
>>> >> >> several rings together?
>>> >> >
>>> >> > Well, there are several topics here...
>>> >> >
>>> >> > What you apparently have is a group of unclassified, as far as=
 Linux
>>> >> > input subsystem concerned, sensors. When I say unclassified I =
mean that
>>> >> > there is no appropriate event code we can assign to the contro=
l to allow
>>> >> > a generic consumer determine the purpose of that sensor. You n=
eed help
>>> >> > of a specialized driver to decide what to do with the data or,=
 in case
>>> >> > of generic driver, user has to explicitly map it to some actio=
n, but
>>> >> > there is no way for automatic discovery/configuration which is=
 the goal
>>> >> > of input core. The only and closest event that we have that is=
 suitable
>>> >> > here is ABS_MISC.
>>> >> >
>>> >> > Here however is a problem: there is only one ABS_MISC and we o=
ften have
>>> >> > several such sensors on a device. I do not want to have ABS_MI=
SCx as
>>> >> > again, it does not solve anything, manufactures always come wi=
th bigger
>>> >> > and bigger devices (there some music controllers with dozens o=
f
>>> >> > sliders). Encoding data into ABS_MISC (let's say highest byte =
denotes
>>> >> > sensor number) is awkward as well. So that is why I propose sp=
litting
>>> >> > them into separate input devices and have driver discover and =
handle
>>> >> > them as it sees fit.
>>> >>
>>> >> The rings are on the tablet. Events from them are combined with =
the
>>> >> events from the other tools moving on the tablet. Splitting the
>>> >> wheels/expresskeys from the tablet would only complicate the
>>> >> situation. We would have to link the wheels back to the tablet i=
n the
>>> >> user land, an unnecessary step that we should/could avoid in the
>>> >> kernel.
>>> >
>>> > The fact that they are in the same physical package does not mean=
 that
>>> > they are necessarily mapped to a single input device. For example=
 my USB
>>> > keyboard consists of 3 logical devices.
>>> >
>>> > I understand that having data from them in the same event stream =
would
>>> > be nice and if you have an idea how to achieve that in a generic =
way
>>> > without resorting to ABS_MISC55 - that would be great. Maybe we
>>> > need something similar to multitouch protocol solution, but for
>>> > unclassified data.
>>> >
>>> > OTOH separate input devices complicate userland in cases when dri=
ver
>>> > wants to handle them together but is really flexible.
>>> >
>>> > --
>>> > Dmitry
>>>
>>> Confound my slow reply speeds... I was just about to hit the "send"
>>> button too! :D
>>>
>>> I'm not sure there is a good solution given the current expectation=
s
>>> of and by the input subsystem. Abusing/ignoring semantic meaning of
>>> axes can confuse the userland. Arbitrarily adding new axes is not
>>> sustainable. Splitting the hardware into per-sensor devices require=
s
>>> additional needlesly-difficult re-unification code.
>>>
>>> Augmenting the input subsystem with something similar to the MT
>>> protocol would be one possible way of "properly" tackling the issue=
=2E
>>> You'd have to figure out a way to deal with arbitrary tool types
>>> though. For instance, say the touch strip on the 24HD were exposed =
to
>>> the user as a strip and not faux-buttons. Two of the three
>>> unclassified sensors producing the same "kind" of data, while the
>>> third sensor produces a different "kind" of data.
>>
>> Right, this requires knowledge in userspace driver as to how use the
>> data from different sensors. But that is not different from
>> ABS_WHEEL/ABS_WHEEL2 - _your_ driver knows what they mean but a gene=
ric
>> either has no idea or even a wrong idea.
>>
>>>
>>> Regardless, how should we handle the issue that presents itself in =
the
>>> here-and-now? Even if refactoring things to split the tablet into m=
ore
>>> devices is the route we ultimately decide on, that's going to take
>>> some time to implement. It'd be nice if 24HD support weren't stalle=
d
>>> waiting for yet-to-be-written code to appear, and preferable if the
>>> hardware worked in its entirety (meaning substituting ABS_WHEEL2 wi=
th
>>> e.g. ABS_THROTTLE for the time being).
>>>
>>
>> Probably multiplexing through ABS_MISC would be not too painful as a=
n
>> interim solution.
>>
Multiplexing is certainly simpler than splitting the tablet into
multiple devices. It's not, however, as simple as it seems. If we only
put the right touch ring into ABS_MISC, it wouldn't be too bad; we
could write some trivial placeholder code for the moment and get back
to fleshing it out when we get some time. That's not an option though
since ABS_MISC is already being used to send tool type information.
Placeholder code wouldn't cut it and we'd have to rewrite portions of
the kernel and X driver right now.

Please don't misunderstand -- I agree that multiplexing is a
reasonable interim solution, and I'm not against doing the work. I
just don't have any time in my schedule right now to devote to it.

That's why I'd prefer using an existing axis that we don't already
use. The code is already written and tested, and our driver already
abuses the semantics of so many other axes that a program trying to
use the kernel events in a generic way will fail spectacularly anyway.
If we don't find time to refactor things in the near future, we can
schedule time up-front with the next device that requires yet another
axis on the assumption that you would block any more patches which
further this cycle of semantic abuse.

>
> Here are a few thoughts I have on it.
>
> First, I think that REL_WHEEL is closest meaning the ring has to user
> land expectations. =C2=A0Its advertised in user manual to do things y=
ou'd
> often do with scroll wheel on a mouse. =C2=A0The default mode is send=
ing
> generic zooming/scrolling events. =C2=A0The extended usages of the wh=
eel
> seem only to be directing the zooming/scrolling to application
> specific features. =C2=A0For example, push button 1 and ring zooms wh=
ole
> canvas. =C2=A0Press button 2 and it zooms size of brush. =C2=A0I thin=
k mapping
> movement to keystroke feature is outside scope of this thread so I'll
> ignore that part.
>
> I do not think user land apps cares much about exact position user is
> touching like they would with a steering wheel so I don't think
> ABS_WHEEL is needed. =C2=A0 There is the tapping specific parts of ri=
ng
> feature to do minor increments but I think driver can hide that by
> sending REL_WHEEL with +5/-5 for scrolls and +1/-1 for taps.
>
While the touch rings may be closer in use to scroll wheels
(REL_WHEEL) than steering wheels (ABS_WHEEL), there is value in the
absolute information even if few applications use it at the moment.
=46or instance, I know of an application which provides variable-speed
smooth scroll/zoom depending on the absolute position of your finger
on the touch strip. There are some very interesting uses of the
absolute data, and the kernel shouldn't throw it away just because the
relative axis has a closer semantic meaning in the "usual" case. A
touch strip or ring may /resemble/ a scroll wheel, but it's semantic
meaning is application-specific (and, under Windows where the mode
buttons work, subject to change at a moment's notice!).

> Above part was for the semantic part of thread. =C2=A0It still doesn'=
t
> address needing a REL_WHEEL1/2/3/4 for this device and maybe to be
> used by one of those crazy gaming mice that has way to many buttons
> and wheels.
>
> I don't have much to provide here other than I'd also suggest Dmitry'=
s
> idea of multiplex both rings onto 1 REL_WHEEL. =C2=A0I'm not even sur=
e I'd
> do multiplexing so much as reporting both as if they were a single
> ring. =C2=A0Sure, I'd like to use one ring for zooming canvas and one=
 for
> zooming paint brush some day but I'd prefer a working driver today
> that has both rings zooming the same thing.
>
The X driver code to do that is already written and waiting on the
kernel driver going upstream. You'll be able to map the wheels
independently, just like you can right now with the strips.

> If we move to MT approach for reporting wheels, I suspect we will als=
o
> have the "pointer emulation" concept where REL_WHEEL has some hybrid
> meaning to work nicely with older applications and
> REL_MULTI_WHEEL/REL_MULTI_WHEEL_SLOT for multiplexing wheel data. =C2=
=A0So
> an intermediate step of merging doesn't sound like a dead end.
>
> Chris

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
