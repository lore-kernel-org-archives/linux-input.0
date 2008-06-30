From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [rft]power management for usbtouch
Date: Mon, 30 Jun 2008 11:47:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806301145020.2708-100000@iolanthe.rowland.org>
References: <20080630112709.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36168 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753314AbYF3Pr2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 11:47:28 -0400
In-Reply-To: <20080630112709.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Ville Syrj?l? <syrjala@sci.fi>, daniel.ritz@gmx.ch, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 30 Jun 2008, Dmitry Torokhov wrote:

> > > Forcing a disconnection during suspend might be a good idea.  But if 
> > > you do, is there any reason to consider manual suspension different 
> > > from system sleep?
> > 
> > During system sleep user space is asleep and cannot make demands
> > on drivers. If you force a device to sleep, the driver cannot work. Therefore
> > it should not be bound to such a device. It's cleaner to disconnect.
> 
> I'd agree with this. Otherwise we need somehow to be able to resync
> the state of the device (like have LEDs and repeat rate reset,
> re-upload force-feedback effects, etc, etc) once device is resumed.
> So... what is the consensus? Do we need to worry about manual
> device-level suspension or it will be reworked/removed?

My feeling is that we will leave manual suspension in the kernel.  The
code passed to the USB driver's suspend method will be changed so that
the method can tell whether it is being called for a system sleep vs.
an autosuspend vs. a manual suspend.

Alan Stern

