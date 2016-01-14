From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] [v5]Input: evdev: fix bug of dropping full valid packet
 after syn_dropped
Date: Thu, 14 Jan 2016 23:22:30 +0530
Message-ID: <CADYu30_1YOe51rzfkejr8N1xy3dxJZcmT7bA_0KO=FfP2NSiVQ@mail.gmail.com>
References: <1452686262-6684-1-git-send-email-a.mathur@samsung.com>
	<20160113185239.GC39593@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:32772 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756413AbcANRwb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jan 2016 12:52:31 -0500
In-Reply-To: <20160113185239.GC39593@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, s.samuel@samsung.com, r.mahale@samsung.com

On Thu, Jan 14, 2016 at 12:22 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jan 13, 2016 at 05:27:41PM +0530, Aniroop Mathur wrote:
>> If last event in old queue that was dropped was EV_SYN/SYN_REPORT, then
>> lets generate EV_SYN/SYN_REPORT immediately after queing EV_SYN/SYN_DROPPED
>> so that clients would not ignore next valid full packet events.
>>
>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>> ---
>>  drivers/input/evdev.c |   45 +++++++++++++++++++++++++++++++++------------
>>  1 file changed, 33 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index e9ae3d5..0bc7b98 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -156,7 +156,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>  {
>>       struct input_event ev;
>> +     struct input_event *prev_ev;
>>       ktime_t time;
>> +     unsigned int mask = client->bufsize - 1;
>> +
>> +     /* store previous event */
>> +     prev_ev = &client->buffer[(client->head - 1) & mask];
>
> How do you know that previous event is valid/exists? In fact, when we
> are dropping events due to the full queue, you will be referencing the
> newest event being processed, not the previous event.
>
> I also wonder if this code is safe with regard to __evdev_flush_queue()
> that is dropping bunch of events and possible empty SYN_REPORT groups.
>

Yes, right.
Sorry, I could not understand what you meant on the first read.
You were asking to validate head for last event dropped in queue,
but I understood something else.
Thanks for making me find the problem.
Now, I have corrected it and sent the new patch v6 and v7.

v6:
Corrected head index to store last event properly
About __evdev_flush_queue():
As input core passes packets (not single events) to evdev handler so
after flushing queue for particular events, there will always be syn_report
in the buffer at the end. And if flush request is for ev_syn, then
syn_report will could not be queued after syn_dropped, anyways.
Only problematic case will be if last event stored in the queue was not
syn_report and other events are filtered out such that last event now becomes
syn_report. But I cannot think of a case when last event stored in the buffer
was not syn_report during flushing the queue.

Still, if such case exist, we can take care of it:
How about we store the last event occurred before flushing the queue and
decides of the basis of this event?

v7:
Included fix during pass_events and during clock change request.
It does not consider ev_dev_flush_queue() case.

So, if you find no problem for the case __evdev_flush_queue, we
can use v6, otherwise v7.

BR,
Aniroop Mathur

> Thanks.
>
> --
> Dmitry
