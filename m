From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC] input: mt: Support for touch cancel
Date: Thu, 14 Mar 2013 09:43:27 +1000
Message-ID: <20130313234327.GA5162@yabbi.redhat.com>
References: <CAPDwgkMbwTtf2a5Xuvb3_B18FBJ7w6VJx1CJN=gGwaaRSKzDbA@mail.gmail.com>
 <20130312013605.GA31587@yabbi.redhat.com>
 <CAPDwgkOOVfZ+E0bLJ-Uqq-CgAapYvd9oPg1H1B2MH8gsf62GpQ@mail.gmail.com>
 <20130313005432.GA15794@yabbi.bne.redhat.com>
 <CAPDwgkO5LUUkVQiUWyoC+mSeN+fXDPV2yV-2Qt6aqQ=eh-bwpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:56282 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359Ab3CMXnd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Mar 2013 19:43:33 -0400
Content-Disposition: inline
In-Reply-To: <CAPDwgkO5LUUkVQiUWyoC+mSeN+fXDPV2yV-2Qt6aqQ=eh-bwpg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yufeng Shen <miletus@chromium.org>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Daniel Kurtz <djkurtz@chromium.org>, rbyers@chromium.org, sadrul@chromium.org

On Wed, Mar 13, 2013 at 06:44:24PM -0400, Yufeng Shen wrote:
> On Tue, Mar 12, 2013 at 8:54 PM, Peter Hutterer <peter.hutterer@who-t.net>wrote:
> 
> > On Tue, Mar 12, 2013 at 02:10:26PM -0400, Yufeng Shen wrote:
> > > On Mon, Mar 11, 2013 at 9:36 PM, Peter Hutterer
> > > <peter.hutterer@who-t.net> wrote:
> > > >
> > > > On Mon, Mar 11, 2013 at 04:34:27PM -0400, Yufeng Shen wrote:
> > > > > I have ran into cases where I want to make a touch end event to have
> > a
> > > > > touch cancel indication.
> > > > >
> > > > > This comes from trying to solve the problem of :
> > > > >
> > > > > If the touch sequence happens before the system suspends, and the
> > touch
> > > > > release event is
> > > > > never received after the system resumes, userspace MT state tracking
> > could
> > > > > be in a bad state.
> > > > >
> > > > > ( see #5 from
> > > > >
> > https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-synaptics/+bug/968845
> > > > > for an example of how this could happen from lid close/open on MBA)
> > > >
> > > > ftr, this a bug in the driver and should be fixed now.
> > >
> > > By driver do you mean the trackpad driver or the xf86-input driver ?
> >
> > xf86-input-synaptics
> >
> > > From the thread
> > > I can only see the fix in xf85-input-synaptics to clear the touch
> > > device HW state on
> > > resume, which I would expect to have the same side effect of triggering
> > unwanted
> > > gesture that I want address in this post, right ?
> > >
> > > If there is a fix in trackpad kernel driver, can you point me to that ?
> >
> > there are two issues: one was that the driver never cleared the state
> > correctly and thus was left with inconsistent state. this caused a lot of
> > stuck button bugs, etc. that part was buggy and got fixed in
> > xf86-input-synaptics.
> >
> > the server also releases all buttons/touches on a device when it gets
> > disabled to avoid stuck buttons. this should release any touch sequences
> > from a client's POV.
> >
> > the issue you want to fix is that you don't want to send those events but
> > something else to avoid the clients interpreting this as a release.
> > correct?
> > what's the exact use-case here, what's your client stack, how often does
> > this happen?
> >
> >
> Right. The problem we are facing is that we have seen noise touch events
> generated around suspend/resume (caused by the magnet from the lid
> affecting the touch sensor during the lid close/open on our testing
> devices).
> This can cause stuck finger problem, as you have pointed out above, if the
> touch release events get lost during system sleep. This does happen from
> time to time depending on how user closes the lid and the environment
> condition.
> 

is there anything special about these fake touches that they can be
identified? location, timing, pressure, size of contact, etc?
because if so, we can look at ignoring those in the synaptics driver for
apple touchpads.

> The stacks here are
> device driver  --> xf86-input-evdev  --> X server --> custom gesture
> recognizer
> 
> We did a local patch in device driver that upon resume, releases all
> fingers/slots. This will clear all the MT states in higher stacks, but would
> cause the gesture recognizer to generate some unwanted gestures
> (like clicks, particularly bad if the objects underneath happen to be
> clickable).
> So we put another hack in the device driver that when releasing
> touches on resume, we assign these fake touches end events with a max
> touch pressure & touch_major, so the gesture recognizer knows how to
> filter out these touch end events to not cause any gesture.

