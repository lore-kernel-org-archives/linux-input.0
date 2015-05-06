From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Add driver for mouse logitech M560
Date: Wed, 6 May 2015 09:27:01 -0400
Message-ID: <CAN+gG=EhehbJV3O981Ru8z96j3DkuNQ5SvMJvzoKrwsBcnLz5Q@mail.gmail.com>
References: <1430469813-3303-1-git-send-email-kreijack@libero.it>
	<20150505173659.b07a6c178996018bb43120b0@ao2.it>
	<20150506084814.3937e2e816eab76bd0012a55@ao2.it>
	<20150506093558.c479b8499fb63c5f9b05cc31@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:34518 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbbEFN1B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2015 09:27:01 -0400
Received: by qcyk17 with SMTP id k17so4337501qcy.1
        for <linux-input@vger.kernel.org>; Wed, 06 May 2015 06:27:01 -0700 (PDT)
In-Reply-To: <20150506093558.c479b8499fb63c5f9b05cc31@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Goffredo Baroncelli <kreijack@libero.it>, linux-input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, Goffredo Baroncelli <kreijack@inwind.it>

On Wed, May 6, 2015 at 3:35 AM, Antonio Ospite <ao2@ao2.it> wrote:
> On Wed, 6 May 2015 08:48:14 +0200
> Antonio Ospite <ao2@ao2.it> wrote:
>
>> On Tue, 5 May 2015 17:36:59 +0200
>> Antonio Ospite <ao2@ao2.it> wrote:
>>
>> > On Fri,  1 May 2015 10:43:33 +0200
>> > Goffredo Baroncelli <kreijack@libero.it> wrote:
>> >
>> [...]
>> > > + /* exit if the data is not a mouse related report */
>> > > + if (data[0] != 0x02 && data[2] != M560_SUB_ID)
>> >
>> > What are the possible values of data[0] that you observed?
>> > Can it only be 0x02 and 0x11?
>> >
>> > If we wanted to be stricter we could anticipate the full validation and
>> > then simplify the ifs below to just check the report type, something
>> > like:
>> >
>> >     bool valid_mouse_report;
>> >     ...
>> >
>> >     valid_mouse_report = (data[0] == 0x02 ||
>> >                           (data[0] == REPORT_ID_HIDPP_LONG &&
>> >                            data[2] == M560_SUB_ID &&
>> >                            data[6] == 0x00))
>> >
>> >     if (!valid_mouse_report)
>> >             return 0;
>> >
>> >     if (data[0] == REPORT_ID_HIDPP_LONG) {
>> >             ...
>> >     } else /* if (data[0] == 0x02) */ {
>> >             ...
>> >     }
>> >
>> > but maybe this is overkill.
>> >
>>
>> Or maybe just using an else, without the preventive validation, would
>> already improve readability, checking things only once:
>>
>>       if (data[0] == REPORT_ID_HIDPP_LONG &&
>>           data[2] == M560_SUB_ID && data[6] == 0x00) {
>>               ...
>>       } else if (data[0] == 0x02) {
>>               ...
>>       } else {
>>               /* unsupported report */
>>               return 0;
>>       }
>>
>
> If the function returns 0 at the end, then the else here is even
> redundant.
>
> We may return 1 at the end of the function to differentiate between "no
> action performed (0)" and "no further processing (1)" like stated in
> include/linux/hid.h line 661, even if I don't see the core handling the
> difference between the two return values when calling the raw_event
> callback.
>
> Benjamin, can you comment about what the convention is here? I am

As you saw, we used to care, but we don't anymore. "no further
processing (1)" is now simply ignored and nobody took the time to fix
it properly. The last change which introduced that was b1a1442 ("HID:
core: fix reporting of raw events"), and it fixed a real problem. But
that means that we simply ignore the positive return value.

There may be a chance that we fix that in the future (I have too much
on my plate right now), so I would advice to follow the documentation
even if it is not entirely true anymore.

> referring also to the checks at the begin of m560_raw_event().

Again, there is no strict rule. The less operations you do, the better
it is (it will be called at each report, so potentially can add a lot
of head over).  Also the clearer it is, the better. That's why I am
often tempted to add extra functions for each type of processing with
a clear "return m560_process_hidpp_report()". Something like that :)

>
> Thanks,
>    Antonio

Cheers,
Benjamin
