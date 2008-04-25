From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [INPUT] ucb1400: add key interface
Date: Fri, 25 Apr 2008 16:22:46 -0400
Message-ID: <20080425162040.ZZRA012@mailhub.coreip.homeip.net>
References: <20080424110305.GA2971@www.tglx.de> <20080425112156.ZZRA012@mailhub.coreip.homeip.net> <20080425174535.GA10734@www.tglx.de> <20080425142949.ZZRA012@mailhub.coreip.homeip.net> <20080425184723.GA23710@www.tglx.de> <20080425145231.ZZRA012@mailhub.coreip.homeip.net> <20080425191026.GA25987@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:37197 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764200AbYDYUWx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 16:22:53 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1535175nfb.21
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2008 13:22:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080425191026.GA25987@www.tglx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Siewior <bigeasy@linutronix.de>
Cc: linux-input@vger.kernel.org

On Fri, Apr 25, 2008 at 09:10:26PM +0200, Sebastian Siewior wrote:
> * Dmitry Torokhov | 2008-04-25 14:56:24 [-0400]:
> 
> >> The code:
> >> |        /* Post events
> >> |         * BTN_TOUCH has to be first as mousedev relies on it when doing
> >> |         * absolute -> relative conversion
> >> |         */
> >> |        if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
> >> |        if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
> >> 
> >> Nothing happens if z is lets say 27. 
> >
> >Right, you want to have hysteresis to avoid jitter.
> Aha, good to know.
> 
> >> How do I do fine tunning with
> >> evdev? This looks like nothing has any influence on 30 & 25.
> >
> >Synaptics native driver ignores BTN_TOUCH and goes strictly by
> >ABS_PRESSURE. The same would be valid for evdev/tslib combo on
> >UCB1400. BTN_TOUCH is for mousedev (and similar dumb consumers)
> >benefit only.
> Oh okey. Now I have the picture. I was going to try mice interface with
> qtopia once everything is working (what could take few days). It looked
> on the first shot like I could use the bare mice interface without tslib
> once I get calibration working (right now I thing that it could be
> easily solved with proper max/min x & y values). If this is not is not
> working than I would have get tslib working what would make the
> BTN_TOUCH thing useless.

Yeah, mousedev may work to a degree but if you want precise operation
of your toucscreen interfacing through tslib is way to go.

So do you think we should still apply your patch?

-- 
Dmitry
