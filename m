From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 3/4] input: Deprecate real timestamps beyond year 2106
Date: Fri, 28 Oct 2016 08:19:46 -0700
Message-ID: <CABeXuvra9faVw1z_0Bjwp5znO5y+6y0fSJ29AuBWt2A-cRLtrg@mail.gmail.com>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com>
 <1476761253-13450-4-git-send-email-deepa.kernel@gmail.com> <5347568.3SpFZiqxSr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33312 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbcJ1PTr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Oct 2016 11:19:47 -0400
In-Reply-To: <5347568.3SpFZiqxSr@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>

On Fri, Oct 28, 2016 at 5:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, October 17, 2016 8:27:32 PM CEST Deepa Dinamani wrote:
>> @@ -55,24 +60,24 @@ struct ff_effect_compat {
>>
>>  static inline size_t input_event_size(void)
>>  {
>> -       return (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) ?
>> -               sizeof(struct input_event_compat) : sizeof(struct input_event);
>> +       return in_compat_syscall() ? sizeof(struct raw_input_event_compat) :
>> +                                    sizeof(struct raw_input_event);
>>  }
>
> I think the COMPAT_USE_64BIT_TIME check has to stay here,
> it's needed for x32 mode on x86-64.

There is no time_t anymore in the raw_input_event structure.
The struct uses __kernel_ulong_t type.
This should take care of x32 support.

>From this cover letter:
https://www.spinics.net/lists/linux-arch/msg16356.html

I see that that the __kernel types were introduced to address the ABI
issues for x32.

-Deepa
