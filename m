From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 4/4] input: serio: Replace timeval by timespec64
Date: Thu, 15 Sep 2016 10:21:02 -0700
Message-ID: <CABeXuvo+hFgP_pbOPd+X6RXUdqdpN-iDDYwE=z+0djnJtq3yig@mail.gmail.com>
References: <1473775805-2242-1-git-send-email-deepa.kernel@gmail.com>
 <1473775805-2242-5-git-send-email-deepa.kernel@gmail.com> <2982423.lGps9KTD1c@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36445 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbcIORVE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Sep 2016 13:21:04 -0400
In-Reply-To: <2982423.lGps9KTD1c@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>

On Tue, Sep 13, 2016 at 8:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, September 13, 2016 7:10:05 AM CEST Deepa Dinamani wrote:
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
>>
>> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>>
>
> Looks all correct to me,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> I think it could be done a little nicer using ktime_get()
> instead of ktime_get_ts64(), but probably nobody cares with
> this driver.

I tried to keep the processing same as timeval.
This could be changed to ktime_get() if that is preferred.

-Deepa
