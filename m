From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: New "ABS_WHEEL2" axis?
Date: Wed, 7 Dec 2011 00:50:09 -0800
Message-ID: <20111207085009.GA20488@core.coreip.homeip.net>
References: <CANRwn3SH9VO-1P_zAkDopVJRjApnZWpEZWP3YpuXg3cbiCQffg@mail.gmail.com>
 <201110052034.52397.dmitry.torokhov@gmail.com>
 <CANRwn3S4XJT=KS1yp8YqAT0e3Da7hfBq2Aen2QzsdzdjTiZQXw@mail.gmail.com>
 <20111130221547.GC3108@core.coreip.homeip.net>
 <CAF8JNh+zKrTfZ131JYmZSRZtMKNf9ymuzGuM6ow=QT9cnM_ijg@mail.gmail.com>
 <20111130231910.GA3220@core.coreip.homeip.net>
 <CANRwn3R36zTfxN=M9XxSnfn==jcJY48B3gRdemNyFyS8BNUohA@mail.gmail.com>
 <20111201051102.GA16816@core.coreip.homeip.net>
 <CAGzDe_bVjBv-JkUA7dJe1wGk2eo8R0fA6QL+D12KftauEKtCgQ@mail.gmail.com>
 <CANRwn3St0GtrNs8AgqYhaZppRdiC=Rku-MP8VKycPS7p1W4Efg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34716 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1LGIuQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2011 03:50:16 -0500
