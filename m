From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Enable xy scrolling for Apple Magic Mouse
Date: Sun, 14 Feb 2010 23:18:50 -0800
Message-ID: <20100215071850.GB9135@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>
 <201002141724.33223.edt@aei.ca>
 <87zl3bbfdo.fsf@troilus.org>
 <201002141858.26917.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f196.google.com ([209.85.210.196]:52699 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab0BOHSz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Feb 2010 02:18:55 -0500
Content-Disposition: inline
In-Reply-To: <201002141858.26917.edt@aei.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ed Tomlinson <edt@aei.ca>
Cc: Michael Poole <mdpoole@troilus.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 14, 2010 at 06:58:26PM -0500, Ed Tomlinson wrote:
> On Sunday 14 February 2010 17:51:15 Michael Poole wrote:
> > Ed Tomlinson writes:
> > 
> > > Hi,
> > >
> > > Here is a patch that enables xy scrolling with the magic mouse.  I have also
> > > changed the accelleration logic to work better with xy scrolling.
> > 
> > Hi Ed,
> > 
> > Your other patch to call input_unregister_device() looks good -- thanks!
> 
> Thanks.  One question about it though.  Do we have to check if msc is null before
> the unregister?

If it is NULL whan remove() is running there are much bigger problems
with the driver/HID subsystem.

> 
> > I've never used a horizontal scroll wheel -- what are the common uses
> > for it?  Why should the acceleration be separate for the two directions
> > rather than using the same factor?  Why does the kernel need to emulate
> > this rather than having user-space implement the emulation?
> 
> Its usefull for scrolling left and right while browsing.  If you use kde it can
> be used to scroll between applications on the taskbar.   Here most applications
> with a horizontial scrollbar work as expected.
> 
> I first tried with a single acceleration value for both axies.  It leads to confusing
> things happening.   For example.  I quickly scroll down, then nudge the
> window to the left.  This works as expect with two values.  With one the
> nudge is accelerated and moves too far.
> 
> My personal goal is to have the basic, apple defined, gestures working
> from kernel space.  This way the device works as expected without needing
> to fiddle with X or other managers (think wayland and/or chromeOS).

I am not sure if this is the desired approach. The current idea is to
export useable but minimally processed events to userspace and let them
be turned into gestures there (by evdev, synaptics driver and so forth).

Thanks.
 
-- 
Dmitry
