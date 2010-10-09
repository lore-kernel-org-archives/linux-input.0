From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Sat, 9 Oct 2010 12:52:17 +0200
Message-ID: <201010091252.18184.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010061606330.2047-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58837 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497Ab0JIKxd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Oct 2010 06:53:33 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010061606330.2047-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Wednesday, October 06, 2010, Alan Stern wrote:
> On Wed, 6 Oct 2010, Rafael J. Wysocki wrote:
> 
> > > Mobile folks wish to power down some devices (most often input -
> > > touchscreen, keypad) under certain circumstances to save power.
> > > So far they were doing that by adding "disable" hook to individual
> > > drivers and while I did allow that in for some devices I feel that we
> > > need more standardised solution, preferably one that could re-use
> > > existing PM hooks in drivers.
> > 
> > There's no interface for that at the PM core level, but I think we should
> > add it, perhaps in analogy to the autosuspend one.  Namely, we can add a
> > flag for drivers who want to make their suspend/resume callbacks to be
> > reachable directly from user space.  Setting that flag would enable a sysfs
> > attribute in /sys/devices/.../power/ allowing user space to invoke
> > pm_runtime_suspend() and pm_runtime_resume() for the given device.
> 
> We already have power/control.  If the subsystem sets it to "on" by 
> default and the driver suspends the device whenever it is idle, then 
> userspace can control the power level by writing "auto" or "on" to 
> power/control.

The problem is that with the 'auto' setting the driver decides when to suspend
and the driver need not know it's the right time.

Suspending a graphics adapter when the user presses a "turn screen off"
button it a good example of this.  The graphics driver may not know the button
was pressed and it has to be told about that.  OTOH the button driver need
not know what exactly should be done when it is pressed.  There may be a user
space component in between that processes the button event and should be able
to tell the graphics driver to suspend.

Thanks,
Rafael
