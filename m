From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [rft]power management for usbtouch
Date: Mon, 30 Jun 2008 12:30:24 -0400
Message-ID: <20080630122901.ZZRA012@mailhub.coreip.homeip.net>
References: <20080630115953.ZZRA012@mailhub.coreip.homeip.net> <Pine.LNX.4.44L0.0806301210430.2708-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:41787 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYF3Qa2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 12:30:28 -0400
Received: by yx-out-2324.google.com with SMTP id 31so288668yxl.1
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2008 09:30:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0806301210430.2708-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Ville Syrj?l? <syrjala@sci.fi>, daniel.ritz@gmx.ch, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Jun 30, 2008 at 12:16:13PM -0400, Alan Stern wrote:
> On Mon, 30 Jun 2008, Dmitry Torokhov wrote:
> 
> > > My feeling is that we will leave manual suspension in the kernel.  The
> > > code passed to the USB driver's suspend method will be changed so that
> > > the method can tell whether it is being called for a system sleep vs.
> > > an autosuspend vs. a manual suspend.
> > > 
> > 
> > Ok, I see... So what does a device do when it is suspended and a
> > request comes in? Does it automatically resume and service the request
> > (and potentially goes back to sleep)? Does it queue the request for
> > later? Ignore it? Is it a system-wide policy or up to the device
> > [class]?
> 
> What sort of request do you mean?  If a device is suspended, it _can't_ 
> receive any data (requests or otherwise) over the USB bus.
> 
> If a device receives data over some other channel (like a mouse getting
> a button click) while it is suspended, its behavior depends on the
> settings at the time it was suspended.  If remote wakeup was disabled
> then the device does essentially nothing (maybe it remembers the data
> for later, maybe not).  If remote wakeup was enabled then the device
> should send a wakeup request to the host.
> 

I was talking about system-initiated requests... Setting LED on a keyboard,
setting rate on a mouse, uploading a force-feedback effect, writing a
sector on a disk, etc...

-- 
Dmitry
