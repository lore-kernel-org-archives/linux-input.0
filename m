From: Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH 2/7] Input: sx8654 - add reset-gpio support
Date: Tue, 16 Oct 2018 21:32:41 +0200
Message-ID: <8d5ea869-0d92-aef0-1d27-bb5ecf5ba0af@skidata.com>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
 <20181016091653.26896-3-richard.leitner@skidata.com>
 <20181016173931.GC230131@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016173931.GC230131@dtor-ws>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

Hi Dimitry,
thanks for the quick reply!

On 10/16/18 7:39 PM, Dmitry Torokhov wrote:
> Hi Richard,
> 
> On Tue, Oct 16, 2018 at 11:16:48AM +0200, Richard Leitner wrote:
>> The sx8654 features a NRST input which may be connected to a GPIO.
>> Therefore add support for hard-resetting the sx8654 via this NRST.
>>
>> If the reset-gpio property is provided the sx8654 is resetted via NRST
>> instead of the soft-reset via I2C.
>>

...

>> +
>> +	dev_dbg(&ts->client->dev, "NRST unavailable, try softreset\n");
>> +	err = i2c_smbus_write_byte_data(ts->client, I2C_REG_SOFTRESET,
>> +					SOFTRESET_VALUE);
>> +	if (err)
>> +		return err;
> 
> Have this in an "else" branch?

If that's the preferred way... of course.

> 
>> +
>> +	return 0;
>> +}
>> +
>>   static int sx8654_open(struct input_dev *dev)
>>   {
>>   	struct sx8654 *sx8654 = input_get_drvdata(dev);
>> @@ -171,6 +195,44 @@ static void sx8654_close(struct input_dev *dev)
>>   	}
>>   }
>>   
>> +#ifdef CONFIG_OF
>> +static int sx8654_get_ofdata(struct sx8654 *ts)
>> +{
>> +	struct device *dev = &ts->client->dev;
>> +	struct device_node *node = dev->of_node;
>> +	int err;
>> +
>> +	if (!node) {
>> +		ts->gpio_reset = NULL;
>> +		return 0;
>> +	}
> 
> There is no need to wrap this into CONFIG_OF or test "node". Just use
> devm_gpiod_get_optional() and it will work equally well on DT, ACPI, and
> static board systems.

Ok. Thank you for that information!
I haven't been aware of this before :-)

> 
>> +
>> +	ts->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>> +	if (PTR_ERR(ts->gpio_reset) == -EPROBE_DEFER) {
>> +		return -EPROBE_DEFER;
>> +	} else if (IS_ERR(ts->gpio_reset)) {
>> +		err = PTR_ERR(ts->gpio_reset);
> 
> I'd do:
> 
> 		if (err != -EPROBE_DEFER)
> 			dev_err(...)
> 
> here instead of separate branch.

Indeed... Looks like a more sexy solution. Thanks.

> 
>> +		dev_err(dev, "unable to request GPIO reset pin (%d)\n", err);
>> +		return err;
>> +	}
>> +	dev_dbg(dev, "got GPIO reset pin\n");
> 
> Also, I'd move all this code directly into probe() since all this
> #ifdefery is not needed.

Without the #ifdef'ery and node checking this sounds reasonable.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id sx8654_of_match[] = {
>> +	{ .compatible = "semtech,sx8654", },
>> +	{ },
>> +};
> 
> Please keep the device table wehere it was.

OK.

>> @@ -186,10 +248,20 @@ static int sx8654_probe(struct i2c_client *client,
>>   	if (!sx8654)
>>   		return -ENOMEM;
>>   
>> +	sx8654->client = client;
>> +
>> +	error = sx8654_get_ofdata(sx8654);
>> +	if (error) {
>> +		dev_err(&client->dev, "get_ofdata failed: %d\n", error);
>> +		return error;
>> +	}
>> +
>>   	input = devm_input_allocate_device(&client->dev);
>>   	if (!input)
>>   		return -ENOMEM;
>>   
>> +	sx8654->input = input;
>> +
>>   	input->name = "SX8654 I2C Touchscreen";
>>   	input->id.bustype = BUS_I2C;
>>   	input->dev.parent = &client->dev;
>> @@ -201,15 +273,11 @@ static int sx8654_probe(struct i2c_client *client,
>>   	input_set_abs_params(input, ABS_X, 0, MAX_12BIT, 0, 0);
>>   	input_set_abs_params(input, ABS_Y, 0, MAX_12BIT, 0, 0);
>>   
>> -	sx8654->client = client;
>> -	sx8654->input = input;
>> -
> 
> Why do we need to move this?

This was because sx8654_get_ofdata needed ts->client->dev.
But as I will integrate the reset gpio getting in the probe function 
I'll move it back.

...

> 
> Thanks.
> 

I'll send a v2 of the series as soon as I have fixed the other patches.

regards;Richard.L
