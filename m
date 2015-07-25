From: Dirk Behme <dirk.behme@gmail.com>
Subject: Re: [PATCH 2/4] Input: zforce - swap reset and interrupt GPIO
Date: Sat, 25 Jul 2015 07:19:04 +0200
Message-ID: <55B31C48.6070903@gmail.com>
References: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com> <1437396997-3182-3-git-send-email-dirk.behme@de.bosch.com> <20150724213223.GD33241@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37223 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbbGYFTL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Jul 2015 01:19:11 -0400
Received: by wibud3 with SMTP id ud3so54997851wib.0
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2015 22:19:09 -0700 (PDT)
In-Reply-To: <20150724213223.GD33241@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org

On 24.07.2015 23:32, Dmitry Torokhov wrote:
> On Mon, Jul 20, 2015 at 02:56:35PM +0200, Dirk Behme wrote:
>> From: Dirk Behme <dirk.behme@gmail.com>
>>
>> Swap the order of the reset and interrupt GPIO. This is the preparation
>> to make the interrupt GPIO optional.
>>
>> Note that this needs the same change in the device tree. But as mainline
>> doesn't contain any zforce device tree entries, nothing has to be done
>> for us, here.
>>
>> All non-mainline device trees have to be adapted, though.
>
> No, we can not do that.


The proposal to make the interrupt GPIO optional and not completely 
drop it came from you. Any other proposal how you like to get this 
implemented? With completely dropping the interrupt GPIO we would 
avoid this.


> We will have to switch to using named gpios
> (probably call then attn-gpio and reset-gpio respectively and
> handle old-style DTSes with unnamed 2-entry gpios list).


Just to understand correctly: You want the driver to support two GPIOs 
DT styles? One with unnamed 2-entry gpios list, where the interrupt 
GPIO can't be optional, and one with two named GPIOs, where the 
attn-gpio can be optional?

Btw, what does 'attn' stand for? I'd name it int-gpio.


Best regards

Dirk


>>
>> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>> ---
>>   .../bindings/input/touchscreen/zforce_ts.txt         |  4 ++--
>>   drivers/input/touchscreen/zforce_ts.c                | 20 ++++++++++----------
>>   2 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
>> index 80c37df..a19b508 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
>> @@ -23,8 +23,8 @@ Example:
>>   			interrupts = <2 0>;
>>   			vdd-supply = <&reg_zforce_vdd>;
>>
>> -			gpios = <&gpio5 6 0>, /* INT */
>> -				<&gpio5 9 0>; /* RST */
>> +			gpios = <&gpio5 9 0>, /* RST */
>> +				<&gpio5 6 0>; /* INT */
>>
>>   			x-size = <800>;
>>   			y-size = <600>;
>> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
>> index edf01c3..ac7b661 100644
>> --- a/drivers/input/touchscreen/zforce_ts.c
>> +++ b/drivers/input/touchscreen/zforce_ts.c
>> @@ -754,17 +754,8 @@ static int zforce_probe(struct i2c_client *client,
>>   	if (!ts)
>>   		return -ENOMEM;
>>
>> -	/* INT GPIO */
>> -	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 0, GPIOD_IN);
>> -	if (IS_ERR(ts->gpio_int)) {
>> -		ret = PTR_ERR(ts->gpio_int);
>> -		dev_err(&client->dev,
>> -			"failed to request interrupt GPIO: %d\n", ret);
>> -		return ret;
>> -	}
>> -
>>   	/* RST GPIO */
>> -	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 1,
>> +	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 0,
>>   					    GPIOD_OUT_HIGH);
>>   	if (IS_ERR(ts->gpio_rst)) {
>>   		ret = PTR_ERR(ts->gpio_rst);
>> @@ -773,6 +764,15 @@ static int zforce_probe(struct i2c_client *client,
>>   		return ret;
>>   	}
>>
>> +	/* INT GPIO */
>> +	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 1, GPIOD_IN);
>> +	if (IS_ERR(ts->gpio_int)) {
>> +		ret = PTR_ERR(ts->gpio_int);
>> +		dev_err(&client->dev,
>> +			"failed to request interrupt GPIO: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>   	ts->reg_vdd = devm_regulator_get_optional(&client->dev, "vdd");
>>   	if (IS_ERR(ts->reg_vdd)) {
>>   		ret = PTR_ERR(ts->reg_vdd);
>> --
>> 2.3.4
>>
>

