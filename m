From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 2/3] input: evdev: Replace timeval with timespec64
Date: Tue, 2 Jan 2018 16:35:41 +0100
Message-ID: <CAK8P3a0EEGtSJ6g1JWwkZWaKTDFNN=q-ZQXcmzK4q3-xiBC+4Q@mail.gmail.com>
References: <20171218051844.10193-1-deepa.kernel@gmail.com>
 <20171218051844.10193-3-deepa.kernel@gmail.com> <20180102064617.zmv6ospfkectaa37@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42079 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeABPfm (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 10:35:42 -0500
In-Reply-To: <20180102064617.zmv6ospfkectaa37@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, y2038 Mailman List <y2038@lists.linaro.org>

On Tue, Jan 2, 2018 at 7:46 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Dec 17, 2017 at 09:18:43PM -0800, Deepa Dinamani wrote:
>> @@ -304,12 +314,11 @@ static void evdev_events(struct input_handle *handle,
>>  {
>>       struct evdev *evdev = handle->private;
>>       struct evdev_client *client;
>> -     ktime_t ev_time[EV_CLK_MAX];
>> +     struct timespec64 ev_time[EV_CLK_MAX];
>>
>> -     ev_time[EV_CLK_MONO] = ktime_get();
>> -     ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
>> -     ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_MONO],
>> -                                              TK_OFFS_BOOT);
>> +     ktime_get_ts64(&ev_time[EV_CLK_MONO]);
>> +     ktime_get_real_ts64(&ev_time[EV_CLK_REAL]);
>> +     get_monotonic_boottime64(&ev_time[EV_CLK_BOOT]);
>
> This may result in different ev_time[] members holding different times,
> whereas the original code would take one time sample and convert it to
> different clocks.

Is this important? On each client we only return one of the two
times, and I would guess that you cannot rely on a correlation
between timestamps on different devices, since the boot and real
offsets can change over time.

> Also, why can't we keep using ktime_t internally? It is y2038 safe,
> right?

Correct, but there may also be a performance difference if we get
a lot of events, not sure if that matters.

> I think you should drop this patch and adjust the 3rd one to
> massage the input event timestamp patch to do ktime->timespec64->input
> timestamp conversion.

The change in __evdev_queue_syn_dropped still seems useful to me
as ktime_get_*ts64() is a bit more efficient than ktime_get*() followed by
a slow ktime_to_timespec64() or ktime_to_timeval().

For evdev_events(), doing a single ktime_get() followed by a
ktime_to_timespec64/ktime_to_timeval can be faster than three
ktime_get_*ts64 (depending on the hardware clock source), or
it can be slower depending on the CPU and the clocksource
hardware. Again, no idea if this matters at the usual rate of
input events.

I guess dropping the evdev_events() change and replacing it with a
ktime_to_timespec64 change in evdev_pass_values()
would be fine here, it should keep the current performance
behavior and get rid of the timeval.

       Arnd
