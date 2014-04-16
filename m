From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [patch]GPIO button is supposed to wake the system up if the wakeup
 attribute is set
Date: Wed, 16 Apr 2014 18:05:26 +0530
Message-ID: <534E790E.2040401@nvidia.com>
References: <5345FDBD.9090908@linux.intel.com> <20140410114810.73e1d4b6@alan.etchedpixels.co.uk> <534C01DD.4010807@linux.intel.com> <534D282B.50301@nvidia.com> <534D5BEA.30906@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6914 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbaDPMfu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2014 08:35:50 -0400
In-Reply-To: <534D5BEA.30906@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tuesday 15 April 2014 09:48 PM, Li, Aubrey wrote:
> On 2014/4/15 20:38, Laxman Dewangan wrote:
>> On Monday 14 April 2014 09:12 PM, Li, Aubrey wrote:
>>> ping...
>>>
>>> On 2014/4/10 18:48, One Thousand Gnomes wrote:
>>>>
>> I think when we say irq_wake_enable() then based on underlying HW, it
>> should not turn off the irq if it is require for the wakeup. I mean it
>> need to be handle in the hw specific callbacks to keep enabling the
>> wakeup irq on suspend also.
> I failed to see why this can't be generic to all of the GPIO buttons for
> suspend wakeup. Do you see any cases broken by this proposal?

My point here is that if underlying HW needs to have irq enabled for 
wakup then it need to handle in centralized location i.e. the driver 
which is implementing it for the irq callbacks.
Otherwise, we need to change this on multiple places who needs wakeups 
which is vast in nature like sd driver for sdcard insert/remove etc. 
almost all drivers which need wakeups through GPIOs.

>> For me, I have key which is interrupt based from PMIC, not based on GPIO
>> and on that if I set it to IRQF_EARLY_RESUME then it works fine.
>>
> IRQF_NO_SUSPEND - Do not disable this IRQ during suspend
> IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
> resume time.
>
> IRQF_NO_SUSPEND is exactly what I want, instead of IRQF_EARLY_RESUME.
> Can you please send your proposal/code to help me understand why this
> has to hw specific and why IRQF_EARLY_RESUME is better than IRQF_NO_SUSPEND?

IRQF_EARLY_RESUME helps to re-enable mask or irq before parent interrupt 
resume and so parent isr handler sees the irq flag enabled when it try 
to scan source of interrupt. Otherwise parent isr handler treat this as 
spurious interrupt and does not call handler as irq flag disabled for that.

This only happen when on resume, parent inettrupt enabled before the 
child interrupt on irq resume. Because as soon as parent isr re-enabled 
on resume, its hadnler get called before actually child interrupt 
enabled. This is what I observed mainly on PMIC and its sub irq. Not 
observed on SoC level of interrupts.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
