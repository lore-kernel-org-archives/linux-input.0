From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 21 Sep 2015 09:59:19 -0700
Message-ID: <20150921165919.GG17389@dtor-ws>
References: <20150921161634.GA17389@dtor-ws>
 <Pine.LNX.4.44L0.1509211228290.1713-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1509211228290.1713-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 21, 2015 at 12:34:56PM -0400, Alan Stern wrote:
> On Mon, 21 Sep 2015, Dmitry Torokhov wrote:
> 
> > On Mon, Sep 21, 2015 at 10:38:46AM -0400, Alan Stern wrote:
> > > On Mon, 21 Sep 2015, Pavel Machek wrote:
> > > 
> > > > > > In fact, then, what you need seems to be the feature discussed by Alan
> > > > > > and me some time ago allowing remote wakeup do be disabled for runtime
> > > > > > PM from user space as that in combination with autosuspend should
> > > > > > address your use case.
> > > > > 
> > > > > That, plus they want the touchscreen to go into runtime suspend 
> > > > > whenever the screen is off (was this not the main reason for the 
> > > > > patch?).
> > > > > 
> > > > > It seems to me that it should be possible to arrange for this to happen 
> > > > > simply by making userspace close the touchscreen device when the screen 
> > > > > is turned off.  Or am I missing something?
> > > > 
> > > > Well... that's not what existing userspace expects. Your X windows
> > > > server will not close the touchscreen.
> > > 
> > > Surely that's a userspace issue, rather than a kernel problem?  The X
> > > server does have some notion of power management and power savings; why
> > > not extend that notion to include touchscreens?
> > 
> > It is not really practical: there are many consumers of input events, if
> > we build infrastructure to control it and proxy all users through it,
> > why not have it in kernel? Plus, there are users of input events
> > directly in the kernel, such as legacy VT/keyboard, or Android/ChromeOS
> > cpufreq_interactive governor that monitors user activity and bumps up
> > CPU speed when user actively interacts with the device. They would keep
> > input devices active even though user might not be actually able to
> > use some input devices.
> 
> It sounds like you are suggesting there should be a general mechanism
> for userspace to tell the kernel (or the input core) to ignore all
> events from a particular input device -- or even from all input devices
> -- thereby allowing those devices to go to low power.

Yes. In ChromeOS we have a custim "inhibit" control that:

1. Tells input core to ignore all events form a given device
2. Allows driver to put device in low power mode if driver desires to do
so. The driver can do it via runtime PM or on it's own. Usually on it's
own since when using runtime PM userspace may disable it, which may not
be desirable.

I would love to have something generic instead of input-specific.

> 
> I don't like to think of this as "forcing runtime suspend".  It's more
> like telling the kernel that a device is no longer being used, so the
> natural runtime PM mechanism can put it in runtime suspend.

I'd call it "accelerating" runtime suspend. Userspace tells the kernel
that it intends not to use given device and kernel reacts accordingly.

> 
> Perhaps another way to think about it is that these input devices 
> should not increment their runtime usage counter as part of the open 
> routine; they should use something other than the number of open file 
> references to indicate when they can go into runtime suspend.  (I'm not 
> sure what else they should use, though.)

I do not really want input specific support; as I mentioned before we
have something like that in ChromeOS kernels but I was hesitant bringing
it upstream as I believe it is not necessarily input device specific and
I would love to have it implemented at device core level.

Thanks.

-- 
Dmitry
