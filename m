From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 21 Sep 2015 12:34:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509211228290.1713-100000@iolanthe.rowland.org>
References: <20150921161634.GA17389@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48452 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757267AbbIUQe5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 12:34:57 -0400
In-Reply-To: <20150921161634.GA17389@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Mon, 21 Sep 2015, Dmitry Torokhov wrote:

> On Mon, Sep 21, 2015 at 10:38:46AM -0400, Alan Stern wrote:
> > On Mon, 21 Sep 2015, Pavel Machek wrote:
> > 
> > > > > In fact, then, what you need seems to be the feature discussed by Alan
> > > > > and me some time ago allowing remote wakeup do be disabled for runtime
> > > > > PM from user space as that in combination with autosuspend should
> > > > > address your use case.
> > > > 
> > > > That, plus they want the touchscreen to go into runtime suspend 
> > > > whenever the screen is off (was this not the main reason for the 
> > > > patch?).
> > > > 
> > > > It seems to me that it should be possible to arrange for this to happen 
> > > > simply by making userspace close the touchscreen device when the screen 
> > > > is turned off.  Or am I missing something?
> > > 
> > > Well... that's not what existing userspace expects. Your X windows
> > > server will not close the touchscreen.
> > 
> > Surely that's a userspace issue, rather than a kernel problem?  The X
> > server does have some notion of power management and power savings; why
> > not extend that notion to include touchscreens?
> 
> It is not really practical: there are many consumers of input events, if
> we build infrastructure to control it and proxy all users through it,
> why not have it in kernel? Plus, there are users of input events
> directly in the kernel, such as legacy VT/keyboard, or Android/ChromeOS
> cpufreq_interactive governor that monitors user activity and bumps up
> CPU speed when user actively interacts with the device. They would keep
> input devices active even though user might not be actually able to
> use some input devices.

It sounds like you are suggesting there should be a general mechanism
for userspace to tell the kernel (or the input core) to ignore all
events from a particular input device -- or even from all input devices
-- thereby allowing those devices to go to low power.

I don't like to think of this as "forcing runtime suspend".  It's more
like telling the kernel that a device is no longer being used, so the
natural runtime PM mechanism can put it in runtime suspend.

Perhaps another way to think about it is that these input devices 
should not increment their runtime usage counter as part of the open 
routine; they should use something other than the number of open file 
references to indicate when they can go into runtime suspend.  (I'm not 
sure what else they should use, though.)

Alan Stern

