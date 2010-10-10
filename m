From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Sun, 10 Oct 2010 17:09:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010101700100.30042-100000@netrider.rowland.org>
References: <20101010205147.GA18455@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:45590 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750761Ab0JJVJL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Oct 2010 17:09:11 -0400
In-Reply-To: <20101010205147.GA18455@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sun, 10 Oct 2010, Dmitry Torokhov wrote:

> > > OK, so how is a graphics driver going to figure out it should suspend when the
> > > button is pressed in the example above?
> > 
> > The graphics driver doesn't have to figure that out at all.  It merely
> > has to suspend the display whenever it can, i.e., whenever the usage
> > count drops to 0 (or equivalently, whenever the runtime_idle callback
> > runs).
> 
> That makes sense for drivers that do very agressive PM, but fails for
> cases when you have bigger timeouts. My phone shuts off its display
> automatically after 30 seconds or a minute but I have an option of
> pressing a button which causes it to shut off immediately.
> 
> > 
> > It's up to userspace to make sure that the display's usage count goes
> > to 0 at the proper time, i.e., when the button is pressed.  Contrary to
> > what you wrote above, we _do_ have an interface for this at the PM core
> > level: power/control.
> > 
> 
> I think that while using power/control is a _very_ good option "auto"
> and "on" are not enough, we need 3 states: "on", "off" and "auto".

Will the driver use autosuspend for the 30-second delay?  Then all you
have to do is this: When the button is pressed, write 0 to
power/autosuspend_delay_ms, causing an immediate runtime suspend.  
Then before turning the display back on, write 30000 to set the delay
to 30 seconds again.  You can leave power/control set to "auto" the
whole time.

I don't like the idea of having an "off" setting in power/control.  
What happens if the user turns a disk drive controller "off" and the 
system needs to read or write something on that disk drive?

Alan Stern

