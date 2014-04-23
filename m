From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] evdev: flush ABS_* events during EVIOCGABS
Date: Wed, 23 Apr 2014 15:38:49 +1000
Message-ID: <20140423053849.GA4036@yabbi.redhat.com>
References: <1397156944-5991-1-git-send-email-dh.herrmann@gmail.com>
 <20140422041535.GA10735@yabbi.redhat.com>
 <CANq1E4RQtaNNab9PzoBchmx2qqpJ5_PdrZjf2+ZQkq4YTNzXkA@mail.gmail.com>
 <20140423002103.GA6917@yabbi.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:43945 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbaDWFjK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 01:39:10 -0400
Content-Disposition: inline
In-Reply-To: <20140423002103.GA6917@yabbi.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Wed, Apr 23, 2014 at 10:21:03AM +1000, Peter Hutterer wrote:
> On Tue, Apr 22, 2014 at 08:21:54AM +0200, David Herrmann wrote:
> > Hi Peter
> > 
> > On Tue, Apr 22, 2014 at 6:15 AM, Peter Hutterer
> > <peter.hutterer@who-t.net> wrote:
> > > How are you planning to handle the slot-based events? We'd either need to
> > > add something similar (but more complex) to evdev_handle_mt_request or rely
> > > on the caller to call the whole EV_ABS range and ditch anything ABS_MT_.
> > > I'd prefer the former, the latter is yet more behaviour that's easy to get
> > > wrong.
> > 
> > This is all racy..
> > 
> > We _really_ need an ioctl to receive _all_ ABS information atomically.
> > I mean, there's no way we can know the user's state from the kernel.
> > Even if the user resyncs via EVIOCGMTSLOTS, we can never flush the
> > whole ABS queue. Problem is, the user has to call the ioctl for _each_
> > available MT code and events might get queued in between. So yeah,
> > this patch doesn't help much..
> > 
> > I have no better idea than adding a new EVIOCGABS call that retrieves
> > ABS values for all slots atomically (and for all other axes..). No
> > idea how to properly fix the old ioctls.
> 
> bonus points for making that ioctl fetch the state of the last SYN_DROPPED
> and leave the events since in the client buffer. That way we can smooth over
> SYN_DROPPED and lose less information.

to expand on this, something like the below would work from userspace:
 
1. userspace opens fd, EVIOCGBIT for everything
2. userspace calls EVIOCGABSATOMIC
3. kernel empties the event queue, flags the client as capable
4. kernel copies current device state into client-specific struct
5. kernel replies with that device state to the ioctl
6. client reads events 
..
7. kernel sees a SYN_DROPPED for this client. Takes a snapshot of the device
for the client, empties the buffer, leaves SYN_DROPPED in the buffer
(current behaviour)
8. client reads SYN_DROPPED, calls EVIOCGABSATOMIC
9. kernel replies with the snapshot state, leaves the event buffer otherwise
unmodified
10. client reads all events after SYN_DROPPED, gets a smooth continuation
11. goto 6

if the buffer overflows multiple times, repeat 7 so that the snapshot state
is always the last SYN_DROPPED state. well, technically the state should be
the state of the device at the first SYN_REPORT after the last SYN_DROPPED,
since the current API says that interrupted event is incomplete.

there are two oddities here:
1. the first ioctl will have to flush the buffer to guarantee consistent state,
though you could even avoid that by taking a snapshot of the device on
open(). though that comes with a disadvantage, you don't know if the client
supports the new approach so you're wasting effort and memory here.
2. I'm not quite sure how to handle multiple repeated calls short of
updating the client-specific snapshot with every event as it is read
successfully.

any comments?

Cheers,
   Peter

