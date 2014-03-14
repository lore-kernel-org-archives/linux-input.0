From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH v3 2/4] mfd: max8997: handle IRQs using regmap
Date: Fri, 14 Mar 2014 09:33:35 +0100
Message-ID: <5322BEDF.4080408@samsung.com>
References: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
 <1394703532-494-3-git-send-email-r.baldyga@samsung.com>
 <53218C30.9000707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:20295 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374AbaCNIdk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Mar 2014 04:33:40 -0400
In-reply-to: <53218C30.9000707@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com

On 03/13/2014 11:45 AM, Chanwoo Choi wrote:
> Hi Robert,
> 
> On 03/13/2014 06:38 PM, Robert Baldyga wrote:
>> This patch modifies mfd driver to use regmap for handling interrupts.
>> It allows to simplify irq handling process. This modifications needed
>> to make small changes in function drivers, which use interrupts.
>>
>> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

(...)

>> @@ -468,8 +560,11 @@ static int max8997_suspend(struct device *dev)
>>  	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
>>  	struct max8997_dev *max8997 = i2c_get_clientdata(i2c);
>>  
>> -	if (device_may_wakeup(dev))
>> -		irq_set_irq_wake(max8997->irq, 1);
>> +	if (device_may_wakeup(dev)) {
>> +		enable_irq_wake(max8997->irq);
>> +		disable_irq(max8997->irq);
> 
> irq_set_irq_wake() is same as enable_irq_wake().

It's more intuitive name and makes code reading easier.

> Why is it necessary for disable_irq(max8997->irq)?

It's because we don't want to get interrupts before i2c controller will
be ready. So we disable irq in drivers suspend, and enable in resume.

If some iqr will come before enable_irq() call, it will be noticed, and
IRQ_PENDING flag will be set. In this case irq will be handled
immediately after enable_irq() call.

In previous version there was call of max8997_irq_resume() in resume
function, which caused forced interrupt handling, which has similar effect.

> 
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> @@ -478,9 +573,12 @@ static int max8997_resume(struct device *dev)
>>  	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
>>  	struct max8997_dev *max8997 = i2c_get_clientdata(i2c);
>>  
>> -	if (device_may_wakeup(dev))
>> -		irq_set_irq_wake(max8997->irq, 0);
>> -	return max8997_irq_resume(max8997);
>> +	if (device_may_wakeup(dev)) {
>> +		disable_irq_wake(max8997->irq);
>> +		enable_irq(max8997->irq);
> 
> ditto.
> 
>> +	}
>> +
>> +	return 0;
>>  }
>>  

Thanks,
Robert Baldyga
