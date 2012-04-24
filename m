From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Tue, 24 Apr 2012 11:10:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204241100210.1511-100000@iolanthe.rowland.org>
References: <201204241635.10090.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37264 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754777Ab2DXPKF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 11:10:05 -0400
In-Reply-To: <201204241635.10090.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Tue, 24 Apr 2012, Oliver Neukum wrote:

> Am Montag, 23. April 2012, 17:42:11 schrieb Alan Stern:
> > I don't like the idea of changing the status codes.  It would mean 
> > changing usb_kill_urb too.
> 
> Why?

Okay, maybe it wouldn't.  If usb_unlink_urb returned -ENOENT as the 
status for synchronous givebacks then they could be treated the same as 
usb_kill_urb's synchronous completions.

But it certainly would mean changing every HCD.

> > Instead of changing return codes or adding locks, how about
> > implementing a small state machine for each URB?
> > 
> >         Initially the state is ACTIVE.
> > 
> >         When the URB times out, acquire the lock.  If the state is not
> >         equal to ACTIVE, drop the lock and return immediately (the URB
> >         is being unlinked concurrently).  Otherwise set the state to 
> >         UNLINK_STARTED, drop the lock, call usb_unlink_urb, and
> >         reacquire the lock.  If the state hasn't changed, set it back
> >         to ACTIVE.  But if the state has changed to UNLINK_FINISHED,
> >         set it to ACTIVE and resubmit.
> > 
> >         In the completion handler, grab the lock.  If the state
> >         is ACTIVE, resubmit.  But if the state is UNLINK_STARTED, 
> >         change it to UNLINK_FINISHED and don't resubmit.
> > 
> > This is a better approach, in that it doesn't make any assumptions 
> > regarding synchronous vs. asynchronous unlinks.  If you want, you could 
> > have two different ACTIVE substates, one for URBs which haven't yet 
> > been unlinked and one for URBs which have been.  Then you could avoid 
> > unlinking the same URB twice.
> 
> That would work, provided we extend the status machine by an error
> code when resubmission is not desired

Presumably there would be a "resubmit" function which could be called
by both the completion handler and the unlink handler.  It should be
able to tell if a resubmission was not desired, with no need for extra
state information.

How does the current driver decide whether to resubmit?

> and check for UNLINK_STARTED
> also when a timeout begins.

That was part of my description above: "If the state is not equal to
ACTIVE, drop the lock and return immediately (the URB is being unlinked
concurrently)."

> But I wouldn't call that a simple solution.

Well, that's a matter of opinion.  It does have the advantage, unlike 
lots of other proposals in this email thread, of being a _correct_ 
solution.

Alan Stern

