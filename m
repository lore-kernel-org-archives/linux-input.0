From: Kim Kyuwon <q1.kim@samsung.com>
Subject: Re: [PATCH] Input: add MAX7359 key switch controller driver, v2
Date: Tue, 14 Jul 2009 12:09:36 +0900
Message-ID: <4A5BF6F0.6020403@samsung.com>
References: <4A04E5EA.7000103@samsung.com>
 <5d5443650905091027w2b60f2ael520373790e6414c7@mail.gmail.com>
 <4d34a0a70905101934j320c03abl7e39af4fbfdf1f62@mail.gmail.com>
 <20090511031208.GA15208@dtor-d630.eng.vmware.com>
 <5d5443650906191038o797e0c3eu8234a56ee247ea68@mail.gmail.com>
 <5d5443650907130152t420e9426q762c24bdb1b29aae@mail.gmail.com>
 <20090713093147.GJ10819@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17820 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbZGNDJh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 23:09:37 -0400
In-reply-to: <20090713093147.GJ10819@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Kim Kyuwon <chammoru@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Dmitry Torokhov wrote:
> On Mon, Jul 13, 2009 at 02:22:10PM +0530, Trilok Soni wrote:
>> Hi Dmitry,
>>
>>
>> I don't see this driver picked up yet in your -next branch. We should
>> target this driver to be mainlined in next merge window. This is very
>> important driver for some of the embedded systems, including palm pre
>> :)
>>
> 
> I was wondering if somebody could test the patch below and if it still
> works then I will apply to the next branch. Thanks!
> 

Dear Marek,

Because I don't have the NCP board(which includes the max7359 keypad) 
now, I can't test this patch. Marek, could you please test this patch?

Sincerely,
Kyuwon
