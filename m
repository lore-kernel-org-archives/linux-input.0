From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Route kbd leds through the generic leds layer (3rd
 version)
Date: Sat, 6 Mar 2010 07:54:57 +0100
Message-ID: <20100306065457.GE28759@elf.ucw.cz>
References: <20100224012010.GA4062@const>
 <20100225013840.GA5519@const.homenet.telecomitalia.it>
 <20100225102056.GG10823@core.coreip.homeip.net>
 <20100225214403.GB9378@const.homenet.telecomitalia.it>
 <20100226035448.GA16797@core.coreip.homeip.net>
 <20100226103505.GB3992@const.homenet.telecomitalia.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:53068 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751272Ab0CFGzF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 6 Mar 2010 01:55:05 -0500
Content-Disposition: inline
In-Reply-To: <20100226103505.GB3992@const.homenet.telecomitalia.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-found

Hi!

> > > Being able to assign only some of the devices to the linux console
> > > would indeed probably be good, but to me it's just a refinement. Users
> > > a priori assume all keyboards get their leds updated, so my patch
> > > makes sense.  And it won't prevent a further patch that, in addition
> > > to input::<led> leds, adds per-device leds, which the user could use
> > > instead of input::<led>.
> > 
> > I think that if we want to go LED route we shoudl start with adding led
> > devices to individual keyboard drivers first
> 
> Mmm, thinking again, I think my patch could be rather easily converted
> into creating led instances for each device, with proper trigger
> defaults.  Something like input-devicename::numlock? (devicename::numlock
> might get conflicts with non-input devices I guess?)

Yep, that would be cool.

> That being said, usermode tools which want to set up the modifiers and
> connect the input LEDs to them need an easy and proper way to do so.
> Having central input::numlock and such still seems a good thing.

This is something where I'm not too sure. Opening few files in
sequence is not that hard to the userland so "group of leds"
abstraction does not make too much sense...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
