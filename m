From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH] input: qt1070: add device tree support
Date: Mon, 20 Aug 2012 10:08:54 +0800
Message-ID: <50319C36.10605@atmel.com>
References: <1345197788-32116-1-git-send-email-voice.shen@atmel.com> <502E8CCA.6090601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:60221 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab2HTCJJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Aug 2012 22:09:09 -0400
In-Reply-To: <502E8CCA.6090601@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: dmitry.torokhov@gmail.com, nicolas.ferre@atmel.com, jm.lin@atmel.com, linux-input@vger.kernel.org

Hi Sir,

On 8/18/2012 2:26, Shubhrajyoti wrote:
> Hi Bo,
> On Friday 17 August 2012 03:33 PM, Bo Shen wrote:
>> This patch enable the qt1070 device tree support
>>
>> If using device tree, the node of qt1070 looks like
>> i2c@0 {					     // this is an example
>> 	status = "okay";		     // Enable i2c master
>> 	qt1070@1b {
>> 		compatible = "atmel,qt1070"; // FDT device id
>> 		reg = <0x1b>;		     // qt1070 i2c address
>> 		change-gpio = <&pioA 7 1>;   // gpio used as interrupt
>> 	};
>> };
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>>   drivers/input/keyboard/qt1070.c |   19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
>> index ca68f29..7d656b5 100644
>> --- a/drivers/input/keyboard/qt1070.c
>> +++ b/drivers/input/keyboard/qt1070.c
>> @@ -33,6 +33,8 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/delay.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>>
>>   /* Address for each register */
>>   #define CHIP_ID            0x00
>> @@ -155,6 +157,10 @@ static int __devinit qt1070_probe(struct i2c_client *client,
>>   		return -ENODEV;
>>   	}
>>
>> +	if (client->dev.of_node)
>> +		client->irq = of_get_named_gpio(client->dev.of_node,
>> +				"change-gpio", 0);
>> +
>>   	if (!client->irq) {
>>   		dev_err(&client->dev, "please assign the irq to this device\n");
>>   		return -EINVAL;
>> @@ -200,9 +206,9 @@ static int __devinit qt1070_probe(struct i2c_client *client,
>>   	qt1070_write(client, RESET, 1);
>>   	msleep(QT1070_RESET_TIME);
>>
>> -	err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
>> -				   IRQF_TRIGGER_NONE | IRQF_ONESHOT,
>> -				   client->dev.driver->name, data);
> where is the gpio request done?
> Am I missing something?

OK. I will add gpio request.

Thanks.

>> +	err = request_threaded_irq(gpio_to_irq(client->irq), NULL,
>> +			qt1070_interrupt, IRQF_TRIGGER_NONE | IRQF_ONESHOT,
>> +			client->dev.driver->name, data);
>>   	if (err) {
>>   		dev_err(&client->dev, "fail to request irq\n");
>>   		goto err_free_mem;
>> @@ -243,6 +249,12 @@ static int __devexit qt1070_remove(struct i2c_client *client)
>>   	return 0;
>>   }
>>
>> +static const struct of_device_id atmel_qt1070_of_match[] = {
>> +	{ .compatible = "atmel,qt1070", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, atmel_qt1070_of_match);
>> +
>>   static const struct i2c_device_id qt1070_id[] = {
>>   	{ "qt1070", 0 },
>>   	{ },
>> @@ -253,6 +265,7 @@ static struct i2c_driver qt1070_driver = {
>>   	.driver	= {
>>   		.name	= "qt1070",
>>   		.owner	= THIS_MODULE,
>> +		.of_match_table = atmel_qt1070_of_match,
>>   	},
>>   	.id_table	= qt1070_id,
>>   	.probe		= qt1070_probe,
>

