From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2] Input - mt: Fix input_mt_get_slot_by_key
Date: Fri, 24 Apr 2015 10:50:18 +1000
Message-ID: <20150424005018.GA2641@jelly.redhat.com>
References: <1427741655-4142-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150406163349.GD36770@dtor-ws>
 <alpine.LNX.2.00.1504071517260.30181@pobox.suse.cz>
 <CAKdAkRROn=tCuSDmCqsugPAFBsTa5jEZsOEoTBCAFUrheM2X8Q@mail.gmail.com>
 <5539279F.4050400@bitmath.org>
 <20150423182046.GF34808@dtor-ws>
 <20150423183827.GA10937@mail.corp.redhat.com>
 <20150423184709.GG34808@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150423184709.GG34808@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Apr 23, 2015 at 11:47:09AM -0700, Dmitry Torokhov wrote:
> On Thu, Apr 23, 2015 at 02:38:27PM -0400, Benjamin Tissoires wrote:
> > On Apr 23 2015 or thereabouts, Dmitry Torokhov wrote:
> > > On Thu, Apr 23, 2015 at 07:10:55PM +0200, Henrik Rydberg wrote:
> > > > > "Creation, replacement and destruction of contacts is achieved by
> > > > > modifying the ABS_MT_TRACKING_ID of the associated slot.  A
> > > > > non-negative tracking id is interpreted as a contact, and the value -1
> > > > > denotes an unused slot.  A tracking id not previously present is
> > > > > considered new, and a tracking id no longer present is considered
> > > > > removed."
> > > > > 
> > > > > If some userspace is confused with missing -1 tracking ID for that
> > > > > slot, that userspace should be fixed.
> > > > 
> > > > I agree. Some userland applications work with add/remove out of convenience, and
> > > > cannot handle the more compressed notation the kernel slot handling allows.
> > > > Fixing those applications will be a good thing.
> > > > 
> > > > Unfortunately the patch already appeared in Linus' tree...
> > > 
> > > It's in 4.1-rc0 so we can just revert it.
> > > 
> > 
> > Before we call for a revert, I'd like to hear Peter thoughts about it,
> > as he is the main user of the slotted protocol.
> > 
> > Also, Dmitry, can you check if the ChromeOS driver and (or) the android
> > one would need to be adapted? My guess is that none of these drivers are
> > able to handle a silent closing of a slot
> 
> I will, at least for Chrome. But if it is broken I'll simply open a big
> to fix it ;)
> 
> > and the easiest solution might
> > be to simply change the documentation if in fact nobody uses the
> > compressed notation (which removes just one ABS_SLOT event within the
> > frame, so not sure we can call it compressed BTW).
> 
> No, it is more that that I think. Wouldn't we need to allocate memory
> for 2*n slots to actually reliably track all contacts if they all happen
> to get released and put back onto the surface in different place very
> very quickly if we insist on sending tracking id -1 for previously used
> slots?

can't you just slot in an extra event that contains only the
ABS_MT_TRACKING_ID -1 for the needed slots, followed by an SYN_REPORT and
whatever BTN_TOOL_* updates are needed? You don't need extra slots here,
you're just putting one extra event in the queue before handling the new
touches as usual.

thing is: I've always assumed that a touch is terminated by a -1 event
and this hasn't been a problem until very recently. so anything I've ever
touched will be broken if we start switching tracking IDs directly.  That
includes xorg input, libinput and anything that uses libevdev. sorry.

if the kernel switches from one tracking ID to another directly,
libevdev will actually discard the new tracking ID.
http://cgit.freedesktop.org/libevdev/tree/libevdev/libevdev.c#n968
(sorry again) aside from the warning, it's safe to switch directly though,
there shouldn't be any side-effects. 
as for fixing this: I can add something to libevdev to allow it but I'll
also need to fix up every caller to handle this sequence then, they all rely
on the -1. so some stuff will simply break.
plus we still have synaptics up to 1.7.x and evdev up to 2.8.x that are
pre-libevdev.

for other event processing it's tricky as well. if you go from two
touches to two new touches you need to send out a BTN_TOOL_DOUBLETAP 0, then
1. if not, a legacy process missed the event completely (synaptics would
suffer from that). likewise, without the BTN_TOUCH going to 0 for one frame
you'll get coordinate jumps on the pointer emulation.

having the tracking ID go -1 and then to a real one in the same frame makes
this even worse, because now even the MT-capable processes need to attach
flags to each touch whether it intermediately terminated or not. The event
ordering is not guaranteed, so we don't know until the SYN_REPORT whether
we switched from 2 fingers to 1, or 2 fingers to 2 fingers. or possibly
three fingers if BTN_TOOL_TRIPLETAP is set which we won't know until the
end. That has to be fixed in every caller. and it changes the evdev protocol
from "you have the state at SYN_REPORT" to "you need to keep track of some
state changes within the frame". that's no good.

so summary: switching directly between IDs is doable but requires userspace
fixes everywhere. terminating and restarting a contact within the same frame
is going to be nasty, let's not do that please.
best solution: the kernel inserts an additional event to terminate all
restarted contacts before starting the new ones as normal in the subsequent
frame.
 
Cheers,
   Peter
