From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] evdev: flush ABS_* events during EVIOCGABS
Date: Wed, 23 Apr 2014 10:21:03 +1000
Message-ID: <20140423002103.GA6917@yabbi.bne.redhat.com>
References: <1397156944-5991-1-git-send-email-dh.herrmann@gmail.com>
 <20140422041535.GA10735@yabbi.redhat.com>
 <CANq1E4RQtaNNab9PzoBchmx2qqpJ5_PdrZjf2+ZQkq4YTNzXkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:60249 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaDWAVH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 20:21:07 -0400
Content-Disposition: inline
In-Reply-To: <CANq1E4RQtaNNab9PzoBchmx2qqpJ5_PdrZjf2+ZQkq4YTNzXkA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, Apr 22, 2014 at 08:21:54AM +0200, David Herrmann wrote:
> Hi Peter
> 
> On Tue, Apr 22, 2014 at 6:15 AM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > How are you planning to handle the slot-based events? We'd either need to
> > add something similar (but more complex) to evdev_handle_mt_request or rely
> > on the caller to call the whole EV_ABS range and ditch anything ABS_MT_.
> > I'd prefer the former, the latter is yet more behaviour that's easy to get
> > wrong.
> 
> This is all racy..
> 
> We _really_ need an ioctl to receive _all_ ABS information atomically.
> I mean, there's no way we can know the user's state from the kernel.
> Even if the user resyncs via EVIOCGMTSLOTS, we can never flush the
> whole ABS queue. Problem is, the user has to call the ioctl for _each_
> available MT code and events might get queued in between. So yeah,
> this patch doesn't help much..
> 
> I have no better idea than adding a new EVIOCGABS call that retrieves
> ABS values for all slots atomically (and for all other axes..). No
> idea how to properly fix the old ioctls.

bonus points for making that ioctl fetch the state of the last SYN_DROPPED
and leave the events since in the client buffer. That way we can smooth over
SYN_DROPPED and lose less information.

Cheers,
   Peter
