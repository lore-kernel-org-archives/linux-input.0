From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] input: polldev can cause crash in case of polling
	disabled
Date: Wed, 17 Feb 2010 18:03:15 +0100
Message-ID: <20100217170315.GB10249@redhat.com>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com> <20100216175047.GB15376@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com> <20100216214309.GC15376@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24203 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab0BQREH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 12:04:07 -0500
Content-Disposition: inline
In-Reply-To: <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: samu.p.onkalo@nokia.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On 02/17, samu.p.onkalo@nokia.com wrote:
>
> First time device open:
> [   29.094879] INPUT_OPEN_POLLED_DEVICE - enter
> [   29.099182] polldev_wq before start_workqueue: 0
> [   29.154449] polldev_wq after start_workqueue: ded3c580
> [   29.159637] cpu_wq of wq: dc4b8480
> [   29.255950] poll_interval: 32
> [   29.258941] addr of work: dfbe8f20
> [   29.262359] data (==cwq) at work (before queueing): 0
> [   29.267669] data (==cwq) at work (after queueing): dc4b8480  <------- CPU workqueue same as polldev_wq
> [   29.273315] wq from cwq: ded3c580
> [   29.276641] INPUT_OPEN_POLLED_DEVICE - done
>
> there were other devices opened and closed between
>
> Second time device open:
> [  202.372680] INPUT_OPEN_POLLED_DEVICE - enter
> [  202.377258] polldev_wq before start_workqueue: dc57ba00
> [  202.382598] cpu_wq of wq: dc4ea900
> [  202.386077] polldev_wq after start_workqueue: dc57ba00
> [  202.391326] cpu_wq of wq: dc4ea900
> [  202.459259] poll_interval: 0  <-------------------------------- no queueing because of this
> [  202.462188] addr of work: dfbe8f20
> [  202.465637] data (==cwq) at work (before queueing): dc4b8480  <----------- CPU workqueue not updated.
> [  202.471435] wq from cwq: 6b6b006f
> [  202.474853] data (==cwq) at work (after queueing): dc4b8480 <----- queueing not done -> not updated
> [  202.480468] wq from cwq: 6b6b006f <-------------------------- crap
> [  202.483886] INPUT_OPEN_POLLED_DEVICE - done
>
> And when cancel_delayed_work_sync is called, kernel crashes due to crap address to per-cpu workqueue.
>
> Actually problem is that "data" field in the work struct points to the non-existing per-cpu workqueue entry.
> When this is cancelled at device close, kernel crashes. But what is the root cause? In input-polldev,
> workqueue can change from time to time depending on what happens at the userspace. Work struct
> can still contain references to the old workqueue. Is that illegal thing to do?

Yes, it is illegal. Well, it is OK to do queue(), but not cancel/flush.

> It is said in the workqueue.c:
> * The caller must ensure that workqueue_struct on which this work was last
>  * queued can't be destroyed before this function returns.
>
> This is not true here. Workqueue has been destroyed since the work has
> never queued to the new workqueue.

Not sure I understand... The comment says that workqueue_struct must
stay valid until cancel() returns, of course this also means it must
be valid when cancel() is called.

> Either cancel_(delayed)_work_sync should clear the data field

I am a bit confused. Yes I think this is possible, but Dmitry thinks
we should clear ->data when the work completes... See another email in
this thread.

> instead of setting it to non-pending or
> input-polldev must clear the work struct in case of no queueing.

Or the caller of cancel can clear ->data?

Of course, I don't understand input-polldev.c, but shouldn't the trivial
patch below fix the problem? Although, most likely I do not really
understand what the problem is ;)

Oleg.

the patch assumes INIT can't race with queue, I don't know if this
is true.

--- drivers/input/input-polldev.c
+++ drivers/input/input-polldev.c
@@ -100,6 +100,7 @@ static void input_close_polled_device(st
 	struct input_polled_dev *dev = input_get_drvdata(input);
 
 	cancel_delayed_work_sync(&dev->work);
+	INIT_DELAYED_WORK(&dev->work, dev->work->func);
 	input_polldev_stop_workqueue();
 
 	if (dev->close)

