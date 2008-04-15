From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] wm97xx-core: Only schedule interrupt handler if
	not already scheduled
Date: Tue, 15 Apr 2008 09:48:19 +0100
Message-ID: <20080415084819.GA24498@rakim.wolfsonmicro.main>
References: <20080414173841.GA2213@rakim.wolfsonmicro.main> <1208194775-4293-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20080414140832.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35400 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755501AbYDOIsV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2008 04:48:21 -0400
Content-Disposition: inline
In-Reply-To: <20080414140832.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 14, 2008 at 02:10:02PM -0400, Dmitry Torokhov wrote:
> On Mon, Apr 14, 2008 at 06:39:33PM +0100, Mark Brown wrote:

> > +	if (!work_pending(&wm->pen_event_work)) {
> > +		wm->mach_ops->irq_enable(wm, 0);
> > +		queue_work(wm->ts_workq, &wm->pen_event_work);
> > +	}

> Given the fact that work will not be queued if it is pending anyway
> why is this change needed?

As well as not queuing the work it ensures that the calls to
irq_enable() are balanced which helps with implementing that operation.
