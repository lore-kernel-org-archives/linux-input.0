From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [rft]power management for usbtouch
Date: Mon, 30 Jun 2008 12:02:44 -0400
Message-ID: <20080630115953.ZZRA012@mailhub.coreip.homeip.net>
References: <20080630112709.ZZRA012@mailhub.coreip.homeip.net> <Pine.LNX.4.44L0.0806301145020.2708-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:31670 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbYF3QCs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 12:02:48 -0400
Received: by yx-out-2324.google.com with SMTP id 31so281877yxl.1
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2008 09:02:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0806301145020.2708-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Ville Syrj?l? <syrjala@sci.fi>, daniel.ritz@gmx.ch, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Jun 30, 2008 at 11:47:28AM -0400, Alan Stern wrote:
> On Mon, 30 Jun 2008, Dmitry Torokhov wrote:
> 
> > > > Forcing a disconnection during suspend might be a good idea.  But if 
> > > > you do, is there any reason to consider manual suspension different 
> > > > from system sleep?
> > > 
> > > During system sleep user space is asleep and cannot make demands
> > > on drivers. If you force a device to sleep, the driver cannot work. Therefore
> > > it should not be bound to such a device. It's cleaner to disconnect.
> > 
> > I'd agree with this. Otherwise we need somehow to be able to resync
> > the state of the device (like have LEDs and repeat rate reset,
> > re-upload force-feedback effects, etc, etc) once device is resumed.
> > So... what is the consensus? Do we need to worry about manual
> > device-level suspension or it will be reworked/removed?
> 
> My feeling is that we will leave manual suspension in the kernel.  The
> code passed to the USB driver's suspend method will be changed so that
> the method can tell whether it is being called for a system sleep vs.
> an autosuspend vs. a manual suspend.
> 

Ok, I see... So what does a device do when it is suspended and a
request comes in? Does it automatically resume and service the request
(and potentially goes back to sleep)? Does it queue the request for
later? Ignore it? Is it a system-wide policy or up to the device
[class]?

-- 
Dmitry
