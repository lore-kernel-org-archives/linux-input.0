From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [patch]GPIO button is supposed to wake the system up if the wakeup
 attribute is set
Date: Fri, 18 Apr 2014 01:48:54 +0800
Message-ID: <53501406.6010702@linux.intel.com>
References: <5345FDBD.9090908@linux.intel.com> <20140410114810.73e1d4b6@alan.etchedpixels.co.uk> <534C01DD.4010807@linux.intel.com> <534D282B.50301@nvidia.com> <534D5BEA.30906@linux.intel.com> <534E790E.2040401@nvidia.com> <53500470.8090009@linux.intel.com> <53500CEB.9060405@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31197 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbaDQRs4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2014 13:48:56 -0400
In-Reply-To: <53500CEB.9060405@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 2014/4/18 1:18, Laxman Dewangan wrote:
> On Thursday 17 April 2014 10:12 PM, Li, Aubrey wrote:
>> On 2014/4/16 20:35, Laxman Dewangan wrote:
>>> On Tuesday 15 April 2014 09:48 PM, Li, Aubrey wrote:
>>>> On 2014/4/15 20:38, Laxman Dewangan wrote:
>>>>> On Monday 14 April 2014 09:12 PM, Li, Aubrey wrote:
>>>>>> ping...
>>>>>>
>>>>>> On 2014/4/10 18:48, One Thousand Gnomes wrote:
>>>>> I think when we say irq_wake_enable() then based on underlying HW, it
>>>>> should not turn off the irq if it is require for the wakeup. I mean it
>>>>> need to be handle in the hw specific callbacks to keep enabling the
>>>>> wakeup irq on suspend also.
>>>> I failed to see why this can't be generic to all of the GPIO buttons
>>>> for
>>>> suspend wakeup. Do you see any cases broken by this proposal?
>>> My point here is that if underlying HW needs to have irq enabled for
>>> wakup then it need to handle in centralized location i.e. the driver
>>> which is implementing it for the irq callbacks.
>>> Otherwise, we need to change this on multiple places who needs wakeups
>>> which is vast in nature like sd driver for sdcard insert/remove etc.
>>> almost all drivers which need wakeups through GPIOs.
>> I think we have to handle this driver by driver. I didn't see how can we
>> make it in a centralized location. Looking forward to see your proposal.
> 
> For Tegra SoC, we have implemented this such that we keep re-enabe
> interrupts when going to suspend. That's why my point is.
> May be your SoC ha implemented on different way and hence it is require
> NO_SUSPEND.
> 
> I do not have any negative remark here, I jut kept my point here.

I see. thanks for your point.

> 
>> This is expected behavior. I think I still need IRQF_NO_SUSPEND here.
>> What I want is, this IRQ is able to generate pm wakeup event to wake the
>> system up. It's enough for my case.
>>
>> Did you see a failing case of my patch?
> 
> Nop, I have not tested the patch and I think it will not break anything
> for me with your patch.

Good to hear it.

Thanks,
-Aubrey

> 
> 
> 
> -----------------------------------------------------------------------------------
> 
> This email message is for the sole use of the intended recipient(s) and
> may contain
> confidential information.  Any unauthorized review, use, disclosure or
> distribution
> is prohibited.  If you are not the intended recipient, please contact
> the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> 
> 
> 

