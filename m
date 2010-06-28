From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 11:17:14 +0200
Message-ID: <4C28689A.60701@euromail.se>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com> <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com> <4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com> <4C285E85.6080008@euromail.se> <4C2865D0.7020605@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:40441 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab0F1JSI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 05:18:08 -0400
In-Reply-To: <4C2865D0.7020605@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Joonyoung Shim wrote:
> On 6/28/2010 5:34 PM, Henrik Rydberg wrote:
>> Joonyoung Shim wrote:
>> [...]
>>> I see, but i have something wondering at your document.
>>>
>>> This is your patch of "Document the MT event slot protocol"
>>>
>>> +Protocol Example A
>>> +------------------
>>> +
>>> +Here is what a minimal event sequence for a two-contact touch would look
>>> +like for a type A device:
>>> +
>>> +   ABS_MT_POSITION_X x[0]
>>> +   ABS_MT_POSITION_Y y[0]
>>> +   SYN_MT_REPORT
>>> +   ABS_MT_POSITION_X x[1]
>>> +   ABS_MT_POSITION_Y y[1]
>>> +   SYN_MT_REPORT
>>> +   SYN_REPORT
>>>
>>> +The sequence after moving one of the contacts looks exactly the same; the
>>> +raw data for all present contacts are sent between every synchronization
>>> +with SYN_REPORT.
>>>
>>> -Usage
>>> ------
>>> +Here is the sequence after lifting the first contact:
>>> +
>>> +   ABS_MT_POSITION_X x[1]
>>> +   ABS_MT_POSITION_Y y[1]
>>> +   SYN_MT_REPORT
>>> +   SYN_REPORT
>>> +
>>> +And here is the sequence after lifting the second contact:
>>> +
>>> +   SYN_MT_REPORT
>>> +   SYN_REPORT
>>> +
>>>
>>> Here, there is no reporting for ABS_MT_POSITION_X/Y event, because that
>>> is the last contact?
>>> Then, the coordinates of the first contact are x[1] and y[1], right? If 
>>> yes, it is some confusing, i think they are x[0] and y[0].
>> It is a bit confusing I agree, but the document is correct. The empty
>> input_mt_sync() is used when there is no data to report, no lifted fingers,
>> nothing. Just imagine a device which gets polled periodically.
>>
> 
> The thing i wondering is why reports x[1] and y[1] instead of x[0] and 
> y[0] after lifting the first contact. I have understood the first 
> contact are x[0] and y[0] and the second contact are x[1] and y[1].

Yes, after lifting the first contact, what remains is the second contact, which
is the one getting reported. Again, stateless protocol. ;-)

> 
>> [...]
>>>> I see. And you want BTN_TOUCH to follow the logic for the single touch? I think
>>>> that is the main issue here. We can have _one_ of the following definitions, but
>>>> not both:
>>>>
>>>> 1. input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
>>>>
>>> OK, i will use this. This was original code.
>>>
>>>> 2. input_report_key(input_dev, BTN_TOUCH,
>>>>                     finger[single_id].status != QT602240_RELEASE);
>>>>
>>>> If you use the latter, there should be another event to denote the finger_num ==
>>>> 0 case. This line at the end should do it:
>>>>
>>>> if (finger_num == 0)
>>>> 	input_mt_sync(input_dev);
>>>>
>>> I don't know why this needs?
>> The general reason is the one given above. Since you are going with the first
>> option, it won't be needed.
>>
> 
> But, input_mt_sync is reported already with reporting of ABS_MT_POSITION_X/Y.
> I meant the case of single touch reporting.

Yes. I meant there should be at least one event when all fingers are up. Since
you report ABS_MT_TOUCH_MAJOR = 0 for every finger going up, this is already
guaranteed, and you can disregard my last comment.

Thanks,
Henrik
