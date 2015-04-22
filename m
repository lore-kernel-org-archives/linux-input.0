From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [PATCH] Input :Added Check for EV_ABS event params
Date: Wed, 22 Apr 2015 19:14:36 +0530
Message-ID: <CA+HOOsiwzjeazdzD3f4wWOe3BN67qDbUb+3_-RFZKxTqmy-pEQ@mail.gmail.com>
References: <aksgarg1989@gmail.com>
	<1429640392-30471-1-git-send-email-aksgarg1989@gmail.com>
	<20150421182916.GB16790@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35695 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635AbbDVNoh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2015 09:44:37 -0400
Received: by igbyr2 with SMTP id yr2so113799680igb.0
        for <linux-input@vger.kernel.org>; Wed, 22 Apr 2015 06:44:36 -0700 (PDT)
In-Reply-To: <20150421182916.GB16790@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "anshul.g@samsung.com" <anshul.g@samsung.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>

Hello Mr. Dmitry ,

On Tue, Apr 21, 2015 at 11:59 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Anshul,
>
> On Tue, Apr 21, 2015 at 11:19:52AM -0700, Anshul Garg wrote:
>> From: Anshul Garg <aksgarg1989@gmail.com>
>>
>> while handling EV_ABS event in input_handle_abs_event
>> function added check for out of range event value from
>> input driver. As input driver sets the ABS params at
>> registration time so input core should ignore events out
>> of the range set by the input driver.
>
> No, I do not think we want to do that, at least not unconditionally,
> especially since it is perfectly allowed to use 0 as min/max, which
> means that exact min and max are not defined. Historically min and max
> were provided to the userspace as a guidance and it was up to userspace
> to decide what to do with values outside of the limits.
>
> Thanks.

Thanks for the feedback.

Yes this check should not be added unconditionally as by default
min,max value will be zero.
If input driver has called input_set_abs_params function it means
both max,min will not be zero.

So we can add this check if at least one from min,max is non zero.

Moreover as per my understanding input driver will use this function
if it wants to control range of event value to be sent to user space or in case
fuzz logic to be applied on events sent from input driver.

Yes we can leave this decision on user space  but if out of range event
can be ignored at kernel layer it will save some operation from driver
perspective.

Thanks


>
>>
>> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
>> ---
>>  drivers/input/input.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index cc357f1..b1a6ff6 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -244,6 +244,11 @@ static int input_handle_abs_event(struct input_dev *dev,
>>               pold = NULL;
>>       }
>>
>> +     if (dev->absinfo[code].minimum > *pval || dev->absinfo[code].maximum < *pval) {
>> +             /* Ignore event with out of range values */
>> +             return INPUT_IGNORE_EVENT;
>> +     }
>> +
>>       if (pold) {
>>               *pval = input_defuzz_abs_event(*pval, *pold,
>>                                               dev->absinfo[code].fuzz);
>> --
>> 1.7.9.5
>>
>>
>> ---
>> This email has been checked for viruses by Avast antivirus software.
>> http://www.avast.com
>>
>
> --
> Dmitry
