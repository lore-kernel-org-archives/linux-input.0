From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Tue, 15 Mar 2011 23:30:24 -0700
Message-ID: <20110316063024.GE14604@core.coreip.homeip.net>
References: <20110309134552.32007.52489.stgit@bob.linux.org.uk>
 <20110315060203.GF1046@core.coreip.homeip.net>
 <20110315125846.34b6af32@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52904 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab1CPGbH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 02:31:07 -0400
Received: by iyb26 with SMTP id 26so1353617iyb.19
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2011 23:31:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315125846.34b6af32@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org, rjw@sisk.pl

On Tue, Mar 15, 2011 at 12:58:46PM +0000, Alan Cox wrote:
> > I'd be more happy if it was just an input device. If non-wired interrupt
> > is a common case then we should probably add polled input device mode,
> 
> I can't really answer how common it is or would be - its a generic chip
> that is used on all sorts of equipment
> 
> > but we certainly should not register completely non-functional input
> > device as the driver does now.
> 
> Agreed
> 
> > We also have a way of retrieving current (or rather most recent)
> > coordinates via EVIOCGABS so I am not sure why we want the sysfs way of
> > retrieving coordinates as well.
> 
> The sysfs way comes about because the devices are very very power
> oriented, waking up and polling regularly burns power, hence also the
> power control side. Opening an input device would power it up for the
> duration it was open and the polling would cause a lot of wakeups burning
> power.
> 
> Doing open/EVIOCGABS/close to avoid that aspect of the input layer
> won't ensure you get current data that I can see - because an IRQ may not
> have occurred between the open and the EVIOCGABS so any data may be very
> stale or non-existent.

I would be perfectly fine with a driver that does refresh it's state in
dev->open() if we expect that data might be stale. We normally do not do
that because old data is normally not interesting for touchpads, mice or
keyboards and we not always have option of querying current hardware
state.

> 
> The polled case looks trivial to sort but for an IRQ driver driver it
> looks like you would need a new "get co-ordinates right now" optional
> method tht EVIOCGABS would use if available ?
> 
> > Regarding power mode - I really believe that this should be done on the
> > driver core level instead of implementing "manual off" in every single
> > driver out there.
> 
> Definitely - not sure what plans Rafael has there ?
>

Last time we discussed this we were talking about sysfs entry at the
driver core level allowing userspace to "expire" idle timer and force
runtime PM action. Rafael, did I remember that right?

Thanks.

-- 
Dmitry
