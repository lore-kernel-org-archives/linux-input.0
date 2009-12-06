From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
	specify exact irq flags
Date: Sun, 6 Dec 2009 09:46:52 +0100
Message-ID: <20091206084652.GB2766@ucw.cz>
References: <87tywlcbyr.fsf@tac.ki.iif.hu> <20091124063711.GL17675@esdhcp04058.research.nokia.com> <87my2cp4h6.fsf@tac.ki.iif.hu> <20091124170249.GQ17675@esdhcp04058.research.nokia.com> <87k4xfojhb.fsf@tac.ki.iif.hu> <20091126063506.GM23244@core.coreip.homeip.net> <20091127105408.GV17675@esdhcp04058.research.nokia.com> <87tywe4zf3.fsf@tac.ki.iif.hu> <20091128132742.GC27249@gw.healthdatacare.com> <87skbx34ba.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45559 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757528AbZLFU0K (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2009 15:26:10 -0500
Content-Disposition: inline
In-Reply-To: <87skbx34ba.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi!

> > Yeah, that would be nice. But it won't work for us :(
> >
> > This is because the actual input device might be open for several
> > applications. Then we have single process which controls state of
> > the device. Now if, for example the device is locked by user, this
> > process just disables those buttons which are not allowed to wake
> > up the device and blanks the screen.
> >
> > So the input device is still open but we just prevent GPIO lines
> > from generating any interrupts while the device is locked. There
> > are other use-cases also where different buttons are
> > disabled/enabled.
> 
> Hi,
> 
> I thought we'd better ask our friends over at linux-pm, if they've got
> some interface for this task.  To summarize: an embedded application
> wants to go into a "locked" state, where some input devices (gpio keys
> in this case) are "muted", ie. they don't even generate interrupts to
> minimize power consumption.  This could be solved by adding a new
> interface to gpio-keys, but the problem seems more general, so I wonder

Is it so bright idea? How much power does it save?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
