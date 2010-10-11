From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 11:56:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010111140040.2339-100000@netrider.rowland.org>
References: <201010110024.25955.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:44985 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754562Ab0JKP41 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 11:56:27 -0400
In-Reply-To: <201010110024.25955.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Mon, 11 Oct 2010, Rafael J. Wysocki wrote:

> On Sunday, October 10, 2010, Alan Stern wrote:
> > On Sun, 10 Oct 2010, Dmitry Torokhov wrote:
> ... 
> > > > 
> > > > It's up to userspace to make sure that the display's usage count goes
> > > > to 0 at the proper time, i.e., when the button is pressed.  Contrary to
> > > > what you wrote above, we _do_ have an interface for this at the PM core
> > > > level: power/control.
> 
> I think that power/control is not sufficient, because drivers may generally not
> have enough information to make a decision to suspend the device.  What you're
> saying basically means that for every driver there should be an interface for
> user space to tell it when the device is not used (and therefore may be
> suspended), which is pretty much what I'm saying.  The difference seems to be
> that I think it's better to put this interface into /sys/devices/.../power/,
> while your opinion seems to be that the interface should be driver-specific.

This has to depend on how the device is going to be used.  Will there
be multiple user processes, each using it independently?  In that case
a single attribute value won't work; some sort of counter will be
needed.  Will all access funnel through a single process?  Then a
single attribute value will work, and that attribute might as well be
power/control.

I'm not fully convinced that we are yet in a good position to do
anything along these lines.  A driver can generally tell when it is
being used easily enough: If there are I/O calls then it is in use.  
Of course there are exceptions, like a display screen that is in use
when the user is looking at it, not when the display is being updated.

To the extent that drivers can tell what's going on just by monitoring
their own activities, we don't need a new interface.  For anything
beyond that, it seems likely that the situation will vary considerably
from one device to another.  At this point we don't have enough
experience to specify a single approach that will work everywhere.

Especially since I haven't seen any scenarios so far that can't be
solved using the existing interfaces under power/.

> > I don't like the idea of having an "off" setting in power/control.  
> > What happens if the user turns a disk drive controller "off" and the 
> > system needs to read or write something on that disk drive?
> 
> That's why I said about a new flag that will only be set by drivers
> _knowing_ that they can suspend "on demand".

For such drivers, the only question is "Does userspace want me to
suspend now?"  This question can be answered by
power/autosuspend_delay_ms or by power/control.  Why is a new flag
needed?

Alan Stern

