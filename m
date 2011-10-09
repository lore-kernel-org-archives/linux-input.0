From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] input/imx_keypad: add pm suspend and resume functions
Date: Sun, 9 Oct 2011 17:47:34 +0800
Message-ID: <4E916DB6.1090203@gmail.com>
References: <1317369254-31146-1-git-send-email-jason77.wang@gmail.com> <4E857E25.4040503@cn.fujitsu.com> <4E858509.80303@gmail.com> <4E858668.2020203@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:35394 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1JIJsP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Oct 2011 05:48:15 -0400
In-Reply-To: <4E858668.2020203@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: Hui Wang <jason77.wang@gmail.com>, dmitry.torokhov@gmail.com, s.hauer@pengutronix.de, maramaopercheseimorto@gmail.com, linux-input@vger.kernel.org

Wanlong Gao wrote:
> On 09/30/2011 04:59 PM, Hui Wang wrote:
>
>   
>> Wanlong Gao wrote:
>>     
>>> On 09/30/2011 03:54 PM, Hui Wang wrote:
>>>
>>>   
>>>       
>>>> The imx_keypad driver is set wake capable in the imx_keypad_probe(),
>>>> but it doesn't implement suspend and reusme callback interface.
>>>>
>>>> >From the i.MX series MCU Reference Manual, the kpp (keypad port) is
>>>> a major wake up source which can detect any key press even in low
>>>> power modes and even when there is no clock.
>>>>
>>>> Now add suspend and resume callback functions for this driver.
>>>>
>>>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>>>> ---
>>>>         
>
>   
>>>   
>>>       
>> The i.MX series kpp is not like other normal kpps on other platforms, 
>> the kpp on the i.MX can detect key event and wake up system from low 
>> power mode even we disable kpp clock. So i choose to unconditionally 
>> disable its clock. I have explain it the commit header.
>>
>> "From the i.MX series MCU Reference Manual, the kpp (keypad port) is
>>
>> a major wake up source which can detect any key press even in low
>> power modes and even when there is no clock.
>> "
>>
>>     
>
>
> I see.
>
>   
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
>
>
> But is it need to hold a mutex lock also when *disable_irq_wake()* here ?
>   
Yes, this is a problem, i will address it in the V2.

Thanks,
Hui.
> Thanks
> -Wanlong Gao
>
>   

