From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 08:53:09 -0700
Message-ID: <20101012155308.GA30513@core.coreip.homeip.net>
References: <33A307AF30D7BF4F811B1568FE7A9B180468726AB4@EXDCVYMBSTM006.EQ1STM.local>
 <Pine.LNX.4.44L0.1010121117460.1705-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53276 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778Ab0JLPxS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 11:53:18 -0400
Received: by iwn7 with SMTP id 7so905202iwn.19
        for <linux-input@vger.kernel.org>; Tue, 12 Oct 2010 08:53:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010121117460.1705-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sundar R IYER <sundar.iyer@stericsson.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

On Tue, Oct 12, 2010 at 11:34:18AM -0400, Alan Stern wrote:
> On Tue, 12 Oct 2010, Sundar R IYER wrote:
> 
> > Hi,
> > 
> > Sorry to be jumping in late. My few comments dispersed with
> > individual replies
> > 
> > >-----Original Message-----
> > >From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > >Sent: Tuesday, October 12, 2010 3:39 AM
> > >
> > >
> > >I do not believe there is a generic answer - different devices,
> > >different options. For example I could see buttons split into 2 groups -
> > >"important" ones that bring the system from sleep or "stupor" and "not
> > >so important" that gets to be ignored. Or user woudl need to "flick"
> > >the screen. Or toss the phone into a corner cussing :)
> > >
> > 
> > Yes. At least on the U8500 (and couple of OMAPs as well), it is the 
> > always-on power button on AB8500/TWLs that is the necessary event 
> > to turn off the display/keypad. The entire display/keypad themselves
> > cannot wakeup the system. But on the older phones, we generally had
> > to have the menu + star combination to unlock the phone, which falls into
> > the main keypad.
> 
> We're not talking about waking up the system.  I'm concerned more about
> how the keypad is supposed to work in the scenario Dmitry brought up.  
> But evidently things are too variable to say much for certain.
> 
> I get the impression that in many cases the entire keypad will have to 
> remain functional, and it will be up to userspace to discard keys that 
> aren't wanted at a particular time.

Again, depends on the hardware. If it is basically a single interrupt
line - then yes, you need to wake up the whoke device (although I have
an idea at the very back of my queue about alowing consumers to
subscribe to certain events so that userspace does not get woken up for
events it does not care about).

If there are several interrupts available you can partition the device
into several components.

> 
> > >The point is that there seems to be a need for kicking devices into low
> > >power mode and I woudl like to have generic interface for that,
> > >preferrably reusing (as far as kernel drivers go) existing PM
> > >infrastructure.
> 
> "Kicking devices into low power mode" is ambiguous.  How about 
> "requesting that an idle device go into low-power mode" instead?  This 
> doesn't carry an implication that the user could force a non-idle 
> device to suspend or could force the driver to do something against its 
> will.

Yes, of course. I used "kick" to add some flavor to this conversation, the
API is of course should only provide ways to do "request".

> 
> Of course, if the device is idle then it's natural to ask why it isn't 
> already in low-power mode.  Maybe it's waiting for an autosuspend 
> timer to expire; anything else doesn't make much sense.

Right. I expect that standard screen/keyboard autosuspend shoudl be in
10s of seconds (30-60 i guess) but users might accelerate suspending by
pressing a button. Or software might do the same for userspace when
proximity sensor fires up.

> > Coming in late, I would just like to summarize some of the points; please
> > correct if I am wrong:
> > 
> > - user space intervention is required to communicate specific events
> >   to individual devices to put them into an appropriate power state.
> 
> Stop after "communicate specific events to individual devices" (or
> drivers).  I don't agree that userspace should always have the ability
> to put devices into specific power states.

I think we agree that it should read "request devices go into different
power state".

-- 
Dmitry
