From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: Re: [PATCH] [v9]Input: evdev: fix bug of dropping valid packet
 after syn_dropped event
Date: Wed, 1 Feb 2017 00:29:17 +0800
Message-ID: <CADYu30-ybzBHKpZ6iUTiKr-S7gdpN38dDDJ9x4La-iuPd-1nBQ@mail.gmail.com>
References: <1475608376-3077-1-git-send-email-a.mathur@samsung.com>
 <CGME20161119190005epcas4p156a7f1ebece75cae0bfaf88500d8bf90@epcas4p1.samsung.com>
 <20161121161701epcms5p3a2be540957bf9e316b0d6168c935321c@epcms5p3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34425 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdAaQ3T (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 11:29:19 -0500
In-Reply-To: <20161121161701epcms5p3a2be540957bf9e316b0d6168c935321c@epcms5p3>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, a.mathur@samsung.com, Rahul Mahale <r.mahale@samsung.com>, SAMUEL SEQUEIRA <s.samuel@samsung.com>

On Tue, Nov 22, 2016 at 12:17 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> Hello Mr. Torokhov,
>
>
>>>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>>  {
>>>          struct input_event ev;
>>> +        struct input_event *last_ev;
>>>          ktime_t time;
>>> +        unsigned int mask = client->bufsize - 1;
>>> +
>>> +        /* capture last event stored in the buffer */
>>> +        last_ev = &client->buffer[(client->head - 1) & mask];
>
>> I am uneasy with this "looking back" into the queue. How can we be sure
>> that we are looking at the right event? As far as I can tell we do not
>> know if that event has been consumed or not.
>
>

Hello Mr. Dmitry Torokhov,
Along with the below point I already mentioned,
I thought more about this doubt - whether the last event is consumed or not.
Actually, it does not matter whether last event is consumed or not.
In both cases, we need to insert the SYN_REPORT event right after SYN_DROPPED
event. So even if last event which if is SYN_REPORT is consumed by the client
already and next event inserted is SYN_DROPPED, then also we need to insert
SYN_REPORT event.

So it does not matter whether last event is consumed or not consumed.
The only thing matter is that whether SYN_DROPPED event is inserted
correctly or not.

>
> Well, I think that for an exceptional case where even if last event is
> consumed then also it is the right event to proceed with.
>
> Before mentioning then exceptional case, there is a need to fix a bug in
> calling evdev_queue_syn_dropped in evdev_handle_get_val function.
> The bug is:
> Currently we are calling evdev_queue_syn_dropped without taking care
> whether some events have actually been flushed out or not by calling
> __evdev_flush_queue function. But ideally we should call
> evdev_queue_syn_dropped only when some events are being flushed out.
> For example: If client requests for EV_KEY events and queue only has
> EV_LED type of events, then it is possible that bits_to_user fails
> but no events get flushed out from queue and hence we should not be
> inserting SYN_DROPPED event for this case.
> So to fix this,
> I think we need to return the number of events dropped from function
> __evdev_flush_queue, say n is that value. So only if n > 0, then only
> evdev_queue_syn_dropped should be called.
> - __evdev_flush_queue(client, type);
> + n =  __evdev_flush_queue(client, type);
> - if (ret < 0)
> + if (ret < 0 && n > 0)
>       evdev_queue_syn_dropped(client);
>
> Along with this bug fix, it will also handle the case when queue is
> empty at time of invoking EVIOCG[type] ioctl call so after including
> this fix, we can remove explicit handling of queue empty case from this patch.
>
> After having this change, that exceptional case where even if the last event
> is consumed, it is still the right event is:
> Suppose client request from EV_KEY type of events using EVIOCG[type] ioctl call
> and queue does contain EV_KEY type of events and bits_to_user fails too.
> Now, after this when we invoke evdev_queue_syn_dropped function, there is a
> chance that queue get fully consumed i.e. head == tail. So last event is
> consumed as well. But since we need to send SYN_DROPPED event for this case
> to indicate to user space that some events have been dropped, so we also have
> to check whether we need to insert a SYN_REPORT event or not right after
> SYN_DROPPED event using that last consumed event. And I think that it is for
> sure that this last event is actually SYN_REPORT event since input core
> always send events in packets so SYN_REPORT is always the last event forwarded
> by input core to evdev.
>
> Does the above mentioned points seem okay to you?
>
>
> --
> Best Regards,
> Aniroop Mathur
>
>
> --------- Original Message ---------
> Sender : Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Date   : 2016-11-20 00:30 (GMT+5:30)
> Title  : Re: [PATCH] [v9]Input: evdev: fix bug of dropping valid packet after syn_dropped event
>
> Hi Anoroop,
>
> On Wed, Oct 05, 2016 at 12:42:56AM +0530, Aniroop Mathur wrote:
>> If last event dropped in the old queue was EV_SYN/SYN_REPORT, then lets
>> generate EV_SYN/SYN_REPORT immediately after queing EV_SYN/SYN_DROPPED
>> so that clients would not ignore next valid full packet events.
>>
>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>>
>> Difference from v8:
>> Added check for handling EVIOCG[type] ioctl for queue empty case
>> ---
>>  drivers/input/evdev.c | 52 ++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 39 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index e9ae3d5..69407ff 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -156,7 +156,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>  {
>>          struct input_event ev;
>> +        struct input_event *last_ev;
>>          ktime_t time;
>> +        unsigned int mask = client->bufsize - 1;
>> +
>> +        /* capture last event stored in the buffer */
>> +        last_ev = &client->buffer[(client->head - 1) & mask];
>
> I am uneasy with this "looking back" into the queue. How can we be sure
> that we are looking at the right event? As far as I can tell we do not
> know if that event has been consumed or not.
>
>>
>>          time = client->clk_type == EV_CLK_REAL ?
>>                          ktime_get_real() :
>> @@ -170,13 +175,28 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>          ev.value = 0;
>>
>>          client->buffer[client->head++] = ev;
>> -        client->head &= client->bufsize - 1;
>> +        client->head &= mask;
>>
>>          if (unlikely(client->head == client->tail)) {
>>                  /* drop queue but keep our SYN_DROPPED event */
>> -                client->tail = (client->head - 1) & (client->bufsize - 1);
>> +                client->tail = (client->head - 1) & mask;
>>                  client->packet_head = client->tail;
>>          }
>> +
>> +        /*
>> +         * If last packet was completely stored, then queue SYN_REPORT
>> +         * so that clients would not ignore next valid full packet
>> +         */
>> +        if (last_ev->type == EV_SYN && last_ev->code == SYN_REPORT) {
>> +                last_ev->time = ev.time;
>> +                client->buffer[client->head++] = *last_ev;
>> +                client->head &= mask;
>> +                client->packet_head = client->head;
>> +
>> +                /* drop queue but keep our SYN_DROPPED & SYN_REPORT event */
>> +                if (unlikely(client->head == client->tail))
>> +                        client->tail = (client->head - 2) & mask;
>> +        }
>>  }
>>
>>  static void evdev_queue_syn_dropped(struct evdev_client *client)
>> @@ -218,7 +238,7 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>>                  spin_lock_irqsave(&client->buffer_lock, flags);
>>
>>                  if (client->head != client->tail) {
>> -                        client->packet_head = client->head = client->tail;
>> +                        client->packet_head = client->tail = client->head;
>>                          __evdev_queue_syn_dropped(client);
>>                  }
>>
>> @@ -231,22 +251,24 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>>  static void __pass_event(struct evdev_client *client,
>>                           const struct input_event *event)
>>  {
>> +        unsigned int mask = client->bufsize - 1;
>> +
>>          client->buffer[client->head++] = *event;
>> -        client->head &= client->bufsize - 1;
>> +        client->head &= mask;
>>
>>          if (unlikely(client->head == client->tail)) {
>>                  /*
>>                   * This effectively "drops" all unconsumed events, leaving
>> -                 * EV_SYN/SYN_DROPPED plus the newest event in the queue.
>> +                 * EV_SYN/SYN_DROPPED, EV_SYN/SYN_REPORT (if required) and
>> +                 * newest event in the queue.
>>                   */
>> -                client->tail = (client->head - 2) & (client->bufsize - 1);
>> -
>> -                client->buffer[client->tail].time = event->time;
>> -                client->buffer[client->tail].type = EV_SYN;
>> -                client->buffer[client->tail].code = SYN_DROPPED;
>> -                client->buffer[client->tail].value = 0;
>> +                client->head = (client->head - 1) & mask;
>> +                client->packet_head = client->tail = client->head;
>> +                __evdev_queue_syn_dropped(client);
>>
>> -                client->packet_head = client->tail;
>> +                client->buffer[client->head++] = *event;
>> +                client->head &= mask;
>> +                /* No need to check for buffer overflow as it just occurred */
>>          }
>>
>>          if (event->type == EV_SYN && event->code == SYN_REPORT) {
>> @@ -920,6 +942,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
>>          int ret;
>>          unsigned long *mem;
>>          size_t len;
>> +        bool is_queue_empty;
>>
>>          len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
>>          mem = kmalloc(len, GFP_KERNEL);
>> @@ -933,12 +956,15 @@ static int evdev_handle_get_val(struct evdev_client *client,
>>
>>          spin_unlock(&dev->event_lock);
>>
>> +        if (client->head == client->tail)
>> +                is_queue_empty = true;
>> +
>>          __evdev_flush_queue(client, type);
>>
>>          spin_unlock_irq(&client->buffer_lock);
>>
>>          ret = bits_to_user(mem, maxbit, maxlen, p, compat);
>> -        if (ret < 0)
>> +        if (ret < 0 && !is_queue_empty)
>>                  evdev_queue_syn_dropped(client);
>>
>>          kfree(mem);
>> --
>> 2.6.2
>>
>
> Thanks.
>
> --
> Dmitry
>
>
