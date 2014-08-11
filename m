From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC RESEND 5/5] Input: evdev - add new EVIOCGABSRANGE ioctl
Date: Sun, 10 Aug 2014 17:01:35 -0700
Message-ID: <20140811000134.GA12650@core.coreip.homeip.net>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
 <1405775445-4454-6-git-send-email-dh.herrmann@gmail.com>
 <20140806013519.GA11429@jelly.redhat.com>
 <CANq1E4QB3wiHRTjb_4xmVvXwOZvdpOQR9nZtnaZt=k2GaLJAmw@mail.gmail.com>
 <20140808174742.GG26820@core.coreip.homeip.net>
 <CANq1E4R14eOiXQ9p7XOPiOBuOnNns+EwgQMqrwOqeVKn4y8vAQ@mail.gmail.com>
 <20140810231759.GA10731@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:37891 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbaHKABk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Aug 2014 20:01:40 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so9687520pdi.6
        for <linux-input@vger.kernel.org>; Sun, 10 Aug 2014 17:01:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140810231759.GA10731@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>

On Mon, Aug 11, 2014 at 09:17:59AM +1000, Peter Hutterer wrote:
> On Sun, Aug 10, 2014 at 05:21:47PM +0200, David Herrmann wrote:
> > Hi
> > 
> > On Fri, Aug 8, 2014 at 7:47 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Fri, Aug 08, 2014 at 03:26:56PM +0200, David Herrmann wrote:
> > >> Hi
> > >>
> > >> On Wed, Aug 6, 2014 at 3:35 AM, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> > >> >> +
> > >> >> +/**
> > >> >> + * EVIOCGABSRANGE - Fetch range of ABS values
> > >> >> + *
> > >> >> + * This fetches the current values of a range of ABS codes atomically. The range
> > >> >> + * of codes to fetch and the buffer-types are passed as "struct input_absrange",
> > >> >> + * which has the following fields:
> > >> >> + *      slots: Number of MT slots to fetch data for.
> > >> >> + *       code: First ABS axis to query.
> > >> >> + *      count: Number of ABS axes to query starting at @code.
> > >> >> + *     buffer: Pointer to a receive buffer where to store the fetched ABS
> > >> >> + *             values. This buffer must be an array of __s32 with at least
> > >> >> + *             (@slots * @code) elements. The buffer is interpreted as two
> > >> >> + *             dimensional __s32 array, declared as: __s32[slots][codes]
> > >> >
> > >> > tbh this seems more complicated than necessary. Have you thought about
> > >> > just dumping the events into the client buffer as if they came fresh in from
> > >> > the device? So to sync, the client calls the ioctl with a buffer and a
> > >> > buffer size, and the kernel simply writes a series of struct input_events
> > >> > into that buffer, with ABS_MT_SLOT as required for all slots, (optionally?)
> > >> > followed by a SYN_DROPPED. So the buffer afterwards could look like this:
> > >> >    EV_ABS ABS_X 30
> > >> >    EV_ABS ABS_X 1202
> > >> >    EV_ABS ABS_MT_SLOT 0
> > >> >    EV_ABS ABS_MT_POSITION_X 30
> > >> >    EV_ABS ABS_MT_POSITION_Y 1202
> > >> >    EV_ABS ABS_MT_SLOT 1
> > >> >    EV_ABS ABS_MT_POSITION_X 80
> > >> >    EV_ABS ABS_MT_POSITION_Y 1800
> > >> >    EV_SYN SYN_REPORT 0
> > >> >
> > >> > the client can then go through and just process the events on-by-one as it
> > >> > would otherwise with real events.
> > >> >
> > >> > This approach could be even extended to include EV_KEY, etc. providing a
> > >> > single ioctl to sync the whole state of the device atomically.
> > >> >
> > >> > comments?
> > >
> > > I like it.
> > >
> > >>
> > >> So you mean instead of passing a __32 array we pass a "struct
> > >> input_event" array and write it there? So bypassing the receive-queue?
> > >> That does sound quite nice, indeed. We could replace all the other
> > >> "sync" ioctls and just provide a way to receive all the events
> > >> directly.
> > >>
> > >> Something like:
> > >>
> > >> EVIOCQUERY(struct input_query)
> > >>
> > >> struct input_query {
> > >>         __u16 type;
> > >>         __u16 start_code;
> > >>         __u16 end_code;
> > >>         __u16 slots;
> > >>
> > >>         struct input_event buffer[];
> > >> };
> > >
> > > No, it is more like EVIOCRESYNC(void) which makes input core to dump all
> > > existing state into the client's standard event queue so that here is no
> > > need to reconcile/reconstruct anything. We could give a new SYN marker
> > > to indicate end-of-state boundary.
> > 
> > This doesn't make sense to me, for two reasons:
> >  * Events received during re-sync are usually handled differently than
> >    normal events. For instance, you *must* never handle key events
> >    from re-syncs for shortcuts, because you don't know the order
> >    they were pressed in. 
> 
> I think you're vastly overestimating what the majority of userspace does ;)
> both the xorg and the libinput-based stacks pretty much ignore this at the
> moment and by the time we handle shortcuts we're already one or more APIs
> away from the SYN_DROPPED handling.

Also, client would not out of sudden get a bunch of events, it would have
requested them to be resent so it would know how to handle them properly.

> 
> also, I haven't seen SYN_DROPPED issues from keyboard events. They usually
> happen only on absolute touch devices and ironically enough that's the one
> case where the kernel currently doesn't allow for a race-less resync.
> 
> >    If we put sync events in the queue, users cannot know where an event
> >    from.
> >    Inserting a SYNC marker is ridiculous, because following normal
> >    events may drop those (via SYN_DROPPED). We'd have to
> >    protect it. Furthermore, it's awful to handle this from user-space,
> >    because you have no idea how many events are sent as part
> >    of the sync.
> 
> I suspect Dmitry meant a new EV_SYN code. From a userspace POV, I'd know
> that after the ioctl() all events up until SYN_SYNC_DONE are the syncing
> events. That would work well and is coincidentally almost identical to the
> libevdev public API.

Yes, that's what I ment.


> 
> In libevdev we already have code to calculate the maximum number of events
> by a device for the current SYN_DROPPED handling. And you can reduce the
> number of events by only sending those in a non-zero state for EV_KEY,
> EV_LED, etc.
> 
> IMO the real issue preventing this approach is:
> 
> >  * The receive-queue is usually too small to hold all those events.
> >    I mean, evdev uses EVDEV_BUF_PACKETS as number of buffer
> >    slots (defined as 8!). You cannot even hold a whole keyboard
> >    state there. Yes, usually it should be enough, but re-syncing

Note that EVDEV_BUF_PACKETS is not raw number of events in the queue, but
number for full "packets". For plain keyboards we end up with buffer enough to
hold 8 * 8 = 64 events. Since we only need to transmit active keys that should
be enough for any keyboard and if there are keyboards reporting more then we'd
have to change their hint anyway.

> >
> >    is about handling corner-cases. If we make SYN_DROPPED
> >    handling cause SYN_DROPPED, we can just ignore it.
> 
> yep, that too was my first thought. with a plain resync ioctl you're pretty
> much guaranteed to get SYN_DROPPED before the client manages to handle the
> resync. Even if you reduce the number of events as above because the most
> common occurance for SYN_DROPPED is in the ABS_MT range which we cannot
> meaningfully reduce.

Hmm, that's a problem... But is it? We need to make sure that buffer is large
enough for the MT device to transmit all it's contacts properly. We can not
expect that we'll always be able to reduce number of events if a user actively
uses 10 contacts. IOW we need to solve this issue regardless of this proposed
sync ioctl.

Maybe we need to review drivers and see if they need to supply their own hints
or update hinting logic in core?

Thanks.

-- 
Dmitry
