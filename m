From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: wacom: Replace 'oVid' and 'oPid' with heuristics
Date: Mon, 8 Aug 2016 18:36:19 +0200
Message-ID: <20160808163619.GE17850@mail.corp.redhat.com>
References: <20160711180711.17537-1-killertofu@gmail.com>
 <20160711180711.17537-2-killertofu@gmail.com>
 <20160712090510.GG4663@mail.corp.redhat.com>
 <c2cab4aa-d677-a213-df23-64f7d5840cd5@gmail.com>
 <20160725090218.GC19383@mail.corp.redhat.com>
 <CANRwn3SpWH7OnFJq4CbC9_jO5jwAgM-ci8TBAYBAbD2o+xQc6g@mail.gmail.com>
 <00b65e10-9023-b289-ce18-ccf939d7e9f2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44206 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458AbcHHQgY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Aug 2016 12:36:24 -0400
Content-Disposition: inline
In-Reply-To: <00b65e10-9023-b289-ce18-ccf939d7e9f2@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Aug 05 2016 or thereabouts, Jason Gerecke wrote:
> On 08/03/2016 10:13 AM, Jason Gerecke wrote:
> > On Mon, Jul 25, 2016 at 2:02 AM, Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> >> Hi Jason,
> >>
> >> [I've seen v2 and v3 but the discussion is mainly going there, so
> >> pulling this one out of the archives]
> >>
> >> On Jul 20 2016 or thereabouts, Jason Gerecke wrote:
> >>> On 07/12/2016 02:05 AM, Benjamin Tissoires wrote:
> >>>> On Jul 11 2016 or thereabouts, Jason Gerecke wrote:
> >>>>> The 'oVid' and 'oPid' variables used by wacom_are_sibling are a hacky
> >>>>> solution to the problem of the driver having few good heuristics to use
> >>>>> to determine if two devices should be considered siblings or not. This
> >>>>> commit replaces them with heuristics that leverage the information we
> >>>>> have available to determine if two devices are likely siblings or not.
> >>>>
> >>>> I agree it's nicer to have a better heuristic for sibling matching,
> >>>> but I wonder if this heuristic is reliable enough when talking about
> >>>> future devices. It might be, but I know from experience that the
> >>>> firmware team can be very original and find a way that screws up us all
> >>>> :/
> >>>>
> >>>> Keeping the safety net of reducing the checks with ovid/opid might come
> >>>> handy in the future.
> >>>>
> >>>
> >>> The biggest problem with oVid/oPid is that they're kinda antithetical to
> >>> the HID_GENERIC codepath. If a device is split between two PIDs then
> >>> arbitration is broken for any kernel that doesn't include specific
> >>> support for the device.
> >>
> >> Well, we currently already have different paths for HID_GENERIC and
> >> other various protocols. Why is that a problem to have heuristics for
> >> HID_GENERIC and ovid/opid for those we need to have special handling?
> >>
> >>>
> >>> I agree that heuristics aren't as confidence-inspiring as explicit
> >>> notation, but if they can be made to work well enough then I'd prefer
> >>> using them. Either way, I suppose as userspace starts taking over
> >>> arbitration duties it will become a more and more moot issue.
> >>
> >> Yep, but currently the patch might link 2 devices that were not bound
> >> together before, so I still think ovid/opid is the best way for the non
> >> generic devices. For generic devices (future I think) we can always ask
> >> people to use userspace touch arbitration.
> >>
> >>>
> >>>>>
> >>>>> Written out, the new heuristics are basically:
> >>>>>
> >>>>>   * If a device with the same VID/PID as that being probed already exists,
> >>>>>     it should be preferentially checked for siblingship.
> >>>>
> >>>> That's assuming you don't have 2 27QHD connected as 2 monitors (if you
> >>>> really have a lot of money to spend) :)
> >>>>
> >>>> I think the code is OK, just not the comment above (mostly the
> >>>> "preferentially" word itches me)
> >>>>
> >>>
> >>> I'll try to come up with better / more clear wording (see my later
> >>> comments on the "Try to find an already-probed interface from the same
> >>> device" hunk for more detail).
> >>
> >> Thanks for the changes in v2/3
> >>
> >>>
> >>>>>
> >>>>>   * Two HID devices which have the same VID/PID are not siblings if they
> >>>>>     are not part of the same logical hardware device.
> >>>>>
> >>>>>   * Two HID devices which have different VID/PIDs are not siblings if
> >>>>>     they have different parent (e.g. USB hub) devices.
> >>>>>
> >>>>>   * Devices without the WACOM_DEVICETYPE_DIRECT flag set may only be
> >>>>>     siblings of devies with the same VID/PID (Wacom often splits their
> >>>>>     direct input tablets into two devices to make it easier to meet
> >>>>>     Microsoft's touchscreen requirements).
> >>>>
> >>>> That's a strong assumption on the future. If you are forced to use the
> >>>> Precision Touchpad protocol for Intuos, this will just blow up.
> >>>>
> >>>
> >>> I originally didn't include this condition in my checks since I was
> >>> similarly wary. Leaving it out does open two small corner cases though.
> >>>
> >>> 1) A pen-only tablet connected to the same hub as a touch-only tablet.
> >>> Touch-only Wacom tablets aren't particularly common and it would
> >>> be a little strange to have one paired with a pen-only tablet, but it
> >>> could conceivably happen. Although pairing the devices shouldn't
> >>> normally be an issue since a user isn't likely to use both
> >>> simultaneously, it might cause problems for multi-seat setups.
> >>
> >> Yes, multi-seats is one big issue here.
> >>
> >>>
> >>> 2) A pen-only tablet connected to the same hub as a pen-and-touch tablet
> >>> which has the *touch* interface probed first. As far as I'm aware, there
> >>> aren't any Wacom devices that have the USB interfaces ordered
> >>> touch-then-pen, but as you point out, who knows what those tricksy
> >>> firmware engineers will do in the future to ruin your day.
> >>
> >> And the winner is... the Cintiq 13HDT -> touch interface and then Pen :)
> >>
> >> Which means with the new patch, connecting a Cintiq 21UX (1 not 2) which
> >> is a direct device which I assume doesn't have an internal hub, you end
> >> up binding the 21UX pen with the 13HD touch, and things gets nasty for
> >> the 13HD pen interface.
> >>
> > 
> > Argh. Good to know.
> > 
> >>>
> >>> I'm open to leaving the check in or out depending on your feelings. If
> >>> you've got thoughts on how to close these corner cases as well, I'm all
> >>> ears :)
> >>
> >> I really think the ovid/opid approach solves most of the issues with the
> >> current hardware. You are concerned about future hardware that will be
> >> handled by HID_GENERIC. Why not just adding a special case for
> >> HID_GENERIC that uses your heuristics?
> >> In userspace I think we will still have the ovid/opid approach in
> >> libwacom because it restricts the amount of combinations by a very good
> >> factor.
> >>
> >> If the kernel with the new heuristics (HID_GENERIC only) fails, we will
> >> be able to tell users to switch to userspace touch arbitration.
> >>
> >> /me turns in circle a little, but how does that sounds?
> >>
> >> Cheers,
> >> Benjamin
> >>
> > 
> > That sounds reasonable. I'll return the old oVid/oPid checks, and
> > integrate them with heuristics for HID_GENERIC devices. Patch to come
> > soon (TM).
> > 
> > Jason
> > ---
> > Now instead of four in the eights place /
> > you’ve got three, ‘Cause you added one  /
> > (That is to say, eight) to the two,     /
> > But you can’t take seven from three,    /
> > So you look at the sixty-fours....
> > 
> 
> One question before I post the updated v4 patch: did you want me to
> remove the "direct-input devices may not be siblings of indirect-input
> devices" check? It opens up the holes mentioned above, but would
> properly arbitrate hypothetical future split-indirect devices.

