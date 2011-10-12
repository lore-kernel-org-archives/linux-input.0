From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 11:28:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110121101420.2093-100000@iolanthe.rowland.org>
References: <201110121637.22442.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48891 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751737Ab1JLP2I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 11:28:08 -0400
In-Reply-To: <201110121637.22442.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, 12 Oct 2011, Oliver Neukum wrote:

> Am Mittwoch, 12. Oktober 2011, 16:33:13 schrieb Alan Stern:
> 
> > I admit to not being very familiar with the way usbhid handles 
> > autosuspend.  However in general, if a suspend fails because the driver 
> > is busy, then when the driver stops being busy it should initiate the 
> > next round of autosuspend.  In this case, when the key release has been 
> > fully processed, the driver should call usb_put_interface_async() or 
> > something similar, which would restart the timer.
> 
> I see. I can do this although it is not very elegant, because
> the pm counters at this point ought to be 0 already.

Well, if the usage counter is 0 then you wouldn't want to call
usb_put_interface_async().  On the other hand, if the usage counter is
0 then by definition the device isn't in use, so you shouldn't need to
fail an autosuspend request -- not unless it races with an I/O event.

To anticipate your next question, how should such a race be hanlded?
Here's one way:

	I/O event occurs; interrupt handler is called.

	Handler sets a device_busy flag.

					Autosuspend attempt occurs 
					because the usage counter is 0.

					Suspend routine returns -EBUSY
					because device_busy is set.

	Handler calls usb_get_interface_async().

	The device is active, so the handler goes on to process the 
	event.

	Handler calls usb_put_interface_async().

> Arguably a driver is the wrong layer to do this.

Are you suggesting the usb_runtime_suspend() should call 
usb_mark_last_busy() and pm_runtime_autosuspend() if usb_suspend_both() 
returns -EBUSY or -EAGAIN?

This would allow a driver to block autosuspend attempts while leaving 
the usage counter set to 0.

Alan Stern

