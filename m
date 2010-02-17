From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: polldev can cause crash in case of polling
 disabled
Date: Wed, 17 Feb 2010 01:47:56 -0800
Message-ID: <20100217094756.GA24848@core.coreip.homeip.net>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com>
 <20100216175047.GB15376@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com>
 <20100216214309.GC15376@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com>
 <62697B07E9803846BC582181BD6FB6B82661D4AAC2@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:33156 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863Ab0BQJsQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 04:48:16 -0500
Received: by ywh6 with SMTP id 6so5391059ywh.4
        for <linux-input@vger.kernel.org>; Wed, 17 Feb 2010 01:48:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <62697B07E9803846BC582181BD6FB6B82661D4AAC2@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: samu.p.onkalo@nokia.com
Cc: oleg@redhat.com, linux-input@vger.kernel.org

Hi Samu,

On Wed, Feb 17, 2010 at 09:56:33AM +0100, samu.p.onkalo@nokia.com wrote:
> 
> >
> >Second time device open:
> >[  202.372680] INPUT_OPEN_POLLED_DEVICE - enter
> >[  202.377258] polldev_wq before start_workqueue: dc57ba00
> >[  202.382598] cpu_wq of wq: dc4ea900
> >[  202.386077] polldev_wq after start_workqueue: dc57ba00
> >[  202.391326] cpu_wq of wq: dc4ea900
> >[  202.459259] poll_interval: 0  <-------------------------------- no
> >queueing because of this
> >[  202.462188] addr of work: dfbe8f20
> >[  202.465637] data (==cwq) at work (before queueing): dc4b8480  <------
> >----- CPU workqueue not updated.
> >[  202.471435] wq from cwq: 6b6b006f
> >[  202.474853] data (==cwq) at work (after queueing): dc4b8480 <-----
> >queueing not done -> not updated
> >[  202.480468] wq from cwq: 6b6b006f <-------------------------- crap
> >[  202.483886] INPUT_OPEN_POLLED_DEVICE - done
> >
> >And when cancel_delayed_work_sync is called, kernel crashes due to crap
> >address to per-cpu workqueue.
> >
> >Actually problem is that "data" field in the work struct points to the
> >non-existing per-cpu workqueue entry.
> >When this is cancelled at device close, kernel crashes. But what is the
> >root cause? In input-polldev,
> >workqueue can change from time to time depending on what happens at the
> >userspace. Work struct
> >can still contain references to the old workqueue. Is that illegal thing
> >to do?
> >Or should cancellation of the work cleanup the work struct so that it is
> >in initial state.
> >
> >It is said in the workqueue.c:
> >* The caller must ensure that workqueue_struct on which this work was
> >last
> > * queued can't be destroyed before this function returns.
> >
> >This is not true here. Workqueue has been destroyed since the work has
> >never queued to the new workqueue.
> >Either cancel_(delayed)_work_sync should clear the data field instead of
> >setting it to non-pending or
> >input-polldev must clear the work struct in case of no queueing. Or do
> >you have other proposals?
> >
> 
> One solution is not to destroy and recreate workqueue in input-polldev
> based on open / close calls. This way references to workqueue stays valid.
> 

I would really prefer having this fixed in the workqueue core instead of
working around the issue in a driver.

Thanks.

-- 
Dmitry
