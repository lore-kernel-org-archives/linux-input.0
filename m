From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Tue, 17 Jun 2008 13:24:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806171316380.2652-100000@iolanthe.rowland.org>
References: <20080617112149.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:46126 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754992AbYFQRYZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2008 13:24:25 -0400
In-Reply-To: <20080617112149.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Ville Syrj?l? <syrjala@sci.fi>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Peter Stokes <linux@dadeos.co.uk>

On Tue, 17 Jun 2008, Dmitry Torokhov wrote:

> On Tue, Jun 17, 2008 at 10:39:15AM -0400, Alan Stern wrote:
> > On Tue, 17 Jun 2008, Dmitry Torokhov wrote:
> > 
> > > Input core only protects open() and close(); connect() and
> > > disconnect() belong to respective bus's implementation the device is
> > > sitting on and input core has no authority over it.
> > 
> > What about open vs. unregister?  The input core must have some 
> > protection for those two.
> > 
> 
> input_unregister_device() sets dev->going_away at the very beginning
> and input_open_device() will fail with -ENODEV when trying to open such
> devices. dev->going_away (among other things) is protected by
> dev->mutex.
> 
> Do you see any issues with this scheme?

It depends on how much code is protected by dev->mutex.

The real issue involving open vs. unregister comes down to this.  It 
should not be possible for either:

    (1) an input_unregister_device() call to return while an
	input_open_device() call is in progress; or

    (2) an input_open_device() call to be made after
	input_unregister_device() has returned.

Your description above suggests that (2) can never happen, but I can't
tell for sure.  And what about (1)?

Alan Stern

