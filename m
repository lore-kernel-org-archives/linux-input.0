From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] wm97xx-core: Only schedule interrupt handler if
	not already scheduled
Date: Tue, 15 Apr 2008 09:02:35 -0400
Message-ID: <20080415085946.ZZRA012@mailhub.coreip.homeip.net>
References: <20080414173841.GA2213@rakim.wolfsonmicro.main> <1208194775-4293-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20080414140832.ZZRA012@mailhub.coreip.homeip.net> <20080415084819.GA24498@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:5584 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759591AbYDONCk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2008 09:02:40 -0400
Received: by yw-out-2324.google.com with SMTP id 5so984457ywb.1
        for <linux-input@vger.kernel.org>; Tue, 15 Apr 2008 06:02:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080415084819.GA24498@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 15, 2008 at 09:48:19AM +0100, Mark Brown wrote:
> On Mon, Apr 14, 2008 at 02:10:02PM -0400, Dmitry Torokhov wrote:
> > On Mon, Apr 14, 2008 at 06:39:33PM +0100, Mark Brown wrote:
> 
> > > +	if (!work_pending(&wm->pen_event_work)) {
> > > +		wm->mach_ops->irq_enable(wm, 0);
> > > +		queue_work(wm->ts_workq, &wm->pen_event_work);
> > > +	}
> 
> > Given the fact that work will not be queued if it is pending anyway
> > why is this change needed?
> 
> As well as not queuing the work it ensures that the calls to
> irq_enable() are balanced which helps with implementing that operation.

Hmm... another question then - what would fire up wm97xx_pen_interrupt()
again, before wm97xx_pen_irq_worker had a chance to run, if the very
first thing we do after getting interrupt is irq_enable(wm, 0)?

-- 
Dmitry
