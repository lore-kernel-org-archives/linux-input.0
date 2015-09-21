From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 21 Sep 2015 22:20:13 +0200
Message-ID: <20150921202013.GA11745@amd>
References: <20150921123055.GB16589@amd>
 <Pine.LNX.4.44L0.1509211035000.1713-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40890 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383AbbIUUUT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 16:20:19 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1509211035000.1713-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon 2015-09-21 10:38:46, Alan Stern wrote:
> On Mon, 21 Sep 2015, Pavel Machek wrote:
> 
> > > > In fact, then, what you need seems to be the feature discussed by Alan
> > > > and me some time ago allowing remote wakeup do be disabled for runtime
> > > > PM from user space as that in combination with autosuspend should
> > > > address your use case.
> > > 
> > > That, plus they want the touchscreen to go into runtime suspend 
> > > whenever the screen is off (was this not the main reason for the 
> > > patch?).
> > > 
> > > It seems to me that it should be possible to arrange for this to happen 
> > > simply by making userspace close the touchscreen device when the screen 
> > > is turned off.  Or am I missing something?
> > 
> > Well... that's not what existing userspace expects. Your X windows
> > server will not close the touchscreen.
> 
> Surely that's a userspace issue, rather than a kernel problem?  The X
> server does have some notion of power management and power savings; why
> not extend that notion to include touchscreens?

Well... once upon a time, it was kernel job to mask differences
between different hardware platforms.

In a way, the hardware is "buggy" -- if your mouse clicked randomly
when you were not holding it in your hand it would be buggy... and it
would be nice for kernel to fix that "bug". 

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
