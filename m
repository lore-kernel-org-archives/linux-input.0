From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: polldev can cause crash in case of polling
 disabled
Date: Tue, 16 Feb 2010 13:43:10 -0800
Message-ID: <20100216214309.GC15376@core.coreip.homeip.net>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com>
 <20100216175047.GB15376@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:39120 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933264Ab0BPVsm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 16:48:42 -0500
Received: by gxk27 with SMTP id 27so522256gxk.1
        for <linux-input@vger.kernel.org>; Tue, 16 Feb 2010 13:48:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: samu.p.onkalo@nokia.com, oleg@redhat.com
Cc: linux-input@vger.kernel.org

On Tue, Feb 16, 2010 at 07:37:49PM +0100, samu.p.onkalo@nokia.com wrote:
> 
> 
> >-----Original Message-----
> >From: ext Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> >Sent: 16 February, 2010 19:51
> >To: Onkalo Samu.P (Nokia-D/Tampere)
> >Cc: linux-input@vger.kernel.org
> >Subject: Re: [PATCH] input: polldev can cause crash in case of polling
> >disabled
> >
> >Hi Samu,
> >
> >On Tue, Feb 16, 2010 at 04:44:41PM +0200, Samu Onkalo wrote:
> >> If polling is set to disabled value and polled input device
> >> is opened and closed several times, address to workqueue will probably
> >> change at some point. Since nothing is queued (due to polled disabled
> >> state), content of the work struct contains pointer to the old and
> >non-existent
> >> workqueue.
> >
> >This I do not quite understand. The work struct as far as I can see does
> >not reference workqueue at all. There is a list entry but if we do not
> >poll the device that entry should be always detached from any lists. We
> >properly initialize WQ entry when we create the device and it shoudl
> >remain valid until the device is destroyed.
> 
> 'data' entry contains a pointer to per-cpu-workqueue which in turn contains
> the workqueue pointer. This 'data' entry is not ok in case of failure. I can
> Collect more data about this.
> 
> >
> >> When the device is closed again, cancel_delayed_work_sync
> >> goes crazy due to pointer to nonexisting workqueue.
> >>
> >
> >What kind of failure do you see? Is there a stack trace or something?
> 
> Kernel panic while in workqueue handling (paging fault with some crappy address).
> 
> >
> >> In case on disabled polling, init work struct to initial value to
> >> clean up the old values.
> >>
> >
> >Also, why would not we see the same issue with enabled polling? The
> >workqueue is being created and destroyed in this case as well.
> 
> 
> Queue_delayed_work updates the work struct. Workqueue itself is ok.
> 
> I think that the sequence goes about this way (no other polled devices open):
> 1. Polled device is opened with polling enabled
> 2. It first creates workqueue and then queue the first polling. Kernels
> Workqueue functions updates current workqueue information to the work-struct
> 3. polled device is closed
> 4. workqueue is destroyed
> 
> 5. polling interval is set to 0
> 6. device is reopened
> 7. New workqueue is created
> 8. polled device is closed without queueing a work
> 9. work struct for polled device contains pointer to the old (created in 2.) wq
> 10. cancel_workqueue... can access unallocated memory causing crash.
> 

Ah, I see. In this case I think it should be fixed in workqueue code by
clearing work data so it does not point to the [potentially] non-existing
workqueue when we cancel or complete work.

Oleg, do you agree?

-- 
Dmitry
