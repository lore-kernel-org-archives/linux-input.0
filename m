From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 21 Sep 2015 13:32:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509211323540.1713-100000@iolanthe.rowland.org>
References: <20150921165919.GG17389@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150921165919.GG17389@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, 21 Sep 2015, Dmitry Torokhov wrote:

> > It sounds like you are suggesting there should be a general mechanism
> > for userspace to tell the kernel (or the input core) to ignore all
> > events from a particular input device -- or even from all input devices
> > -- thereby allowing those devices to go to low power.
> 
> Yes. In ChromeOS we have a custim "inhibit" control that:
> 
> 1. Tells input core to ignore all events form a given device
> 2. Allows driver to put device in low power mode if driver desires to do
> so. The driver can do it via runtime PM or on it's own. Usually on it's
> own since when using runtime PM userspace may disable it, which may not
> be desirable.
> 
> I would love to have something generic instead of input-specific.
> 
> > 
> > I don't like to think of this as "forcing runtime suspend".  It's more
> > like telling the kernel that a device is no longer being used, so the
> > natural runtime PM mechanism can put it in runtime suspend.
> 
> I'd call it "accelerating" runtime suspend. Userspace tells the kernel
> that it intends not to use given device and kernel reacts accordingly.

Okay.

> > Perhaps another way to think about it is that these input devices 
> > should not increment their runtime usage counter as part of the open 
> > routine; they should use something other than the number of open file 
> > references to indicate when they can go into runtime suspend.  (I'm not 
> > sure what else they should use, though.)
> 
> I do not really want input specific support; as I mentioned before we
> have something like that in ChromeOS kernels but I was hesitant bringing
> it upstream as I believe it is not necessarily input device specific and
> I would love to have it implemented at device core level.

That's not a bad idea.  On the other hand, there must be lots of 
devices which would not be suitable for this.  Disk drives, for 
instance.

What happens if the "inhibit" control is turned on and the driver puts 
the device into runtime suspend, but then an I/O request arrives?

	If the I/O request originated from userspace, it means the
	user is violating the terms of the "inhibit" control.  Should
	the request simply fail?

	What if the I/O request originated from somewhere in the
	kernel, not from the user?

	Or maybe the driver would want to carry out the request,
	overriding the "inhibit" control temporarily.  Does it simply
	turn off the control, meaning that the device won't go back
	into runtime suspend until userspace turns the control on
	again?

	Or if the driver doesn't turn off the "inhibit" control, then
	how does it know when it can safely put the device back into
	runtime suspend?

Qustions like these make me think that this mechanism is best suited 
for a kind of device that doesn't handle I/O requests.  In other words, 
something that just reports events as they occur -- which is another 
way of describing an input device!

Alan Stern
