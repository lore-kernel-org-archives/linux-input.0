From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] Input: clarify gamepad API ABS values
Date: Thu, 14 Nov 2013 23:53:35 +0100
Message-ID: <20131114235335.f18e7440e0803ed97dc65972@studenti.unina.it>
References: <1380806829-11824-1-git-send-email-dh.herrmann@gmail.com>
	<20131114180720.fece45888942c29d5865073e@studenti.unina.it>
	<CANq1E4Q-yPVh7ah-SMGb--VCJA97c2yCLSGQakFzGWWQydo7jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:3507 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755391Ab3KNWxj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Nov 2013 17:53:39 -0500
In-Reply-To: <CANq1E4Q-yPVh7ah-SMGb--VCJA97c2yCLSGQakFzGWWQydo7jw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, 14 Nov 2013 18:22:28 +0100
David Herrmann <dh.herrmann@gmail.com> wrote:

> On Thu, Nov 14, 2013 at 6:07 PM, Antonio Ospite
> <ospite@studenti.unina.it> wrote:

[...]
> > I know it is not really relevant and you won't fix the kernel interface
> > anyway, but I was just curios: is there any known userspace using the
> > gamepad API?
> 
> The xwiimote userspace-drivers use it, other than that it is hard to
> tell.. I looked at a lot of games and applications and they all just
> contain a bunch of hacks and per-driver-mappings. I cannot really tell
> whether anyone uses it, yet (there's isn't really a reason to use it
> as only the wiimote kernel drivers comply to it).
> 
> However, I hope we can make all new drivers adhere these rules so
> user-space no longer has to guess the mappings.
>

I am going to adopt the gamepad API for the PS3 controller as well,
motivating the change with the current utterly broken status of
the mapping from the evdev point of view.

I have reasons to believe that any existing linux software targeting the
PS3 controller is just parsing the hidraw data itself, the joystick
interface is not completely usable either in the current status.

> > Another question is below.
> >
> >> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> >> ---
> >>  Documentation/input/gamepad.txt | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
> >> index 8002c89..31bb6a4 100644
> >> --- a/Documentation/input/gamepad.txt
> >> +++ b/Documentation/input/gamepad.txt
> >> @@ -122,12 +122,14 @@ D-Pad:
> >>        BTN_DPAD_*
> >>      Analog buttons are reported as:
> >>        ABS_HAT0X and ABS_HAT0Y
> >> +      (for ABS values negative is left/up, positive is right/down)
> >>
> >
> > Does that mean that analog D-Pad Left and D-Pad Right are supposed to be
> > described as a single axis (ABS_HAT0X), even if in the input report
> > they come as two different fields (non adjacent even)? And same for
> > analog Up/Down?
> >
> > JFYI on the PS3 controller it is possible to have values from analog
> > D-Pad Left and analog D-Pad Right at the same time, even if it is
> > mechanically unlikely.
> 
> Yes, it's a single axis. It's called a D-Pad (Direction-Pad) so it is
> supposed to give information about a direction. This somehow excludes
> reporting information for left/right separately, right?
>

Mathematically, yes, but I am still not completely sure that being so
strict is convenient in this case: when describing the _digital_ D-Pad
we mention "4 buttons" and then "four directions", and indeed hardware
generally exposes all four directional buttons independently (even if
opposed ones are not supposed to be pressed at the same time, they still
might); so it could make sense to use the same scheme for _analog_
D-Pad axes too: four independent analog D-Pad axes.

Again, JFYI the PS3 controller allows to press even _digital_ D-Pad
Left and Right at the same time even if this is mechanically trickier
to achieve than the correspondent analog events.

> I didn't know there are actually devices reporting this separately, so
> I never considered that during the development of the API.
> Fortunately, the drivers which follow this spec all use digital DPADs,
> so we can easily change it now.
>

I'd say we change it. But maybe it's better to hear from someone more
into games.

> What exactly does the PS3 controller return? Is it
> pressure-information for the dpad?

Yes it is, 4 pressure values form 0 to 255, one for each "direction".

>I'm open to change this to report 4
> ABS values, but I'm not sure that we want that. From a user-space
> perspective I want to get 2 values, not 4. I wouldn't even know what
> to do with 4 dpad-values. So why not convert that in the kernel to:
>   x = x1 - x0;
>   y = y1 - y0;
> This gives you proper x/y DPAD values from 4 pressure inputs.
> 
> But I'm open for suggestions..

If I have to, I'll do that conversion; I just don't know yet how to
prepare for this scenario at the HID descriptor level.

In my driver I'd like to just fixup the whole HID descriptor and then
simply remap the keycodes, I'd like to avoid parsing the raw data
explicitly in C.

[...]
> >
> > What about analog Action-Pad buttons?
> > Do you suggest any mapping for them?
> 
> Do we have devices which report analog action-pad values? If there
> are, we can introduce new ABS_* bits for them (the current ones really
> don't fit). This requires the ABS2 patches which are currently pending
> on the list, though.
>
> And again, what information do these action-pads provide? Pressure?

The PS3 controller reports a pressure value from 0 to 255 for each of
the Action-Pad buttons.

I am writing some documentation of the input report of the PS3
controller, I'll post it here soon.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
