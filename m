From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 21:58:10 +0900
Message-ID: <4C289C62.5090403@samsung.com>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
 <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com>
 <4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com>
 <4C285E85.6080008@euromail.se> <4C2865D0.7020605@samsung.com>
 <4C28689A.60701@euromail.se> <4C2872B2.1030405@samsung.com>
 <4C2877F3.8020003@euromail.se> <4C2883A9.5060305@samsung.com>
 <4C28944A.4050501@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55924 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab0F1M6M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 08:58:12 -0400
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4Q00BFS6OYIM50@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 21:58:10 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4Q00HPK6OYYS@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 21:58:10 +0900 (KST)
In-reply-to: <4C28944A.4050501@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On 6/28/2010 9:23 PM, Henrik Rydberg wrote:
> Joonyoung Shim wrote:
>> On 6/28/2010 7:22 PM, Henrik Rydberg wrote:
>>> Joonyoung Shim wrote:
>>> [...]
>>>> Do you mean to report the coordinates of contact __remaining__? You told 
>>>> me at first, "The position should be the position where the finger left
>>>> the surface", so i am confusing.
>>> The two comments do not apply to the same situation. The latter comment was made
>>> in the context of a tracking-capable device which sends one last event for a
>>> finger going away. Transformed to the stateless type A protocol, that results in
>>> (touch = 0, x = last value, y = last value). 
>>> The former comment was in the
>>> general context of the type A protocol, which has no notion of anything going
>>> away. After you lift a finger and look at the state, what you see is the
>>> remaining set of fingers.
>>>
>> OK, i see, but i think it needs to add the latter comment on MT protocol 
>> document to prevent some confusion.
>>
> 
> Something like this? Dmitry, would you please consider squashing this patch with
> the 5b version, if Joonyoung concurs?
> 
> Thanks,
> Henrik
> 
> ---
> 
> diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/
> index 3ab038d..bdcba15 100644
> --- a/Documentation/input/multi-touch-protocol.txt
> +++ b/Documentation/input/multi-touch-protocol.txt
> @@ -43,15 +43,16 @@ input_sync() function. This instructs the receiver to act up
>  accumulated since last EV_SYN/SYN_REPORT and prepare to receive a new set
>  of events/packets.
> 
> -The main difference between the raw type A protocol and the higher level
> -type B slot protocol lies in the usage of identifiable contacts. The slot
> -protocol requires the use of the ABS_MT_TRACKING_ID, either provided by the
> -hardware or computed from the raw data [5].
> +The main difference between the stateless type A protocol and the stateful
> +type B slot protocol lies in the usage of identifiable contacts to reduce
> +the amount of data sent to userspace. The slot protocol requires the use of
> +the ABS_MT_TRACKING_ID, either provided by the hardware or computed from
> +the raw data [5].
> 
>  For type A devices, the kernel driver should generate an arbitrary
> -enumeration of the set of anonymous contacts currently on the surface. The
> -order in which the packets appear in the event stream is not important.
> -Event filtering and finger tracking is left to user space [3].
> +enumeration of the full set of anonymous contacts currently on the
> +surface. The order in which the packets appear in the event stream is not
> +important.  Event filtering and finger tracking is left to user space [3].
> 

What is the full set of anonymous contacts? It needs the description of
case sending event for a finger going away.

>  For type B devices, the kernel driver should associate a slot with each
>  identified contact, and use that slot to propagate changes for the contact.
> 


