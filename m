From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Fri, 25 Jun 2010 10:34:54 +0900
Message-ID: <4C2407BE.2050106@samsung.com>
References: <1277298967-22596-1-git-send-email-jy0922.shim@samsung.com>
 <20100623173438.GB11512@core.coreip.homeip.net> <4C226959.3020806@euromail.se>
 <4C22B7B6.3040301@samsung.com> <4C2332FF.7040103@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:27216 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab0FYBe5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jun 2010 21:34:57 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4J00J1BR271C10@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Fri, 25 Jun 2010 10:34:55 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4J008C2R2791@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Fri, 25 Jun 2010 10:34:55 +0900 (KST)
In-reply-to: <4C2332FF.7040103@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On 6/24/2010 7:27 PM, Henrik Rydberg wrote:
> Joonyoung Shim wrote:
> [...]
>>> The finger[id].status is checked twice in this block, is there any particular
>>> reason for it?
>> There is three states press / release / none. The none state means that
>> the finger weren't be pressed still. First checking is to detect none
>> state and second checking is to distinguish press and release. Does it
>> need to report the finger of none state?
>>
>>> Either way, reporting only a part of the finger properties before
>>> input_mt_sync() is wrong. Perhaps one can move the second test up together with
>>> the first one?
>>>
>> I don't know well what you mean. Please give me detailed thing.
> 
> The code has one patch where (ABS_MT_TRACKING_ID, ABS_MT_TOUCH_MAJOR) is
> reported, and another patch where (ABS_MT_TRACKING_ID, ABS_MT_TOUCH_MAJOR,
> ABS_MT_POSITION_X, ABS_MT_POSITION_Y) is reported. This is incorrect. Either
> send the release event with ABS_MT_TOUCH_MAJOR set to zero, or do not report the
> finger at all.
> 

OK. I had to remove ABS_MT_TRACKING_ID event to use MT protocol A.

>>>>> +
>>>>> +			input_mt_sync(input_dev);
>>>>> +		}
>>>>> +
>>>>> +		if (!finger_num)
>>>>> +			input_report_key(input_dev, BTN_TOUCH, 0);
>>> The lines above can be combined with the first BTN_TOUCH instance to something
>>> like this:
>>>
>>> 	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
>>>
>>> The input core will not emit the key unless it actually changes.
>>>
>> I have a quick question. If finger_num is more than one, should 
>> BTN_TOUCH be reported before ABS_XX event reporting?
> 
> BTN_TOUCH should be placed first for the benefit of mousedev (is this correct,
> Dmitry?), but there is no restriction on the ordering between MT events and
> other events in the package.
> 

OK.

>>>>> +		input_sync(input_dev);
>>>>> +	} else {
>>>>> +		qt602240_dump_message(dev, &message);
>>>>> +		qt602240_check_config_error(data, &message, reportid);
>>>>> +	}
>>>>> +
>>>>> +	goto repeat;
>>> [...]
>>>>> +	__set_bit(EV_ABS, input_dev->evbit);
>>>>> +	__set_bit(EV_KEY, input_dev->evbit);
>>>>> +	__set_bit(BTN_TOUCH, input_dev->keybit);
>>>>> +
>>>>> +	/* For single touch */
>>>>> +	input_set_abs_params(input_dev, ABS_X, 0, QT602240_MAX_XC, 0,
>>>>> +			0);
>>>>> +	input_set_abs_params(input_dev, ABS_Y, 0, QT602240_MAX_YC, 0,
>>>>> +			0);
>>>>> +
>>>>> +	/* For multi touch */
>>>>> +	input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0,
>>>>> +			QT602240_MAX_ID, 0, 0);
>>> What is a normal value for QT602240_MAX_ID? Is it modified every time there is a
>>> new touch?
>>>
>> The ID value range can differ by chip firmware, but it can be calculated
>> from 0 to 9. ID is decided by touch order. If i pressed three fingers,
>> IDs ard 0, 1, 2.
> 
> In the MT protocol lingo, this is actually not a tracking id, but a slot id. A
> tracking id increases for every new touch, and can be a much larger number than
> the number of slots. Since the MT slot protocol is in the pipe now, perhaps you
> would like to become the first driver to use the MT slots protocol? It seems it
> would simplify the code of this driver.
> 

The ID of this chip is created in order, so i think the slot id and the
tracking id have same relative offset. Now, i will use MT protocol A and
i can change to MT slots protocol later if it is merged.

Thanks.
