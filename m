From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v3] Input: evdev - Flush queues during EVIOCGKEY-like ioctls
Date: Thu, 6 Jun 2013 23:10:58 +0200
Message-ID: <CANq1E4QZ_qyZjHSb23_0f6Kh+XPuPfiCRf6O=0MoOQanASFjZA@mail.gmail.com>
References: <1364471980-2426-1-git-send-email-dh.herrmann@gmail.com>
	<20130606191514.GA4542@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38335 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab3FFVK7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Jun 2013 17:10:59 -0400
Received: by mail-ie0-f182.google.com with SMTP id 9so8568635iec.13
        for <linux-input@vger.kernel.org>; Thu, 06 Jun 2013 14:10:58 -0700 (PDT)
In-Reply-To: <20130606191514.GA4542@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi Dmitry

On Thu, Jun 6, 2013 at 9:15 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi David,
>
> On Thu, Mar 28, 2013 at 12:59:40PM +0100, David Herrmann wrote:
>> If userspace requests current KEY-state, they very likely assume that no
>> such events are pending in the output queue of the evdev device.
>> Otherwise, they will parse events which they already handled via
>> EVIOCGKEY(). For XKB applications this can cause irreversible keyboard
>> states if a modifier is locked multiple times because a CTRL-DOWN event is
>> handled once via EVIOCGKEY() and once from the queue via read(), even
>> though it should handle it only once.
>>
>> Therefore, lets do the only logical thing and flush the evdev queue
>> atomically during this ioctl. We only flush events that are affected by
>> the given ioctl.
>>
>> This only affects boolean events like KEY, SND, SW and LED. ABS, REL and
>> others are not affected as duplicate events can be handled gracefully by
>> user-space.
>>
>> Note: This actually breaks semantics of the evdev ABI. However,
>> investigations showed that userspace already expects the new semantics and
>> we end up fixing at least all XKB applications.
>> All applications that are aware of this race-condition mirror the KEY
>> state for each open-file and detect/drop duplicate events. Hence, they do
>> not care whether duplicates are posted or not and work fine with this fix.
>>
>> Also note that we need proper locking to guarantee atomicity and avoid
>> dead-locks. event_lock must be locked before queue_lock (see input-core).
>> However, we can safely release event_lock while flushing the queue. This
>> allows the input-core to proceed with pending events and only stop if it
>> needs our queue_lock to post new events.
>> This should guarantee that we don't block event-dispatching for too long
>> while flushing a single event queue.
>
> Could you please tell me again why we need to take event_lock in
> addition to buffer_lock? We only affect the state of one client's buffer
> and it seems to be that event_lock alone should be enough. At least it
> is enough in read() when we fetching events form the client's queue.

We need the buffer_lock to protect against evdev_fetch_next_event() as
we might modify any part of the buffer in __flush_queue(). We don't
want userspace to get inconsistent data. And we need event_lock to
protect:
  memcpy(mem, bits, sizeof(unsigned long) * max);
Otherwise, input-core might modify the event-bits while we copy them
to our buffer. But we want the function to be atomic, so we cannot
allow modifications during the function-call.

Regards
David
