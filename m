From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Sun, 10 Oct 2010 20:16:13 -0700
Message-ID: <20101011031613.GA4470@core.coreip.homeip.net>
References: <20101010205147.GA18455@core.coreip.homeip.net>
 <Pine.LNX.4.44L0.1010101700100.30042-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60128 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0JKDQU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Oct 2010 23:16:20 -0400
Received: by yxm8 with SMTP id 8so54679yxm.19
        for <linux-input@vger.kernel.org>; Sun, 10 Oct 2010 20:16:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010101700100.30042-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>

On Sun, Oct 10, 2010 at 05:09:09PM -0400, Alan Stern wrote:
> On Sun, 10 Oct 2010, Dmitry Torokhov wrote:
> 
> > > > OK, so how is a graphics driver going to figure out it should suspend when the
> > > > button is pressed in the example above?
> > > 
> > > The graphics driver doesn't have to figure that out at all.  It merely
> > > has to suspend the display whenever it can, i.e., whenever the usage
> > > count drops to 0 (or equivalently, whenever the runtime_idle callback
> > > runs).
> > 
> > That makes sense for drivers that do very agressive PM, but fails for
> > cases when you have bigger timeouts. My phone shuts off its display
> > automatically after 30 seconds or a minute but I have an option of
> > pressing a button which causes it to shut off immediately.
> > 
> > > 
> > > It's up to userspace to make sure that the display's usage count goes
> > > to 0 at the proper time, i.e., when the button is pressed.  Contrary to
> > > what you wrote above, we _do_ have an interface for this at the PM core
> > > level: power/control.
> > > 
> > 
> > I think that while using power/control is a _very_ good option "auto"
> > and "on" are not enough, we need 3 states: "on", "off" and "auto".
> 
> Will the driver use autosuspend for the 30-second delay?  Then all you
> have to do is this: When the button is pressed, write 0 to
> power/autosuspend_delay_ms, causing an immediate runtime suspend.  
> Then before turning the display back on, write 30000 to set the delay
> to 30 seconds again.  You can leave power/control set to "auto" the
> whole time.
> 

This means messing up with the currently set timeout. If userspace could
have an option of "accelerating" expiring of the current timeout that
would be better.

> I don't like the idea of having an "off" setting in power/control.  
> What happens if the user turns a disk drive controller "off" and the 
> system needs to read or write something on that disk drive?
> 

I see. Well, for some devices "sicky off" maybe the one that makes most
sense. For others we may need an option that would put them into low
power mode while allowing bringing them back if they are needed.

In case of touchscreens/keypads they are most likely configured as
wakeup sources so when user actually tried to use the device they'll be
brought online.

-- 
Dmitry
