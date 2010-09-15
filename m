From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] input: add support for Nomadik SKE keypad
 controller
Date: Wed, 15 Sep 2010 02:00:46 -0700
Message-ID: <20100915090046.GC28348@core.coreip.homeip.net>
References: <1284535498-9954-1-git-send-email-sundar.iyer@stericsson.com>
 <20100915075513.GB28348@core.coreip.homeip.net>
 <33A307AF30D7BF4F811B1568FE7A9B18043784FA97@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43196 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab0IOJAw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 05:00:52 -0400
Received: by pzk34 with SMTP id 34so2650269pzk.19
        for <linux-input@vger.kernel.org>; Wed, 15 Sep 2010 02:00:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B18043784FA97@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar R IYER <sundar.iyer@stericsson.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Kwangwoo LEE <kwangwoo.lee@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

On Wed, Sep 15, 2010 at 10:49:03AM +0200, Sundar R IYER wrote:
> Hi Dmitry,
> 
> >-----Original Message-----
> >From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> 
> >> +
> >> +	/* disable auto scan interrupt; mask the interrupt generated */
> >> +	ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
> >> +	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
> >> +
> >> +	mod_timer(&keypad->timer, jiffies + 2);
> >> +
> >
> >I expected you would do "return IRQ_HANDLED;" here so that hardware
> >polling is done exclusively in timer handler.
> >
> What I thought is: enable the timer by default; so that in case we find out the
> ASRs aren't stable, the reporting automatically will get deferred to the timer. In
> a normal case, when the ASRs are stable, the reporting gets done by the IRQ handler;
> in case they aren't, the reporting will get done by the timers. Is this not correct?

My concern was is that first time around ASRs are not stable; you defer
to timer. Then you get 2nd interrupt and ASRs are stable now so both IRQ
and timer trying to work the hardware.

If you have IRQ kick the timer and bail only timer (and only 1 instance)
accesses the hardware.

-- 
Dmitry
