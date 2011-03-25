From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Input: wm831x-ts - Fix races with IRQ management
Date: Fri, 25 Mar 2011 10:49:46 +0000
Message-ID: <20110325104945.GA31415@opensource.wolfsonmicro.com>
References: <1300142701-22260-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1300142701-22260-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110318112043.GA27129@sirena.org.uk>
 <20110325073032.GB2590@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60420 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934195Ab1CYKts (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 06:49:48 -0400
Content-Disposition: inline
In-Reply-To: <20110325073032.GB2590@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Fri, Mar 25, 2011 at 12:30:32AM -0700, Dmitry Torokhov wrote:

> I am just not comfortable with a touchcsreen requiring essentially 2
> threads to operate (2 IRQ threads, 2 works).  I was thinking about
> converting to a thread with a state machine and 2 non-threaded IRQs
> disabling themselves and waking the thread up. Do you think something
> like that would work?

You can't use non-threaded IRQs as the chip is accessed over I2C or SPI
so when using the built in interrupts you're in thread context before
you've decoded the IRQ.  Given the need to ack the IRQ to stop it trying
to do something it doesn't seem worth trying to move the chip
interaction out of the IRQ handlers there - it'd just be performance
pain and you'd still need to worry about which IRQs are enabled at any
given moment since you'd need to disable the IRQs if you wanted to defer
handling them.

Combining the two work items to do the IRQ enable handovers should be
doable, though.
