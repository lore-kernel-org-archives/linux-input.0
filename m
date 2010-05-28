From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.35-rc0
Date: Thu, 27 May 2010 19:46:46 -0700
Message-ID: <20100528024646.GA21961@core.coreip.homeip.net>
References: <20100520165243.GA20861@core.coreip.homeip.net>
 <alpine.LFD.2.00.1005271837050.11382@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:34308 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab0E1Cqz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 May 2010 22:46:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005271837050.11382@i5.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Ragwitz <rafl@debian.org>, Arjan Opmeer <arjan@opmeer.net>, Eric Piel <eric.piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Thu, May 27, 2010 at 06:53:20PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 20 May 2010, Dmitry Torokhov wrote:
> > 
> > Dmitry Torokhov (17):
> >       Input: elantech - enforce common prefix on messages
> >       Input: elantech - relax signature checks
> 
> These two commits (I _think_ - I didn't actually bisect it) seem to result 
> in a Dell Inspiron bootup message changing from:
> 
> 	input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input5
> 
> to
> 
> 	elantech: assuming hardware version 2, firmware version 4.3.1
> 	elantech: Synaptics capabilities query result 0x08, 0x18, 0x0c.
> 	input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio1/input/input5
> 
> and the end result is a total disaster. In the words of my daughter, whose 
> laptop this is:
> 
> 	Subject: Computer=awful
> 
> 	I am not able to click by tapping, I actually have to press down.. It's
> 	really frustrating and I want it fixed.
> 
> and having tested it, I have to agree. It's beyond awful. It's absolutely 
> disgusting, and the touchpad went from "quite usable" (with tapping, 
> double-tapping, scroll-wheel on the right side etc) to "totally unusable". 
> The buttons you have to press (since tapping doesn't work) are on the 
> touch-pad itself, and it's basically a total pain.
> 
> The scroll-wheel emulation still seems to work, but tapping has gone away. 
> I'm reading the docs, and they say that you can do magic things with the 
> raw registers, but if I'm looking at the register contents they seem to 
> say that tapping _is_ enabled. It just doesn't work.
> 
> So it would seem that the "non-native" PS/2 emulation of that thing is way 
> better than the native driver, and we should _not_ try to treat it as a 
> touchpad. We're better off leaving it in ImPS/2 mode.
>

*sigh*

I do hope we will sort it out because there is a demand to make it use
Synaptics driver so it is configurable. Any chance I could persuade you
to stick "options psmouse proto=imps" in your daughter's laptop for the
time being? If we can't make it work reasonably in the next 2-3 rcs
we'll revert autodetection to what it was before.

Is it Mini 10 BTW?

Thanks.

-- 
Dmitry
