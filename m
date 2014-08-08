From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC RESEND 5/5] Input: evdev - add new EVIOCGABSRANGE ioctl
Date: Fri, 8 Aug 2014 10:47:42 -0700
Message-ID: <20140808174742.GG26820@core.coreip.homeip.net>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
 <1405775445-4454-6-git-send-email-dh.herrmann@gmail.com>
 <20140806013519.GA11429@jelly.redhat.com>
 <CANq1E4QB3wiHRTjb_4xmVvXwOZvdpOQR9nZtnaZt=k2GaLJAmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33742 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbaHHRrr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Aug 2014 13:47:47 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so7554361pad.23
        for <linux-input@vger.kernel.org>; Fri, 08 Aug 2014 10:47:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4QB3wiHRTjb_4xmVvXwOZvdpOQR9nZtnaZt=k2GaLJAmw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>

On Fri, Aug 08, 2014 at 03:26:56PM +0200, David Herrmann wrote:
> Hi
> 
> On Wed, Aug 6, 2014 at 3:35 AM, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> >> +
> >> +/**
> >> + * EVIOCGABSRANGE - Fetch range of ABS values
> >> + *
> >> + * This fetches the current values of a range of ABS codes atomically. The range
> >> + * of codes to fetch and the buffer-types are passed as "struct input_absrange",
> >> + * which has the following fields:
> >> + *      slots: Number of MT slots to fetch data for.
> >> + *       code: First ABS axis to query.
> >> + *      count: Number of ABS axes to query starting at @code.
> >> + *     buffer: Pointer to a receive buffer where to store the fetched ABS
> >> + *             values. This buffer must be an array of __s32 with at least
> >> + *             (@slots * @code) elements. The buffer is interpreted as two
> >> + *             dimensional __s32 array, declared as: __s32[slots][codes]
> >
> > tbh this seems more complicated than necessary. Have you thought about
> > just dumping the events into the client buffer as if they came fresh in from
> > the device? So to sync, the client calls the ioctl with a buffer and a
> > buffer size, and the kernel simply writes a series of struct input_events
> > into that buffer, with ABS_MT_SLOT as required for all slots, (optionally?)
> > followed by a SYN_DROPPED. So the buffer afterwards could look like this:
> >    EV_ABS ABS_X 30
> >    EV_ABS ABS_X 1202
> >    EV_ABS ABS_MT_SLOT 0
> >    EV_ABS ABS_MT_POSITION_X 30
> >    EV_ABS ABS_MT_POSITION_Y 1202
> >    EV_ABS ABS_MT_SLOT 1
> >    EV_ABS ABS_MT_POSITION_X 80
> >    EV_ABS ABS_MT_POSITION_Y 1800
> >    EV_SYN SYN_REPORT 0
> >
> > the client can then go through and just process the events on-by-one as it
> > would otherwise with real events.
> >
> > This approach could be even extended to include EV_KEY, etc. providing a
> > single ioctl to sync the whole state of the device atomically.
> >
> > comments?

I like it.

> 
> So you mean instead of passing a __32 array we pass a "struct
> input_event" array and write it there? So bypassing the receive-queue?
> That does sound quite nice, indeed. We could replace all the other
> "sync" ioctls and just provide a way to receive all the events
> directly.
> 
> Something like:
> 
> EVIOCQUERY(struct input_query)
> 
> struct input_query {
>         __u16 type;
>         __u16 start_code;
>         __u16 end_code;
>         __u16 slots;
> 
>         struct input_event buffer[];
> };

No, it is more like EVIOCRESYNC(void) which makes input core to dump all
existing state into the client's standard event queue so that here is no
need to reconcile/reconstruct anything. We could give a new SYN marker
to indicate end-of-state boundary.

Thanks.

-- 
Dmitry
