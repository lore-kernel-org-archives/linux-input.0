From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] input/imx_keypad: add pm suspend and resume functions
Date: Fri, 30 Sep 2011 16:59:53 +0800
Message-ID: <4E858509.80303@gmail.com>
References: <1317369254-31146-1-git-send-email-jason77.wang@gmail.com> <4E857E25.4040503@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51047 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538Ab1I3JAM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Sep 2011 05:00:12 -0400
In-Reply-To: <4E857E25.4040503@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: Hui Wang <jason77.wang@gmail.com>, dmitry.torokhov@gmail.com, s.hauer@pengutronix.de, maramaopercheseimorto@gmail.com, linux-input@vger.kernel.org

Wanlong Gao wrote:
> On 09/30/2011 03:54 PM, Hui Wang wrote:
>
>   
>> The imx_keypad driver is set wake capable in the imx_keypad_probe(),
>> but it doesn't implement suspend and reusme callback interface.
>>
>> >From the i.MX series MCU Reference Manual, the kpp (keypad port) is
>> a major wake up source which can detect any key press even in low
>> power modes and even when there is no clock.
>>
>> Now add suspend and resume callback functions for this driver.
>>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> ---
>> Validated this patch both on i.MX51 PDK and i.MX31 PDK
>>
>>  drivers/input/keyboard/imx_keypad.c |   42 +++++++++++++++++++++++++++++++++++
>>  1 files changed, 42 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
>> index d92c15c..9992617 100644
>> --- a/drivers/input/keyboard/imx_keypad.c
>> +++ b/drivers/input/keyboard/imx_keypad.c
>> @@ -567,10 +567,52 @@ static int __devexit imx_keypad_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_PM
>> +static int imx_kbd_suspend(struct device *dev)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct imx_keypad *kbd = platform_get_drvdata(pdev);
>> +
>> +	clk_disable(kbd->clk);
>> +
>> +	if (device_may_wakeup(&pdev->dev))
>> +		enable_irq_wake(kbd->irq);
>> +
>> +	return 0;
>> +}
>>     
>
> 	struct input_dev *input_dev = kbd->input_dev;
> 	if (device_may_wakeup(dev)) {
> 		enable_irq_wake(kdb->irq);
> 	} else {
> 		mutex_lock(&input_dev->mutex);
>
> 		if (input_dev->users)
> 			clk_disable(kbd->clk);
>
> 		mutex_unlock(&input_dev->mutex);
> 	}
>
> right?
>
>   
The i.MX series kpp is not like other normal kpps on other platforms, 
the kpp on the i.MX can detect key event and wake up system from low 
power mode even we disable kpp clock. So i choose to unconditionally 
disable its clock. I have explain it the commit header.

"From the i.MX series MCU Reference Manual, the kpp (keypad port) is

a major wake up source which can detect any key press even in low
power modes and even when there is no clock.
"

>> +
>> +static int imx_kbd_resume(struct device *dev)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct imx_keypad *kbd = platform_get_drvdata(pdev);
>> +	struct input_dev *input_dev = kbd->input_dev;
>> +
>> +	mutex_lock(&input_dev->mutex);
>> +
>> +	if (device_may_wakeup(&pdev->dev))
>> +		disable_irq_wake(kbd->irq);
>> +
>> +	if (input_dev->users)
>> +		clk_enable(kbd->clk);
>> +
>> +	mutex_unlock(&input_dev->mutex);
>> +
>> +	return 0;
>> +}
>>     
>
> 	struct input_dev *input_dev = kbd->input_dev;
> 	if (device_may_wakeup(dev)) {
> 		disable_irq_wake(kdb->irq);
> 	} else {
> 		mutex_lock(&input_dev->mutex);
>
> 		if (input_dev->users)
> 			clk_enable(kbd->clk);
>
> 		mutex_unlock(&input_dev->mutex);
> 	}
>
>   
So, if we unconditionally disable kpp clock in the suspend, we don't 
need above logic as well in the resume.
>> +
>> +static const struct dev_pm_ops imx_kbd_pm_ops = {
>>     
>
>
> SIMPLE_DEV_PM_OPS?
>   
Correct, i will use SIMPLE_DEV_PM_OPS in V2.

>
> Thanks
> -Wanlong Gao
>
>   

