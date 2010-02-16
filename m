From: <samu.p.onkalo@nokia.com>
Subject: RE: [PATCH] input: polldev can cause crash in case of polling
 disabled
Date: Tue, 16 Feb 2010 19:37:49 +0100
Message-ID: <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com>
 <20100216175047.GB15376@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33585 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab0BPSiL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 13:38:11 -0500
In-Reply-To: <20100216175047.GB15376@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org



>-----Original Message-----
>From: ext Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>Sent: 16 February, 2010 19:51
>To: Onkalo Samu.P (Nokia-D/Tampere)
>Cc: linux-input@vger.kernel.org
>Subject: Re: [PATCH] input: polldev can cause crash in case of polling
>disabled
>
>Hi Samu,
>
>On Tue, Feb 16, 2010 at 04:44:41PM +0200, Samu Onkalo wrote:
>> If polling is set to disabled value and polled input device
>> is opened and closed several times, address to workqueue will probably
>> change at some point. Since nothing is queued (due to polled disabled
>> state), content of the work struct contains pointer to the old and
>non-existent
>> workqueue.
>
>This I do not quite understand. The work struct as far as I can see does
>not reference workqueue at all. There is a list entry but if we do not
>poll the device that entry should be always detached from any lists. We
>properly initialize WQ entry when we create the device and it shoudl
>remain valid until the device is destroyed.

'data' entry contains a pointer to per-cpu-workqueue which in turn contains
the workqueue pointer. This 'data' entry is not ok in case of failure. I can
Collect more data about this.

>
>> When the device is closed again, cancel_delayed_work_sync
>> goes crazy due to pointer to nonexisting workqueue.
>>
>
>What kind of failure do you see? Is there a stack trace or something?

Kernel panic while in workqueue handling (paging fault with some crappy address).

>
>> In case on disabled polling, init work struct to initial value to
>> clean up the old values.
>>
>
>Also, why would not we see the same issue with enabled polling? The
>workqueue is being created and destroyed in this case as well.


Queue_delayed_work updates the work struct. Workqueue itself is ok.

I think that the sequence goes about this way (no other polled devices open):
1. Polled device is opened with polling enabled
2. It first creates workqueue and then queue the first polling. Kernels
Workqueue functions updates current workqueue information to the work-struct
3. polled device is closed
4. workqueue is destroyed

5. polling interval is set to 0
6. device is reopened
7. New workqueue is created
8. polled device is closed without queueing a work
9. work struct for polled device contains pointer to the old (created in 2.) wq
10. cancel_workqueue... can access unallocated memory causing crash.





