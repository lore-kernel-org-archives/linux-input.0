From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] [v5]Input: evdev: fix bug of dropping full valid packet
 after syn_dropped
Date: Thu, 14 Jan 2016 01:58:39 +0530
Message-ID: <CADYu30_eUUDTKOz+1UK7v9Km+g8R5AOP9cfKU+kidgZ-SBqUyg@mail.gmail.com>
References: <1452686262-6684-1-git-send-email-a.mathur@samsung.com>
	<20160113185239.GC39593@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34383 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbcAMU2k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 15:28:40 -0500
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

yes right, prev_ev variable name is fine for clk_change & flush_queue but not
for buffer overrun. It is better to give some other name, may be last_ev or
temp_ev. (the event chosen is right though)

In case of buffer overrun,
old events does exist due to which overrun occurred, so last/newest event does
exist to compare with. (referring by the name prev_ev currently in patch)

In case of clock change request,
we flush queue only if it is not empty, so last event does exist to compare
with.
Most likely, last event will be syn_report here as input core passes events
to handler when syn_report occurs.

In case __evdev_flush_queue,
tbh, I have not dealt with this function much and thats why in my v1 & v2 patch,
I added the code separately for clock change and buffer run. But on
more thought,
I could not thought of any problem so moved the code to common function
__evdev_queue_syn_dropped.
AFAICT, in this case, even if all events are flushed, one syn_report
will be there
in queue at least, so last event will exist to compare with.

BR,
Aniroop Mathur

> I also wonder if this code is safe with regard to __evdev_flush_queue()
> that is dropping bunch of events and possible empty SYN_REPORT groups.
>
> Thanks.
>
> --
> Dmitry
