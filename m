From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [rft]power management for usbtouch
Date: Mon, 30 Jun 2008 12:58:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806301249440.2708-100000@iolanthe.rowland.org>
References: <20080630122901.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34448 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753467AbYF3Q6R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 12:58:17 -0400
In-Reply-To: <20080630122901.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Ville Syrj?l? <syrjala@sci.fi>, daniel.ritz@gmx.ch, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 30 Jun 2008, Dmitry Torokhov wrote:

> On Mon, Jun 30, 2008 at 12:16:13PM -0400, Alan Stern wrote:
> > On Mon, 30 Jun 2008, Dmitry Torokhov wrote:
> > 
> > > > My feeling is that we will leave manual suspension in the kernel.  The
> > > > code passed to the USB driver's suspend method will be changed so that
> > > > the method can tell whether it is being called for a system sleep vs.
> > > > an autosuspend vs. a manual suspend.
> > > > 
> > > 
> > > Ok, I see... So what does a device do when it is suspended and a
> > > request comes in? Does it automatically resume and service the request
> > > (and potentially goes back to sleep)? Does it queue the request for
> > > later? Ignore it? Is it a system-wide policy or up to the device
> > > [class]?
> > 
> > What sort of request do you mean?  If a device is suspended, it _can't_ 
> > receive any data (requests or otherwise) over the USB bus.
> > 
> > If a device receives data over some other channel (like a mouse getting
> > a button click) while it is suspended, its behavior depends on the
> > settings at the time it was suspended.  If remote wakeup was disabled
> > then the device does essentially nothing (maybe it remembers the data
> > for later, maybe not).  If remote wakeup was enabled then the device
> > should send a wakeup request to the host.
> > 
> 
> I was talking about system-initiated requests... Setting LED on a keyboard,
> setting rate on a mouse, uploading a force-feedback effect, writing a
> sector on a disk, etc...

Then I don't understand the original question, since it's impossible 
for the system to send a request to a suspended device.

Did you perhaps intend to ask what a _driver_ does when its device is
suspended and it receives an I/O request?  The action depends on the
reason for the suspend:

	If the device was suspended for a system sleep, the request
	should be deferred until the device is resumed when the
	system wakes up.

	If the device was autosuspended, the driver should autoresume
	the device and then transmit the request.

	If the device was manually suspended, the driver should fail
	the request.

In practice, what is most likely to happen is that the driver will 
always try to autoresume the device.  Then:

	If a system sleep is in progress, the autoresume is supposed to
	block until the system wakes up (but this behavior has not yet 
	been implemented -- generally no requests can arrive during a
	system sleep anyway because userspace is frozen).

	If the device is autosuspended, the autoresume works and the
	driver can transmit the request.

	If the device is manually suspended, the autoresume fails and
	so the driver fails the request.

Alan Stern

