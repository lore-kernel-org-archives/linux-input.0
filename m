From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v2 6/7] mfd: cros_ec: Instantiate sub-devices from device
 tree
Date: Mon, 08 Sep 2014 12:57:31 +0200
Message-ID: <540D8B9B.8020805@collabora.co.uk>
References: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk> <1408974008-17184-7-git-send-email-javier.martinez@collabora.co.uk> <20140904082513.GC8257@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140904082513.GC8257@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello Lee,

Sorry for the delay but had been on holidays last week.

On 09/04/2014 10:25 AM, Lee Jones wrote:
>>  
>> -static const struct mfd_cell cros_devs[] = {
>> -	{
>> -		.name = "cros-ec-keyb",
>> -		.id = 1,
>> -		.of_compatible = "google,cros-ec-keyb",
>> -	},
>> -	{
>> -		.name = "cros-ec-i2c-tunnel",
>> -		.id = 2,
>> -		.of_compatible = "google,cros-ec-i2c-tunnel",
>> -	},
>> -};
>> -
>>  int cros_ec_register(struct cros_ec_device *ec_dev)
>>  {
>>  	struct device *dev = ec_dev->dev;
>> +#ifdef CONFIG_OF
>> +	struct device_node *node = dev->of_node;
>> +#endif
> 
> Drop the #ifdiffery.
>

I used the #ifdef guards because I remembered of_node being conditionally
build but I see that this is not longer true after commmit:

c9e358d driver-core: remove conditionals around devicetree pointers

So I'll remove it, thanks for the pointer.

>>  	int err = 0;
>>  
>>  	if (ec_dev->din_size) {
>> @@ -138,13 +129,19 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>  
>>  	mutex_init(&ec_dev->lock);
>>  
>> -	err = mfd_add_devices(dev, 0, cros_devs,
>> -			      ARRAY_SIZE(cros_devs),
>> -			      NULL, ec_dev->irq, NULL);
>> -	if (err) {
>> -		dev_err(dev, "failed to add mfd devices\n");
>> -		return err;
>> +#ifdef CONFIG_OF
> 
> And here.
> 

Nod.

>> +	/*
>> +	 * Add sub-devices declared in the device tree.  NOTE they should NOT be
>> +	 * declared in cros_devs
>> +	 */
> 
> Drop this comment.  cros_devs no longer exists and we know what
> of_platform_populate() does.
> 

Ok.

>> +	if (node) {
>> +		err = of_platform_populate(node, NULL, NULL, dev);
>> +		if (err) {
>> +			dev_err(dev, "fail to add %s\n", node->full_name);
> 
> That's not true.  Just put "Failed to register subordinate devices".
> 

Ok.

>> +			return err;
>> +		}
>>  	}
>> +#endif
>>  
>>  	dev_info(dev, "Chrome EC device registered\n");
>>  
> 

Thanks a lot for the feedback and best regards,
Javier
