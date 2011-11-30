From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: New "ABS_WHEEL2" axis?
Date: Wed, 30 Nov 2011 14:42:09 -0800
Message-ID: <CAF8JNh+zKrTfZ131JYmZSRZtMKNf9ymuzGuM6ow=QT9cnM_ijg@mail.gmail.com>
References: <CANRwn3SH9VO-1P_zAkDopVJRjApnZWpEZWP3YpuXg3cbiCQffg@mail.gmail.com>
	<201110052034.52397.dmitry.torokhov@gmail.com>
	<CANRwn3S4XJT=KS1yp8YqAT0e3Da7hfBq2Aen2QzsdzdjTiZQXw@mail.gmail.com>
	<20111130221547.GC3108@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43690 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab1K3WmK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Nov 2011 17:42:10 -0500
Received: by ywa9 with SMTP id 9so1150893ywa.19
        for <linux-input@vger.kernel.org>; Wed, 30 Nov 2011 14:42:09 -0800 (PST)
In-Reply-To: <20111130221547.GC3108@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Linux Input <linux-input@vger.kernel.org>

> On Thu, Oct 06, 2011 at 01:31:09PM -0700, Jason Gerecke wrote:
>> On Wed, Oct 5, 2011 at 8:34 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Wednesday, October 05, 2011 12:44:40 PM Jason Gerecke wrote:
>> >> I'm working on adding support for the recently-announced Cintiq 24HD,
>> >> and am hashing out most of the details on the linuxwacom mailing list.
>> >> In the discussions there, it was suggested that we add a new e.g.
>> >> "ABS_WHEEL2" axis to the input.h header to represent the second touch
>> >> ring available on the 24HD. I think it's a good idea, but wanted to
>> >> get some opinions from over here before making a patch. The other
>> >> option we have available is to use an axis not already in use by the
>> >> wacom driver (such as ABS_RUDDER), but none have a matching semantic
>> >> meaning.
>
> Looking at this once more ABS_WHEEL does not semantically match to what
> Wacom driver users it for either. ABS_WHEEL is not "an abstract
> circular-shaped sensor on a device" for rather a "steering wheel"-like
> control on a game controller. So Wacom needs to move away from using this
> event.

We can move away from using the WHEEL. But, we do still need to use
something to report the values. We need a constructive suggestion to
"move away" ;).

>> The rings are controls built into the "pad" -- the hardware you bring
>> the stylus in proximity to. Along with the touch rings, there are also
>> buttons and touch strips. Now, some devices have controls on only the
>> left-hand side of the pad, while others have the controls on both
>> sides of the pad. While one could argue that this makes each "side" a
>> complete context that can be broken apart into separate devices, that
>> doesn't really solve anything. What's stopping us from grouping
>> several rings together?
>
> Well, there are several topics here...
>
> What you apparently have is a group of unclassified, as far as Linux
> input subsystem concerned, sensors. When I say unclassified I mean that
> there is no appropriate event code we can assign to the control to allow
> a generic consumer determine the purpose of that sensor. You need help
> of a specialized driver to decide what to do with the data or, in case
> of generic driver, user has to explicitly map it to some action, but
> there is no way for automatic discovery/configuration which is the goal
> of input core. The only and closest event that we have that is suitable
> here is ABS_MISC.
>
> Here however is a problem: there is only one ABS_MISC and we often have
> several such sensors on a device. I do not want to have ABS_MISCx as
> again, it does not solve anything, manufactures always come with bigger
> and bigger devices (there some music controllers with dozens of
> sliders). Encoding data into ABS_MISC (let's say highest byte denotes
> sensor number) is awkward as well. So that is why I propose splitting
> them into separate input devices and have driver discover and handle
> them as it sees fit.

The rings are on the tablet. Events from them are combined with the
events from the other tools moving on the tablet. Splitting the
wheels/expresskeys from the tablet would only complicate the
situation. We would have to link the wheels back to the tablet in the
user land, an unnecessary step that we should/could avoid in the
kernel.

Ping
