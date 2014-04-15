From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [patch]GPIO button is supposed to wake the system up if the wakeup
 attribute is set
Date: Tue, 15 Apr 2014 18:08:03 +0530
Message-ID: <534D282B.50301@nvidia.com>
References: <5345FDBD.9090908@linux.intel.com> <20140410114810.73e1d4b6@alan.etchedpixels.co.uk> <534C01DD.4010807@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12319 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbaDOMiY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2014 08:38:24 -0400
In-Reply-To: <534C01DD.4010807@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Monday 14 April 2014 09:12 PM, Li, Aubrey wrote:
> ping...
>
> On 2014/4/10 18:48, One Thousand Gnomes wrote:
>> On Thu, 10 Apr 2014 10:11:09 +0800
>> "Li, Aubrey" <aubrey.li@linux.intel.com> wrote:
>>
>>> When the wakeup attribute is set, GPIO button is supposed to set
>>> irqflag - IRQF_NO_SUSPEND to request irq. So when the system enters
>>> the suspend sleep mode, the GPIO irq keeps enabled and is able to
>>> wake the system up.
>>>

I think when we say irq_wake_enable() then based on underlying HW, it 
should not turn off the irq if it is require for the wakeup. I mean it 
need to be handle in the hw specific callbacks to keep enabling the 
wakeup irq on suspend also.
For me, I have key which is interrupt based from PMIC, not based on GPIO 
and on that if I set it to IRQF_EARLY_RESUME then it works fine.



-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
