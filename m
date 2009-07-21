From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v3] Input: add touchscreen driver for MELFAS MCS-5000
 controller
Date: Tue, 21 Jul 2009 21:15:43 +0900
Message-ID: <4A65B16F.7010902@samsung.com>
References: <4A56A304.3050009@samsung.com>
 <20090714060403.GE2822@dtor-d630.eng.vmware.com>
 <4A5D8A73.4040707@samsung.com>
 <20090715153001.GD21611@dtor-d630.eng.vmware.com>
 <4A655253.7050501@samsung.com> <20090721074508.GA9778@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58704 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464AbZGUMPq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 08:15:46 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KN400ENOSQ7VL@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 21 Jul 2009 21:15:43 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KN400IE6SQ70B@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Tue, 21 Jul 2009 21:15:43 +0900 (KST)
In-reply-to: <20090721074508.GA9778@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.fujak@samsung.com

On 7/21/2009 4:45 PM, Dmitry Torokhov wrote:
> On Tue, Jul 21, 2009 at 02:29:55PM +0900, Joonyoung Shim wrote:
>> On 7/16/2009 12:30 AM, Dmitry Torokhov wrote:
>>> On Wed, Jul 15, 2009 at 04:51:15PM +0900, Joonyoung Shim wrote:
>>>> On 7/14/2009 3:04 PM, Dmitry Torokhov wrote:
>>>>> Hi Joonyoung,
>>>>>
>>>>> On Fri, Jul 10, 2009 at 11:10:12AM +0900, Joonyoung Shim wrote:
>>>>>> The MELPAS MCS-5000 is the touchscreen controller. The overview of this
>>>>>> controller can see at the following website:
>>>>>>
>>>>>> http://www.melfas.com/product/product01.asp?k_r=eng_
>>>>>>
>>>>>> This driver is tested on s3c6410 NCP board and supports only the i2c
>>>>>> interface.
>>>>>>
>>>>>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>>>>>> ---
>>>>>> Dear Dmitry,
>>>>>>
>>>>>> I sent the patch v2, but couldn't get any response.
>>>>>> This patch v3 is updated a little bit from v2.
>>>>>>
>>>>> While I was sittign on the patch mainline acquired threaded IRQ support
>>>>> which fits the bill here and simplifies logic quite a bit, could you
>>>>> please try the patch below and tell me if the touchscreen still works?
>>>>>
>>>> I've tested your patch, but it does not work. If i touch the pannel,
>>>> mcs5000_ts_hardirq is called once, but mcs5000_ts_interrupt is not
>>>> called, so the interrupt is not occurred any longer.
>>>>
>>> Hmm, wierd... I guess since threaded IRQs are pretty new there could be
>>> some issues there.
>>>
>> I wonder, are there drivers using the threaded IRQs at present?
>> I want to refer another driver but i can't find it.
> 
> I have drivers/input/misc/dm355evm_keys.c in my tree.

I found it.

> 
> Anyways, I reviewed the code again and the problem with both patches is
> that we should not be disabling IRQ in the hard IRQ handler as it
> inhibits running the thread, so we need to move disable_irq_nosync to be
> the very first thing we do in the threaded handler.
> 

This has one problem.

The MCS5000 detects interrupt at low level. After interrupt occurs, the 
interrupt signal of the MCS5000 maintains the low level. It needs an i2c
operation to change to high the interrupt signal.

If we do disbling IRQ in the threaded handler instead of the hard IRQ
handler, the interrupt occurs infinitely because the interrupt signal is
low.

I have tested your new patch, and it appeared above result. It will 
maybe need a dummy i2c operation in the hard IRQ handler, but the i2c
operation cannot use in the IRQ handler.

> Updated patch below; please give it a spin. If it works the MAX driver
> will need the same adjustment.
> 

I'm not sure about the MAX7359 keypad driver, but I think we need some
thing disabling IRQ in hard IRQ handler to change to driver using
threaded irq.
