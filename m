From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: pxa27x_keypad: fix NULL pointer dereference
Date: Mon, 16 Sep 2013 10:06:17 -0700
Message-ID: <20130916170617.GA20734@core.coreip.homeip.net>
References: <1379349842-13089-1-git-send-email-mikedunn@newsguy.com>
 <201309161849.53556.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54248 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab3IPRGW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Sep 2013 13:06:22 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so4351773pdi.5
        for <linux-input@vger.kernel.org>; Mon, 16 Sep 2013 10:06:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201309161849.53556.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Mike Dunn <mikedunn@newsguy.com>, linux-input@vger.kernel.org, Chao Xie <chao.xie@marvell.com>, Robert Jarzmik <robert.jarzmik@free.fr>

On Mon, Sep 16, 2013 at 06:49:53PM +0200, Marek Vasut wrote:
> Dear Mike Dunn,
> 
> > A NULL pointer dereference exception occurs in the driver probe function
> > when device tree is used.  The pdata pointer will be NULL in this case,
> > but the code dereferences it in all cases.  When device tree is used, a
> > platform data structure is allocated and initialized, and in all cases
> > this pointer is copied to the driver's private data, so the variable being
> > tested should be accessed through the driver's private data structure.
> > 
> > Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> > ---
> >  drivers/input/keyboard/pxa27x_keypad.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/pxa27x_keypad.c
> > b/drivers/input/keyboard/pxa27x_keypad.c index 134c3b4..3b2a614 100644
> > --- a/drivers/input/keyboard/pxa27x_keypad.c
> > +++ b/drivers/input/keyboard/pxa27x_keypad.c
> > @@ -795,8 +795,10 @@ static int pxa27x_keypad_probe(struct platform_device
> > *pdev) goto failed_put_clk;
> >  	}
> > 
> > -	if ((pdata->enable_rotary0 && keypad->rotary_rel_code[0] != -1) ||
> > -	    (pdata->enable_rotary1 && keypad->rotary_rel_code[1] != -1)) {
> > +	if ((keypad->pdata->enable_rotary0 &&
> > +	     keypad->rotary_rel_code[0] != -1) ||
> > +	    (keypad->pdata->enable_rotary1 &&
> > +	     keypad->rotary_rel_code[1] != -1)) {
> >  		input_dev->evbit[0] |= BIT_MASK(EV_REL);
> >  	}
> 
> Nice find. Acked-by: Marek Vasut <marex@denx.de>

Excellent booby trap. I would prefer if we explicitly did

	pdata = keypad->pdata;

after calling the parse DT fucntion with a nice comment, because we
somebody might want to rearrange the code and accidentially revert the
checks to the original state.

Thanks.

-- 
Dmitry
