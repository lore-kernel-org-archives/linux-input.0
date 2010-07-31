From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 13/13] IR: Port ene driver to new IR subsystem and enable
	it.
Date: Sat, 31 Jul 2010 17:53:33 -0400
Message-ID: <AANLkTi=tZaSGp3V8+4FHupzegmVrgM4-dzJb-y8YazOh@mail.gmail.com>
References: <AANLkTimaut1mMUXwbJAgjNjmQkxgsf-GOCTXmKYNm1Lz@mail.gmail.com>
	<BTtOJbzJjFB@christoph>
	<AANLkTikRBupAsSSk5QmudHrpEccMSOjmK2bT+xg8CocK@mail.gmail.com>
	<1280602281.20879.76.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47124 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab0GaVxe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jul 2010 17:53:34 -0400
In-Reply-To: <1280602281.20879.76.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Walls <awalls@md.metrocast.net>
Cc: Christoph Bartelmus <lirc@bartelmus.de>, jarod@wilsonet.com, linux-input@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, maximlevitsky@gmail.com, mchehab@redhat.com

On Sat, Jul 31, 2010 at 2:51 PM, Andy Walls <awalls@md.metrocast.net> w=
rote:
> On Sat, 2010-07-31 at 14:14 -0400, Jon Smirl wrote:
>> On Sat, Jul 31, 2010 at 1:47 PM, Christoph Bartelmus <lirc@bartelmus=
=2Ede> wrote:
>> > Hi Jon,
>> >
>> > on 31 Jul 10 at 12:25, Jon Smirl wrote:
>> >> On Sat, Jul 31, 2010 at 11:12 AM, Andy Walls <awalls@md.metrocast=
=2Enet>
>> >> wrote:
>> >>> I think you won't be able to fix the problem conclusively either=
 way. =A0A
>> >>> lot of how the chip's clocks should be programmed depends on how=
 the
>> >>> GPIOs are used and what crystal is used.
>> >>>
>> >>> I suspect many designers will use some reference design layout f=
rom ENE,
>> >>> but it won't be good in every case. =A0The wire-up of the ENE of=
 various
>> >>> motherboards is likely something you'll have to live with as unk=
nowns.
>> >>>
>> >>> This is a case where looser tolerances in the in kernel decoders=
 could
>> >>> reduce this driver's complexity and/or get rid of arbitrary fudg=
e
>> >>> factors in the driver.
>> >
>> >> The tolerances are as loose as they can be. The NEC protocol uses
>> >> pulses that are 4% longer than JVC. The decoders allow errors up =
to 2%
>> >> (50% of 4%). =A0The crystals used in electronics are accurate to
>> >> 0.0001%+.
>> >
>> > But the standard IR receivers are far from being accurate enough t=
o allow
>> > tolerance windows of only 2%.
>> > I'm surprised that this works for you. LIRC uses a standard tolera=
nce of
>> > 30% / 100 us and even this is not enough sometimes.
>> >
>> > For the NEC protocol one signal consists of 22 individual pulses a=
t 38kHz.
>> > If the receiver just misses one pulse, you already have an error o=
f 1/22
>> >> 4%.
>>
>> There are different types of errors. The decoders can take large
>> variations in bit times. The problem is with cumulative errors. In
>> this case the error had accumulated up to 450us in the lead pulse.
>> That's just too big of an error
>
> Hi Jon,
>
> Hmmm. =A0Leader marks are, by protocol design, there to give time for=
 the
> receiver's AGC to settle. =A0We should make it OK to miss somewhat la=
rge
> portions of leader marks. =A0I'm not sure what the harm is in accepti=
ng
> too long of a leader mark, but I'm pretty sure a leader mark that is =
too
> long will always be due to systematic error and not noise errors.
>
> However, if we know we have systematic errors caused by unknowns, we
> should be designing and implementing a decoding system that reasonabl=
y
> deals with those systematic errors. =A0Again the part of the system a=
lmost
> completely out of our control is the remote controls, and we *have no
> control* over systematic errors introduced by remotes.

We haven't encountered remotes with systematic errors. If remotes had
large errors in them they wouldn't be able to reliably control their
target devices. Find a remote that won't work with the protocol
engines and a reasonably accurate receiver.

>
> Obviously we want to reduce or eliminate systematic errors by
> determining the unknowns and undoing their effects or by compensating
> for their overall effect. =A0But in the case of the ENE receiver driv=
er,
> you didn't seem to like the Maxim's software compensation for the
> systematic receiver errors.

I would be happier if we could track down the source of the error
instead of sticking a bandaid on at the end of the process.

>> and caused the JVC code to be
>> misclassified as NEC.
>
> I still have not heard why we need protocol discrimination/classifcat=
ion
> in the kernel. =A0Doing discrimination between two protocols with suc=
h
> close timings is whose requirement again?

If we don't do protocol engines we have to revert back to raw
recording and having everyone train the system with their remotes. The
goal is to eliminate the training step. We would also have to have
large files (LIRC configs) for building the keymaps and a new API to
deal with them. With the engines the key presses are identified by
short strings.

A use case: install mythtv, add an IR receiver. Myth UI says to set
your universal remote to a Motorola DVR profile. Remote works - no
training step needed.

LIRC has protocol engines too. irrecord first tries to fit the remote
into a protocol engine. If it can't it reverts to raw mode. Let's
analyze those cases where lirc ends up in raw mode and see if we can
figure out what's going wrong.

=46or example I know of two things that will trip up irrecord that are
fixed in the kernel system
1) the ene driver. we know now it had a 4% error in the reported period=
s
2) Sony remotes - they mix protocols on a single remote.

> Since these two protocols have such close timings that systematic err=
ors
> can cause misclassification when using simple mark or space measureme=
nts
> against fixed thresholds, it indicates that a more sophisticated
> discrimination mechanism would be needed. =A0Perhaps one that takes m=
ultiple
> successive measurements into account?

If we get to the point where we need more sophisticated
classifications we can build it. But are we at that point yet? I'd
prefer to initially leave everything pretty strict as a way of
flushing out driver implementation bugs.

=46ind some remotes and receivers that break the current system.

>
> Regards,
> Andy
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
