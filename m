From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [Y2038] [PATCH v4 4/4] input: serio: Replace timeval by timespec64
Date: Sat, 16 Dec 2017 13:37:09 -0800
Message-ID: <CABeXuvqkahAH3e-Tdt3n9GgG+r=xJNB4+VqZcea4EtKJONG9MQ@mail.gmail.com>
References: <20171207181306.5623-1-deepa.kernel@gmail.com> <20171207181306.5623-5-deepa.kernel@gmail.com>
 <1513287928.18523.283.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:46702 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756888AbdLPVhL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 16 Dec 2017 16:37:11 -0500
In-Reply-To: <1513287928.18523.283.camel@codethink.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Peter Hutterer <peter.hutterer@who-t.net>, Arnd Bergmann <arnd@arndb.de>

On Thu, Dec 14, 2017 at 1:45 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Thu, 2017-12-07 at 10:13 -0800, Deepa Dinamani wrote:
>> struct timeval is not y2038 safe.
>> All references to timeval will be deleted from the
>> kernel to make it y2038 safe.
>> Replace its uses by y2038 safe struct timespec64.
>>
>> The timestamps changed here only keep track of delta
>> times. These timestamps are also internal to kernel.
>> Hence, monotonic times are sufficient here.
>> The unit of the delta times is also changed in certain
>> cases to nanoseconds rather than microseconds. This is
>> in line with timespec64 which keeps time in nanoseconds.
> [...]
>> --- a/drivers/input/serio/hil_mlc.c
>> +++ b/drivers/input/serio/hil_mlc.c
> [...]
>> @@ -466,7 +466,7 @@ static const struct hilse_node hil_mlc_se[HILSEN_END] = {
>>       FUNC(hilse_init_lcv, 0, HILSEN_NEXT,    HILSEN_SLEEP,   0)
>>
>>       /* 1  HILSEN_RESTART */
>> -     FUNC(hilse_inc_lcv, 10, HILSEN_NEXT,    HILSEN_START,  0)
>> +     FUNC(hilse_inc_lcv, 10000,      HILSEN_NEXT,    HILSEN_START,  0)
> [...]
>
> The second macro argument here ends up as the second argument to
> hilse_inc_lcv() which appears to limit the number of retries, not a
> time limit.  So I don't think the value here (or wherever else
> hilse_inc_lcv is referenced) should be changed.

I think I misread the code here.

> The EXPECT, EXPECT_LAST etc. macros take a timeout ('to' parameter)
> which is then assigned to hil_mlc::intimeout, so it seems that those
> *should* be scaled up, but this patch doesn't do that.  It also doesn't
> change the type of hil_mlc::intimeout (suseconds_t implying units of
> microseconds) or the comment on hilse_node::arg.

Yes, I have overlooked the suseconds_t here. So apart from what you
point out IN() and a few other things should also be fixed.

I will drop this patch and repost the series as Arnd mentioned he
already posted a version of this patch. The series can go in without
it and if we prefer my version here, I can submit the patch alone.

Thanks,
-Deepa
