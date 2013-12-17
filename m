From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input synaptics-rmi4: Bug fixes to ATTN GPIO handling.
Date: Tue, 17 Dec 2013 11:44:21 -0800
Message-ID: <52B0A995.3080801@synaptics.com>
References: <1387251906-23530-1-git-send-email-cheiny@synaptics.com> <20131217165752.GB17790@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:40708 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3LQToX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 14:44:23 -0500
In-Reply-To: <20131217165752.GB17790@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 12/17/2013 08:57 AM, Dmitry Torokhov wrote:
> Hi Chris,
>
> On Mon, Dec 16, 2013 at 07:45:06PM -0800, Christopher Heiny wrote:
>> This patch fixes two bugs in handling of the RMI4 attention line GPIO.
>>
>> 1) in enable_sensor(), make sure the attn_gpio is defined before attempting to
>> get its value.
>>
>> 2) in rmi_driver_probe(), declare the name of the attn_gpio, then
>> request the attn_gpio before attempting to export it. As an added bonus,
>> the code relating to the export is tidied up.
>>
>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> ---
>>
>> This patch implements changes to the synaptics-rmi4 branch of
>> Dmitry's input tree.  The base for the patch is commit
>> e0c5aec5e6144ae8391d164e2dc659f8ef2b2ba7.
>
> You do not have to mention base commit (and update it all the time),
> that's way too  much work. If you are the one posting patches I should
> be able to figure out how to apply them.
>
>>
>>   drivers/input/rmi4/rmi_driver.c | 37 ++++++++++++++++++++++---------------
>>   1 file changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
>> index a30c7d3..030e8d5 100644
>> --- a/drivers/input/rmi4/rmi_driver.c
>> +++ b/drivers/input/rmi4/rmi_driver.c
>> @@ -169,7 +169,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
>>
>>   	data->enabled = true;
>>
>> -	if (!pdata->level_triggered &&
>> +	if (pdata->attn_gpio && !pdata->level_triggered &&
>>   		    gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity)
>>   		retval = process_interrupt_requests(rmi_dev);
>>
>> @@ -807,6 +807,9 @@ static int rmi_driver_remove(struct device *dev)
>>   	return 0;
>>   }
>>
>> +
>> +static const char *GPIO_LABEL = "attn";
>> +
>
> This wastes 4 or 8 bytes I believe. If you want to do that then you
> should say:
>
> static const char GPIO_LABEL[] = "attn";

Hmmm.  Learned something new today!

>
>
>>   static int rmi_driver_probe(struct device *dev)
>>   {
>>   	struct rmi_driver *rmi_driver;
>> @@ -959,20 +962,24 @@ static int rmi_driver_probe(struct device *dev)
>>   	}
>>
>>   	if (IS_ENABLED(CONFIG_RMI4_DEV) && pdata->attn_gpio) {
>> -		retval = gpio_export(pdata->attn_gpio, false);
>> -		if (retval) {
>> -			dev_warn(dev, "WARNING: Failed to export ATTN gpio!\n");
>> -			retval = 0;
>> -		} else {
>> -			retval = gpio_export_link(dev,
>> -						  "attn", pdata->attn_gpio);
>> -			if (retval) {
>> -				dev_warn(dev,
>> -					"WARNING: Failed to symlink ATTN gpio!\n");
>> -				retval = 0;
>> -			} else {
>> -				dev_info(dev, "Exported ATTN GPIO %d.",
>> -					pdata->attn_gpio);
>> +		retval = gpio_request(pdata->attn_gpio, GPIO_LABEL);
>> +		if (retval)
>> +			dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code: %d.\n",
>> +				pdata->attn_gpio, retval);
>> +		else {
>
> The rule is: if one branch needs {} then they both should use them:
>
> 	if (condition) {
> 		statement;
> 	} else {
> 		statement;
> 		...
> 		statement;
> 	}

OK.

>
>> +			retval = gpio_export(pdata->attn_gpio, false);
>> +			if (retval)
>> +				dev_warn(dev, "WARNING: Failed to export ATTN  %d, code: %d.\n",
>> +					pdata->attn_gpio, retval);
>> +			else {
>> +				retval = gpio_export_link(dev, "attn",
>
> Why are we using constant when we request gpio but not here?

It's a leftover that wasn't caught.  We'll use the constant.

>
>> +							  pdata->attn_gpio);
>> +				if (retval)
>> +					dev_warn(dev,
>> +						"WARNING: Failed to symlink ATTN gpio!\n");
>> +				else
>> +					dev_info(dev, "Exported ATTN GPIO %d.",
>> +						pdata->attn_gpio);
>>   			}
>>   		}
>>   	}
>
> Thanks.
>

