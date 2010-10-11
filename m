From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 12:53:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010111240390.2339-100000@netrider.rowland.org>
References: <20101011161546.GA5149@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:52882 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755539Ab0JKQxM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 12:53:12 -0400
In-Reply-To: <20101011161546.GA5149@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>

On Mon, 11 Oct 2010, Dmitry Torokhov wrote:

> > > This means messing up with the currently set timeout. If userspace could
> > > have an option of "accelerating" expiring of the current timeout that
> > > would be better.
> > 
> > Accelerating the expiration of the timeout _is_ a form of messing with
> > the currently-set timeout.  It can't be "better".
> 
> I was thinking about the case where timeout is user-supplied setting.
> Instead of having application store the original value, write 0, and
> later on restore it, I thought it would be better (as in simpler) to
> have a separate sysfs entry to "expire" the original timeout
> immediately.

What you're suggesting can be added.  For example, writing a blank line
to power/autosuspend_delay_ms could be defined to have this effect.  
I'm not sure how beneficial it would turn out to be in the long run.

> > Can you give any examples where "sticky off" is really useful (other
> > than just for debugging)?
> > 
> 
> A mobile device might have a set of keys that, once device is put into
> lower power mode, should not bring the device out of that mode. This I
> would call a "sticky off" case.

But here the "sticky off" refers to the entire mobile device, not to 
any particular driver.  In other words, it isn't a runtime-PM issue.

An example of runtime-PM "sticky off" would be a mouse that gets set to
low power and is forced to remain that way even when the user moves or
clicks it.  I don't see how that would be useful.

Alan Stern

