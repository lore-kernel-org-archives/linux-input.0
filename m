From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [PATCH] Input/evdev: Add 64bit timestamp support
Date: Tue, 7 Jul 2015 19:30:23 +0530
Message-ID: <CA+HOOshg_UV7J25zBZFZiT4iUnihVJQnRj3MgKErQeSSg24yug@mail.gmail.com>
References: <aksgarg1989@gmail.com>
	<1436211224-59601-1-git-send-email-aksgarg1989@gmail.com>
	<20150706224802.GB32140@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35479 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757430AbbGGOAY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2015 10:00:24 -0400
Received: by qget71 with SMTP id t71so84422625qge.2
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2015 07:00:23 -0700 (PDT)
In-Reply-To: <20150706224802.GB32140@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Mr. Dmitry ,

On Tue, Jul 7, 2015 at 4:18 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Anshul,
>
> On Mon, Jul 06, 2015 at 12:33:44PM -0700, Anshul Garg wrote:
>> From: Anshul Garg <aksgarg1989@gmail.com>
>>
>> As per current implementation input driver can only
>> send ktime converted to timeval which user space again
>> have to convert.
>
> Why? ktime is kernel construct and thus userspace has no business using
> it directly.
>
As per current implementation , input subsystem fills the event timestamp
from ktime_get_real,ktme_get_mono depending upon clock type and then
converts it to timeval structure.

Then user space program uses timevaltoNano api to get the event time.

>> In some cases input drivers need 64bit timestamp value
>> from driver only so that same value can be used by upper
>> layer without any manipulation.
>
> Why do they need 64 bit value? What exactly is special about 64 bits? Do
> they need to know number of seconds since beginning of the universe?
>
> You need to specify the problem better instead of just saying we need 64
> bits.
>
Since currently event time is of type timeval and event handlers send the
time as per this format only.
By 64bit timestamp i am suggesting support for sending timestamp
directly obtained using api(ktime_get_real,ktime_get_boottime etc).

I am thinking of following reasons.
1. For every event sent from input subsystem user space has to convert
time again.[from timeval to ns] which can be avoided if we add the
functionality
of sending ktime to user space.


>> Proposed implementation is placed under CONFIG flag which
>> will not break any existing code.
>
> Yes, it does. As soon as somebody enables this option their usersoace
> will [potentially] break, because instead of timeval they will be
> getting 64 bit values.
>
> If we want to do this users will have to explicitly request such
> timestamps.
>
If someone enables this CONFIG option input subsystem will also send
timestamp [nanosec]value along with time[timeval].
So i think existing interface will not break.

Yes we can achieve this by providing ioctl from userspace.
So that user can decide which timestamp user needs from input subsystem

>>
>> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
>> ---
>>  drivers/input/Kconfig      |    8 ++++++++
>>  drivers/input/evdev.c      |   21 ++++++++++++++++++++-
>>  include/uapi/linux/input.h |    3 +++
>>  3 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
>> index a35532e..9bf9044 100644
>> --- a/drivers/input/Kconfig
>> +++ b/drivers/input/Kconfig
>> @@ -161,6 +161,14 @@ config INPUT_EVDEV
>>         To compile this driver as a module, choose M here: the
>>         module will be called evdev.
>>
>> +config INPUT_EVDEV_64BIT_TIMESTAMP
>> +       bool "64 Event timestamp"
>> +     depends on INPUT_EVDEV
>> +     default n
>> +     help
>> +          Say Y here if you need to send 64bit timestamp from input
>> +        drivers otherwise N.
>> +
>>  config INPUT_EVBUG
>>       tristate "Event debugging"
>>       help
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index 9d35499..396b60f 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -90,6 +90,9 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>                       continue;
>>               } else if (head != i) {
>>                       /* move entry to fill the gap */
>> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
>> +                     client->buffer[head].timestamp = ev->timestamp;
>> +#endif
>>                       client->buffer[head].time = ev->time;
>>                       client->buffer[head].type = ev->type;
>>                       client->buffer[head].code = ev->code;
>> @@ -111,6 +114,9 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>  {
>>       struct input_event ev;
>> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
>> +     struct timespec64 ts;
>> +#endif
>>       ktime_t time;
>>
>>       time = client->clk_type == EV_CLK_REAL ?
>> @@ -118,7 +124,10 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>                       client->clk_type == EV_CLK_MONO ?
>>                               ktime_get() :
>>                               ktime_get_boottime();
>> -
>> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
>> +     ts = ktime_to_timespec64(time);
>> +     ev.timestamp = ts.tv_sec*NSEC_PER_SEC + ts.tv_nsec;
>> +#endif
>>       ev.time = ktime_to_timeval(time);
>>       ev.type = EV_SYN;
>>       ev.code = SYN_DROPPED;
>> @@ -194,6 +203,9 @@ static void __pass_event(struct evdev_client *client,
>>                */
>>               client->tail = (client->head - 2) & (client->bufsize - 1);
>>
>> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
>> +             client->buffer[client->tail].timestamp = event->timestamp;
>> +#endif
>>               client->buffer[client->tail].time = event->time;
>>               client->buffer[client->tail].type = EV_SYN;
>>               client->buffer[client->tail].code = SYN_DROPPED;
>> @@ -215,6 +227,9 @@ static void evdev_pass_values(struct evdev_client *client,
>>       struct evdev *evdev = client->evdev;
>>       const struct input_value *v;
>>       struct input_event event;
>> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
>> +     struct timespec64 ts;
>> +#endif
>>       bool wakeup = false;
>>
>>       if (client->revoked)
>> @@ -222,6 +237,10 @@ static void evdev_pass_values(struct evdev_client *client,
>>
>>       event.time = ktime_to_timeval(ev_time[client->clk_type]);
>>
>> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
>> +     ts = ktime_to_timespec64(ev_time[client->clk_type]);
>> +     event.timestamp = ts.tv_sec*NSEC_PER_SEC + ts.tv_nsec;
>
> Won't this overflow?
>
>> +#endif
>>       /* Interrupts are disabled, just acquire the lock. */
>>       spin_lock(&client->buffer_lock);
>>
>> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
>> index 905d90c..e0e47bb 100644
>> --- a/include/uapi/linux/input.h
>> +++ b/include/uapi/linux/input.h
>> @@ -26,6 +26,9 @@ struct input_event {
>>       __u16 type;
>>       __u16 code;
>>       __s32 value;
>> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
>> +     __s64 timestamp;
>> +#endif
>>  };
>>
>>  /*
>> --
>> 1.7.9.5
>>
>
> Thanks.
>
> --
> Dmitry
