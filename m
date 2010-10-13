From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 10:10:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010131007310.2311-100000@iolanthe.rowland.org>
References: <20101013095737.GI6424@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49648 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751936Ab0JMOKA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 10:10:00 -0400
In-Reply-To: <20101013095737.GI6424@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sundar R IYER <sundar.iyer@stericsson.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

On Wed, 13 Oct 2010, Mark Brown wrote:

> On Wed, Oct 13, 2010 at 08:16:20AM +0200, Sundar R IYER wrote:
> 
> > >> This isn't *really* about saving power in the individual device; it's
> > >> more about stopping the device generating events that disrupt the rest
> > >> of the system.  Suspending the device can be one way of doing that and
> > >> is useful if it can be done but is not really the immediate goal here.
> 
> > >Runtime PM is _not_ a reliable way of preventing a device from
> > >generating events.  It is meant for saving energy, nothing else.
> 
> > >If that's what this is about, then the answer is simple: Don't use
> > >runtime PM to try to suppress events.
> 
> > I think it is unfair to discriminate here about saving power and turning off
> > events. I believe putting the device into power save leads to, if device permits
> > preventing generating events is valid to hook up run time PM.
> 
> This is the opposite way around to expectations - the expectation is
> that runtime power management will flow from the device becoming idle
> enough to turn off rather than the other way around.

Absolutely.  Another point worth mentioning is that a device in
runtime-suspend can be resumed at any time, for a variety of reasons
unconnected with anything the user does.  While it is back at full
power, there is nothing to stop it from generating events.

Alan Stern

