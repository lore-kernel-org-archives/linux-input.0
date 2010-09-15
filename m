From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] Input: serio - convert to use workqueue instead of a thread
Date: Wed, 15 Sep 2010 11:46:20 +0200
Message-ID: <4C9095EC.4030008@kernel.org>
References: <20100915051652.GA22219@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49848 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886Ab0IOJqY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 05:46:24 -0400
In-Reply-To: <20100915051652.GA22219@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

Hello,

On 09/15/2010 07:16 AM, Dmitry Torokhov wrote:
> Instead of creating an exclusive thread to handle serio events (which
> happen rarely), let's switch to using a workqueue. With the arrival of
> concurrency-managed workqueue infrastructure it should reduce total
> number of threads in the system.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
> If this makes sense I have a similar patch for gameport... Hopefully
> this will allow to get rid of kseriod, kgameportd, kpsmoused and
> ipolldevd...

Generally looks good to me.  Just some deatils.

> +	serio_wq = alloc_workqueue("kseriod", WQ_UNBOUND, 1);

I don't think there's any need to use WQ_UNBOUND + @max_active of 1.
The event handler seems to be handling synchornization itself and the
there's single work item.

Also, there's no reason to use a separate workqueue at all.  Just
schedule_work() and do cancel_work_sync() on serio_exit().  With the
worker pool sharing, there's no latency or execution advantage to
using a separate workqueue anymore unless you need a rescuer or want
to have a separate flush / attribute domain (not the case here).  I'll
soon push workqueue document upstream and also am preparing more
helpers (alloc_ordered_workqueue() and flush_work_sync()) and
conversions of various users for the next cycle.  Hopefully, what to
use when will get clearer with those.

Thank you for doing this.

-- 
tejun
