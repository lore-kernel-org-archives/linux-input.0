From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 11:32:24 -0800
Message-ID: <20101203193224.GA21277@core.coreip.homeip.net>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
 <20101202212223.GA9864@core.coreip.homeip.net>
 <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33755 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab0LCTce (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 14:32:34 -0500
Received: by gwj20 with SMTP id 20so4987336gwj.19
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 11:32:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On Thu, Dec 02, 2010 at 03:34:20PM -0600, Bill Gatliff wrote:
> Guys:
> 
> 
> 
> On Thu, Dec 2, 2010 at 3:22 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > We do not have such fine granularity as per-read. Input drivers get
> > notified when first application opens one of the interfaces (by
> > implementing input->open()). We expect that applications that open
> > input interfaces will read the data from them.
> 
> Right, I know that applications will ultimately read from the interface.  :)
> 
> I have noticed that several Android ports (among others) call read on
> /dev/input/eventX inside of a delayed loop--- as if they want to pace
> the rate of incoming events themselves.  In fact, in those ports the
> length of each delay is controlled by how often Android applications
> a.k.a. Activities want events streamed to them.
> 
> This is a great idea in theory, especially for things like
> accelerometers which can go much, much faster than an activity might
> need the data.  But I just haven't seen anywhere in those
> aforementioned ports where the pacing information gets conveyed over
> to the kernel-side driver.  You have answered my basic question,
> however: if such information gets conveyed back to a driver, it
> doesn't get there through the evdev interface!
> 
> Would a patch that adds a read callback, similar to how open works
> now, be well-received?  I can see it being very useful for certain
> situations...
> 

How would the driver know if application that is opened the device
does not want to be aware of the events that happened before read as
opposed to the application that simply choses to "batch" events and
process them at once? The driver might not be able to retrieve the "old"
state of the hardware. Lets say toggle WIFI button was pressed and
released while application wasn't reading. Normally kernel would queue
the events and when userspace read the FD they'd see events, whereas in
your case events would be lost.

I'd say applications that really want this behavior simply need to
go through open/read/close cycles.

-- 
Dmitry
