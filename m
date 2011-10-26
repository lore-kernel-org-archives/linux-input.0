From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v2] input/imx_keypad: add pm suspend and resume functions
Date: Wed, 26 Oct 2011 16:41:41 +0800
Message-ID: <4EA7C7C5.3000803@gmail.com>
References: <1318472013-32517-1-git-send-email-jason77.wang@gmail.com> <20111026075800.GW23421@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:56831 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab1JZInj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Oct 2011 04:43:39 -0400
In-Reply-To: <20111026075800.GW23421@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, dmitry.torokhov@gmail.com, maramaopercheseimorto@gmail.com, gaowanlong@cn.fujitsu.com, linux-input@vger.kernel.org

Sascha Hauer wrote:
> On Thu, Oct 13, 2011 at 10:13:33AM +0800, Hui Wang wrote:
>   
>> The imx_keypad driver is set wake capable in the imx_keypad_probe(),
>> but it doesn't implement suspend and reusme callback interface.
>>
>> From the i.MX series MCU Reference Manual, the kpp (keypad port) is
>> a major wake up source which can detect any key press even in low
>> power modes and even when there is no clock.
>>
>> Now add suspend and resume callback functions for this driver.
>>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> ---
>>
>> Sorry for resending this patch, the previous sent patch with [v2]
>> as a prefix, i am afraid that patch was filtered out from mailing list.
>> Now resending this patch with [PATCH v2] as a prefix.
>>
>> In the V2:
>> 1) add a check for input->users before disable clock.
>> 2) add mutex_lock/unlock to protect input->users checking.
>> 3) use SIMPLE_DEV_PM_OPS.
>>
>>  drivers/input/keyboard/imx_keypad.c |   46 +++++++++++++++++++++++++++++++++++
>>  1 files changed, 46 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
>> index d92c15c..c43fa97 100644
>> --- a/drivers/input/keyboard/imx_keypad.c
>> +++ b/drivers/input/keyboard/imx_keypad.c
>> @@ -567,10 +567,56 @@ static int __devexit imx_keypad_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_PM
>> +static int imx_kbd_suspend(struct device *dev)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct imx_keypad *kbd = platform_get_drvdata(pdev);
>> +	struct input_dev *input_dev = kbd->input_dev;
>> +
>> +	/* imx kbd can wake up system even clock is disabled */
>> +	mutex_lock(&input_dev->mutex);
>> +
>> +	if (input_dev->users)
>> +		clk_disable(kbd->clk);
>> +
>> +	mutex_unlock(&input_dev->mutex);
>> +
>> +	if (device_may_wakeup(&pdev->dev))
>> +		enable_irq_wake(kbd->irq);
>>     
>
> enable_irq_wake can fail. More specifically it *will* fail on all non
> tzic i.MX boards as this function is not yet implemented for the avic
> irq controller.
> You should check the return value.
>
>   
Hi Sascha,

I have sent a patch to change plat-mxc/avic.c to use generic irq chip, 
in this patch, two lines to handle wakeup_set issues:

gc->wake_enabled = IRQ_MSK(32);
ct->chip.irq_set_wake = irq_gc_set_wake;

These two lines will make enable_irq_wake successful unconditionally.

And i recall you have sent this patch to Arnd through a pull request.

Thanks,
Hui.
> Sascha
>
>
>
>   

