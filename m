From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 13:45:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010121334140.1705-100000@iolanthe.rowland.org>
References: <20101012155308.GA30513@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60717 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932349Ab0JLRps (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 13:45:48 -0400
In-Reply-To: <20101012155308.GA30513@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sundar R IYER <sundar.iyer@stericsson.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

On Tue, 12 Oct 2010, Dmitry Torokhov wrote:

> > Of course, if the device is idle then it's natural to ask why it isn't 
> > already in low-power mode.  Maybe it's waiting for an autosuspend 
> > timer to expire; anything else doesn't make much sense.
> 
> Right. I expect that standard screen/keyboard autosuspend shoudl be in
> 10s of seconds (30-60 i guess) but users might accelerate suspending by
> pressing a button. Or software might do the same for userspace when
> proximity sensor fires up.

On Tue, 12 Oct 2010, Sundar R IYER wrote:

> Okay. I messed up the kicking part; but why should the device solely wait 
> for an auto suspend timer to expire. Don't you agree that the keypad module 
> be turned off when a keypad slider is pushed back into a phone?

Okay, we can agree on this.  Adding an interface to accelerate (or cut
short) an autosuspend timeout makes sense, and it should handle all the 
cases the two of you have mentioned.

Rafael might want more, however, although I'm not sure exactly what he
would like to have.

> >> Coming in late, I would just like to summarize some of the points; please
> >> correct if I am wrong:
> >>
> >> - user space intervention is required to communicate specific events
> >>   to individual devices to put them into an appropriate power state.
> >
> >Stop after "communicate specific events to individual devices" (or
> >drivers).  I don't agree that userspace should always have the ability
> >to put devices into specific power states.
> >
> 
> Yes not always; but examples of keypads, touch panels could.

I still disagree.  The user should be able to tell the driver that he's
not going to be using the keypad, touch panel, or whatever in the near
future... but it's up the driver to decide whether or not to go to low
power.

> >> - auto suspend isn't the correct choice for input devices as they may
> >>   conflict with system suspend (touch screen off/idle needs to be sync'ed
> >>   with system suspend as with a lock switch)
> >
> >I don't understand this at all.  How does autosuspend conflict with
> >system suspend?  Your example isn't clear.
> 
> Hmm. I was looking at the case with touch screen. I set my display backlight
> to go off after say 30 seconds; my touch screen idle begins only when the display
> goes off; meaning I still expect the touch screen to respond to any events before
> the timeout. This in turn requires that the timeouts for the backlight and the touch
> be synchronized, failing which the user might interpret the touch to be non-functional
> in case the touch timeout and backlight timeout vary. Am I wrong to think that
> such inter-dependency between devices should be avoided?

Although such dependencies do sometimes make things awkward,
occasionally you need to have them.  But I still don't see how this is
connected with system suspend, or how autosuspend conflicts with system
suspend.

Alan Stern

