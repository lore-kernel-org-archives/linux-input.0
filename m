From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: byd - fix issue where generic PS/2 mice are
 detected as BYD touchpad
Date: Mon, 11 Jul 2016 19:57:57 -0700
Message-ID: <20160712025757.GA12185@dtor-ws>
References: <20160627213412.GC22620@dtor-ws>
 <1467172878-25483-1-git-send-email-pospeselr@gmail.com>
 <20160711202620.GA24346@smaug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35058 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933173AbcGLC6A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 22:58:00 -0400
Received: by mail-pa0-f53.google.com with SMTP id dx3so1438708pab.2
        for <linux-input@vger.kernel.org>; Mon, 11 Jul 2016 19:58:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160711202620.GA24346@smaug>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: Richard Pospesel <pospeselr@gmail.com>, linux-input@vger.kernel.org, phonesyfreakies@gmail.com

On Mon, Jul 11, 2016 at 09:26:20PM +0100, Chris Diamand wrote:
> Hi Richard,
> 
> Thanks for working on this!
> 
> Patch looks mostly good, and seems to have worked judging by the comments on
> the bug report. Not many comments from me as it's just moving stuff around.
> 
> I think it might be better to keep detect() and init() separate - it seems to
> me that a detect() function shouldn't really have any side effects (even if
> we're certain it's a BYD touchpad), so doing kzalloc and setting up the timer
> in detect() feels a bit wrong.

Right.

> 
> But as mentioned earlier, we shouldn't do the touchpad initialisation twice.
> So maybe do the magic sequence stuff in detect(), and the actual driver init
> in init().

Since we can't transparently detect the device without changing its
state everything should go into byd_init() and we should remove
byd_detect() (unless we decide to do some DMI matching).

> 
> > Input: byd - fix issue where generic PS/2 mice are...
> 
> You may need a shorter commit title.
> 
> > The secret handshake used was not sufficient to determine whether the connected
> > device was actually a BYD touchpad.  Added some restrictions on what the first
> > byte returned may be (based off of experiments with BYD touchapd).  Moved
> > subsequent initialization logic from byd_init to tail of byd_detect, and
> > removed byd_init function.
> > 
> > Fixes bug 1201781.  Tested on laptop with BYD touchpad hardware.
> > 
> > Applied against commit fcd6eb50eadd83f857eac55f99316f1789707cdb
> 
> Probably don't need this in the commit message.
> 
> > 
> > Signed-off-by: Richard Pospesel <pospeselr@gmail.com>
> > 
> > ---
> > diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> > index ec73f75..92f5556 100644
> > --- a/drivers/input/mouse/byd.c
> > +++ b/drivers/input/mouse/byd.c
> > @@ -2,6 +2,10 @@
> >   * BYD TouchPad PS/2 mouse driver
> >   *
> >   * Copyright (C) 2015 Chris Diamand <chris@diamand.org>
> > + * Copyright (C) 2015 Richard Pospesel
> > + * Copyright (C) 2015 Tai Chi Minh Ralph Eastwood
> > + * Copyright (C) 2015 Martin Wimpress
> > + * Copyright (C) 2015 Jay Kuri
> 
> I already updated these in 82aaa086019ce0e6fcd3a44c0a2e4329afe988b6, so no
> need to include it here. (I think there's a disparity between input-next and
> mainline).

I have 2 branches (for-linus and next), and they may have contain
different changes (as I re-sync with mainline as needed), not all the
time.

> 
> >   *
> >   * This program is free software; you can redistribute it and/or modify it
> >   * under the terms of the GNU General Public License version 2 as published by
> > @@ -355,7 +359,7 @@ static int byd_reset_touchpad(struct psmouse *psmouse)
> >  		{ PSMOUSE_CMD_ENABLE, 0 },
> >  		/*
> >  		 * BYD-specific initialization, which enables absolute mode and
> > -		 * (if desired), the touchpad's built-in gesture detection.
> > +		 * disables the builtin hardware gesture recogniton.
> >  		 */
> >  		{ 0x10E2, 0x00 },
> >  		{ 0x10E0, 0x02 },
> > @@ -435,6 +439,10 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
> >  	struct ps2dev *ps2dev = &psmouse->ps2dev;
> >  	u8 param[4] = {0x03, 0x00, 0x00, 0x00};
> > 
> > +	if (psmouse_reset(psmouse))
> > +		return -EIO;

I would rather we reset the device after the first magic handshake to
speed up case when it is not byd device. Hmm... You know, reset is quite
slow operation and given how unreliable the first handshake is I really
lean towards asking to add DMI matching into the driver. Because we just
penalized everyone else with "standard" mice here.

> > +
> > +	/* 'Secret' handshake */
> >  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> >  		return -1;
> >  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> > @@ -446,62 +454,68 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
> >  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> >  		return -1;
> > 
> > -	if (param[1] != 0x03 || param[2] != 0x64)
> > +	/*
> > +	 * BYD touchpad returns 0x03 for resolution ( 8 count / mm ) and
> > +	 * 0x64 ( 100 samples / sec ) for sampling rate
> 
> Spaces inside brackets?
> 
> > +	 * The first byte's value is dependent on the mouse button states:
> > +	 *  0 : no button pressed
> > +	 *  1 : right button pressed
> > +	 *  4 : left button pressed
> > +	 *  5 : right and left button pressed
> > +	 */
> > +	if ((param[0] & 0x05) != param[0] ||
> 
> Neat. Took me a while though, would something like this be clearer?
> 
>     param[0] & ~(0x00 | 0x01 | 0x04 | 0x05)

Hmm... Either "param[0] & ~0x05" or "param[0] & ~(BIT(0) | BIT(2))" or
leave as Richard had it.

Thanks.

-- 
Dmitry
