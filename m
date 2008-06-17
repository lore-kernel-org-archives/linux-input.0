From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Tue, 17 Jun 2008 13:53:56 -0400
Message-ID: <20080617134137.ZZRA012@mailhub.coreip.homeip.net>
References: <20080617112149.ZZRA012@mailhub.coreip.homeip.net> <Pine.LNX.4.44L0.0806171316380.2652-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:39520 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbYFQRyL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2008 13:54:11 -0400
Received: by yx-out-2324.google.com with SMTP id 31so558010yxl.1
        for <linux-input@vger.kernel.org>; Tue, 17 Jun 2008 10:54:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0806171316380.2652-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Ville Syrj?l? <syrjala@sci.fi>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Peter Stokes <linux@dadeos.co.uk>

On Tue, Jun 17, 2008 at 01:24:25PM -0400, Alan Stern wrote:
> On Tue, 17 Jun 2008, Dmitry Torokhov wrote:
> 
> > On Tue, Jun 17, 2008 at 10:39:15AM -0400, Alan Stern wrote:
> > > On Tue, 17 Jun 2008, Dmitry Torokhov wrote:
> > > 
> > > > Input core only protects open() and close(); connect() and
> > > > disconnect() belong to respective bus's implementation the device is
> > > > sitting on and input core has no authority over it.
> > > 
> > > What about open vs. unregister?  The input core must have some 
> > > protection for those two.
> > > 
> > 
> > input_unregister_device() sets dev->going_away at the very beginning
> > and input_open_device() will fail with -ENODEV when trying to open such
> > devices. dev->going_away (among other things) is protected by
> > dev->mutex.
> > 
> > Do you see any issues with this scheme?
> 
> It depends on how much code is protected by dev->mutex.
> 
> The real issue involving open vs. unregister comes down to this.  It 
> should not be possible for either:
> 
>     (1) an input_unregister_device() call to return while an
> 	input_open_device() call is in progress; or

Theoretically it is possible with wierd scheduling i guess. What I can
guarantee is that either input_open_device() fails or if it succeeds
input_close_device() will be called for the device at some point but
before input_unregister_device() returns. Does this help?

> 
>     (2) an input_open_device() call to be made after
> 	input_unregister_device() has returned.

As soon as input_unregister_device() starts executing
input_open_device() will start failing. Additionally, when
unregistering a device we forcefully disconnect all attached input
handlers so by the time input_unregister_device() is finished there
should be noone who can call input_open_device().

-- 
Dmitry
