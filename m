From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: evdev: fix queueing of SYN_DROPPED event for
 EVIOCG[type] IOCTL case
Date: Wed, 18 Jan 2017 22:17:12 +0530
Message-ID: <CADYu30-Rrz4zTT1cvkPBjnfjJrjFa2BA-=enn0mfs5NrFiLHUg@mail.gmail.com>
References: <1480018303-4220-1-git-send-email-a.mathur@samsung.com> <CADYu30-oJW68-6QRv56bPQJ-zGiohWmvpYgbOENPEzFnWDV4QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35779 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbdARQyP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 11:54:15 -0500
In-Reply-To: <CADYu30-oJW68-6QRv56bPQJ-zGiohWmvpYgbOENPEzFnWDV4QQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aniroop Mathur <a.mathur@samsung.com>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>

Dear Mr. Dmitry Torokhov,

Could you please update about this patch?
Thank you.

-- Aniroop Mathur


On Wed, Dec 14, 2016 at 11:54 PM, Aniroop Mathur
<aniroop.mathur@gmail.com> wrote:
> Hello Mr. Torokhov,
>
> Would you kindly update about this patch?
> Thanks!
>
> Best Regards,
> Aniroop Mathur
>
>
> On Fri, Nov 25, 2016 at 1:41 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
>> Currently, when EVIOCG[type] ioctl call is issued and bits_to_user fails,
>> then SYN_DROPPED event is inserted in the event queue always.
>>
>> However, it is not compulsory that some events are flushed out on every
>> EVIOCG[type] ioctl call like in case of empty event queue and in case when
>> EVIOCG[type] ioctl is issued for say A type of events but event queue does
>> not have any A type of events but some other type of events.
>>
>> Therefore, insert SYN_DROPPED event only when some events have been flushed
>> out from event queue plus bits_to_user fails.
>>
>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>> ---
>>  drivers/input/evdev.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index e9ae3d5..f8b295e 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -108,9 +108,11 @@ static bool __evdev_is_filtered(struct evdev_client *client,
>>  }
>>
>>  /* flush queued events of type @type, caller must hold client->buffer_lock */
>> -static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>> +static unsigned int __evdev_flush_queue(struct evdev_client *client,
>> +                                       unsigned int type)
>>  {
>>         unsigned int i, head, num;
>> +       unsigned int drop_count = 0;
>>         unsigned int mask = client->bufsize - 1;
>>         bool is_report;
>>         struct input_event *ev;
>> @@ -129,9 +131,11 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>
>>                 if (ev->type == type) {
>>                         /* drop matched entry */
>> +                       drop_count++;
>>                         continue;
>>                 } else if (is_report && !num) {
>>                         /* drop empty SYN_REPORT groups */
>> +                       drop_count++;
>>                         continue;
>>                 } else if (head != i) {
>>                         /* move entry to fill the gap */
>> @@ -151,6 +155,7 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>         }
>>
>>         client->head = head;
>> +       return drop_count;
>>  }
>>
>>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>> @@ -920,6 +925,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
>>         int ret;
>>         unsigned long *mem;
>>         size_t len;
>> +       unsigned int drop_count = 0;
>>
>>         len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
>>         mem = kmalloc(len, GFP_KERNEL);
>> @@ -933,12 +939,12 @@ static int evdev_handle_get_val(struct evdev_client *client,
>>
>>         spin_unlock(&dev->event_lock);
>>
>> -       __evdev_flush_queue(client, type);
>> +       drop_count = __evdev_flush_queue(client, type);
>>
>>         spin_unlock_irq(&client->buffer_lock);
>>
>>         ret = bits_to_user(mem, maxbit, maxlen, p, compat);
>> -       if (ret < 0)
>> +       if (ret < 0 && drop_count > 0)
>>                 evdev_queue_syn_dropped(client);
>>
>>         kfree(mem);
>> --
>> 2.6.2
>>
