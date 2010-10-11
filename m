From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 10:07:33 -0700
Message-ID: <20101011170733.GA27304@core.coreip.homeip.net>
References: <20101011161546.GA5149@core.coreip.homeip.net>
 <Pine.LNX.4.44L0.1010111240390.2339-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42660 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab0JKRHl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 13:07:41 -0400
Received: by pwj4 with SMTP id 4so930587pwj.19
        for <linux-input@vger.kernel.org>; Mon, 11 Oct 2010 10:07:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010111240390.2339-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>

On Mon, Oct 11, 2010 at 12:53:11PM -0400, Alan Stern wrote:
> On Mon, 11 Oct 2010, Dmitry Torokhov wrote:
> 
> > > > This means messing up with the currently set timeout. If userspace could
> > > > have an option of "accelerating" expiring of the current timeout that
> > > > would be better.
> > > 
> > > Accelerating the expiration of the timeout _is_ a form of messing with
> > > the currently-set timeout.  It can't be "better".
> > 
> > I was thinking about the case where timeout is user-supplied setting.
> > Instead of having application store the original value, write 0, and
> > later on restore it, I thought it would be better (as in simpler) to
> > have a separate sysfs entry to "expire" the original timeout
> > immediately.
> 
> What you're suggesting can be added.  For example, writing a blank line
> to power/autosuspend_delay_ms could be defined to have this effect.  
> I'm not sure how beneficial it would turn out to be in the long run.
> 
> > > Can you give any examples where "sticky off" is really useful (other
> > > than just for debugging)?
> > > 
> > 
> > A mobile device might have a set of keys that, once device is put into
> > lower power mode, should not bring the device out of that mode. This I
> > would call a "sticky off" case.
> 
> But here the "sticky off" refers to the entire mobile device, not to 
> any particular driver.

Where did I say that? The device is still running, playing your favorite
song collection for example. Still you probably do not want your car
keys compose and e-mail for you while you are jogging, thus the main
keypad would be forced off.

-- 
Dmitry
