From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] input/imx_keypad: add pm suspend and resume functions
Date: Sun, 9 Oct 2011 17:49:57 +0800
Message-ID: <4E916E45.4050201@gmail.com>
References: <1317369254-31146-1-git-send-email-jason77.wang@gmail.com> <4E857E25.4040503@cn.fujitsu.com> <4E858509.80303@gmail.com> <20110930091229.GA21336@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:35606 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1JIJuN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Oct 2011 05:50:13 -0400
In-Reply-To: <20110930091229.GA21336@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hui Wang <jason77.wang@gmail.com>, gaowanlong@cn.fujitsu.com, s.hauer@pengutronix.de, maramaopercheseimorto@gmail.com, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Fri, Sep 30, 2011 at 04:59:53PM +0800, Hui Wang wrote:
>   
>> Wanlong Gao wrote:
>>     
>>> On 09/30/2011 03:54 PM, Hui Wang wrote:
>>>       
>>>> +
>>>> +static int imx_kbd_resume(struct device *dev)
>>>> +{
>>>> +	struct platform_device *pdev = to_platform_device(dev);
>>>> +	struct imx_keypad *kbd = platform_get_drvdata(pdev);
>>>> +	struct input_dev *input_dev = kbd->input_dev;
>>>> +
>>>> +	mutex_lock(&input_dev->mutex);
>>>> +
>>>> +	if (device_may_wakeup(&pdev->dev))
>>>> +		disable_irq_wake(kbd->irq);
>>>> +
>>>> +	if (input_dev->users)
>>>> +		clk_enable(kbd->clk);
>>>> +
>>>> +	mutex_unlock(&input_dev->mutex);
>>>> +
>>>> +	return 0;
>>>> +}
>>>>         
>>> 	struct input_dev *input_dev = kbd->input_dev;
>>> 	if (device_may_wakeup(dev)) {
>>> 		disable_irq_wake(kdb->irq);
>>> 	} else {
>>> 		mutex_lock(&input_dev->mutex);
>>>
>>> 		if (input_dev->users)
>>> 			clk_enable(kbd->clk);
>>>
>>> 		mutex_unlock(&input_dev->mutex);
>>> 	}
>>>
>>>       
>> So, if we unconditionally disable kpp clock in the suspend, we don't
>> need above logic as well in the resume.
>>     
>
> We should not unconditionally disable clock in suspend, you need to check
> if there are any users (or drop check in resume), otherwise you'll get
> unbalanced count in clk (suspend - decrement, resume - not enabling clk
> if device is not being used).
>
> Also locking is needed in suspend.
>
>   
Got it, will fix them in the V2.

Thanks,
Hui.
> Thanks.
>
>   

