From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Sun, 10 Oct 2010 16:34:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010101626550.30042-100000@netrider.rowland.org>
References: <201010100102.19862.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:41079 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751537Ab0JJUej (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Oct 2010 16:34:39 -0400
In-Reply-To: <201010100102.19862.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sun, 10 Oct 2010, Rafael J. Wysocki wrote:

> > > > > There's no interface for that at the PM core level, but I think we should
> > > > > add it, perhaps in analogy to the autosuspend one.  Namely, we can add a
> > > > > flag for drivers who want to make their suspend/resume callbacks to be
> > > > > reachable directly from user space.  Setting that flag would enable a sysfs
> > > > > attribute in /sys/devices/.../power/ allowing user space to invoke
> > > > > pm_runtime_suspend() and pm_runtime_resume() for the given device.
> > > > 
> > > > We already have power/control.  If the subsystem sets it to "on" by 
> > > > default and the driver suspends the device whenever it is idle, then 
> > > > userspace can control the power level by writing "auto" or "on" to 
> > > > power/control.

...

> > You are clearly right; userspace has to tell the driver when it is okay
> > to suspend.  My point was that we already have a mechanism in the PM
> > core for doing this -- assuming the driver is written appropriately (to 
> > assume that it should try to suspend whenever possible).  We shouldn't 
> > need to add another mechanism.
> 
> OK, so how is a graphics driver going to figure out it should suspend when the
> button is pressed in the example above?

The graphics driver doesn't have to figure that out at all.  It merely
has to suspend the display whenever it can, i.e., whenever the usage
count drops to 0 (or equivalently, whenever the runtime_idle callback
runs).

It's up to userspace to make sure that the display's usage count goes
to 0 at the proper time, i.e., when the button is pressed.  Contrary to
what you wrote above, we _do_ have an interface for this at the PM core
level: power/control.

Alan Stern

