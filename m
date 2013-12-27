From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH V2] input synaptics-rmi4: Bug fixes to ATTN GPIO handling.
Date: Fri, 27 Dec 2013 15:43:27 -0800
Message-ID: <52BE109F.1070904@synaptics.com>
References: <1387853059-19099-1-git-send-email-cheiny@synaptics.com> <20131226223718.GC18562@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:2166 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab3L0Xnf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Dec 2013 18:43:35 -0500
In-Reply-To: <20131226223718.GC18562@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 12/26/2013 02:37 PM, Dmitry Torokhov wrote:
> Hi Chris,
>
> On Mon, Dec 23, 2013 at 06:44:19PM -0800, Christopher Heiny wrote:
>> This patch fixes some bugs in handling of the RMI4 attention line GPIO.
>>
>> 1) in enable_sensor(), eliminate the complicated check on ATTN and just
>> call process_interrupt_requests().  This will have minimal overhead if ATTN
>> is not asserted, and clears the state of the RMI4 device in any case.
>>
>> 2) Correctly free the GPIO in rmi_driver_remove().
>>
>> 3) in rmi_driver_probe()
>>      - declare the name of the attention gpio (GPIO_LABEL)
>>      - use gpio_request_one() to get the gpio and export it.
>>      - simplify conditional gpio acquisition logic and combine with interrupt
>>        setup
>>
>> 4) use gpio_is_valid() instead of comparing to 0.
>>
>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> ---
>>
>>   drivers/input/rmi4/rmi_driver.c | 43 ++++++++++++++++++++++-------------------
>>   1 file changed, 23 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
>> index a30c7d3..9b02358 100644
>> --- a/drivers/input/rmi4/rmi_driver.c
>> +++ b/drivers/input/rmi4/rmi_driver.c
>> @@ -140,7 +140,6 @@ static int enable_sensor(struct rmi_device *rmi_dev)
>>   	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>>   	struct rmi_phys_device *rmi_phys;
>>   	int retval = 0;
>> -	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
>>
>>   	if (data->enabled)
>>   		return 0;
>> @@ -169,11 +168,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
>>
>>   	data->enabled = true;
>>
>> -	if (!pdata->level_triggered &&
>> -		    gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity)
>> -		retval = process_interrupt_requests(rmi_dev);
>> -
>> -	return retval;
>> +	return process_interrupt_requests(rmi_dev);
>>   }
>>
>>   static void rmi_free_function_list(struct rmi_device *rmi_dev)
>> @@ -800,13 +795,20 @@ static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend, rmi_driver_resume);
>>   static int rmi_driver_remove(struct device *dev)
>>   {
>>   	struct rmi_device *rmi_dev = to_rmi_device(dev);
>> +	const struct rmi_device_platform_data *pdata =
>> +					to_rmi_platform_data(rmi_dev);
>>
>>   	disable_sensor(rmi_dev);
>>   	rmi_free_function_list(rmi_dev);
>>
>> +	if (gpio_is_valid(pdata->attn_gpio))
>> +		gpio_free(pdata->attn_gpio);
>
> It looks like you let driver registration to continue even if GPIO
> request fails. You probably need to introduce a flag indicating whether
> you successfully requested gpio or not. Or you can treat failure to
> acquire gpio as fatal.

In testing, the driver continues to work even if the GPIO is not 
acquired, but some diagnostic features may not be available, so we treat 
the failure to acquire as a warning.  I'll add a flag to indicate 
whether it was acquired or not.

>
>> +
>>   	return 0;
>>   }
>>
>> +static const char GPIO_LABEL[] = "attn";
>> +
>>   static int rmi_driver_probe(struct device *dev)
>>   {
>>   	struct rmi_driver *rmi_driver;
>> @@ -937,7 +939,7 @@ static int rmi_driver_probe(struct device *dev)
>>   		mutex_init(&data->suspend_mutex);
>>   	}
>>
>> -	if (pdata->attn_gpio) {
>> +	if (gpio_is_valid(pdata->attn_gpio)) {
>>   		data->irq = gpio_to_irq(pdata->attn_gpio);
>>   		if (pdata->level_triggered) {
>>   			data->irq_flags = IRQF_ONESHOT |
>> @@ -948,24 +950,17 @@ static int rmi_driver_probe(struct device *dev)
>>   				(pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
>>   				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>>   		}
>> -	} else
>> -		data->poll_interval = ktime_set(0,
>> -			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
>> -			DEFAULT_POLL_INTERVAL_MS) * 1000 * 1000);
>> -
>> -	if (data->f01_container->dev.driver) {
>> -		/* Driver already bound, so enable ATTN now. */
>> -		enable_sensor(rmi_dev);
>> -	}
>>
>> -	if (IS_ENABLED(CONFIG_RMI4_DEV) && pdata->attn_gpio) {
>
> Do you really need to export gpio if you do not have RMI4_DEV option?

Not really, but it doesn't hurt to do so.  I was trying to simplify the 
driver logic, but I guess that went too far.  I'll re-add the check.

[snip]
