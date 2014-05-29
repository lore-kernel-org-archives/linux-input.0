From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/3] Input: wacom - Don't declare ABS_X/Y for multitouch
Date: Thu, 29 May 2014 10:26:55 -0700
Message-ID: <CAF8JNh+0kO2W006N+rEvprfrjGNDA6gQ20GmWvYgPNYyPryjjQ@mail.gmail.com>
References: <1401232687-9738-1-git-send-email-pingc@wacom.com>
	<20140529070805.GB11817@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:58383 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbaE2R04 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 13:26:56 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so366160lab.25
        for <linux-input@vger.kernel.org>; Thu, 29 May 2014 10:26:55 -0700 (PDT)
In-Reply-To: <20140529070805.GB11817@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Ping Cheng <pingc@wacom.com>

On Thu, May 29, 2014 at 12:08 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, May 27, 2014 at 04:18:07PM -0700, Ping Cheng wrote:
>> We use ABS_MT_POSITION_X/Y for multitouch (touch_max > 1) events now.
>> No need to declare ABS_X/Y for touch_max == 2 any more.
>
> This will make legacy clients, such as GPM on text console,

I see your point. But, since copy_abs() is added in
input_mt_init_slots(), which copies ABS_MT_* parameters to ABS_* for
MT (all touch_max >= 2 devices), we do not need to duplicate the same
statements in individual drivers.

> very sad.

It won't upset legacy clients as long as they don't remove copy_abs()
from input-hid.c manually. However, you do have a very good point. It
made me review the relevant code where (touch_max == 2) again. I see
more cleanup needed. I'll make another patch for it.

Ping

>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> Reviewed-by: Jason Gerecke <killertofu@gmail.com>
>> Tested-by: Jason Gerecke <killertofu@gmail.com>
>> ---
>>  drivers/input/tablet/wacom_wac.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
>> index c98e51c..0eb9960 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -1217,8 +1217,8 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
>>                        * a=(pi*r^2)/C.
>>                        */
>>                       int a = data[5];
>> -                     int x_res  = input_abs_get_res(input, ABS_X);
>> -                     int y_res  = input_abs_get_res(input, ABS_Y);
>> +                     int x_res  = input_abs_get_res(input, ABS_MT_POSITION_X);
>> +                     int y_res  = input_abs_get_res(input, ABS_MT_POSITION_Y);
>>                       width  = 2 * int_sqrt(a * WACOM_CONTACT_AREA_SCALE);
>>                       height = width * y_res / x_res;
>>               }
>> @@ -1587,7 +1587,7 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
>>               input_abs_set_res(input_dev, ABS_X, features->x_resolution);
>>               input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
>>       } else {
>> -             if (features->touch_max <= 2) {
>> +             if (features->touch_max == 1) {
>>                       input_set_abs_params(input_dev, ABS_X, 0,
>>                               features->x_max, features->x_fuzz, 0);
>>                       input_set_abs_params(input_dev, ABS_Y, 0,
>> --
>> 1.9.1
>>
>
> --
> Dmitry
