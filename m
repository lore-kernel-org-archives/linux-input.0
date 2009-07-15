From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v3] Input: add touchscreen driver for MELFAS MCS-5000
 controller
Date: Wed, 15 Jul 2009 16:51:15 +0900
Message-ID: <4A5D8A73.4040707@samsung.com>
References: <4A56A304.3050009@samsung.com>
 <20090714060403.GE2822@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43213 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbZGOHvR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 03:51:17 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KMT001PSCHF88@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 15 Jul 2009 16:51:16 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KMT00A84CHFY0@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 15 Jul 2009 16:51:15 +0900 (KST)
In-reply-to: <20090714060403.GE2822@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.fujak@samsung.com

On 7/14/2009 3:04 PM, Dmitry Torokhov wrote:
> Hi Joonyoung,
> 
> On Fri, Jul 10, 2009 at 11:10:12AM +0900, Joonyoung Shim wrote:
>> The MELPAS MCS-5000 is the touchscreen controller. The overview of this
>> controller can see at the following website:
>>
>> http://www.melfas.com/product/product01.asp?k_r=eng_
>>
>> This driver is tested on s3c6410 NCP board and supports only the i2c
>> interface.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> ---
>> Dear Dmitry,
>>
>> I sent the patch v2, but couldn't get any response.
>> This patch v3 is updated a little bit from v2.
>>
> 
> While I was sittign on the patch mainline acquired threaded IRQ support
> which fits the bill here and simplifies logic quite a bit, could you
> please try the patch below and tell me if the touchscreen still works?
> 

I've tested your patch, but it does not work. If i touch the pannel,
mcs5000_ts_hardirq is called once, but mcs5000_ts_interrupt is not
called, so the interrupt is not occurred any longer.

>> I have one question. The MCS-5000 controller don't support PRESSURE, so
>> i removed a fake PRESSURE report on driver, but tslib v1.0
>> (http://tslib.berlios.de) require the PRESSURE report from driver. I
>> wonder whether it is make sense to report a fake PRESSURE for tslib.
>>
> 
> I believe the adjustments to use BTN_TOUCH in absebse of ABS_PRESSURE
> has been applied to tslib, you need to talk to the maintainers about
> releasing updated version instead of adding fake events to the kernel.
> 

I see, thank you.

> Thanks.
> 

