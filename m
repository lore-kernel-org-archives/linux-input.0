From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v2] Input: ads7846 - Replace spinlock by mutex to wrap
 disable()/enable()
Date: Fri, 03 Sep 2010 10:47:04 +0800
Message-ID: <4C8061A8.2080408@gmail.com>
References: <1282370340-3157-1-git-send-email-jason77.wang@gmail.com> <4C7491D7.1030801@gmail.com> <20100901064841.GH23585@core.coreip.homeip.net> <4C7E25E2.90904@gmail.com> <20100901164818.GA6908@core.coreip.homeip.net> <20100902160132.GD16914@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:42889 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003Ab0ICCnq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 22:43:46 -0400
In-Reply-To: <20100902160132.GD16914@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jason Wang <jason77.wang@gmail.com>, notasas@gmail.com, vapier@gentoo.org, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Wed, Sep 01, 2010 at 09:48:18AM -0700, Dmitry Torokhov wrote:
>   
>> On Wed, Sep 01, 2010 at 06:07:30PM +0800, Jason Wang wrote:
>>     
>>> Dmitry Torokhov wrote:
>>>       
>>>> Hi Jason,
>>>>
>>>> On Wed, Aug 25, 2010 at 11:45:27AM +0800, Jason Wang wrote:
>>>>         
>>>>> Hi dmitry and others,
>>>>>
>>>>> could you please to help me review this patch?
>>>>>
>>>>> Thanks,
>>>>> Jason.
>>>>>
>>>>> Jason Wang wrote:
>>>>>           
>>>>>> The commit 9114337 introduces regulator operations in the ads7846
>>>>>> touchscreen driver. Among these operations, some are called in the
>>>>>> spinlock protected context.
>>>>>> On most platforms, the regulator operation is achieved through
>>>>>> i2c/spi bus transfer operations, some bus transfer operations will
>>>>>> call wait_for_completion function. It isn't allowable  to call
>>>>>> sleepable function in the atomic context. So replace the spinlock with
>>>>>> mutex to protect ads7846_disable()/ads7846_enable().
>>>>>>
>>>>>>             
>>>> I am afraid the patch is not correct. ads7846_disable() and
>>>> ads7846_enable() check and modify flags (such as irq_disabled and
>>>> pending) that are also accessed form timer/interrupt context. Moving to
>>>> mutex removes the serialization that used to be there.
>>>>         
>>> Thanks for your comments. you are right it is dangerous and
>>> unreasonable to use different locks to protect a critical resource.
>>>       
>>>> I wonder if we should start by converting the driver to used threaded
>>>> IRQ model with "long playing" interrupt handler so all access happens in
>>>> process context and shutdown sequence is simplified.
>>>>         
>>> It can solve most issues, but it can't solve this situation. Because
>>> here the atomic region in which conflicts happened is from spin_lock
>>> instead of irq handler.
>>>
>>>       
>> Right, but switching to threaded IRQ will allow to use mutex in place
>> of the spinlock everywhere.
>>
>>     
>
> I wonder if the following patch works (or can be made to work)...
>
>   
OK, i will test it on ti_omap3530evm, and give out the result.

