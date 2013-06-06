From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: evdev - Flush queues during EVIOCGKEY-like
 ioctls
Date: Thu, 6 Jun 2013 12:15:14 -0700
Message-ID: <20130606191514.GA4542@core.coreip.homeip.net>
References: <1364471980-2426-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33717 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab3FFTPT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Jun 2013 15:15:19 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so3774255pdj.15
        for <linux-input@vger.kernel.org>; Thu, 06 Jun 2013 12:15:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364471980-2426-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org

Hi David,

On Thu, Mar 28, 2013 at 12:59:40PM +0100, David Herrmann wrote:
> If userspace requests current KEY-state, they very likely assume that no
> such events are pending in the output queue of the evdev device.
> Otherwise, they will parse events which they already handled via
> EVIOCGKEY(). For XKB applications this can cause irreversible keyboard
> states if a modifier is locked multiple times because a CTRL-DOWN event is
> handled once via EVIOCGKEY() and once from the queue via read(), even
> though it should handle it only once.
> 
> Therefore, lets do the only logical thing and flush the evdev queue
> atomically during this ioctl. We only flush events that are affected by
> the given ioctl.
> 
> This only affects boolean events like KEY, SND, SW and LED. ABS, REL and
> others are not affected as duplicate events can be handled gracefully by
> user-space.
> 
> Note: This actually breaks semantics of the evdev ABI. However,
> investigations showed that userspace already expects the new semantics and
> we end up fixing at least all XKB applications.
> All applications that are aware of this race-condition mirror the KEY
> state for each open-file and detect/drop duplicate events. Hence, they do
> not care whether duplicates are posted or not and work fine with this fix.
> 
> Also note that we need proper locking to guarantee atomicity and avoid
> dead-locks. event_lock must be locked before queue_lock (see input-core).
> However, we can safely release event_lock while flushing the queue. This
> allows the input-core to proceed with pending events and only stop if it
> needs our queue_lock to post new events.
> This should guarantee that we don't block event-dispatching for too long
> while flushing a single event queue.

Could you please tell me again why we need to take event_lock in
addition to buffer_lock? We only affect the state of one client's buffer
and it seems to be that event_lock alone should be enough. At least it
is enough in read() when we fetching events form the client's queue.

Thanks.

-- 
Dmitry
