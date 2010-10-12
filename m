From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 19:30:08 +0100
Message-ID: <20101012183008.GJ30933@rakim.wolfsonmicro.main>
References: <20101012174942.GB10861@sirena.org.uk>
 <Pine.LNX.4.44L0.1010121425330.1705-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39416 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752922Ab0JLSaL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 14:30:11 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010121425330.1705-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sundar R IYER <sundar.iyer@stericsson.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

On Tue, Oct 12, 2010 at 02:27:21PM -0400, Alan Stern wrote:
> On Tue, 12 Oct 2010, Mark Brown wrote:

> > This isn't *really* about saving power in the individual device; it's
> > more about stopping the device generating events that disrupt the rest
> > of the system.  Suspending the device can be one way of doing that and
> > is useful if it can be done but is not really the immediate goal here.

> Runtime PM is _not_ a reliable way of preventing a device from 
> generating events.  It is meant for saving energy, nothing else.

Right, yes.

> If that's what this is about, then the answer is simple: Don't use 
> runtime PM to try to suppress events.

I tend to agree that runtime PM usage ought to fall out of the disabling
of the input device rather than the other way around.
