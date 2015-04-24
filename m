From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH v2] Input - mt: Fix input_mt_get_slot_by_key
Date: Fri, 24 Apr 2015 08:26:39 +0200
Message-ID: <5539E21F.6060202@bitmath.org>
References: <1427741655-4142-1-git-send-email-benjamin.tissoires@redhat.com> <20150406163349.GD36770@dtor-ws> <alpine.LNX.2.00.1504071517260.30181@pobox.suse.cz> <CAKdAkRROn=tCuSDmCqsugPAFBsTa5jEZsOEoTBCAFUrheM2X8Q@mail.gmail.com> <5539279F.4050400@bitmath.org> <20150423182046.GF34808@dtor-ws> <20150423183827.GA10937@mail.corp.redhat.com> <20150423184709.GG34808@dtor-ws> <20150424005018.GA2641@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150424005018.GA2641@jelly.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Peter,

It may be a long time ago now, but we had very vocal discussions regarding the
MT protocol back then, and I am quite sure all the subtleties are well
understood. In order to fully appreciate the simplicity of the protocol, one
only needs to stop misintepreting it. In order to do that, please imagine a
large piece of papers, a set of brushes, and a set of colors.

The MT protocol tracks brushes. When lines are drawn, positions are updated.
When the color on the brush changes, the tracking id changes. When the brush is
lifted, the tracking id becomes -1, the "no color" color. There is a fixed set
of brushes. The old test application mtview works precisely this way.

The add/remove protocol tracks colors. Technichally it tracks contacts, which
are the combined (color, brush) objects, but in this analogy, colors and
tracking ids are interchangeable. When lines a drawn, a color is first assigned
to the color and the brush attributes on the color are updated. The positions on
the color are subsequently updated. To change color, the brush is deassign from
the first color and then the brush is assign to the new color. To lift, the
brush is deassign from the color. This is the abstraction the seems to prevail
in userland at the moment.

> can't you just slot in an extra event that contains only the
> ABS_MT_TRACKING_ID -1 for the needed slots, followed by an SYN_REPORT and
> whatever BTN_TOOL_* updates are needed? You don't need extra slots here,
> you're just putting one extra event in the queue before handling the new
> touches as usual.

So you want to add a rule saying that before a brush changes color, it first has
to be cleaned. That may look simple enough, but it misses out on several subtleties.

1. It is no longer possible to create beautiful contiuous tracks of varying color.

2. When a brush moves quickly, it will sometimes restart the track with a new
color. This happens on all hardware with tracking support when you approach the
sampling limit. It happens in the kernel tracking as well, for the same reasons.
Incompatible with 1.

3. There is a difference between losing track of a brush and lifting a brush.
This is one of the situations where the add/remove protocol has to create very
nonintuitive restrictions and rules to cope. The reason starts with 1.

Forcing tracks (brushes) into the add/remove protocol creates problems that are
on a more fundamental level than the subtle issues one may hope to resolve.

> thing is: I've always assumed that a touch is terminated by a -1 event
> and this hasn't been a problem until very recently.

We have talked a lot about the differences, they can hardly have escaped anyone
deeply involved. It is true that this is not normally a problem. It only becomes
important when the sampling rate is too low to resolve all the actions we deem
important.

> so anything I've ever
> touched will be broken if we start switching tracking IDs directly.
> That
> includes xorg input, libinput and anything that uses libevdev. sorry.

This has been in the mainline kernel for the last five years, and obvisouly
still works well most of the time. I sometimes experience glitches in the
trackpad usage on my laptop, and it probably stems from this issues. It is
slightly annoying, but not broken. No reason to panic.

> if the kernel switches from one tracking ID to another directly,
> libevdev will actually discard the new tracking ID.
> http://cgit.freedesktop.org/libevdev/tree/libevdev/libevdev.c#n968
> (sorry again) aside from the warning, it's safe to switch directly though,
> there shouldn't be any side-effects. 
> as for fixing this: I can add something to libevdev to allow it but I'll
> also need to fix up every caller to handle this sequence then, they all rely
> on the -1. so some stuff will simply break.
> plus we still have synaptics up to 1.7.x and evdev up to 2.8.x that are
> pre-libevdev.

Perhaps this is worth looking at in conjunction with the problem of handling
lost touches. I am thinking of suspend/resume issues in particular. If the
system could handle the distinction between a lift and a lost touch, some logic
would be less complicated and more correct.

> for other event processing it's tricky as well. if you go from two
> touches to two new touches you need to send out a BTN_TOOL_DOUBLETAP 0, then
> 1. if not, a legacy process missed the event completely (synaptics would
> suffer from that). likewise, without the BTN_TOUCH going to 0 for one frame
> you'll get coordinate jumps on the pointer emulation.

I am not so sure about this - the movement in synaptics checks if there has been
any identity changes.

> having the tracking ID go -1 and then to a real one in the same frame makes
> this even worse, because now even the MT-capable processes need to attach
> flags to each touch whether it intermediately terminated or not.

This is simply the result of a poor abstraction to begin with. The state tracked
through the input subsystem is the slot state.

> The event
> ordering is not guaranteed, so we don't know until the SYN_REPORT whether
> we switched from 2 fingers to 1, or 2 fingers to 2 fingers. or possibly
> three fingers if BTN_TOOL_TRIPLETAP is set which we won't know until the
> end. That has to be fixed in every caller. and it changes the evdev protocol
> from "you have the state at SYN_REPORT" to "you need to keep track of some
> state changes within the frame". that's no good.

I think this paragraph is mixing what the kernel is conveying with what
representation this is mapped to in some userland applications. The state
transfer of an id change without lifts is correctly transferred.

> so summary: switching directly between IDs is doable but requires userspace
> fixes everywhere. terminating and restarting a contact within the same frame
> is going to be nasty, let's not do that please.

I agree - userland should perhaps use a different abstraction than add/remove.
Why not use the "brushes" abstraction instead?

> best solution: the kernel inserts an additional event to terminate all
> restarted contacts before starting the new ones as normal in the subsequent
> frame.

No, this would just be the first step towards an endless sequence of subtle
issues trying to shoehorn the protocol into a poor abstraction.

Henrik
