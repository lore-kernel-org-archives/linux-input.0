From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 00:24:25 +0200
Message-ID: <201010110024.25955.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010101700100.30042-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33273 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab0JJWZj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Oct 2010 18:25:39 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010101700100.30042-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sunday, October 10, 2010, Alan Stern wrote:
> On Sun, 10 Oct 2010, Dmitry Torokhov wrote:
... 
> > > 
> > > It's up to userspace to make sure that the display's usage count goes
> > > to 0 at the proper time, i.e., when the button is pressed.  Contrary to
> > > what you wrote above, we _do_ have an interface for this at the PM core
> > > level: power/control.

I think that power/control is not sufficient, because drivers may generally not
have enough information to make a decision to suspend the device.  What you're
saying basically means that for every driver there should be an interface for
user space to tell it when the device is not used (and therefore may be
suspended), which is pretty much what I'm saying.  The difference seems to be
that I think it's better to put this interface into /sys/devices/.../power/,
while your opinion seems to be that the interface should be driver-specific.

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
> I don't like the idea of having an "off" setting in power/control.  
> What happens if the user turns a disk drive controller "off" and the 
> system needs to read or write something on that disk drive?

That's why I said about a new flag that will only be set by drivers
_knowing_ that they can suspend "on demand".

Thanks,
Rafael
