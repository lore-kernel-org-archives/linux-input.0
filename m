From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 17:54:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010111739580.16765-100000@netrider.rowland.org>
References: <20101011170733.GA27304@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:42106 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756134Ab0JKVy1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 17:54:27 -0400
In-Reply-To: <20101011170733.GA27304@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>

On Mon, 11 Oct 2010, Dmitry Torokhov wrote:

> > > > Can you give any examples where "sticky off" is really useful (other
> > > > than just for debugging)?
> > > > 
> > > 
> > > A mobile device might have a set of keys that, once device is put into
> > > lower power mode, should not bring the device out of that mode. This I
> > > would call a "sticky off" case.
> > 
> > But here the "sticky off" refers to the entire mobile device, not to 
> > any particular driver.
> 
> Where did I say that?

Just above.  The difficulty here is caused by the fact that you used
the word "device" instead of "system".  You wrote "... should not bring
the device out of that mode", with the word "device" referring back to
"a mobile device" -- which is the entire system.  That is, we have the
mobile system and we have the keypad device; calling the mobile system
a "device" leads to confusion.

>  The device is still running, playing your favorite
> song collection for example. Still you probably do not want your car
> keys compose and e-mail for you while you are jogging, thus the main
> keypad would be forced off.

Then I can't answer this question without knowing more about how the 
keypad works.

	Does suspending the keypad truly put it in low-power mode?

	What happens if a key is pressed while the keypad is suspended?

	Do you want to prevent all the keys from working or just some 
	of them?

	How would the user un-suspend the keypad if the system no 
	longer responds to keystrokes?

Alan Stern

