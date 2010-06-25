From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Fri, 25 Jun 2010 15:32:10 +0200
Message-ID: <4C24AFDA.70601@euromail.se>
References: <1277298967-22596-1-git-send-email-jy0922.shim@samsung.com> <20100623173438.GB11512@core.coreip.homeip.net> <4C226959.3020806@euromail.se> <4C22B7B6.3040301@samsung.com> <4C2332FF.7040103@euromail.se> <4C2407BE.2050106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:41415 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab0FYNc0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jun 2010 09:32:26 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 3C1BCEB161
	for <linux-input@vger.kernel.org>; Fri, 25 Jun 2010 15:32:25 +0200 (CEST)
In-Reply-To: <4C2407BE.2050106@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Joonyoung Shim wrote:
> On 6/24/2010 7:27 PM, Henrik Rydberg wrote:
>> Joonyoung Shim wrote:
>> [...]
>>>> The finger[id].status is checked twice in this block, is there any particular
>>>> reason for it?
>>> There is three states press / release / none. The none state means that
>>> the finger weren't be pressed still. First checking is to detect none
>>> state and second checking is to distinguish press and release. Does it
>>> need to report the finger of none state?
>>>
>>>> Either way, reporting only a part of the finger properties before
>>>> input_mt_sync() is wrong. Perhaps one can move the second test up together with
>>>> the first one?
>>>>
>>> I don't know well what you mean. Please give me detailed thing.
>> The code has one patch where (ABS_MT_TRACKING_ID, ABS_MT_TOUCH_MAJOR) is
>> reported, and another patch where (ABS_MT_TRACKING_ID, ABS_MT_TOUCH_MAJOR,
>> ABS_MT_POSITION_X, ABS_MT_POSITION_Y) is reported. This is incorrect. Either
>> send the release event with ABS_MT_TOUCH_MAJOR set to zero, or do not report the
>> finger at all.
>>
> 
> OK. I had to remove ABS_MT_TRACKING_ID event to use MT protocol A.

Good idea. It _is_ ok to use the tracking id in protocol A, but it is not really
necessary. There are no bandwidth benefits, and the mtdev library handles the
tracking well in userspace.

[...]
>>> The ID value range can differ by chip firmware, but it can be calculated
>>> from 0 to 9. ID is decided by touch order. If i pressed three fingers,
>>> IDs ard 0, 1, 2.
>> In the MT protocol lingo, this is actually not a tracking id, but a slot id. A
>> tracking id increases for every new touch, and can be a much larger number than
>> the number of slots. Since the MT slot protocol is in the pipe now, perhaps you
>> would like to become the first driver to use the MT slots protocol? It seems it
>> would simplify the code of this driver.
>>
> 
> The ID of this chip is created in order, so i think the slot id and the
> tracking id have same relative offset. Now, i will use MT protocol A and
> i can change to MT slots protocol later if it is merged.

Sounds good.

Thanks,
Henrik

