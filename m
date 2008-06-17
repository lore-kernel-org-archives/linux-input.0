From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Tue, 17 Jun 2008 14:52:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806171444230.2652-100000@iolanthe.rowland.org>
References: <20080617134137.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52815 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755173AbYFQSwu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2008 14:52:50 -0400
In-Reply-To: <20080617134137.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Ville Syrj?l? <syrjala@sci.fi>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Peter Stokes <linux@dadeos.co.uk>

On Tue, 17 Jun 2008, Dmitry Torokhov wrote:

> > > input_unregister_device() sets dev->going_away at the very beginning
> > > and input_open_device() will fail with -ENODEV when trying to open such
> > > devices. dev->going_away (among other things) is protected by
> > > dev->mutex.
> > > 
> > > Do you see any issues with this scheme?
> > 
> > It depends on how much code is protected by dev->mutex.
> > 
> > The real issue involving open vs. unregister comes down to this.  It 
> > should not be possible for either:
> > 
> >     (1) an input_unregister_device() call to return while an
> > 	input_open_device() call is in progress; or
> 
> Theoretically it is possible with wierd scheduling i guess. What I can
> guarantee is that either input_open_device() fails or if it succeeds
> input_close_device() will be called for the device at some point but
> before input_unregister_device() returns. Does this help?

Yes, that's right.  I expressed myself poorly above; what I meant was 
that it should be impossible for input_unregister_device() to return 
while a call to an input driver's open method is in progress.  Since 
the entire method call is protected by dev->mutex, this is guaranteed.

> > 
> >     (2) an input_open_device() call to be made after
> > 	input_unregister_device() has returned.
> 
> As soon as input_unregister_device() starts executing
> input_open_device() will start failing. Additionally, when
> unregistering a device we forcefully disconnect all attached input
> handlers so by the time input_unregister_device() is finished there
> should be noone who can call input_open_device().

Again, what I meant was that the open method should never be called 
after input_unregister_device() has returned, and again this is 
guaranteed.

So it all looks good from the point of view of an input device driver.  
The driver knows that after it has called input_unregister_device(),
the input core cannot have any threads for that device executing inside
the driver.

Alan Stern

