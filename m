From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 10:33:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110121030030.2093-100000@iolanthe.rowland.org>
References: <201110120832.45938.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33715 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751130Ab1JLOdO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 10:33:14 -0400
In-Reply-To: <201110120832.45938.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, 12 Oct 2011, Oliver Neukum wrote:

> Am Dienstag, 11. Oktober 2011, 22:42:50 schrieb Matthew Garrett:
> > On Tue, Oct 11, 2011 at 01:09:21PM +0200, Oliver Neukum wrote:
> > > Am Dienstag, 11. Oktober 2011, 13:04:21 schrieb Henrik Rydberg:
> > > > Problem: the hid keyboard driver refuses to suspend while a key is
> > > > pressed, which is fine per se, but there is no indication presented to the power layer,
> > > > resulting in a failed suspend and (due to complex reasons it seems) disabled autosuspend.
> > > 
> > > That is a bug. Autosuspend at a later date should happen.
> > 
> > Yeah, there's definitely something broken here. If I hold down a key on 
> > a USB keyboard for more than two seconds then it attempts to suspend but 
> > fails. Releasing the key triggers another usb_mark_busy() but the core 
> > never tries to suspend it again. What /does/ trigger a second attempt at 
> > suspend is toggling an LED on and then off.
> 
> It seems to me that rpm_suspend() in drivers/base/power has already called
> pm_runtime_cancel_pending(dev) unconditionally before calling rpm_callback()
> And afterwards the timer is not restarted.

I admit to not being very familiar with the way usbhid handles 
autosuspend.  However in general, if a suspend fails because the driver 
is busy, then when the driver stops being busy it should initiate the 
next round of autosuspend.  In this case, when the key release has been 
fully processed, the driver should call usb_put_interface_async() or 
something similar, which would restart the timer.

Alan Stern

