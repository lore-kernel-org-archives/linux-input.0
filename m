From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 6 Oct 2010 11:26:47 -0700
Message-ID: <20101006182647.GA5794@core.coreip.homeip.net>
References: <201010061018.14714.dmitry.torokhov@gmail.com>
 <Pine.LNX.4.44L0.1010061417410.2047-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60492 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932956Ab0JFS0z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 14:26:55 -0400
Received: by pzk34 with SMTP id 34so2017349pzk.19
        for <linux-input@vger.kernel.org>; Wed, 06 Oct 2010 11:26:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010061417410.2047-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Trilok Soni <tsoni@codeaurora.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>

On Wed, Oct 06, 2010 at 02:19:03PM -0400, Alan Stern wrote:
> On Wed, 6 Oct 2010, Dmitry Torokhov wrote:
> 
> > > > I think last time Rafael mentioned that runtime PM did not allow for
> > > > forcing power state from userspace but I wonder if it would be possible
> > > > for userspace to signal and "accelerate" the idle state for a device and
> > > > then standard runtime PM framework would kick in...
> > > 
> > > Yes; drivers can implement their runtime power policy any way they
> > > want.  For example, a driver could create a sysfs attribute file which
> > > userspace could use to ask for changes in the power state.
> > > 
> > > The real question is whether the driver is platform-specific.  If it is
> > > then fine, it can do whatever it wants.  If it isn't then it should
> > > try to avoid doing things that are tied to a specific platform.
> > >
> > 
> > No, I really think it is wrong. This what leads us to the situation we
> > are in at the moment. Every device [re]implements  its own little knobs
> > to do power management. Accelerometers export their (often tailored to a
> > specific platform) attributes in sysfs in nonstandard way. And so on,
> > and so forth.
> > 
> > Here I'd like to see these (PM) hooks done on device core level, i.e.
> > the knobs should be unified and live in /sys/devices/.../deviceX/power/
> 
> I haven't followed this thread in detail.  What sort of knobs are you 
> talking about?  That is, what needs to be done?  Maybe the PM core 
> already provides these features.
> 

Mobile folks wish to power down some devices (most often input -
touchscreen, keypad) under certain circumstances to save power.
So far they were doing that by adding "disable" hook to individual
drivers and while I did allow that in for some devices I feel that we
need more standardised solution, preferably one that could re-use
existing PM hooks in drivers.

-- 
Dmitry
