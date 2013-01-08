From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based probe
Date: Tue, 8 Jan 2013 10:48:37 +0100
Message-ID: <201301081048.38149.marex@denx.de>
References: <1357568989-16237-1-git-send-email-marex@denx.de> <20130108094134.GA21994@gmail.com> <201301081044.14876.marex@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58775 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab3AHJsj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 04:48:39 -0500
In-Reply-To: <201301081044.14876.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: vipul kumar samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>

Dear Lee Jones,

> > > >Both can be killed. gpios as interrupt lines can be requested as:
> > > >  interrupt-parent =<&gpio-controller>;
> > > >  interrupts =<25 0x1>;
> > > >
> > > >and probably the stmpe driver doesn't have to bother at all if
> > > >interrupt was over gpio or not.
> > > 
> > > Yes, both can be killed and similarly we did for spear1340 machine
> > > but some how we missed it on spear320-hmi.
> > 
> > Bingo!
> 
> All right, all right ... got it ;-)
> 
> I'll rework it and repost then.

Maybe I was too quick about understanding the issue at hand. So allow me a 
stupid question -- who's gonna configure the GPIO as input for it to work as IRQ 
GPIO?

Best regards,
Marek Vasut
