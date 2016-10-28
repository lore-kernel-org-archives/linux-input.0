From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/4] input: Deprecate real timestamps beyond year 2106
Date: Fri, 28 Oct 2016 14:56:10 -0700
Message-ID: <CAKdAkRRXyz=uao_XdDVpG=BDsy+GA=bzkEKJabbs3Cd7ZG1mZA@mail.gmail.com>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com>
 <1960434.J8MW3Y2VCi@wuerfel> <CABeXuvro53b_h-L80idmB9G9U=WcdxHekCij4GYx7eVqxWVeNQ@mail.gmail.com>
 <3544660.FKrMrRAIUC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33759 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753480AbcJ1V4M (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Oct 2016 17:56:12 -0400
In-Reply-To: <3544660.FKrMrRAIUC@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>

On Fri, Oct 28, 2016 at 2:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday, October 28, 2016 2:39:35 PM CEST Deepa Dinamani wrote:
>> >> >> @@ -55,24 +60,24 @@ struct ff_effect_compat {
>> >> >>
>> >> >>  static inline size_t input_event_size(void)
>> >> >>  {
>> >> >> -       return (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) ?
>> >> >> -               sizeof(struct input_event_compat) : sizeof(struct input_event);
>> >> >> +       return in_compat_syscall() ? sizeof(struct raw_input_event_compat) :
>> >> >> +                                    sizeof(struct raw_input_event);
>> >> >>  }
>> >> >
>> >> > I think the COMPAT_USE_64BIT_TIME check has to stay here,
>> >> > it's needed for x32 mode on x86-64.
>> >>
>> >> There is no time_t anymore in the raw_input_event structure.
>> >> The struct uses __kernel_ulong_t type.
>> >> This should take care of x32 support.
>> >
>> > I don't think it does.
>> >
>> >> From this cover letter:
>> >> https://www.spinics.net/lists/linux-arch/msg16356.html
>> >>
>> >> I see that that the __kernel types were introduced to address the ABI
>> >> issues for x32.
>> >
>> > This is a variation of the problem we are trying to solve for
>> > the other architectures in your patch set:
>> >
>> > On x32, the kernel uses produces a structure with the 64-bit
>> > layout, using __u64 tv_sec, to match the current user space
>> > that has 64-bit __kernel_ulong_t and 64-bit time_t, but
>> > in_compat_syscall() also returns 'true' here, as this is
>> > mostly a 32-bit ABI (time_t being one of the exceptions).
>>
>> Yes, I missed this.
>>
>> in_compat_syscall() is true for x32, this would mean we end up here
>> even if it is a x32 syscall.
>> But, wouldn't it be better to use in_x32_syscall() here since there is
>> no timeval any more?
>
> We have to distinguish four cases on x86:
>
> - native 32-bit, input_event with 32-bit time_t
> - compat 32-bit, input_event_compat with 32-bit time_t
> - native 64-bit, input_event with 64-bit time_t
> - compat x32, input_event with 64-bit time_t
>
> The first three can happen on other architectures too,
> the last one is x86 specific. There are probably other ways
> to express the condition above, but I can't think of one
> that is better than the one we have today.

Can we detect if given task is compat x32, like we do for compat
64/32? Or entire userspace has to be x32?

Thanks.

-- 
Dmitry
