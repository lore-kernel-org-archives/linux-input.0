From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC RESEND 5/5] Input: evdev - add new EVIOCGABSRANGE ioctl
Date: Mon, 11 Aug 2014 12:00:46 +0200
Message-ID: <CANq1E4T5zdpuf-e9OWn_O+mrFRUKewN4xtqafR2onNKVS=rE4w@mail.gmail.com>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
	<1405775445-4454-6-git-send-email-dh.herrmann@gmail.com>
	<20140806013519.GA11429@jelly.redhat.com>
	<CANq1E4QB3wiHRTjb_4xmVvXwOZvdpOQR9nZtnaZt=k2GaLJAmw@mail.gmail.com>
	<20140808174742.GG26820@core.coreip.homeip.net>
	<CANq1E4R14eOiXQ9p7XOPiOBuOnNns+EwgQMqrwOqeVKn4y8vAQ@mail.gmail.com>
	<20140810231759.GA10731@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:39517 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbaHKKAr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2014 06:00:47 -0400
Received: by mail-ie0-f178.google.com with SMTP id rd18so9515740iec.37
        for <linux-input@vger.kernel.org>; Mon, 11 Aug 2014 03:00:46 -0700 (PDT)
In-Reply-To: <20140810231759.GA10731@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>

Hi

>> > No, it is more like EVIOCRESYNC(void) which makes input core to dump all
>> > existing state into the client's standard event queue so that here is no
>> > need to reconcile/reconstruct anything. We could give a new SYN marker
>> > to indicate end-of-state boundary.
>>
>> This doesn't make sense to me, for two reasons:
>>  * Events received during re-sync are usually handled differently than
>>    normal events. For instance, you *must* never handle key events
>>    from re-syncs for shortcuts, because you don't know the order
>>    they were pressed in.
>
> I think you're vastly overestimating what the majority of userspace does ;)
> both the xorg and the libinput-based stacks pretty much ignore this at the
> moment and by the time we handle shortcuts we're already one or more APIs
> away from the SYN_DROPPED handling.

I know what Xorg and weston do and, honestly, I don't care. If major
user-space components decide to ignore those side-effects, I'm fine.
They may have legitimate reason to do so. But I don't think we should
use this to argue against proper API design in the kernel.

> also, I haven't seen SYN_DROPPED issues from keyboard events. They usually
> happen only on absolute touch devices and ironically enough that's the one
> case where the kernel currently doesn't allow for a race-less resync.

Yes, obviously ABS and REL events are the culprits as they can occur
in vast amounts. However, any other events in between (like button
presses) may be dropped due to excessive ABS events. So I disagree
that this is an exclusive issue of ABS/REL, they just trigger the
SYN_DROPPED.

>>    If we put sync events in the queue, users cannot know where an event
>>    from.
>>    Inserting a SYNC marker is ridiculous, because following normal
>>    events may drop those (via SYN_DROPPED). We'd have to
>>    protect it. Furthermore, it's awful to handle this from user-space,
>>    because you have no idea how many events are sent as part
>>    of the sync.
>
> I suspect Dmitry meant a new EV_SYN code. From a userspace POV, I'd know
> that after the ioctl() all events up until SYN_SYNC_DONE are the syncing
> events. That would work well and is coincidentally almost identical to the
> libevdev public API.
>
> In libevdev we already have code to calculate the maximum number of events
> by a device for the current SYN_DROPPED handling. And you can reduce the
> number of events by only sending those in a non-zero state for EV_KEY,
> EV_LED, etc.

Yes, I understand what Dmitry meant and I see the similarities to
libevdev. However, there are several issues:

1) *If* you flush all events into the queue, followed by a
SYN_SYNC_DONE marker, any following *real* events might cause the
queue to overflow and thus drop the SYN_SYNC_DONE marker. So if
user-space requested a sync and then reads a SYN_DROPPED *before*
reading a SYN_SYNC_DONE, it knows the sync didn't complete and has do
redo the sync all over. This is doable, but makes we wonder whether
it's the right design.