for your hack, if there is a suspend/resume between touch begin/end then you
should get hierarchy events in the recogniser and you can then discard all
touch events from a device that just got enabled but still has touches
ongoing.

fwiw, with the current driver touches are released on _suspend_, not resume.
which only makes the problem more difficult of course. 
 
> But we want to know if there is a more formal way of addressing this
> problem. That's how I started this thread about wanting a support of
> "touch cancel" events.
> 
> With the original problem being described, do you have suggestion on
> on how to better solve this problem ?

tbh, putting in a new protocol revision for buggy hardware is not on top of
my wishlist.

Cheers,
   Peter

> 
> > > > > One possible workaround is to let the touch device driver to release
> > all
> > > > > existing touches on
> > > > > resume, which has the effect of clearing all the MT states in
> > userspace
> > > > > touch stacks.
> > > > > But the touch release/end event often will result in some gesture
> > being
> > > > > recognized and performed,
> > > > > like a tap-to-click being generated.
> > > > >
> > > > > So I am wondering what's the best way to solve the problem of
> > clearing the
> > > > > touch states with
> > > > > minimal side effect. One way I can think of is to have MTB protocol
> > add
> > > > > support of
> > > > > a touch cancel indication on touch release, e.g. making TRACKING_ID
> > = -2
> > > > > meaning that
> > > > > the touch release is synthesized from the system and really has the
> > meaning
> > > > > of releasing and canceling the current touch, while TRACKING_ID = -1
> > > > > meaning that the touch release is reported back from the device.
> > > > >
> > > > > And from Xf86-input driver level, we can add a corresponding
> > TouchCancel
> > > > > for this.
> > > >
> > > > I can handle touch-cancel events in the synaptics driver to avoid
> > > > tap-to-click but further details get a bit nasty.
> > > >
> > > > To actually add TouchCancel to the client-protocol means a new XI
> > protocol
> > > > revision, plus the stuff in the server _and_ the stuff in the client.
> > that
> > > > is quite some lag time here, and if a client cannot handle TouchCancel
> > all
> > > > we can do is do a TouchEnd - which will still trigger the gesture.
> > > >
> > > > even if you update the touch clients you're still lacking any solution
> > for
> > > > pointer-emulated clients. again, here we can only do a ButtonRelease
> > event
> > > > which again will trigger whatever it did.
> > > >
> > > > All the above can be implemented though. In fact, I suspect the
> > protocol
> > > > part is the easy bit (just a flag on TouchEnd) but the server part is
> > > > reasonably nasty.
> > > >
> > > > the real counter-argument is that I think it is a partial solution
> > only.
> > > > From an X perspective touches also end when you vt-switch away from the
> > > > server (device is disabled). but the kernel won't cancel the touch
> > event for
> > > > that. Or when the device is disabled by the client ("disable touchpad
> > while
> > > > typing" feature), So we'd have to maintain both implicit cancel and
> > explicit
> > > > cancel in the driver anyway.
> > > >
> > > > so yeah, I don't think adding this to the kernel would provide any
> > > > significant benefit since we still need to handle all the other cases
> > > > anyway.
> > > >
> > >
> > > What's your suggestion on how to handle all the other cases ?
> > >
> > >
> > > If you feel it is too much effort to take in X server/client code just
> > for
> > > fixing this particular case, how about a more light weighted solution:
> > > we still need kernel to mark some touch end event as synthesized, and
> > > in xf86-input driver (e.g. evdev),  we attach the XI_TouchEnd event with
> > > a special valuator to indicate it has meaning of touch cancel. Then for
> > > X clients who wants to handle this case, they can check this particular
> > > valuator.
> >
> > no, i'm not putting hacks like this into the protocol. first, whether the
> > kernel does this or not is largely irrelevant to the X driver since the
> > kernel suspend is only one case of disabling the device. VT-switch and
> > disabling the device manually are the other two and the kernel won't (and
> > can't) give us events for this.
> >
> > second, the only way you can handle such events in the client is to add it
> > to XI 2.4, i.e.  a proper protocol extension with the spec to describe how
> > and when it is generated, what the effects on grabs and pointer emulation
> > is, etc. the easiest solution is to add a TouchCancelled flag to the
> > TouchEnd event, since that flag must be ignored by clients < XI 2.4 and
> > we don't need to introduce a new event type. so it's largely
> > backwards-compatible, but clients not supporting 2.4 will still release the
> > gesture. That doesn't cover the various details though.
> >
> > you need to also integrate that into the server and I can warn you ahead of
> > time, touch grab ownership handling is pretty insane. Either way, that part
> > is a topic for xorg-devel@lists.x.org.
> >
> > Cheers,
> >    Peter
> >
> >
> >
> >
