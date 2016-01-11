From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] [v4]Input: evdev - drop partial events after emptying the buffer
Date: Mon, 11 Jan 2016 19:46:53 +0530
Message-ID: <CADYu309KOBo0DecJYuWv7T2T9OJhnX0G98CvFWy8OdT60d-W+A@mail.gmail.com>
References: <1451944601-1376-1-git-send-email-a.mathur@samsung.com>
	<20160111041134.GA24860@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33762 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289AbcAKOQy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jan 2016 09:16:54 -0500
In-Reply-To: <20160111041134.GA24860@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, s.samuel@samsung.com, r.mahale@samsung.com

On Mon, Jan 11, 2016 at 9:41 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Tue, Jan 05, 2016 at 03:26:41AM +0530, Aniroop Mathur wrote:
>> This patch introduces concept to drop partial events in evdev handler
>> itself after emptying the buffer which are dropped by all evdev
>> clients in userspace after SYN_DROPPED occurs and this in turn reduces
>> evdev client reading requests plus saves memory space filled by partial
>> events in evdev handler buffer.
>> Also, this patch prevents dropping of full packet by evdev client after
>> SYN_DROPPED occurs in case last stored event was SYN_REPORT.
>> (like after clock change request)
>
> this patch looks technically correct now, thanks. but tbh, especially after
> reading the EVIOCGBUFSIZE patch I'm wondering why you need to optimise this
> path. ignoring events after a SYN_DROPPED is easy in userspace, and you'll
> need the code to do so anyway because even with your patch, there is no API
> guarantee that this will always happen - if you rely on it, your code may
> break on a future kernel.
>
> From userland, this patch has no real effect, it only slightly reduces the
> chance that you get a SYN_DROPPED while reading events after a SYN_DROPPED
> has already occured. And if that's a problem, fixing the kernel is likely
> the wrong solution anyway. so yeah, still in doubt about whether this patch
> provides any real benefit.
>

Hello Mr. Peter,

I'm sorry that I'm really not able to understand you fully above.
Please, provide your opinion after seeing below reason of this patch and
elaborate more on above, if still required.

As you can understand by seeing the patch code, this patch is required for
three reasons as follows:

1. To fix bug of dropping full valid packet events by userspace clients in case
last packet was fully stored and then syn_dropped occurs.

For example:
Consider kernel buf contains:
... SYN_REPORT REL_X, REL_Y, SYN_REPORT <one event space>
Now consider case that clock type is changed, so these events will be dropped
and syn_dropped will be queued.
OR
consider second case that new first packet event occur and that is stored in
last event space left, so all stored events will be dropped and syn_dropped
will be queued + newest event as per current code.
So now for first case, kernel buf contains: SYN_DROPPED
and for second case, kernel buf contains: SYN_DROPPED REL_X
Next consider that full packet is finished storing for both cases and
user-space is notified that events are ready to be read.
So now kernel buf contains: SYN_DROPPED REL_X REL_Y SYN_REPORT
But this new valid full packet event will be ignored by the userspace client
as mentioned in documentation that userspace clients ignore all events up to
and including next SYN_REPORT. As you know, this valid full event should not
be ignored by the userspace. So this patch fixes this bug.

2. To save small memory filled with partial events in evdev handler
kernel buffer after syn_dropped as these partial events will not be consumed by
clients anyways so no need to store them as well.

For example:
Consider full packet as REL_X REL_Y REL_Z REL_RX REL_RY REL_RZ SYN_REPORT
as in case of magnetic sensor data which includes raw data along x, y, z axis
and noise data along x, y, z axis.
Consider kernel buf contains:
SYN_DROPPED REL_Y REL_Z REL_RX REL_RY REL_RZ SYN_REPORT REL_X REL_Y ...
As you know, REL_Y REL_Z REL_RX REL_RY REL_RZ are partial events that will not
be consumed by userspace clients, so this patch saves memory space of these
partial events by not storing them as it not consumed by clients as well.
With this patch, kernel buf will contain only required events:
SYN_DROPPED SYN_REPORT REL_X REL_Y ...

3. To reduce few looping iterations of reading partial events by user space
clients after syn_dropped occurs.

For example:
Userspace client reads some events and userspace buf contains:
SYN_DROPPED REL_Y REL_Z REL_RX REL_RY REL_RZ SYN_REPORT REL_X <more events> ..
Client will process syn_dropped and decides to ignore next events until
syn_report occurs. So it processes REL_Y but ignores, processes REL_Z but
ignores, processes REL_RX but ignores, processes REL_RY but ignores, processes
REL_RZ but ignores and then it processes SYN_REPORT after which it decides to
not ignore any events any more. All this processing will basically be done in
a loop so with this patch extra looping cycles of partial events are removed
because with this patch userspace buf will contain:
SYN_DROPPED SYN_REPORT REL_X REL_Y <more events>
Hence we have saved a few looping cycles here.

