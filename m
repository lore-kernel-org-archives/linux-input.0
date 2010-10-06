From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 6 Oct 2010 14:51:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010061441400.2047-100000@iolanthe.rowland.org>
References: <20101006182647.GA5794@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52366 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933007Ab0JFSvV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 14:51:21 -0400
In-Reply-To: <20101006182647.GA5794@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>

On Wed, 6 Oct 2010, Dmitry Torokhov wrote:

> On Wed, Oct 06, 2010 at 02:19:03PM -0400, Alan Stern wrote:
> > On Wed, 6 Oct 2010, Dmitry Torokhov wrote:
> > 
> > > > > I think last time Rafael mentioned that runtime PM did not allow for
> > > > > forcing power state from userspace but I wonder if it would be possible
> > > > > for userspace to signal and "accelerate" the idle state for a device and
> > > > > then standard runtime PM framework would kick in...
> > > > 
> > > > Yes; drivers can implement their runtime power policy any way they
> > > > want.  For example, a driver could create a sysfs attribute file which
> > > > userspace could use to ask for changes in the power state.
> > > > 
> > > > The real question is whether the driver is platform-specific.  If it is
> > > > then fine, it can do whatever it wants.  If it isn't then it should
> > > > try to avoid doing things that are tied to a specific platform.
> > > >
> > > 
> > > No, I really think it is wrong. This what leads us to the situation we
> > > are in at the moment. Every device [re]implements  its own little knobs
> > > to do power management. Accelerometers export their (often tailored to a
> > > specific platform) attributes in sysfs in nonstandard way. And so on,
> > > and so forth.
> > > 
> > > Here I'd like to see these (PM) hooks done on device core level, i.e.
> > > the knobs should be unified and live in /sys/devices/.../deviceX/power/
> > 
> > I haven't followed this thread in detail.  What sort of knobs are you 
> > talking about?  That is, what needs to be done?  Maybe the PM core 
> > already provides these features.
> > 
> 
> Mobile folks wish to power down some devices (most often input -
> touchscreen, keypad) under certain circumstances to save power.
> So far they were doing that by adding "disable" hook to individual
> drivers and while I did allow that in for some devices I feel that we
> need more standardised solution, preferably one that could re-use
> existing PM hooks in drivers.

The OMAP people are working on exactly the same problem and are doing 
their best to solve it using the runtime PM framework.  There have been 
a couple of threads about it on the linux-pm mailing list:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-September/028689.html
https://lists.linux-foundation.org/pipermail/linux-pm/2010-September/028868.html

The question is not so much how the driver should be told to power-down
a device (the PM framework takes care of all that); it's how to
recognize when those "certain circumstances" occur.  Can this be done
by the kernel in a reasonably platform-independent way?  Or does the
kernel have to be told by userspace?  The PM framework supports both 
kinds of mechanism.

Alan Stern

