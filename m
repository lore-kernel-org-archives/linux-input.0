From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: Add CLOCK_BOOTTIME Support
Date: Thu, 18 Dec 2014 05:12:29 +0530
Message-ID: <CADYu309vPvHYsK4CqUM1kw0eX3AYpqo47Hthh_xCkO+yyV4Pxw@mail.gmail.com>
References: <1418857674-6249-1-git-send-email-aniroop.mathur@gmail.com>
	<20141217231730.GA21713@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54653 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaLQXmb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 18:42:31 -0500
Received: by mail-la0-f46.google.com with SMTP id q1so86536lam.19
        for <linux-input@vger.kernel.org>; Wed, 17 Dec 2014 15:42:29 -0800 (PST)
In-Reply-To: <20141217231730.GA21713@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, a.mathur@samsung.com

Hello Mr. Torokhov,

On Thu, Dec 18, 2014 at 4:47 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Dec 18, 2014 at 04:37:54AM +0530, Aniroop Mathur wrote:
>> This patch adds support for CLOCK_BOOTTIME for input event timestamp.
>> CLOCK_BOOTTIME includes suspend time, so it would allow aplications
>> to get correct time difference between two events even when system
>> resumes from suspend state.
>>
>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>> ---
>>  drivers/input/evdev.c | 52 +++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 38 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index de05545..bfca214 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -28,6 +28,13 @@
>>  #include <linux/cdev.h>
>>  #include "input-compat.h"
>>
>> +enum evdev_clock_type {
>> +     EV_CLK_REAL = 0,
>> +     EV_CLK_MONO,
>> +     EV_CLK_BOOT,
>> +     EV_CLK_MAX
>> +};
>> +
>>  struct evdev {
>>       int open;
>>       struct input_handle handle;
>> @@ -49,12 +56,29 @@ struct evdev_client {
>>       struct fasync_struct *fasync;
>>       struct evdev *evdev;
>>       struct list_head node;
>> -     int clkid;
>> +     int clk_type;
>>       bool revoked;
>>       unsigned int bufsize;
>>       struct input_event buffer[];
>>  };
>>
>> +static int evdev_set_clk_type(int id, struct evdev_client *client)
>> +{
>> +     switch (id) {
>> +
>> +     case CLOCK_REALTIME:
>> +             client->clk_type = EV_CLK_REAL; break;
>> +     case CLOCK_MONOTONIC:
>> +             client->clk_type = EV_CLK_MONO; break;
>> +     case CLOCK_BOOTTIME:
>> +             client->clk_type = EV_CLK_BOOT; break;
>
> Please put "break" on separate lines.
>
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>  /* flush queued events of type @type, caller must hold client->buffer_lock */
>>  static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>  {
>> @@ -108,8 +132,9 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
>>       struct input_event ev;
>>       ktime_t time;
>>
>> -     time = (client->clkid == CLOCK_MONOTONIC) ?
>> -             ktime_get() : ktime_get_real();
>> +     time = (client->clk_type == EV_CLK_REAL) ?
>> +             ktime_get_real() : (client->clk_type == EV_CLK_MONO) ?
>> +             ktime_get() : ktime_get_boottime();
>>
>>       ev.time = ktime_to_timeval(time);
>>       ev.type = EV_SYN;
>> @@ -159,7 +184,7 @@ static void __pass_event(struct evdev_client *client,
>>
>>  static void evdev_pass_values(struct evdev_client *client,
>>                       const struct input_value *vals, unsigned int count,
>> -                     ktime_t mono, ktime_t real)
>> +                     ktime_t *ev_time)
>>  {
>>       struct evdev *evdev = client->evdev;
>>       const struct input_value *v;
>> @@ -169,8 +194,7 @@ static void evdev_pass_values(struct evdev_client *client,
>>       if (client->revoked)
>>               return;
>>
>> -     event.time = ktime_to_timeval(client->clkid == CLOCK_MONOTONIC ?
>> -                                   mono : real);
>> +     event.time = ktime_to_timeval(ev_time[client->clk_type]);
>>
>>       /* Interrupts are disabled, just acquire the lock. */
>>       spin_lock(&client->buffer_lock);
>> @@ -198,21 +222,22 @@ static void evdev_events(struct input_handle *handle,
>>  {
>>       struct evdev *evdev = handle->private;
>>       struct evdev_client *client;
>> -     ktime_t time_mono, time_real;
>> +     ktime_t ev_time[EV_CLK_MAX];
>>
>> -     time_mono = ktime_get();
>> -     time_real = ktime_mono_to_real(time_mono);
>> +     ev_time[EV_CLK_MONO] = ktime_get();
>> +     ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
>> +     ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_BOOT],
>> +                                              TK_OFFS_BOOT);
>
> Nope, that should have read
>
>         ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_BOOT],
>                                                  TK_OFFS_BOOT);
>

Ahhh... okay need to change BOOT to MONO

> Thanks.
>
>
> --
> Dmitry

Thanks for the corrections !!
I have sent the updated the patch with new changes done.

Regards,
Aniroop
