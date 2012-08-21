From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 3/3] input: rotary-encoder: add DT bindings
Date: Tue, 21 Aug 2012 09:58:04 +0200
Message-ID: <50333F8C.8050109@gmail.com>
References: <1343240714-11399-1-git-send-email-zonque@gmail.com> <1343240714-11399-3-git-send-email-zonque@gmail.com> <20120731061214.GB32327@core.coreip.homeip.net> <5017E3FA.9060604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60468 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab2HUH6U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Aug 2012 03:58:20 -0400
Received: by bkwj10 with SMTP id j10so2091227bkw.19
        for <linux-input@vger.kernel.org>; Tue, 21 Aug 2012 00:58:19 -0700 (PDT)
In-Reply-To: <5017E3FA.9060604@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jhovold@gmail.com, hartleys@visionengravers.com

Dmitry,

can we merge this series? Your approach with a fix of that trivial
syntax error I pointed out above is fine for me.

Many thanks,
Daniel


On 31.07.2012 15:56, Daniel Mack wrote:
> On 31.07.2012 08:12, Dmitry Torokhov wrote:
>> Still, I do not line the copying of pdata over, maybe we coudl have
>> something like the patch below?
>
> [...]
> 
>> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
>> index ea51265..0f9d746 100644
>> --- a/drivers/input/misc/rotary_encoder.c
>> +++ b/drivers/input/misc/rotary_encoder.c
>> @@ -24,6 +24,8 @@
>>  #include <linux/gpio.h>
>>  #include <linux/rotary_encoder.h>
>>  #include <linux/slab.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_gpio.h>
>>  
>>  #define DRV_NAME "rotary-encoder"
>>  
>> @@ -140,6 +142,56 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +#ifdef CONFIG_OF
>> +static struct of_device_id rotary_encoder_of_match[] = {
>> +	{ .compatible = "rotary-encoder", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
>> +
>> +static struct rotary_encoder_platform_data * __devinit
>> +rotary_encoder_parse_dt(struct device *dev)
>> +{
>> +	const struct of_device_id *of_id =
>> +				of_match_device(rotary_encoder_of_match, dev);
>> +	struct device_node *np = dev->of_node;
>> +	struct rotary_encoder_platform_data *pdata;
>> +	enum of_gpio_flags flags;
>> +
>> +	if (!of_id || !np)
>> +		return NULL;
>> +
>> +	pdata = kzalloc(sizeof(struct rotary_encoder_platform_data),
>> +			GFP_KERNEL);
>> +	if (!pdata)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	of_property_read_u32(np, "rotary-encoder,steps", &pdata->steps);
>> +	of_property_read_u32(np, "linux,axis", &pdata->axis);
>> +
>> +	pdata->gpio_a = of_get_gpio_flags(np, 0, &flags);
>> +	pdata->inverted_a = flags & OF_GPIO_ACTIVE_LOW;
>> +
>> +	pdata->gpio_b = of_get_gpio_flags(np, 1, &flags);
>> +	pdata->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
>> +
>> +	pdata->relative_axis = !!of_get_property(np,
>> +					"rotary-encoder,relative-axis", NULL);
>> +	pdata->rollover = !!of_get_property(np,
>> +					"rotary-encoder,rollover", NULL);
>> +	pdata->half_period = !!of_get_property(np,
>> +					"rotary-encoder,half-period", NULL))
> 
> Syntax error.
> 
>> +
>> +	return pdata;
>> +}
>> +#else
>> +static inline struct rotary_encoder_platform_data *
>> +rotary_encoder_parse_dt(struct device *dev)
>> +{
>> +	return NULL;
>> +}
>> +#endif
>> +
>>  static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> @@ -150,14 +202,19 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>>  	int err;
>>  
>>  	if (!pdata) {
>> -		dev_err(&pdev->dev, "missing platform data\n");
>> -		return -ENOENT;
>> +		pdata = rotary_encoder_parse_dt(dev);
>> +		if (IS_ERR(pdata))
>> +			return PTR_ERR(pdata);
>> +
>> +		if (!pdata) {
>> +			dev_err(dev, "missing platform data\n");
>> +			return -EINVAL;
>> +		}
> 
> Well, then you would only parse DT parameters in case of no kernel
> provided struct. I thought you were up to a solution where board file
> data could override just parts of the DT provided information. But I
> don't think the latter would be any useful anyway, so I'm happy with
> your solution :)
> 
> 
> Thanks for your help,
> Daniel
> 

