From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Input: LEDs - skip unnamed LEDs
Date: Fri, 24 Jul 2015 10:48:08 +0200
Message-ID: <20150724084808.GA8349@amd>
References: <20150722220202.GG14875@dtor-ws>
 <55B1F5AC.3080702@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54164 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbbGXIsN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2015 04:48:13 -0400
Content-Disposition: inline
In-Reply-To: <55B1F5AC.3080702@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On Fri 2015-07-24 10:22:04, Vlastimil Babka wrote:
> On 07/23/2015 12:02 AM, Dmitry Torokhov wrote:
> >Devices may declare more LEDs than what is known to input-leds
> >(HID does this for some devices). Instead of showing ugly warnings
> >on connect and, even worse, oopsing on disconnect, let's simply
> >ignore LEDs that are not known to us.
> >
> >Reported-by: Vlastimil Babka <vbabka@suse.cz>
> 
> No more warnings and oopses, so:
> 
> Reported-and-tested-by: Vlastimil Babka <vbabka@suse.cz>
> 
> FTR, it now looks like this:
> gusiac:/sys/bus/hid/devices/0003:046D:C50E.0004/input/input15 # ls -1 | grep
> input15
> input15::charging
> input15::mail
> input15::misc
> 
> All three have max_brightness of 1, but echo 1 > brightness does nothing.
> Clearly the leds are indeed autonomous only and the mouse shouldn't even
> report them.

Should the mouse get blacklist entry with fixed HID descriptor?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
