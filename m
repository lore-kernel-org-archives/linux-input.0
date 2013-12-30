From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gamepad - use independent axes for analog D-Pad
 buttons
Date: Mon, 30 Dec 2013 10:51:58 -0800
Message-ID: <20131230185158.GC3278@core.coreip.homeip.net>
References: <1387815463-29345-1-git-send-email-ospite@studenti.unina.it>
 <20131230005209.GC11528@core.coreip.homeip.net>
 <20131230122020.ebaaefb09375e371c2178b38@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:40704 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab3L3SwB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 13:52:01 -0500
Received: by mail-pd0-f174.google.com with SMTP id x10so11462429pdj.5
        for <linux-input@vger.kernel.org>; Mon, 30 Dec 2013 10:52:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131230122020.ebaaefb09375e371c2178b38@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Dec 30, 2013 at 12:20:20PM +0100, Antonio Ospite wrote:
> On Sun, 29 Dec 2013 16:52:09 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Antonio,
> > 
> > On Mon, Dec 23, 2013 at 05:17:43PM +0100, Antonio Ospite wrote:
> > > Model this part of the API after the Sony PlayStation 3 Controller which
> > > exposes independent analog values for each one of the D-Pad buttons.
> > > 
> > > The PS3 programming API psl1ght also maps the analog D-Pad buttons
> > > individually.
> > 
> > Hmm, even though the hardware is capable of producing independent analog
> > values does are they really useful? Looking at my PS3 controller I do
> > not think users will be pressing up/down and left/right dpad buttons at
> > the same time.
> >
> 
> I must agree it's unlikely, while still possible.
> 
> > I'd rather keep using ABS_HAT0X/Y unless there is really good reason for
> > introducing new events.
> > 
> 
> Having analog D-Pad values reported independently was proposed for these
> reasons:
> 
>  - it matches _some_ existing hardware closely (that was the main
>    reason TBH, to simplify the drivers);
> 
>  - it happens to follow what it's being done for D-Pad digital buttons,
>    they are also reported independently.
> 
> However if some other hardware reported D-Pad axis combined already
> then I agree that using something like ABS_HAT0X/Y is safer, I see
> decomposing HORIZ/VERT into the separate LEFT/RIGHT and UP/DOWN to be
> less intuitive (not harder tho).
> 
> Another doubt: David, in the other email you mentioned we could use
> ABS_DPAD_HORIZ/VERT, any particular reason to introduce them in place
> of ABS_HAT0X/Y?

I think xpad driver mapping (while in no way perfect) uses HAT0 for that.

Thanks.

-- 
Dmitry
