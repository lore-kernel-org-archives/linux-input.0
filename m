From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sat, 21 Apr 2012 17:49:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204211717310.3981-100000@netrider.rowland.org>
References: <201204212128.08991.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:42610 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751515Ab2DUVtJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Apr 2012 17:49:09 -0400
In-Reply-To: <201204212128.08991.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sat, 21 Apr 2012, Oliver Neukum wrote:

> > On the other hand, usbnet could call usb_unlink_urb from within a 
> > tasklet.
> 
> No. That would introduce a race.
> Basically whenever a completion handler resubmits itself, any timeout
> has to avoid a race. Checking for a timeout and unlinking must be atomic,
> just as the completion handler must make the resubmission and noting
> the time atomic.
> If I cannot do this with a lock, then a much more complex pattern is necessary.

I see.  I never really understood the problem before.

Although the kerneldoc doesn't actually say so, it should be safe to
assume that usb_unlink_urb calls the completion routine directly _only_
in cases where the unlink succeeded.  (We could add this to the 
kerneldoc.)

Therefore: If the URB completes with status other than -ECONNRESET then 
you can safely take the lock for resubmission.  If the URB completes 
with status == -ECONNRESET then you know it was unlinked, so you don't 
need to take the lock -- the race has already been lost.

Does that solve your problem?

Alan Stern

