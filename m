From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [INPUT] ucb1400: add key interface
Date: Fri, 25 Apr 2008 14:56:24 -0400
Message-ID: <20080425145231.ZZRA012@mailhub.coreip.homeip.net>
References: <20080424110305.GA2971@www.tglx.de> <20080425112156.ZZRA012@mailhub.coreip.homeip.net> <20080425174535.GA10734@www.tglx.de> <20080425142949.ZZRA012@mailhub.coreip.homeip.net> <20080425184723.GA23710@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:17502 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761321AbYDYS4b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 14:56:31 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3230030mue.1
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2008 11:56:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080425184723.GA23710@www.tglx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Siewior <bigeasy@linutronix.de>
Cc: linux-input@vger.kernel.org

On Fri, Apr 25, 2008 at 08:47:23PM +0200, Sebastian Siewior wrote:
> * Dmitry Torokhov | 2008-04-25 14:32:53 [-0400]:
> 
> >> >Plus, you might want
> >> >to select some kind of pressure thresholds before reporting touch press
> >> >and release.
> >> Sure but depending on what? Are there any drivers doing this allready?
> >> I didn't find any on my grep.
> >> Since these values are HW specifc they should be some userspace control
> >> (like for max/min x/y).
> >
> >Synaptics for example does it. You just need to guesstimate what
> >values are most likely to work by default (since you are trying to
> >provide compatibility with a legacy interface, just to get user going)
> >and then leave fine-tuning to evdev/tslib.
> 
> The code:
> |        /* Post events
> |         * BTN_TOUCH has to be first as mousedev relies on it when doing
> |         * absolute -> relative conversion
> |         */
> |        if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
> |        if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
> 
> Nothing happens if z is lets say 27. 

Right, you want to have hysteresis to avoid jitter.

> How do I do fine tunning with
> evdev? This looks like nothing has any influence on 30 & 25.

Synaptics native driver ignores BTN_TOUCH and goes strictly by
ABS_PRESSURE. The same would be valid for evdev/tslib combo on
UCB1400. BTN_TOUCH is for mousedev (and similar dumb consumers)
benefit only.

> My minimum pressure seems to be around 500 and I didn't get it past 700.
> I get nothing if I touch lightly the touchscreen so I thing having
> nothing is allready sane.

Ah, OK then.

-- 
Dmitry
