From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: vt8500: Add power button keypad driver
Date: Sun, 30 Dec 2012 15:57:59 -0800
Message-ID: <20121230235759.GA14116@core.coreip.homeip.net>
References: <1356904862-16417-1-git-send-email-linux@prisktech.co.nz>
 <20121230232527.GA13899@core.coreip.homeip.net>
 <1356911071.26227.10.camel@gitbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:53552 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab2L3X6F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Dec 2012 18:58:05 -0500
Content-Disposition: inline
In-Reply-To: <1356911071.26227.10.camel@gitbox>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vt8500-wm8505-linux-kernel@googlegroups.com, linux-input@vger.kernel.org

On Mon, Dec 31, 2012 at 12:44:31PM +1300, Tony Prisk wrote:
> 
> > > +	status = readl(pmc_base + 0x14);
> > > +	udelay(100);
> > > +	writel(status, pmc_base + 0x14);
> > > +
> > > +	if (status & BIT(14)) {
> > > +		if (!power_button_pressed) {
> > 
> > No need to do this check.
> > 
> The hardware generates multiple interrupts when the button is held.
> Without the !power_button_pressed, it will generate multiple pressed
> events without releases, because the timer doesn't get to finish.

Input core will filter out duplicate events anyway though...

And your current way means that timer is never adjusted, so the key will
be released and reported as pressed again if I keep holding it, which is
not correct.

Thanks.

-- 
Dmitry
