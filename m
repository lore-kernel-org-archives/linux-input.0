From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] input: Request threaded-only IRQs with IRQF_ONESHOT
Date: Mon, 2 Jul 2012 21:11:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1207022111190.2793@ionos>
References: <1341229460-23732-1-git-send-email-lars@metafoo.de> <20120702190402.GA16271@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47657 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab2GBTMR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jul 2012 15:12:17 -0400
In-Reply-To: <20120702190402.GA16271@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Fabien Marteau <fabien.marteau@armadeus.com>, HeungJun Kim <riverful.kim@samsung.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, Bo Shen <voice.shen@atmel.com>, Sriramakrishnan <srk@ti.com>, Kyle Manna <kyle.manna@fuel7.com>, Cyril Chemparathy <cyril@ti.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Alan Cox <alan@linux.intel.com>, Jianchun Bian <jcbian@pixcir.com.cn>, Aaro Koskinen <aaro.koskinen@nokia.com>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, 2 Jul 2012, Dmitry Torokhov wrote:

> H Lars, Thomas,
> 
> On Mon, Jul 02, 2012 at 01:44:20PM +0200, Lars-Peter Clausen wrote:
> > Since commit 1c6c69525b ("genirq: Reject bogus threaded irq requests") threaded
> > IRQs without a primary handler need to be requested with IRQF_ONESHOT, otherwise
> > the request will fail. This patch adds the IRQF_ONESHOT to IIO drivers where it
> > is missing. Not modified by this patch are those drivers where the requested IRQ
> > will always be a nested IRQ (e.g. because it's part of an MFD), since for this
> > special case IRQF_ONESHOT is not required to be specified when requesting the
> > IRQ.
> 
> This is not very helpful. Why, instead of bailing out, genirq case does
> not add IRQF_ONESHOT itself to the flags? Then we would not need to
> alter zillions of drivers.

https://lkml.org/lkml/2012/6/12/151