Received: by iakc1 with SMTP id c1so605047iak.19
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2011 00:50:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANRwn3St0GtrNs8AgqYhaZppRdiC=Rku-MP8VKycPS7p1W4Efg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Thu, Dec 01, 2011 at 02:04:00PM -0800, Jason Gerecke wrote:
> On Thu, Dec 1, 2011 at 9:13 AM, Chris Bagwell <chris@cnpbagwell.com> wrote:
> > On Wed, Nov 30, 2011 at 11:11 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >> On Wed, Nov 30, 2011 at 03:52:55PM -0800, Jason Gerecke wrote:
> >>> On Wed, Nov 30, 2011 at 3:19 PM, Dmitry Torokhov
> >>> <dmitry.torokhov@gmail.com> wrote:
> >>> > On Wed, Nov 30, 2011 at 02:42:09PM -0800, Ping Cheng wrote:
> >>> >> > On Thu, Oct 06, 2011 at 01:31:09PM -0700, Jason Gerecke wrote:
> >>> >> >> On Wed, Oct 5, 2011 at 8:34 PM, Dmitry Torokhov
> >>> >> >> <dmitry.torokhov@gmail.com> wrote:
> >>> >> >> > On Wednesday, October 05, 2011 12:44:40 PM Jason Gerecke wrote:
> >>> >> >> >> I'm working on adding support for the recently-announced Cintiq 24HD,
> >>> >> >> >> and am hashing out most of the details on the linuxwacom mailing list.
> >>> >> >> >> In the discussions there, it was suggested that we add a new e.g.
> >>> >> >> >> "ABS_WHEEL2" axis to the input.h header to represent the second touch
> >>> >> >> >> ring available on the 24HD. I think it's a good idea, but wanted to
> >>> >> >> >> get some opinions from over here before making a patch. The other
> >>> >> >> >> option we have available is to use an axis not already in use by the
> >>> >> >> >> wacom driver (such as ABS_RUDDER), but none have a matching semantic
> >>> >> >> >> meaning.
> >>> >> >
> >>> >> > Looking at this once more ABS_WHEEL does not semantically match to what
> >>> >> > Wacom driver users it for either. ABS_WHEEL is not "an abstract
> >>> >> > circular-shaped sensor on a device" for rather a "steering wheel"-like
> >>> >> > control on a game controller. So Wacom needs to move away from using this
> >>> >> > event.
> >>> >>
> >>> >> We can move away from using the WHEEL. But, we do still need to use
> >>> >> something to report the values. We need a constructive suggestion to
> >>> >> "move away" ;).
> >>> >>
> >>> >> >> The rings are controls built into the "pad" -- the hardware you bring
> >>> >> >> the stylus in proximity to. Along with the touch rings, there are also
> >>> >> >> buttons and touch strips. Now, some devices have controls on only the
> >>> >> >> left-hand side of the pad, while others have the controls on both
> >>> >> >> sides of the pad. While one could argue that this makes each "side" a
> >>> >> >> complete context that can be broken apart into separate devices, that
> >>> >> >> doesn't really solve anything. What's stopping us from grouping
> >>> >> >> several rings together?
> >>> >> >
> >>> >> > Well, there are several topics here...
> >>> >> >
> >>> >> > What you apparently have is a group of unclassified, as far as Linux
> >>> >> > input subsystem concerned, sensors. When I say unclassified I mean that
> >>> >> > there is no appropriate event code we can assign to the control to allow
> >>> >> > a generic consumer determine the purpose of that sensor. You need help
> >>> >> > of a specialized driver to decide what to do with the data or, in case
> >>> >> > of generic driver, user has to explicitly map it to some action, but
> >>> >> > there is no way for automatic discovery/configuration which is the goal
> >>> >> > of input core. The only and closest event that we have that is suitable
> >>> >> > here is ABS_MISC.
> >>> >> >
> >>> >> > Here however is a problem: there is only one ABS_MISC and we often have
> >>> >> > several such sensors on a device. I do not want to have ABS_MISCx as
> >>> >> > again, it does not solve anything, manufactures always come with bigger
> >>> >> > and bigger devices (there some music controllers with dozens of
> >>> >> > sliders). Encoding data into ABS_MISC (let's say highest byte denotes
> >>> >> > sensor number) is awkward as well. So that is why I propose splitting
> >>> >> > them into separate input devices and have driver discover and handle
> >>> >> > them as it sees fit.
> >>> >>
> >>> >> The rings are on the tablet. Events from them are combined with the
> >>> >> events from the other tools moving on the tablet. Splitting the
> >>> >> wheels/expresskeys from the tablet would only complicate the
> >>> >> situation. We would have to link the wheels back to the tablet in the
> >>> >> user land, an unnecessary step that we should/could avoid in the
> >>> >> kernel.
> >>> >
> >>> > The fact that they are in the same physical package does not mean that
> >>> > they are necessarily mapped to a single input device. For example my USB
> >>> > keyboard consists of 3 logical devices.
> >>> >
> >>> > I understand that having data from them in the same event stream would
> >>> > be nice and if you have an idea how to achieve that in a generic way
> >>> > without resorting to ABS_MISC55 - that would be great. Maybe we
> >>> > need something similar to multitouch protocol solution, but for
> >>> > unclassified data.
> >>> >
> >>> > OTOH separate input devices complicate userland in cases when driver
> >>> > wants to handle them together but is really flexible.
> >>> >
> >>> > --
> >>> > Dmitry
> >>>
> >>> Confound my slow reply speeds... I was just about to hit the "send"
> >>> button too! :D
> >>>
> >>> I'm not sure there is a good solution given the current expectations
> >>> of and by the input subsystem. Abusing/ignoring semantic meaning of
> >>> axes can confuse the userland. Arbitrarily adding new axes is not
> >>> sustainable. Splitting the hardware into per-sensor devices requires
> >>> additional needlesly-difficult re-unification code.
> >>>
> >>> Augmenting the input subsystem with something similar to the MT
> >>> protocol would be one possible way of "properly" tackling the issue.
> >>> You'd have to figure out a way to deal with arbitrary tool types
> >>> though. For instance, say the touch strip on the 24HD were exposed to
> >>> the user as a strip and not faux-buttons. Two of the three
> >>> unclassified sensors producing the same "kind" of data, while the
> >>> third sensor produces a different "kind" of data.
> >>
> >> Right, this requires knowledge in userspace driver as to how use the
> >> data from different sensors. But that is not different from
> >> ABS_WHEEL/ABS_WHEEL2 - _your_ driver knows what they mean but a generic
> >> either has no idea or even a wrong idea.
> >>
> >>>
> >>> Regardless, how should we handle the issue that presents itself in the
> >>> here-and-now? Even if refactoring things to split the tablet into more
> >>> devices is the route we ultimately decide on, that's going to take
> >>> some time to implement. It'd be nice if 24HD support weren't stalled
> >>> waiting for yet-to-be-written code to appear, and preferable if the
> >>> hardware worked in its entirety (meaning substituting ABS_WHEEL2 with
> >>> e.g. ABS_THROTTLE for the time being).
> >>>
> >>
> >> Probably multiplexing through ABS_MISC would be not too painful as an
> >> interim solution.
> >>
> Multiplexing is certainly simpler than splitting the tablet into
> multiple devices. It's not, however, as simple as it seems. If we only
> put the right touch ring into ABS_MISC, it wouldn't be too bad; we
> could write some trivial placeholder code for the moment and get back
> to fleshing it out when we get some time. That's not an option though
> since ABS_MISC is already being used to send tool type information.
> Placeholder code wouldn't cut it and we'd have to rewrite portions of
> the kernel and X driver right now.
> 
> Please don't misunderstand -- I agree that multiplexing is a
> reasonable interim solution, and I'm not against doing the work. I
> just don't have any time in my schedule right now to devote to it.
> 
> That's why I'd prefer using an existing axis that we don't already
> use. The code is already written and tested, and our driver already
> abuses the semantics of so many other axes that a program trying to
> use the kernel events in a generic way will fail spectacularly anyway.
> If we don't find time to refactor things in the near future, we can
> schedule time up-front with the next device that requires yet another
> axis on the assumption that you would block any more patches which
> further this cycle of semantic abuse.

I suppose I'd be OK with [ab]using one of existing "free" axes for the
time being, given that we require a specific driver for full support of
wacom tablets anyway.

Thanks.

-- 
Dmitry