I also think that there is a need to change the patch title and description as
well to make it better:

Subject: Drop partial events and queue syn_report after syn_dropped occurs.

Description:
This patch introduces concept to drop partial events and queue syn_report
after syn_dropped which in turn does the following jobs:
- Fixes bug of dropping full valid packet events by userspace clients in case
last packet was fully stored and then syn_dropped occurs.
- Save small memory filled with partial events in evdev handler kernel buffer
after syn_dropped as these partial events will not be consumed by
clients anyways so no need to store them as well.
- Reduces few looping iterations of processing partial events by userspace
clients after syn_dropped occurs.

Thanks.

BR,
Aniroop Mathur

> Cheers,
>    Peter
>
>> --
>> Please ignore v3.
>>
>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>> ---
>>  drivers/input/evdev.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 40 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index e9ae3d5..15b6eb2 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -58,6 +58,7 @@ struct evdev_client {
>>       struct list_head node;
>>       unsigned int clk_type;
>>       bool revoked;
>> +     bool drop_pevent; /* specifies if partial events need to be dropped */
>>       unsigned long *evmasks[EV_CNT];
>>       unsigned int bufsize;
>>       struct input_event buffer[];
>> @@ -156,7 +157,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>  {
>>       struct input_event ev;
>> +     struct input_event *prev_ev;
>>       ktime_t time;
>> +     unsigned int mask = client->bufsize - 1;
>> +
>> +     /* Store previous event */
>> +     prev_ev = &client->buffer[(client->head - 1) & mask];
>>
>>       time = client->clk_type == EV_CLK_REAL ?
>>                       ktime_get_real() :
>> @@ -170,13 +176,33 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>       ev.value = 0;
>>
>>       client->buffer[client->head++] = ev;
>> -     client->head &= client->bufsize - 1;
>> +     client->head &= mask;
>>
>>       if (unlikely(client->head == client->tail)) {
>>               /* drop queue but keep our SYN_DROPPED event */
>> -             client->tail = (client->head - 1) & (client->bufsize - 1);
>> +             client->tail = (client->head - 1) & mask;
>>               client->packet_head = client->tail;
>>       }
>> +
>> +     /*
>> +      * If last packet is NOT fully stored, set drop_pevent to true to
>> +      * ignore partial events and if last packet is fully stored, queue
>> +      * SYN_REPORT so that clients would not ignore next full packet.
>> +      */
>> +     if (prev_ev->type != EV_SYN && prev_ev->code != SYN_REPORT) {
>> +             client->drop_pevent = true;
>> +     } else if (prev_ev->type == EV_SYN && prev_ev->code == SYN_REPORT) {
>> +             prev_ev->time = ev.time;
>> +             client->buffer[client->head++] = *prev_ev;
>> +             client->head &= mask;
>> +             client->packet_head = client->head;
>> +
>> +             /* drop queue but keep our SYN_DROPPED & SYN_REPORT event */
>> +             if (unlikely(client->head == client->tail)) {
>> +                     client->tail = (client->head - 2) & mask;
>> +                     client->packet_head = client->tail;
>> +             }
>> +     }
>>  }
>>
>>  static void evdev_queue_syn_dropped(struct evdev_client *client)
>> @@ -235,18 +261,8 @@ static void __pass_event(struct evdev_client *client,
>>       client->head &= client->bufsize - 1;
>>
>>       if (unlikely(client->head == client->tail)) {
>> -             /*
>> -              * This effectively "drops" all unconsumed events, leaving
>> -              * EV_SYN/SYN_DROPPED plus the newest event in the queue.
>> -              */
>> -             client->tail = (client->head - 2) & (client->bufsize - 1);
>> -
>> -             client->buffer[client->tail].time = event->time;
>> -             client->buffer[client->tail].type = EV_SYN;
>> -             client->buffer[client->tail].code = SYN_DROPPED;
>> -             client->buffer[client->tail].value = 0;
>> -
>>               client->packet_head = client->tail;
>> +             __evdev_queue_syn_dropped(client);
>>       }
>>
>>       if (event->type == EV_SYN && event->code == SYN_REPORT) {
>> @@ -284,6 +300,17 @@ static void evdev_pass_values(struct evdev_client *client,
>>                       wakeup = true;
>>               }
>>
>> +             /*
>> +              * drop partial events of last packet but queue SYN_REPORT
>> +              * so that clients would not ignore extra full packet.
>> +              */
>> +             if (client->drop_pevent) {
>> +                     if (v->type == EV_SYN && v->code == SYN_REPORT)
>> +                             client->drop_pevent = false;
>> +                     else
>> +                             continue;
>> +             }
>> +
>>               event.type = v->type;
>>               event.code = v->code;
>>               event.value = v->value;
>> --
>> 2.6.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
