From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 4/4] input: keyboard: gpio-keys-polled: skip oftree code
 when CONFIG_OF disabled
Date: Mon, 29 Apr 2019 23:40:12 +0200
Message-ID: <d1a9f570-4f92-b46f-140e-45c823c82474@metux.net>
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-5-git-send-email-info@metux.net>
 <2a760b29-9f0b-ffa7-03dd-47ddb074563a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a760b29-9f0b-ffa7-03dd-47ddb074563a@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 29.04.19 21:44, Frank Rowand wrote:
> On 4/16/19 12:57 PM, Enrico Weigelt, metux IT consult wrote:
>> we don't need to build in oftree probing stuff when oftree isn't
>> enabled at all.
>>
>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>> ---
>>  drivers/input/keyboard/gpio_keys_polled.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
>> index 3f773b2..fbccb89 100644
>> --- a/drivers/input/keyboard/gpio_keys_polled.c
>> +++ b/drivers/input/keyboard/gpio_keys_polled.c
>> @@ -147,6 +147,7 @@ static void gpio_keys_polled_close(struct input_polled_dev *dev)
>>  static struct gpio_keys_platform_data *
>>  gpio_keys_polled_get_devtree_pdata(struct device *dev)
>>  {
>> +#ifdef CONFIG_OF
>>  	struct gpio_keys_platform_data *pdata;
>>  	struct gpio_keys_button *button;
>>  	struct fwnode_handle *child;
>> @@ -200,6 +201,9 @@ static void gpio_keys_polled_close(struct input_polled_dev *dev)
>>  	}
>>  
>>  	return pdata;
>> +#else /* CONFIG_OF */
>> +	return ERR_PTR(-ENOENT);
>> +#endif /* CONFIG_OF */
>>  }
>>  
>>  static void gpio_keys_polled_set_abs_params(struct input_dev *input,
>> @@ -226,7 +230,7 @@ static void gpio_keys_polled_set_abs_params(struct input_dev *input,
>>  	{ .compatible = "gpio-keys-polled", },
>>  	{ },
>>  };
> 
> 
>> -MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
>> +MODULE_DEVICE_TABLE_OF(gpio_keys_polled_of_match);
> 
> Not needed, when you use of_match_ptr() -- see below.

Shall I remove the MODULE_DEVICE_TABLE... line completely ?

I'd like to have nothing of-related compiled in, when oftree isn't
enabled.

>>  static struct gpio_desc *gpio_keys_polled_get_gpiod_fwnode(
>>  	struct device *dev,
>> @@ -452,7 +456,9 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>>  	.probe	= gpio_keys_polled_probe,
>>  	.driver	= {
>>  		.name	= DRV_NAME,
> 
>> +#ifdef CONFIG_OF
>>  		.of_match_table = gpio_keys_polled_of_match,
>> +#endif /* CONFIG_OF */
> 
> No need for the #ifdef, use of_match_ptr():
> 
>   		.of_match_table = of_match_ptr(gpio_keys_polled_of_match),

Ok, thanks.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
