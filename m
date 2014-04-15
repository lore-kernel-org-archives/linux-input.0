From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [patch]GPIO button is supposed to wake the system up if the wakeup
 attribute is set
Date: Wed, 16 Apr 2014 00:18:50 +0800
Message-ID: <534D5BEA.30906@linux.intel.com>
References: <5345FDBD.9090908@linux.intel.com> <20140410114810.73e1d4b6@alan.etchedpixels.co.uk> <534C01DD.4010807@linux.intel.com> <534D282B.50301@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20869 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbaDOQSz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2014 12:18:55 -0400
In-Reply-To: <534D282B.50301@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 2014/4/15 20:38, Laxman Dewangan wrote:
> On Monday 14 April 2014 09:12 PM, Li, Aubrey wrote:
>> ping...
>>
>> On 2014/4/10 18:48, One Thousand Gnomes wrote:
>>> On Thu, 10 Apr 2014 10:11:09 +0800
>>> "Li, Aubrey" <aubrey.li@linux.intel.com> wrote:
>>>
>>>> When the wakeup attribute is set, GPIO button is supposed to set
>>>> irqflag - IRQF_NO_SUSPEND to request irq. So when the system enters
>>>> the suspend sleep mode, the GPIO irq keeps enabled and is able to
>>>> wake the system up.
>>>>
> 
> I think when we say irq_wake_enable() then based on underlying HW, it
> should not turn off the irq if it is require for the wakeup. I mean it
> need to be handle in the hw specific callbacks to keep enabling the
> wakeup irq on suspend also.

I failed to see why this can't be generic to all of the GPIO buttons for
suspend wakeup. Do you see any cases broken by this proposal?

> For me, I have key which is interrupt based from PMIC, not based on GPIO
> and on that if I set it to IRQF_EARLY_RESUME then it works fine.
> 
IRQF_NO_SUSPEND - Do not disable this IRQ during suspend
IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
resume time.

IRQF_NO_SUSPEND is exactly what I want, instead of IRQF_EARLY_RESUME.
Can you please send your proposal/code to help me understand why this
has to hw specific and why IRQF_EARLY_RESUME is better than IRQF_NO_SUSPEND?

Thanks,
-Aubrey


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
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

