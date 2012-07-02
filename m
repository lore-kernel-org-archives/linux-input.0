From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Request threaded-only IRQs with IRQF_ONESHOT
Date: Mon, 2 Jul 2012 12:22:52 -0700
Message-ID: <20120702192252.GA17212@core.coreip.homeip.net>
References: <1341229460-23732-1-git-send-email-lars@metafoo.de>
 <20120702190402.GA16271@core.coreip.homeip.net>
 <alpine.LFD.2.02.1207022111190.2793@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35866 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab2GBTW7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jul 2012 15:22:59 -0400
Received: by pbbrp8 with SMTP id rp8so7930307pbb.19
        for <linux-input@vger.kernel.org>; Mon, 02 Jul 2012 12:22:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1207022111190.2793@ionos>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Fabien Marteau <fabien.marteau@armadeus.com>, HeungJun Kim <riverful.kim@samsung.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, Bo Shen <voice.shen@atmel.com>, Sriramakrishnan <srk@ti.com>, Kyle Manna <kyle.manna@fuel7.com>, Cyril Chemparathy <cyril@ti.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Alan Cox <alan@linux.intel.com>, Jianchun Bian <jcbian@pixcir.com.cn>, Aaro Koskinen <aaro.koskinen@nokia.com>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jul 02, 2012 at 09:11:44PM +0200, Thomas Gleixner wrote:
> On Mon, 2 Jul 2012, Dmitry Torokhov wrote:
> 
> > H Lars, Thomas,
> > 
> > On Mon, Jul 02, 2012 at 01:44:20PM +0200, Lars-Peter Clausen wrote:
> > > Since commit 1c6c69525b ("genirq: Reject bogus threaded irq requests") threaded
> > > IRQs without a primary handler need to be requested with IRQF_ONESHOT, otherwise
> > > the request will fail. This patch adds the IRQF_ONESHOT to IIO drivers where it
> > > is missing. Not modified by this patch are those drivers where the requested IRQ
> > > will always be a nested IRQ (e.g. because it's part of an MFD), since for this
> > > special case IRQF_ONESHOT is not required to be specified when requesting the
> > > IRQ.
> > 
> > This is not very helpful. Why, instead of bailing out, genirq case does
> > not add IRQF_ONESHOT itself to the flags? Then we would not need to
> > alter zillions of drivers.
> 
> https://lkml.org/lkml/2012/6/12/151

Hm, OK, Linus wins... I guess I need to queue this for 3.5 then...

-- 
Dmitry
