From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [Y2038] [PATCH v4 1/4] uinput: Use monotonic times for uinput timestamps.
Date: Thu, 14 Dec 2017 14:07:32 -0800
Message-ID: <CABeXuvpJFkEgSA-4WFWGDfGAYVjcwD30GbYP0xtzyREKPCfEJg@mail.gmail.com>
References: <20171207181306.5623-1-deepa.kernel@gmail.com> <20171207181306.5623-2-deepa.kernel@gmail.com>
 <1513286249.18523.280.camel@codethink.co.uk> <1513286332.18523.281.camel@codethink.co.uk>
 <CABeXuvpGRtp2fR3yW-eDyCOYpWfLReNytpew7kXD0xOxTEnZZw@mail.gmail.com> <1513288412.18523.285.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:44686 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752886AbdLNWHd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Dec 2017 17:07:33 -0500
In-Reply-To: <1513288412.18523.285.camel@codethink.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Peter Hutterer <peter.hutterer@who-t.net>, Arnd Bergmann <arnd@arndb.de>

On Thu, Dec 14, 2017 at 1:53 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Thu, 2017-12-14 at 13:44 -0800, Deepa Dinamani wrote:
>> On Thu, Dec 14, 2017 at 1:18 PM, Ben Hutchings
>> > <ben.hutchings@codethink.co.uk> wrote:
>> > On Thu, 2017-12-14 at 21:17 +0000, Ben Hutchings wrote:
>> > > On Thu, 2017-12-07 at 10:13 -0800, Deepa Dinamani wrote:
>> > > > struct timeval which is part of struct input_event to
>> > > > maintain the event times is not y2038 safe.
>> > > >
>> > > > Real time timestamps are also not ideal for input_event
>> > > > as this time can go backwards as noted in the patch
>> > > > a80b83b7b8 by John Stultz.
>> > > >
>> > > > The patch switches the timestamps to use monotonic time
>> > > > from realtime time. This is assuming no one is using
>> > > > absolute times from these timestamps.
>> > >
>> > > Why is this change not opt-in, as for evdev?  I assume there were
>> > > compatibility reasons for not changing evdev's clock by default, so I
>> > > would expect them to apply to uinput as well.  (But I'm also prepared
>> > > to believe that user-space is now generally compatible with and would
>> > > prefer monotonic time from all input devices.)
>> >
>> > Never mind, I've gone back and seen Arnd's comments about compatibility
>> > on v3.  It might be worth copying those into the commit message though.
>>
>> Commit message already talks about this assumption?:
>>
>> The patch switches the timestamps to use monotonic time
>> from realtime time. This is assuming no one is using
>> absolute times from these timestamps.
>
> Yes, but Arnd did a bit of code research to check that assumption.
> A commit message that says "we checked and it appears that no user-
> space depends on this" looks better than "I assume that no user-space
> depends on this".

The fact is we do not know all the places this is used. Arnd happened
to find an instance. This is why Dmitry suggested that we will provide
a ioctl or something if someone complains.
It is not my assumption. It is the assumption that the patch is based
on. This is to call people's attention to the fact that this is
controversial. And, if they do not agree with the assumption, they
should complain.
So it does not matter we found an instance where the assumption is true.

-Deepa
