From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Sun, 10 Oct 2010 13:51:47 -0700
Message-ID: <20101010205147.GA18455@core.coreip.homeip.net>
References: <201010100102.19862.rjw@sisk.pl>
 <Pine.LNX.4.44L0.1010101626550.30042-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36895 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0JJUvy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Oct 2010 16:51:54 -0400
Received: by pwj4 with SMTP id 4so721044pwj.19
        for <linux-input@vger.kernel.org>; Sun, 10 Oct 2010 13:51:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010101626550.30042-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sun, Oct 10, 2010 at 04:34:38PM -0400, Alan Stern wrote:
> On Sun, 10 Oct 2010, Rafael J. Wysocki wrote:
> 
> > > > > > There's no interface for that at the PM core level, but I think we should
> > > > > > add it, perhaps in analogy to the autosuspend one.  Namely, we can add a
> > > > > > flag for drivers who want to make their suspend/resume callbacks to be
> > > > > > reachable directly from user space.  Setting that flag would enable a sysfs
> > > > > > attribute in /sys/devices/.../power/ allowing user space to invoke
> > > > > > pm_runtime_suspend() and pm_runtime_resume() for the given device.
> > > > > 
> > > > > We already have power/control.  If the subsystem sets it to "on" by 
> > > > > default and the driver suspends the device whenever it is idle, then 
> > > > > userspace can control the power level by writing "auto" or "on" to 
> > > > > power/control.
> 
> ...
> 
> > > You are clearly right; userspace has to tell the driver when it is okay
> > > to suspend.  My point was that we already have a mechanism in the PM
> > > core for doing this -- assuming the driver is written appropriately (to 
> > > assume that it should try to suspend whenever possible).  We shouldn't 
> > > need to add another mechanism.
> > 
> > OK, so how is a graphics driver going to figure out it should suspend when the
> > button is pressed in the example above?
> 
> The graphics driver doesn't have to figure that out at all.  It merely
> has to suspend the display whenever it can, i.e., whenever the usage
> count drops to 0 (or equivalently, whenever the runtime_idle callback
> runs).

That makes sense for drivers that do very agressive PM, but fails for
cases when you have bigger timeouts. My phone shuts off its display
automatically after 30 seconds or a minute but I have an option of
pressing a button which causes it to shut off immediately.

> 
> It's up to userspace to make sure that the display's usage count goes
> to 0 at the proper time, i.e., when the button is pressed.  Contrary to
> what you wrote above, we _do_ have an interface for this at the PM core
> level: power/control.
> 

I think that while using power/control is a _very_ good option "auto"
and "on" are not enough, we need 3 states: "on", "off" and "auto".

Thanks.

-- 
Dmitry
