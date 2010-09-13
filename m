From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] wacom + runtime PM = AA deadlock
Date: Mon, 13 Sep 2010 13:28:31 -0700
Message-ID: <201009131328.33600.dmitry.torokhov@gmail.com>
References: <Pine.LNX.4.44L0.1009131600230.1315-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:65501 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab0IMU2q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 16:28:46 -0400
In-Reply-To: <Pine.LNX.4.44L0.1009131600230.1315-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Jiri Slaby <jslaby@suse.cz>, pingc@wacom.com, linux-pm <linux-pm@lists.linux-foundation.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Monday, September 13, 2010 01:02:16 pm Alan Stern wrote:
> On Mon, 13 Sep 2010, Oliver Neukum wrote:
> > Am Montag, 13. September 2010, 17:17:54 schrieb Alan Stern:
> > > On Mon, 13 Sep 2010, Oliver Neukum wrote:
> > > > PM in this driver looks broken. Please try this.
> > > > 
> > > > In short you want to drop the PM reference and depend on remote
> > > > wakeup and busy marking for this driver. Currently it gets a
> > > > reference on every open() but never drops it.
> > > > 
> > > > For locking you depend on the PM core's internal lock. You simply
> > > > make sure you have a PM reference during open() and close()
> > > 
> > > Is there any point in resuming the device during close() just in order
> > > to kill the interrupt URB?  It seems counterproductive -- if the device
> > > had been suspended then there wouldn't be any interrupt URB to kill in
> > > the first place.
> > 
> > Suppose the device does not support remote wakeup. It would never
> > be autosuspended while it is open, but simply resetting the flag
> > would never reach the PM layer.
> 
> Whoops, that's right.  I didn't see the assignment to
> needs_remote_wakeup.
> 
> How come wacom_open doesn't check to see if wacom->open is already set?

No need - input core will not call dev->open() twice.

-- 
Dmitry
