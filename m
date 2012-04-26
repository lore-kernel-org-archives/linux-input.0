From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in
 __usbhid_submit_report
Date: Thu, 26 Apr 2012 16:40:51 -0700
Message-ID: <20120426234051.GA25823@kroah.com>
References: <Pine.LNX.4.44L0.1204251113330.1471-100000@iolanthe.rowland.org>
 <alpine.LNX.2.00.1204270044100.1856@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:61834 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759483Ab2DZXkz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Apr 2012 19:40:55 -0400
Received: by dadz8 with SMTP id z8so181759dad.10
        for <linux-input@vger.kernel.org>; Thu, 26 Apr 2012 16:40:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1204270044100.1856@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.de>, Ming Lei <ming.lei@canonical.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Fri, Apr 27, 2012 at 12:44:57AM +0200, Jiri Kosina wrote:
> On Wed, 25 Apr 2012, Alan Stern wrote:
> 
> > On Wed, 25 Apr 2012, Oliver Neukum wrote:
> > 
> > > From 9ff6b78dc59c98b9844dc9922549fd338828a889 Mon Sep 17 00:00:00 2001
> > > From: Oliver Neukum <oliver@neukum.org>
> > > Date: Wed, 25 Apr 2012 12:50:37 +0200
> > > Subject: [PATCH] usbhid: prevent deadlock during timeout
> > > 
> > > On some HCDs usb_unlink_urb() can directly call the
> > > completion handler. That limits the spinlocks that can
> > > be taken in the handler to locks not held while calling
> > > usb_unlink_urb()
> > > To prevent a race with resubmission, this patch exposes
> > > usbcore's infrastructure for blocking submission, uses it
> > > and so drops the lock without causing a race in usbhid.
> > 
> > Simply preventing resubmission is a good idea.
> > 
> > > Signed-off-by: Oliver Neukum <oneukum@suse.de>
> > > ---
> > >  drivers/hid/usbhid/hid-core.c |   61 +++++++++++++++++++++++++++++++++++++----
> > >  drivers/usb/core/urb.c        |   30 ++++++++++++++++++++
> > >  include/linux/usb.h           |    2 +
> > >  3 files changed, 87 insertions(+), 6 deletions(-)
> > 
> > This should be split into two patches: one for usbhid and one for 
> > usbcore.
> 
> Alternatively you can use my
> 
> 	Acked-by: Jiri Kosina <jkosina@suse.cz>
> 
> for the usbhid part and apply through USB tree.
> 
> Thanks everybody,

Wait, was this really a valid solution here?  If so, can someone bounce
this to me...

thanks,

greg k-h
