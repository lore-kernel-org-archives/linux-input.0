From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 11:34:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010121117460.1705-100000@iolanthe.rowland.org>
References: <33A307AF30D7BF4F811B1568FE7A9B180468726AB4@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52513 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757538Ab0JLPeT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 11:34:19 -0400
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B180468726AB4@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar R IYER <sundar.iyer@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

On Tue, 12 Oct 2010, Sundar R IYER wrote:

> Hi,
> 
> Sorry to be jumping in late. My few comments dispersed with
> individual replies
> 
> >-----Original Message-----
> >From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> >Sent: Tuesday, October 12, 2010 3:39 AM
> >
> >
> >I do not believe there is a generic answer - different devices,
> >different options. For example I could see buttons split into 2 groups -
> >"important" ones that bring the system from sleep or "stupor" and "not
> >so important" that gets to be ignored. Or user woudl need to "flick"
> >the screen. Or toss the phone into a corner cussing :)
> >
> 
> Yes. At least on the U8500 (and couple of OMAPs as well), it is the 
> always-on power button on AB8500/TWLs that is the necessary event 
> to turn off the display/keypad. The entire display/keypad themselves
> cannot wakeup the system. But on the older phones, we generally had
> to have the menu + star combination to unlock the phone, which falls into
> the main keypad.

We're not talking about waking up the system.  I'm concerned more about
how the keypad is supposed to work in the scenario Dmitry brought up.  
But evidently things are too variable to say much for certain.

I get the impression that in many cases the entire keypad will have to 
remain functional, and it will be up to userspace to discard keys that 
aren't wanted at a particular time.

> >The point is that there seems to be a need for kicking devices into low
> >power mode and I woudl like to have generic interface for that,
> >preferrably reusing (as far as kernel drivers go) existing PM
> >infrastructure.

"Kicking devices into low power mode" is ambiguous.  How about 
"requesting that an idle device go into low-power mode" instead?  This 
doesn't carry an implication that the user could force a non-idle 
device to suspend or could force the driver to do something against its 
will.

Of course, if the device is idle then it's natural to ask why it isn't 
already in low-power mode.  Maybe it's waiting for an autosuspend 
timer to expire; anything else doesn't make much sense.

> Coming in late, I would just like to summarize some of the points; please
> correct if I am wrong:
> 
> - user space intervention is required to communicate specific events
>   to individual devices to put them into an appropriate power state.

Stop after "communicate specific events to individual devices" (or
drivers).  I don't agree that userspace should always have the ability
to put devices into specific power states.

> - auto suspend isn't the correct choice for input devices as they may
>   conflict with system suspend (touch screen off/idle needs to be sync'ed
>   with system suspend as with a lock switch)

I don't understand this at all.  How does autosuspend conflict with 
system suspend?  Your example isn't clear.

> - PM ATM doesn't provide a sysfs attribute for enabling/disabling or forcing
>   an individual device into low power mode unlike for platform.

PM does indeed provide a sysfs attribute for enabling/disabling
individual devices for low-power mode.  It doesn't provide an attribute
for _forcing_ a device into low-power mode, and I don't think it
should.  The driver should always be in charge.

> However a new
>   "suspend_ondemand" flag can enable such devices to be put into appropriate
>   states via a /sys/devices/.../power/ by the user space.

This has not yet been settled.  Why do we need an "ondemand" flag when 
we already have power/control?

> If my above summarization is correct, I personally feel the on demand flag is a clean
> option for the current requirement.

Including some sort of interface for cutting short an autosuspend delay
makes sense (and doing it doesn't require a new attribute), but I'm not 
convinced that anything else is needed.

Alan Stern

