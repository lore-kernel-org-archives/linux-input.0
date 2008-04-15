From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] wm97xx-core: Only schedule interrupt handler if not already scheduled
Date: Tue, 15 Apr 2008 15:42:50 +0100
Message-ID: <20080415144250.GB5203@sirena.org.uk>
References: <20080414173841.GA2213@rakim.wolfsonmicro.main> <1208194775-4293-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20080414140832.ZZRA012@mailhub.coreip.homeip.net> <20080415084819.GA24498@rakim.wolfsonmicro.main> <20080415085946.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764993AbYDOOnT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080415085946.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 15, 2008 at 09:02:35AM -0400, Dmitry Torokhov wrote:
> On Tue, Apr 15, 2008 at 09:48:19AM +0100, Mark Brown wrote:

> > As well as not queuing the work it ensures that the calls to
> > irq_enable() are balanced which helps with implementing that operation.

> Hmm... another question then - what would fire up wm97xx_pen_interrupt()
> again, before wm97xx_pen_irq_worker had a chance to run, if the very
> first thing we do after getting interrupt is irq_enable(wm, 0)?

Normally nothing - in most systems the interrupt will not be shared
and/or the board irq_enable() operation will completely disable the IRQ
line.  The main use case would be if the interrupt is shared and the
board irq_enable() operation doesn't affect other sources, though boards
may also decide that they can do without disabling the interrupt.
