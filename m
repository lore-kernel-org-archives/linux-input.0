From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: polldev can cause crash in case of polling
 disabled
Date: Wed, 17 Feb 2010 11:50:44 -0800
Message-ID: <20100217195044.GC15554@core.coreip.homeip.net>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com>
 <20100216175047.GB15376@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com>
 <20100216214309.GC15376@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com>
 <20100217170315.GB10249@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f197.google.com ([209.85.211.197]:50301 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab0BQTuv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 14:50:51 -0500
Received: by ywh35 with SMTP id 35so230698ywh.4
        for <linux-input@vger.kernel.org>; Wed, 17 Feb 2010 11:50:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100217170315.GB10249@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: samu.p.onkalo@nokia.com, linux-input@vger.kernel.org

On Wed, Feb 17, 2010 at 06:03:15PM +0100, Oleg Nesterov wrote:
> On 02/17, samu.p.onkalo@nokia.com wrote:
> >
> > First time device open:
> > [   29.094879] INPUT_OPEN_POLLED_DEVICE - enter
> > [   29.099182] polldev_wq before start_workqueue: 0
> > [   29.154449] polldev_wq after start_workqueue: ded3c580
> > [   29.159637] cpu_wq of wq: dc4b8480
> > [   29.255950] poll_interval: 32
> > [   29.258941] addr of work: dfbe8f20
> > [   29.262359] data (==cwq) at work (before queueing): 0
> > [   29.267669] data (==cwq) at work (after queueing): dc4b8480  <------- CPU workqueue same as polldev_wq
> > [   29.273315] wq from cwq: ded3c580
> > [   29.276641] INPUT_OPEN_POLLED_DEVICE - done
> >
> > there were other devices opened and closed between
> >
> > Second time device open:
> > [  202.372680] INPUT_OPEN_POLLED_DEVICE - enter
> > [  202.377258] polldev_wq before start_workqueue: dc57ba00
> > [  202.382598] cpu_wq of wq: dc4ea900
> > [  202.386077] polldev_wq after start_workqueue: dc57ba00
> > [  202.391326] cpu_wq of wq: dc4ea900
> > [  202.459259] poll_interval: 0  <-------------------------------- no queueing because of this
> > [  202.462188] addr of work: dfbe8f20
> > [  202.465637] data (==cwq) at work (before queueing): dc4b8480  <----------- CPU workqueue not updated.
> > [  202.471435] wq from cwq: 6b6b006f
> > [  202.474853] data (==cwq) at work (after queueing): dc4b8480 <----- queueing not done -> not updated
> > [  202.480468] wq from cwq: 6b6b006f <-------------------------- crap
> > [  202.483886] INPUT_OPEN_POLLED_DEVICE - done
> >
> > And when cancel_delayed_work_sync is called, kernel crashes due to crap address to per-cpu workqueue.
> >
> > Actually problem is that "data" field in the work struct points to the non-existing per-cpu workqueue entry.
> > When this is cancelled at device close, kernel crashes. But what is the root cause? In input-polldev,
> > workqueue can change from time to time depending on what happens at the userspace. Work struct
> > can still contain references to the old workqueue. Is that illegal thing to do?
> 
> Yes, it is illegal. Well, it is OK to do queue(), but not cancel/flush.
> 
> > It is said in the workqueue.c:
> > * The caller must ensure that workqueue_struct on which this work was last
> >  * queued can't be destroyed before this function returns.
> >
> > This is not true here. Workqueue has been destroyed since the work has
> > never queued to the new workqueue.
> 
> Not sure I understand... The comment says that workqueue_struct must
> stay valid until cancel() returns, of course this also means it must
> be valid when cancel() is called.
>

It apppears that it is allowed to try to cancel work that has never been
queued and I believe that canceled or completed work should be exactly
the same as never been queued work (which is apparently not the case
currently).

Obviously if work has never been queued there is no workqueue struct so
it can't possibly be valid.
 
> > Either cancel_(delayed)_work_sync should clear the data field
> 
> I am a bit confused. Yes I think this is possible, but Dmitry thinks
> we should clear ->data when the work completes... See another email in
> this thread.
> 
> > instead of setting it to non-pending or
> > input-polldev must clear the work struct in case of no queueing.
> 
> Or the caller of cancel can clear ->data?
> 
> Of course, I don't understand input-polldev.c, but shouldn't the trivial
> patch below fix the problem? Although, most likely I do not really
> understand what the problem is ;)
>

Yes, it is certainly possible to work around the issue in every driver
that may happen to shut down and re-create workqueue as needed. The
question is whether it is the right thing to do.

Thanks.

-- 
Dmitry
