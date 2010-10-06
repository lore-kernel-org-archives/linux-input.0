From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 6 Oct 2010 21:08:00 +0200
Message-ID: <201010062108.00366.rjw@sisk.pl>
References: <201010061018.14714.dmitry.torokhov@gmail.com> <Pine.LNX.4.44L0.1010061417410.2047-100000@iolanthe.rowland.org> <20101006182647.GA5794@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51080 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758064Ab0JFTIx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Oct 2010 15:08:53 -0400
In-Reply-To: <20101006182647.GA5794@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Wednesday, October 06, 2010, Dmitry Torokhov wrote:
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

There's no interface for that at the PM core level, but I think we should
add it, perhaps in analogy to the autosuspend one.  Namely, we can add a
flag for drivers who want to make their suspend/resume callbacks to be
reachable directly from user space.  Setting that flag would enable a sysfs
attribute in /sys/devices/.../power/ allowing user space to invoke
pm_runtime_suspend() and pm_runtime_resume() for the given device.

Thanks,
Rafael