2) The evdev queue is not designed to hold this many events. Even if
it is, a SYN_DROPPED happens during excessive event reports. So if we
now also fill the queue with all sync-events, we increase the change
of overflowing the queue again, instead of clearing it and syncing
separately.

3) Flushing sync-events in the queue with special semantics (like only
sending non-zero state) sounds to me like a dirty hack, not like
proper API design. I mean, the queue was designed to send realtime
events, not to provide initial/SYN_DROPPED syncing. I don't see why
this is preferable to a separate user-provided buffer.

> IMO the real issue preventing this approach is:
>
>>  * The receive-queue is usually too small to hold all those events.
>>    I mean, evdev uses EVDEV_BUF_PACKETS as number of buffer
>>    slots (defined as 8!). You cannot even hold a whole keyboard
>>    state there. Yes, usually it should be enough, but re-syncing
>>    is about handling corner-cases. If we make SYN_DROPPED
>>    handling cause SYN_DROPPED, we can just ignore it.
>
> yep, that too was my first thought. with a plain resync ioctl you're pretty
> much guaranteed to get SYN_DROPPED before the client manages to handle the
> resync. Even if you reduce the number of events as above because the most
> common occurance for SYN_DROPPED is in the ABS_MT range which we cannot
> meaningfully reduce.
>
>> I understand why EVIORESYNC(void) is tempting. It avoids all the
>> complexity of my patch and makes all the other sync-ioctls we have so
>> far obsolete. But the reason we want it, is to avoid shortcomings of
>> the limited receive-queue. I don't think any solution involving the
>> receive-queue is going to work out. Even if we always make sure the
>> receive-queue is big enough, we might still get new events coming in
>> before user-space can drain it.
>>
>> How about this:
>>
>> struct input_resync {
>>         __u64 count;
>>         struct input_event buffer[];
>> };
>>
>> EVIOCSYNC(struct input_resync) copies the current state of all
>> available event-types of the device into the buffer. It returns the
>> number of events that it wants to write (so user-space can pass
>> count==0 the first time to figure out the required buffer-size). The
>> ioctl then flushed the _whole_ input queue.
>
> if you go with the suggestion above of only putting events in with a
> non-zero state then a count of 0 is guaranteed to return the wrong number
> since you may get events between the two ioctl calls. I don't think
> the double ioctl() call is that a case we need. as I said above the case of
> all events must already be handled in userspace anyway.

I think it's a bad idea to only send events with non-zero state. I can
live with it, but I don't understand why we do such optimizations for
an edge-case like SYN_DROPPED handling. It just complicates things and
no-one cares whether we copy 10 or 100 events, right?

> what's the reason you don't use a EVIOCSYNC(len) approach btw? quick check
> shows at 13 or 14 bits for len which should be enough for pretty much any
> device for a long time.

I think we can just make user-space read the event-bitmasks and
calculate the length themselves. This way, we avoid double-ioctl()
calls and it's easy enough to do from user-space.

>> Note that even if we used the client's receive buffer, we'd have to
>> copy huge amounts of events while holding the event lock. So both
>> ideas have to lock the buffers during the operation. The downside of
>> my solution is that we have to allocate temporary buffers as we cannot
>> copy to user-space while holding spin-locks. However, my code already
>> makes sure we don't do high-order allocations, so I think this is
>> fine.
>>
>> This ioctl would also allow us to get rid of all the other QUERY
>> ioctls. User-space can use it to initialize it's state and then update
>> it according to incoming events. This way, we simplify the API
>> considerably! I really like this idea. I know, we only need this to
>> handle corner-cases. But as Peter already said, it's really easy to
>> trigger and ignoring it causes awful bugs in user-space.
>
> summary from my side: I'd prefer EVIOCSYNC() with a buffer parameter, only
> sending nonzero state for key/led/sw/etc. and the full state for abs. no
> need for a new EV_SYN code, and provided it empties the whole queue we
> should be race-free.

Except for "only send non-zero state" I fully agree. But I would also
accept it with that limitation/optimization.

Thanks
David
