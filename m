From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] Input: ads7846 - move regulator codes out of spinlock
 protected area
Date: Fri, 20 Aug 2010 15:19:03 +0800
Message-ID: <4C6E2C67.3060108@gmail.com>
References: <1282205670-30618-1-git-send-email-jason77.wang@gmail.com> <20100820051921.GD12243@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63973 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0HTHPj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Aug 2010 03:15:39 -0400
In-Reply-To: <20100820051921.GD12243@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jason Wang <jason77.wang@gmail.com>, notasas@gmail.com, vapier@gentoo.org, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Thu, Aug 19, 2010 at 04:14:30PM +0800, Jason Wang wrote:
>   
>> The commit 9114337 introduces regulator operations in the ads7846
>> touchscreen driver. Among these operations, some are called in the
>> spinlock protected context.
>> On most platforms, the regulator operation is achieved through
>> i2c/spi bus transfer operations, some of bus transfer operations will
>> call wait_for_completion function. It isn't allowable  to call
>> sleepable function in the atomic context. So move them out from the
>> atomic context.
>>     
>
> I do not believe simply moving calls out of splnlock-protected area is
> enough. Are all regulator drivers allow regulator_enable() and
> regulator_disable() to be called simultaneously? Even if they do allow
> it I think there still a race between ads7846_enable/disable/suspend/resume
> and you need to wrap all of it in a mutex...
>
>   
Hi Dmitry,

The regulator_enable() and regulator_disable() are already protected by 
a mutex,
see drivers/regulator/core.c

int regulator_enable(struct regulator *regulator)
{
struct regulator_dev *rdev = regulator->rdev;
int ret = 0;

mutex_lock(&rdev->mutex);
ret = _regulator_enable(rdev);
mutex_unlock(&rdev->mutex);
return ret;
}
EXPORT_SYMBOL_GPL(regulator_enable);

int regulator_disable(struct regulator *regulator)
{
struct regulator_dev *rdev = regulator->rdev;
int ret = 0;

mutex_lock(&rdev->mutex);
ret = _regulator_disable(rdev);
mutex_unlock(&rdev->mutex);
return ret;
}
EXPORT_SYMBOL_GPL(regulator_disable);

So there is no race between these two functions.

You are right, i will design a protection wrap for 
enable/disable/suspend/resume.

Thanks,
Jason.

>> [tested on TI OMAP3530EVM board]
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>>  drivers/input/touchscreen/ads7846.c |   14 ++++++++++----
>>  1 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>> index 1603193..9421df9 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -531,6 +531,9 @@ static ssize_t ads7846_disable_store(struct device *dev,
>>  	if (strict_strtoul(buf, 10, &i))
>>  		return -EINVAL;
>>  
>> +	if (!i)
>> +		regulator_enable(ts->reg);
>> +
>>  	spin_lock_irq(&ts->lock);
>>  
>>  	if (i)
>> @@ -540,6 +543,9 @@ static ssize_t ads7846_disable_store(struct device *dev,
>>  
>>  	spin_unlock_irq(&ts->lock);
>>  
>> +	if (i)
>> +		regulator_disable(ts->reg);
>> +
>>  	return count;
>>  }
>>  
>> @@ -855,8 +861,6 @@ static void ads7846_disable(struct ads7846 *ts)
>>  		}
>>  	}
>>  
>> -	regulator_disable(ts->reg);
>> -
>>  	/* we know the chip's in lowpower mode since we always
>>  	 * leave it that way after every request
>>  	 */
>> @@ -868,8 +872,6 @@ static void ads7846_enable(struct ads7846 *ts)
>>  	if (!ts->disabled)
>>  		return;
>>  
>> -	regulator_enable(ts->reg);
>> -
>>  	ts->disabled = 0;
>>  	ts->irq_disabled = 0;
>>  	enable_irq(ts->spi->irq);
>> @@ -886,6 +888,8 @@ static int ads7846_suspend(struct spi_device *spi, pm_message_t message)
>>  
>>  	spin_unlock_irq(&ts->lock);
>>  
>> +	regulator_disable(ts->reg);
>> +
>>  	if (device_may_wakeup(&ts->spi->dev))
>>  		enable_irq_wake(ts->spi->irq);
>>  
>> @@ -900,6 +904,8 @@ static int ads7846_resume(struct spi_device *spi)
>>  	if (device_may_wakeup(&ts->spi->dev))
>>  		disable_irq_wake(ts->spi->irq);
>>  
>> +	regulator_enable(ts->reg);
>> +
>>  	spin_lock_irq(&ts->lock);
>>  
>>  	ts->is_suspended = 0;
>> -- 
>> 1.5.6.5
>>
>>     
>
>   

