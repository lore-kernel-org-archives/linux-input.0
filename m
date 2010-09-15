From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC] Input: serio - convert to use workqueue instead of a thread
Date: Wed, 15 Sep 2010 11:50:53 +0200
Message-ID: <4C9096FD.4060708@gmail.com>
References: <20100915051652.GA22219@core.coreip.homeip.net> <4C9095EC.4030008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33021 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab0IOJu7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 05:50:59 -0400
Received: by bwz11 with SMTP id 11so324703bwz.19
        for <linux-input@vger.kernel.org>; Wed, 15 Sep 2010 02:50:57 -0700 (PDT)
In-Reply-To: <4C9095EC.4030008@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On 09/15/2010 11:46 AM, Tejun Heo wrote:
> Hello,
> 
> On 09/15/2010 07:16 AM, Dmitry Torokhov wrote:
>> Instead of creating an exclusive thread to handle serio events (which
>> happen rarely), let's switch to using a workqueue. With the arrival of
>> concurrency-managed workqueue infrastructure it should reduce total
>> number of threads in the system.
>>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> ---
>>
>> If this makes sense I have a similar patch for gameport... Hopefully
>> this will allow to get rid of kseriod, kgameportd, kpsmoused and
>> ipolldevd...
> 
> Generally looks good to me.  Just some deatils.
> 
>> +	serio_wq = alloc_workqueue("kseriod", WQ_UNBOUND, 1);
> 
> I don't think there's any need to use WQ_UNBOUND + @max_active of 1.
> The event handler seems to be handling synchornization itself and the
> there's single work item.
> 
> Also, there's no reason to use a separate workqueue at all.  Just
> schedule_work() and do cancel_work_sync() on serio_exit().  With the
> worker pool sharing, there's no latency or execution advantage to
> using a separate workqueue anymore unless you need a rescuer or want
> to have a separate flush / attribute domain (not the case here).  I'll
> soon push workqueue document upstream and also am preparing more
> helpers (alloc_ordered_workqueue() and flush_work_sync()) and
> conversions of various users for the next cycle.  Hopefully, what to
> use when will get clearer with those.

Ooh, it looks like the driver would need flushing rather than
cancelling before exiting as the handler needs to clear the allocated
event items.  I'll prep a branch which contains flush_work_sync()
later today so that you can pull and work on it.

Thank you.

-- 
tejun
