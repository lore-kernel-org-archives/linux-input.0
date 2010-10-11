From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 15:08:46 -0700
Message-ID: <20101011220846.GA28611@core.coreip.homeip.net>
References: <20101011170733.GA27304@core.coreip.homeip.net>
 <Pine.LNX.4.44L0.1010111739580.16765-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59030 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463Ab0JKWJB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 18:09:01 -0400
Received: by ywi6 with SMTP id 6so828505ywi.19
        for <linux-input@vger.kernel.org>; Mon, 11 Oct 2010 15:09:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010111739580.16765-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>

On Mon, Oct 11, 2010 at 05:54:27PM -0400, Alan Stern wrote:
> On Mon, 11 Oct 2010, Dmitry Torokhov wrote:
> 
> > > > > Can you give any examples where "sticky off" is really useful (other
> > > > > than just for debugging)?
> > > > > 
> > > > 
> > > > A mobile device might have a set of keys that, once device is put into
> > > > lower power mode, should not bring the device out of that mode. This I
> > > > would call a "sticky off" case.
> > > 
> > > But here the "sticky off" refers to the entire mobile device, not to 
> > > any particular driver.
> > 
> > Where did I say that?
> 
> Just above.

Hm, indeed I did ;)

>  The difficulty here is caused by the fact that you used
> the word "device" instead of "system".  You wrote "... should not bring
> the device out of that mode", with the word "device" referring back to
> "a mobile device" -- which is the entire system.  That is, we have the
> mobile system and we have the keypad device; calling the mobile system
> a "device" leads to confusion.

Right. I guess the scenario I wanted to describe is when we press a key
to put mobile sysem in a lower power mode (shut of screen, block
certain keys, and so on) but that not necessarily means that entire
system is sleeping.

> 
> >  The device is still running, playing your favorite
> > song collection for example. Still you probably do not want your car
> > keys compose and e-mail for you while you are jogging, thus the main
> > keypad would be forced off.
> 
> Then I can't answer this question without knowing more about how the 
> keypad works.
> 
> 	Does suspending the keypad truly put it in low-power mode?

Could be, it depends.

> 
> 	What happens if a key is pressed while the keypad is suspended?

It may or it may not wake up the device and/or system.

> 
> 	Do you want to prevent all the keys from working or just some 
> 	of them?

It depends.

> 
> 	How would the user un-suspend the keypad if the system no 
> 	longer responds to keystrokes?

I do not believe there is a generic answer - different devices,
different options. For example I could see buttons split into 2 groups -
"important" ones that bring the system from sleep or "stupor" and "not
so important" that gets to be ignored. Or user woudl need to "flick"
the screen. Or toss the phone into a corner cussing :)

The point is that there seems to be a need for kicking devices into low
power mode and I woudl like to have generic interface for that,
preferrably reusing (as far as kernel drivers go) existing PM
infrastructure.

-- 
Dmitry
