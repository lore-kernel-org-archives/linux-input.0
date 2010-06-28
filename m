From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 19:00:18 +0900
Message-ID: <4C2872B2.1030405@samsung.com>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
 <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com>
 <4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com>
 <4C285E85.6080008@euromail.se> <4C2865D0.7020605@samsung.com>
 <4C28689A.60701@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:60617 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab0F1KAv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 06:00:51 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4P00F6AYGI9ZC0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 19:00:18 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4P001LFYGI6E@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 19:00:18 +0900 (KST)
In-reply-to: <4C28689A.60701@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On 6/28/2010 6:17 PM, Henrik Rydberg wrote:
> Joonyoung Shim wrote:
>> On 6/28/2010 5:34 PM, Henrik Rydberg wrote:
>>> Joonyoung Shim wrote:
>>> [...]
>>>> I see, but i have something wondering at your document.
>>>>
>>>> This is your patch of "Document the MT event slot protocol"
>>>>
>>>> +Protocol Example A
>>>> +------------------
>>>> +
>>>> +Here is what a minimal event sequence for a two-contact touch would look
>>>> +like for a type A device:
>>>> +
>>>> +   ABS_MT_POSITION_X x[0]
>>>> +   ABS_MT_POSITION_Y y[0]
>>>> +   SYN_MT_REPORT
>>>> +   ABS_MT_POSITION_X x[1]
>>>> +   ABS_MT_POSITION_Y y[1]
>>>> +   SYN_MT_REPORT
>>>> +   SYN_REPORT
>>>>
>>>> +The sequence after moving one of the contacts looks exactly the same; the
>>>> +raw data for all present contacts are sent between every synchronization
>>>> +with SYN_REPORT.
>>>>
>>>> -Usage
>>>> ------
>>>> +Here is the sequence after lifting the first contact:
>>>> +
>>>> +   ABS_MT_POSITION_X x[1]
>>>> +   ABS_MT_POSITION_Y y[1]
>>>> +   SYN_MT_REPORT
>>>> +   SYN_REPORT
>>>> +
>>>> +And here is the sequence after lifting the second contact:
>>>> +
>>>> +   SYN_MT_REPORT
>>>> +   SYN_REPORT
>>>> +
>>>>
>>>> Here, there is no reporting for ABS_MT_POSITION_X/Y event, because that
>>>> is the last contact?
>>>> Then, the coordinates of the first contact are x[1] and y[1], right? If 
>>>> yes, it is some confusing, i think they are x[0] and y[0].
>>> It is a bit confusing I agree, but the document is correct. The empty
>>> input_mt_sync() is used when there is no data to report, no lifted fingers,
>>> nothing. Just imagine a device which gets polled periodically.
>>>
>> The thing i wondering is why reports x[1] and y[1] instead of x[0] and 
>> y[0] after lifting the first contact. I have understood the first 
>> contact are x[0] and y[0] and the second contact are x[1] and y[1].
> 
> Yes, after lifting the first contact, what remains is the second contact, which
> is the one getting reported. Again, stateless protocol. ;-)
> 

Do you mean to report the coordinates of contact __remaining__? You told 
me at first, "The position should be the position where the finger left
the surface", so i am confusing.
