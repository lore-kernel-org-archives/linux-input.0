From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 1/4] uinput: Add ioctl for using monotonic/ boot times
Date: Thu, 15 Sep 2016 10:11:38 -0700
Message-ID: <CABeXuvpOqBvnUSjMrGBLuQc8C+ELm3TPJR63U36GvJ-F7Zv0Jg@mail.gmail.com>
References: <1473775805-2242-1-git-send-email-deepa.kernel@gmail.com>
 <1473775805-2242-2-git-send-email-deepa.kernel@gmail.com> <2791498.1bf6TGcxHc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36149 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbcIORLk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Sep 2016 13:11:40 -0400
In-Reply-To: <2791498.1bf6TGcxHc@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>

On Tue, Sep 13, 2016 at 8:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, September 13, 2016 7:10:02 AM CEST Deepa Dinamani wrote:
>> --- a/drivers/input/misc/uinput.c
>> +++ b/drivers/input/misc/uinput.c
>> @@ -46,11 +46,28 @@ static int uinput_dev_event(struct input_dev *dev,
>>                             unsigned int type, unsigned int code, int value)
>>  {
>>         struct uinput_device    *udev = input_get_drvdata(dev);
>> +       struct timespec64       ts;
>> +       ktime_t kt;
>>
>>         udev->buff[udev->head].type = type;
>>         udev->buff[udev->head].code = code;
>>         udev->buff[udev->head].value = value;
>> -       do_gettimeofday(&udev->buff[udev->head].time);
>> +
>> +       kt = ktime_get();
>> +       switch (udev->clk_type) {
>> +       case CLOCK_REALTIME:
>> +               ts = ktime_to_timespec64(ktime_mono_to_real(kt));
>> +               break;
>> +       case CLOCK_MONOTONIC:
>> +               ts = ktime_to_timespec64(kt);
>> +               break;
>> +       case CLOCK_BOOTTIME:
>> +               ts = ktime_to_timespec64(ktime_mono_to_any(kt, TK_OFFS_BOOT));
>> +               break;
>> +       }
>> +
>> +       udev->buff[udev->head].time.tv_sec = ts.tv_sec;
>> +       udev->buff[udev->head].time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
>>
>
> This is a bit inefficient. I think it's better to use
> ktime_get_real_ts64(), ktime_get_ts64() and get_monotonic_boottime64().

Right. The way I have is using sequence counters twice, once for ktime_get()
and then again for offset.

> I see that we do the same thing in evdev_events(), so maybe that isn't
> overly critical though. Or we might want to change both.
>
> The last one of these also uses the slow ktime_to_timespec64(), but
> that is something we can improve later in the common code.

Yes, I tried to keep it same as evdev here.
But, evdev itself has a couple of different ways of doing this:

For instance, __evdev_queue_syn_dropped() uses

time = client->clk_type == EV_CLK_REAL ?
            ktime_get_real() :
            client->clk_type == EV_CLK_MONO ?
                ktime_get() :
                ktime_get_boottime();

I can change all this to look the same.

I will wait until I hear if this approach is ok for input events.
I will post an update to series after.

Thanks,
Deepa
