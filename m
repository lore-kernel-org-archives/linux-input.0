From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v3 3/4] input: Deprecate real timestamps beyond year 2106
Date: Mon, 4 Dec 2017 12:40:06 -0800
Message-ID: <CABeXuvp11s5Myx+9ZUYRbR6aU+O43mp=bW-YGXs7KW579Kmxxw@mail.gmail.com>
References: <20171204005545.23325-1-deepa.kernel@gmail.com>
 <20171204005545.23325-4-deepa.kernel@gmail.com> <CAK8P3a1QYnRe3qYv7sTLCZ7dJMEdw=VVb+Kjv6iMCprbhj-Y7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:41145 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdLDUkH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 4 Dec 2017 15:40:07 -0500
In-Reply-To: <CAK8P3a1QYnRe3qYv7sTLCZ7dJMEdw=VVb+Kjv6iMCprbhj-Y7w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>

On Mon, Dec 4, 2017 at 6:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Dec 4, 2017 at 1:55 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> struct timeval is not y2038 safe.
>> All usage of timeval in the kernel will be replaced by
>> y2038 safe structures.
>> The change is also necessary as glibc is introducing support
>> for 32 bit applications to use 64 bit time_t. Without this
>> change, many applications would incorrectly interpret values
>> in the struct input_event.
>> More details about glibc at
>> https://sourceware.org/glibc/wiki/Y2038ProofnessDesign .
>>
>> struct input_event maintains time for each input event.
>> Real time timestamps are not ideal for input as this
>> time can go backwards as noted in the patch a80b83b7b8
>> by John Stultz. Hence, having the input_event.time fields
>> only big enough for monotonic and boot times are
>> sufficient.
>>
>> The change leaves the representation of struct input_event as is
>> on 64 bit architectures. But uses 2 unsigned long values on 32 bit
>> machines to support real timestamps until year 2106.
>> This intentionally breaks the ABI on 32 bit architectures and
>> compat handling on 64 bit architectures.
>> This is as per maintainer's preference to introduce compile time errors
>> rather than run into runtime incompatibilities.
>>
>> The change requires any 32 bit userspace utilities reading or writing
>> from event nodes to update their reading format to match the new
>> input_event. The changes to the popular libraries will be posted once
>> we agree on the kernel change.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> This all looks good, I just have one small request:
>
>> -
>>  struct input_event {
>> +#if __BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)
>>         struct timeval time;
>> +#define input_event_sec time.tv_sec
>> +#define input_event_usec time.tv_usec
>> +#else
>> +       __kernel_ulong_t __sec;
>> +       __kernel_ulong_t __usec;
>> +#define input_event_sec  __sec
>> +#define input_event_usec __usec
>> +#endif
>
> As we are getting closer to removing references to 'struct timeval'
> from the kernel, could you rephrase that conditional to
>
> #if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL)

Thanks. Will do.

I just noticed that I left out the change to uinput for this patch. I
will include that in the update as well.

-Deepa
