From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 1/3] tps6507x-ts: update to devm_* API
Date: Wed, 1 Mar 2017 09:13:52 +0100
Message-ID: <CAGm1_kvVGZ9Ya19ibNU267NdXyVZdBqK9DegQCVbV5ed=fHpDg@mail.gmail.com>
References: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
 <1487950946-18590-2-git-send-email-yegorslists@googlemail.com> <20170228185746.GJ20776@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34716 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdCAIPr (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 03:15:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id m70so5924214wma.1
        for <linux-input@vger.kernel.org>; Wed, 01 Mar 2017 00:14:13 -0800 (PST)
In-Reply-To: <20170228185746.GJ20776@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, Andrey Skvortsov <andrej.skvortzov@gmail.com>

On Tue, Feb 28, 2017 at 7:57 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Feb 24, 2017 at 04:42:24PM +0100, yegorslists@googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Update the code to use devm_* API so that driver
>> core will manage resources.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>>  drivers/input/touchscreen/tps6507x-ts.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
>> index a340bfc..5bf1ec6 100644
>> --- a/drivers/input/touchscreen/tps6507x-ts.c
>> +++ b/drivers/input/touchscreen/tps6507x-ts.c
>> @@ -226,7 +226,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>>        */
>>       init_data = tps_board->tps6507x_ts_init_data;
>>
>> -     tsc = kzalloc(sizeof(struct tps6507x_ts), GFP_KERNEL);
>> +     tsc = devm_kzalloc(&pdev->dev, sizeof(struct tps6507x_ts), GFP_KERNEL);
>
> If you do this, why not use devm_input_allocate_polled_device() as well?
> Then you can get rid of tps6507x_ts_remove().

Will do. The less code the better.

Yegor
