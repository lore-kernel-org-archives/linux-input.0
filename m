From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [PATCH] Input/evdev: Add 64bit timestamp support
Date: Wed, 8 Jul 2015 01:59:33 +0530
Message-ID: <CA+HOOsjj1B3hs1wpYHS6Ee1N8bvoyy_fuavCVs+XqfF7QcMTuA@mail.gmail.com>
References: <aksgarg1989@gmail.com>
	<1436211224-59601-1-git-send-email-aksgarg1989@gmail.com>
	<20150706224802.GB32140@dtor-ws>
	<CA+HOOshg_UV7J25zBZFZiT4iUnihVJQnRj3MgKErQeSSg24yug@mail.gmail.com>
	<20150707181446.GF12491@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35533 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589AbbGGU3e (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2015 16:29:34 -0400
Received: by qkbp125 with SMTP id p125so148738212qkb.2
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2015 13:29:33 -0700 (PDT)
In-Reply-To: <20150707181446.GF12491@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Mr. Dmitry ,

Thanks for the replies.

Yes you are right there is not enough backup for
addition of this feature.
So we can skip it as of now.

Thanks

On Tue, Jul 7, 2015 at 11:44 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Anshul,
>
> On Tue, Jul 07, 2015 at 07:30:23PM +0530, Anshul Garg wrote:
>> Hello Mr. Dmitry ,
>>
>> On Tue, Jul 7, 2015 at 4:18 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > Hi Anshul,
>> >
>> > On Mon, Jul 06, 2015 at 12:33:44PM -0700, Anshul Garg wrote:
>> >> From: Anshul Garg <aksgarg1989@gmail.com>
>> >>
>> >> As per current implementation input driver can only
>> >> send ktime converted to timeval which user space again
>> >> have to convert.
>> >
>> > Why? ktime is kernel construct and thus userspace has no business using
>> > it directly.
>> >
>> As per current implementation , input subsystem fills the event timestamp
>> from ktime_get_real,ktme_get_mono depending upon clock type and then
>> converts it to timeval structure.
>>
>> Then user space program uses timevaltoNano api to get the event time.
>
> OK, so there is a [single?] program that uses some API that converts
> timeval to nanoseconds. I do not think we should be changing kernel,
> especially in an incompatible way, for the benefit of a single program.
>
>>
>> >> In some cases input drivers need 64bit timestamp value
>> >> from driver only so that same value can be used by upper
>> >> layer without any manipulation.
>> >
>> > Why do they need 64 bit value? What exactly is special about 64 bits? Do
>> > they need to know number of seconds since beginning of the universe?
>> >
>> > You need to specify the problem better instead of just saying we need 64
>> > bits.
>> >
>> Since currently event time is of type timeval and event handlers send the
>> time as per this format only.
>> By 64bit timestamp i am suggesting support for sending timestamp
>> directly obtained using api(ktime_get_real,ktime_get_boottime etc).
>>
>> I am thinking of following reasons.
>> 1. For every event sent from input subsystem user space has to convert
>> time again.[from timeval to ns] which can be avoided if we add the
>> functionality
>> of sending ktime to user space.
>
> Or you simply do not convert it to nanoseconds in userspace and use
> timeval that you got.
>
>>
>>
>> >> Proposed implementation is placed under CONFIG flag which
>> >> will not break any existing code.
>> >
>> > Yes, it does. As soon as somebody enables this option their usersoace
>> > will [potentially] break, because instead of timeval they will be
>> > getting 64 bit values.
>> >
>> > If we want to do this users will have to explicitly request such
>> > timestamps.
>> >
>> If someone enables this CONFIG option input subsystem will also send
>> timestamp [nanosec]value along with time[timeval].
>> So i think existing interface will not break.
>
> How can it possibly not break (without recompiling userspace) if you
> change the side of input_event structure? Do an experiment: install one
> of the latest Linux distributions (Fedora, Ubuntu), recompile the kernel
> with your change, and try booting it. See if your mouse works.
>
>>
>> Yes we can achieve this by providing ioctl from userspace.
>> So that user can decide which timestamp user needs from input subsystem
>
> Yes, ioctl might be a better option, but I still haven't hear a good
> reason for adding this feature.
>
> Thanks.
>
> --
> Dmitry
