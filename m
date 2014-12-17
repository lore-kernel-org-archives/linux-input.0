From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: Add support for CLOCK_BOOTTIME
Date: Thu, 18 Dec 2014 04:41:44 +0530
Message-ID: <CADYu30_Xe5jUVO88sgBXXoqMwbETZOh+EXYdmbqv0iyfVp0aMw@mail.gmail.com>
References: <1418748994-2875-1-git-send-email-aniroop.mathur@gmail.com>
	<20141217182011.GA32399@dtor-ws>
	<CADYu30_n-mc8X8h+v4PX7Mq9TSyKY1Hh=zEeKBcHMDrikB9xmA@mail.gmail.com>
	<20141217220323.GB32399@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:41149 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaLQXLq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 18:11:46 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so47562lab.34
        for <linux-input@vger.kernel.org>; Wed, 17 Dec 2014 15:11:44 -0800 (PST)
In-Reply-To: <20141217220323.GB32399@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, a.mathur@samsung.com, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>

Hello Mr. Torokhov,


On Thu, Dec 18, 2014 at 3:33 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Dec 18, 2014 at 03:03:26AM +0530, Aniroop Mathur wrote:
>> Hello Mr. Torokhov,
>>
>> On Wed, Dec 17, 2014 at 11:50 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > Hi Aniroop,
>> >
>> > On Tue, Dec 16, 2014 at 10:26:34PM +0530, Aniroop Mathur wrote:
>> >> This patch adds support for CLOCK_BOOTTIME for input event timestamp.
>> >> CLOCK_BOOTTIME includes suspend time, so it would allow aplications
>> >> to get correct time difference between two events even when system
>> >> resumes from suspend state.
>> >>
>> >> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>> >> ---
>> >>  drivers/input/evdev.c | 33 +++++++++++++++++++++------------
>> >>  1 file changed, 21 insertions(+), 12 deletions(-)
>> >>
>> >> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> >> index de05545..7825794 100644
>> >> --- a/drivers/input/evdev.c
>> >> +++ b/drivers/input/evdev.c
>> >> @@ -28,6 +28,13 @@
>> >>  #include <linux/cdev.h>
>> >>  #include "input-compat.h"
>> >>
>> >> +enum clock_type {
>> >> +     REAL = 0,
>> >> +     MONO,
>> >> +     BOOT,
>> >> +     CLK_MAX
>> >> +};
>> >> +
>> >>  struct evdev {
>> >>       int open;
>> >>       struct input_handle handle;
>> >> @@ -108,8 +115,9 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
>> >>       struct input_event ev;
>> >>       ktime_t time;
>> >>
>> >> -     time = (client->clkid == CLOCK_MONOTONIC) ?
>> >> -             ktime_get() : ktime_get_real();
>> >> +     time = (client->clkid == CLOCK_REALTIME) ?
>> >> +             ktime_get_real() : (client->clkid == CLOCK_MONOTONIC) ?
>> >> +             ktime_get() : ktime_get_boottime();
>> >>
>>
>> Is this okay ?
>> To improve readabilty,
>> how about adding a new funtion to get time depending upon clkid like below ?
>> time = get_clk_time(client->clkid);
>>
>> static ktime_t get_clk_time(int id)
>> {
>>         switch (id) {
>>
>>         case CLOCK_REALTIME:     return ktime_get_real();
>>         case CLOCK_MONOTONIC: return ktime_get();
>>         case CLOCK_BOOTTIME:    return ktime_get_bootime();
>>         }
>> }
>
> Just open-code it in evdev_queue_syn_dropped() since there is only place
> where we call it. And use clk_type instead of clock id-.
>
>>
>> >>       ev.time = ktime_to_timeval(time);
>> >>       ev.type = EV_SYN;
>> >> @@ -159,7 +167,7 @@ static void __pass_event(struct evdev_client *client,
>> >>
>> >>  static void evdev_pass_values(struct evdev_client *client,
>> >>                       const struct input_value *vals, unsigned int count,
>> >> -                     ktime_t mono, ktime_t real)
>> >> +                     ktime_t *ev_time)
>> >>  {
>> >>       struct evdev *evdev = client->evdev;
>> >>       const struct input_value *v;
>> >> @@ -169,8 +177,9 @@ static void evdev_pass_values(struct evdev_client *client,
>> >>       if (client->revoked)
>> >>               return;
>> >>
>> >> -     event.time = ktime_to_timeval(client->clkid == CLOCK_MONOTONIC ?
>> >> -                                   mono : real);
>> >> +     event.time = ktime_to_timeval(client->clkid == CLOCK_REALTIME ?
>> >> +                     ev_time[REAL] : client->clkid == CLOCK_MONOTONIC ?
>> >> +                     ev_time[MONO] : ev_time[BOOT]);
>> >
>> > This becomes unwieldy. Should we have client->clk_type instead of
>> > client->clkid and convert CLOCK_* into your EVDEV_CLK_{REAL|MONO|BOOT}
>> > when setting it in ioctl and then do
>> >
>> >         event.time = ktime_to_timeval(ev_time[client->clk_offset]);
>> >
>>
>> Sure, using clk_type would be better and improve code readability.
>>
>> I am afraid how converting CLOCK_* into your
>> EVDEV_CLK_{REAL|MONO|BOOT} will help
>> because we cannot have ev_time array size more than CLK_MAX (3).
>>
>> Did you mean to have following changes:
>>
>> 1. Add clk_type variable
>> struct evdev_client {
>>          int clkid:
>>       + int clk_type;
>> }
>
> I meant replacing clkid with clk_type in evdev_client.
>
>>
>> 2. Add new funtion for setting clk_type to improve readability
>> static int set_clk_type(struct evdev_client *client, int id)
>
>
> evdev_set_clk_type() to keep with the style.
>
>> {
>>         switch (id) {
>>
>>         case CLOCK_REALTIME:     client->clk_type = EV_REAL;  break;
>>         case CLOCK_MONOTONIC: client->clk_type = EV_MONO; break;
>>         case CLOCK_BOOTTIME:    client->clk_type = EV_BOOT;  break;
>>         default: return -1
>
> -EINVAL here, otherwise yes.
>
>>         }
>>
>>         return 0;
>> }
>>
>> 3. Addition in ioctl call
>>     case EVIOCSCLOCKID:
>>     ...
>>     if (!set_clk_type())
>>            return -EINVAL;
>>
>
>         error = evdev_set_clktype(i);
>         if (error)
>                 return error;
>
>>      client->clkid = i;
>
> Drop this.
>
>>      return 0;
>>
>> 4. Change in evdev_pass_values function
>> event.time = ktime_to_timeval(ev_time[client->clk_type]);
>
> Yes.
>
>>
>> >>
>> >>       /* Interrupts are disabled, just acquire the lock. */
>> >>       spin_lock(&client->buffer_lock);
>> >> @@ -198,21 +207,21 @@ static void evdev_events(struct input_handle *handle,
>> >>  {
>> >>       struct evdev *evdev = handle->private;
>> >>       struct evdev_client *client;
>> >> -     ktime_t time_mono, time_real;
>> >> +     ktime_t ev_time[CLK_MAX];
>> >>
>> >> -     time_mono = ktime_get();
>> >> -     time_real = ktime_mono_to_real(time_mono);
>> >> +     ev_time[MONO] = ktime_get();
>> >> +     ev_time[REAL] = ktime_mono_to_real(ev_time[MONO]);
>> >> +     ev_time[BOOT] = ktime_get_boottime();
>> >
>> > I do not think we want to use ktime_get_boottime() here; I'd rather you
>> > use ktime_mono_to_anY(ev_time[MONO], TK_OFFS_BOOT) so that all 3 times
>> > are consistent.
>> >
>>
>> Sure. I will send the updated patch with this change.
>>
>> >>
>> >>       rcu_read_lock();
>> >>
>> >>       client = rcu_dereference(evdev->grab);
>> >>
>> >>       if (client)
>> >> -             evdev_pass_values(client, vals, count, time_mono, time_real);
>> >> +             evdev_pass_values(client, vals, count, ev_time);
>> >>       else
>> >>               list_for_each_entry_rcu(client, &evdev->client_list, node)
>> >> -                     evdev_pass_values(client, vals, count,
>> >> -                                       time_mono, time_real);
>> >> +                     evdev_pass_values(client, vals, count, ev_time);
>> >>
>> >>       rcu_read_unlock();
>> >>  }
>> >> @@ -874,7 +883,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>> >>       case EVIOCSCLOCKID:
>> >>               if (copy_from_user(&i, p, sizeof(unsigned int)))
>> >>                       return -EFAULT;
>> >> -             if (i != CLOCK_MONOTONIC && i != CLOCK_REALTIME)
>> >> +             if (i != CLOCK_MONOTONIC && i != CLOCK_REALTIME && i != CLOCK_BOOTTIME)
>> >>                       return -EINVAL;
>> >>               client->clkid = i;
>> >>               return 0;
>> >> --
>> >> 1.9.1
>> >>
>> >
>> > Thanks.
>> >
>> > --
>> > Dmitry
>>
>> Thanks,
>> Aniroop Mathur
>
> --
> Dmitry

Thanks for the suggestions !!
I have sent you the updated patch with new changes done.

Thanks,
Aniroop