I thought this check would be without ambiguity (if the directness is
not the same, that means they are on distinct physical devices).
So I'd say this check is necessary.

> 
> Since the new arbitration rules only apply to HID_GENERIC devices and
> userspace will eventually take over the task anyway, I'm okay with
> either option personally.

Also, there is one thing that might have sense since you are now having
the heuristic only for hid-generic.
We might want to be sure to have the proper sibling matching on some
rare cases. So I think it should be interesting to have:
- .ovid/.opid == 0/0 meaning "match against the current device vid/pid"
  (like what the current code does)
- .ovid/.opid == 0xffff/0xffff (HID_ANY_ID) meaning "use the heuristic,
  you can have any other vid/pid"
- .ovid/.opid != 0/0 and not 0xffff/0xffff meaning "match only the
  specified vid/pid"

This would allow to register a new device using HID_GENERIC but with a
specific ovid/opid.

One extra check could also be that we are sure that the sibling device
also is registered as HID_GENERIC + .ovid/.opid == 0xffff/0xffff to
avoid matching against something we already fixed the ovid/opid...

This might be a little over-processed however :)

Cheers,
Benjamin

> 
> Jason
> ---
> Now instead of four in the eights place /
> you’ve got three, ‘Cause you added one /
> (That is to say, eight) to the two, /
> But you can’t take seven from three, /
> So you look at the sixty-fours....
