From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 21 Sep 2015 16:02:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509211552310.1713-100000@iolanthe.rowland.org>
References: <20150921180053.GK17389@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49470 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932230AbbIUUCD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 16:02:03 -0400
In-Reply-To: <20150921180053.GK17389@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Mon, 21 Sep 2015, Dmitry Torokhov wrote:

> > What happens if the "inhibit" control is turned on and the driver puts 
> > the device into runtime suspend, but then an I/O request arrives?
> > 
> > 	If the I/O request originated from userspace, it means the
> > 	user is violating the terms of the "inhibit" control.  Should
> > 	the request simply fail?
> 
> What user? User that inhibited it or user that tried to use the device?

Normally they would be the same.  But even if they aren't, someone has 
violated the kernel interface: The first user told the kernel a 
particular device wasn't going to be used, and then the second user 
tried to use it.

Of course, this issue doesn't arise for devices that merely report 
external events.

> > 	What if the I/O request originated from somewhere in the
> > 	kernel, not from the user?
> 
> I think we should treat in-kernel users as all other users.
> 
> > 
> > 	Or maybe the driver would want to carry out the request,
> > 	overriding the "inhibit" control temporarily.  Does it simply
> > 	turn off the control, meaning that the device won't go back
> > 	into runtime suspend until userspace turns the control on
> > 	again?
> > 
> > 	Or if the driver doesn't turn off the "inhibit" control, then
> > 	how does it know when it can safely put the device back into
> > 	runtime suspend?
> > 
> > Qustions like these make me think that this mechanism is best suited 
> > for a kind of device that doesn't handle I/O requests.  In other words, 
> > something that just reports events as they occur -- which is another 
> > way of describing an input device!
> 
> Or maybe IIO device. Or hwmon. Or something else. I think if we allow
> drivers (or subsystems) to opt in into this mechanism it will solve much
> of worries about disks and similar devices that indeed not very suitable
> for such mechanism.

Should the mechanism really be per-device?  Or would it be more useful 
to have a single "inhibit" setting that affected all the relevant 
devices at once?

The runtime-PM "usage" value for these devices is a little tricky to 
calculate.  It should be nonzero if there are any open files _and_ the 
device isn't "inhibited".  I don't know the best way to represent that 
kind of condition in the runtime PM framework.

Alan Stern

