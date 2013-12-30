From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] Input: gamepad - use independent axes for analog D-Pad
 buttons
Date: Mon, 30 Dec 2013 12:20:20 +0100
Message-ID: <20131230122020.ebaaefb09375e371c2178b38@studenti.unina.it>
References: <1387815463-29345-1-git-send-email-ospite@studenti.unina.it>
	<20131230005209.GC11528@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:53936 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755484Ab3L3LUZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 06:20:25 -0500
In-Reply-To: <20131230005209.GC11528@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Sun, 29 Dec 2013 16:52:09 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Antonio,
> 
> On Mon, Dec 23, 2013 at 05:17:43PM +0100, Antonio Ospite wrote:
> > Model this part of the API after the Sony PlayStation 3 Controller which
> > exposes independent analog values for each one of the D-Pad buttons.
> > 
> > The PS3 programming API psl1ght also maps the analog D-Pad buttons
> > individually.
> 
> Hmm, even though the hardware is capable of producing independent analog
> values does are they really useful? Looking at my PS3 controller I do
> not think users will be pressing up/down and left/right dpad buttons at
> the same time.
>

I must agree it's unlikely, while still possible.

> I'd rather keep using ABS_HAT0X/Y unless there is really good reason for
> introducing new events.
> 

Having analog D-Pad values reported independently was proposed for these
reasons:

 - it matches _some_ existing hardware closely (that was the main
   reason TBH, to simplify the drivers);

 - it happens to follow what it's being done for D-Pad digital buttons,
   they are also reported independently.

However if some other hardware reported D-Pad axis combined already
then I agree that using something like ABS_HAT0X/Y is safer, I see
decomposing HORIZ/VERT into the separate LEFT/RIGHT and UP/DOWN to be
less intuitive (not harder tho).

Another doubt: David, in the other email you mentioned we could use
ABS_DPAD_HORIZ/VERT, any particular reason to introduce them in place
of ABS_HAT0X/Y?

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
