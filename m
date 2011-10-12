From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 15:18:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110121452500.2093-100000@iolanthe.rowland.org>
References: <201110121911.53918.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:32892 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753132Ab1JLTS2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 15:18:28 -0400
In-Reply-To: <201110121911.53918.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, 12 Oct 2011, Oliver Neukum wrote:

> Am Mittwoch, 12. Oktober 2011, 17:28:06 schrieb Alan Stern:
> > > Arguably a driver is the wrong layer to do this.
> > 
> > Are you suggesting the usb_runtime_suspend() should call 
> > usb_mark_last_busy() and pm_runtime_autosuspend() if usb_suspend_both() 
> > returns -EBUSY or -EAGAIN?
> 
> Yes.

I just sent a trial patch to Matthew.  And after a little checking, I
found the reason for the problem.

Originally usbcore did this automatically.  When we switched over to 
the runtime PM framework, the PM core did it.  But the code to retry 
failed autosuspends was removed by Rafael Wysocki in commit 
f71648d73c1650b8b4aceb3856bebbde6daa3b86 (PM / Runtime: Remove idle 
notification after failing suspend), and the USB subsystem wasn't 
updated accordingly.  I even Acked that patch -- apparently I had 
forgotten about the need for this mechanism.

So it looks like putting it back into usbcore is the right thing to do.

Alan Stern

