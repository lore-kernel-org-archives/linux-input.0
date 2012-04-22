From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sun, 22 Apr 2012 08:54:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204220850150.15283-100000@netrider.rowland.org>
References: <CACVXFVOQpYcHUj3XApyCVWDuvUEKi+RSWC8Ly4Dnj7vrun68cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:36406 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751656Ab2DVMyL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Apr 2012 08:54:11 -0400
In-Reply-To: <CACVXFVOQpYcHUj3XApyCVWDuvUEKi+RSWC8Ly4Dnj7vrun68cg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sun, 22 Apr 2012, Ming Lei wrote:

> On Sun, Apr 22, 2012 at 1:31 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Sat, 21 Apr 2012, Ming Lei wrote:
> >> How about always scheduling a tasklet to run what usb_unlink_urb does?
> >> just implement usb_unlink_urb as something like
> >> tasklet_schedule(unlink_tasklet).
> >>
> >> Then we can have a uniform lock requirement and no changes are involved
> >> on host controller drivers.
> >
> > The return values would not be correct.
> 
> If you run 'git grep -n usb_unlink_urb drivers/usb/', it may show that
> most of callers do not check its return value, and the others only check
> for dumping warnings. If usb_unlink_urb is converted into tasklet
> implementation, we still can dump these warnings inside its tasklet function.

That sounds rather awkward.  How would the "tasklet-ized" version of 
usb_unlink_urb know what warnings to issue?

> > On the other hand, usbnet could call usb_unlink_urb from within a
> > tasklet.
> 
> Sorry, you mean tasklet_schedule can't be called inside a tasklet?

What I meant is: If you're going to run in a tasklet, it doesn't matter
whether the tasklet is started by the usb_unlink_urb function or by its
caller.  The end result should be the same either way.

However Oliver has already objected to using a tasklet for unlinking.

Alan Stern

