From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/2] input: rotary-encoder: defer calls gpio_to_irq()
Date: Wed, 25 Jul 2012 09:43:03 +0200
Message-ID: <500FA387.5010504@gmail.com>
References: <1343151487-27841-1-git-send-email-zonque@gmail.com> <1343151487-27841-2-git-send-email-zonque@gmail.com> <ADE657CA350FB648AAC2C43247A983F00206AABE13B5@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44944 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab2GYHnI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 03:43:08 -0400
Received: by wgbdr13 with SMTP id dr13so446598wgb.1
        for <linux-input@vger.kernel.org>; Wed, 25 Jul 2012 00:43:07 -0700 (PDT)
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F00206AABE13B5@AUSP01VMBX24.collaborationhost.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "jhovold@gmail.com" <jhovold@gmail.com>

On 24.07.2012 21:45, H Hartley Sweeten wrote:
> On Tuesday, July 24, 2012 10:38 AM, Daniel Mack wrote:
>> Don't call gpio_to_irq() on GPIOs before gpio_request() succeeded on
>> them. This avoids Ooopses with incorrect DT bindings.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  drivers/input/misc/rotary_encoder.c |    5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
>> index 350cbd1..474b04f 100644
>> --- a/drivers/input/misc/rotary_encoder.c
>> +++ b/drivers/input/misc/rotary_encoder.c
>> @@ -223,8 +223,6 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>>  
>>  	encoder->input = input;
>>  	encoder->pdata = pdata;
>> -	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
>> -	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
>>  
>>  	/* create and register the input driver */
>>  	input->name = pdev->name;
>> @@ -275,6 +273,9 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>>  		goto exit_free_gpio_a;
>>  	}
>>  
>> +	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
>> +	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
>> +
>>  	/* request the IRQs */
>>  	if (pdata->half_period) {
>>  		handler = &rotary_encoder_half_period_irq;
> 
> Daniel,
> 
> You might want to put this patch first before adding the DT binding
> stuff.
> 
> You also might consider using gpio_request_one() or even the
> devm_* version, instead of doing the gpio_request() followed
> by the  gpio_direction_input().
> 
> Actually, if you convert the probe to use the managed resource
> devm_* stuff it would really cleanup the error path and the remove.

Yes, you're right. Thanks for the hint. New version coming up. Does your
Reviewed-by: still apply?


Daniel

