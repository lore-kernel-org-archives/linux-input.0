From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: goodix - disable IRQs while suspended
Date: Thu, 11 Jan 2018 15:08:15 +0100
Message-ID: <cf1f5539-3bcc-46a3-0531-98de667b5898@redhat.com>
References: <20180110113456.3091-1-hdegoede@redhat.com>
 <1515593698.2523.56.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43704 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932920AbeAKOIV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 Jan 2018 09:08:21 -0500
Received: by mail-wm0-f68.google.com with SMTP id g1so5763615wmg.2
        for <linux-input@vger.kernel.org>; Thu, 11 Jan 2018 06:08:20 -0800 (PST)
In-Reply-To: <1515593698.2523.56.camel@hadess.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

Hi,

On 10-01-18 15:14, Bastien Nocera wrote:
> On Wed, 2018-01-10 at 12:34 +0100, Hans de Goede wrote:
>> We should not try to do any i2c transfers before the controller is
>> resumed (which happens before our resume method gets called).
>>
>> So we need to disable our IRQ while suspended to enforce this. The
>> code paths for devices with GPIOs for the int and reset pins already
>> disable the IRQ the through goodix_free_irq().
>>
>> This commit also disables the IRQ while suspended for devices without
>> GPIOs for the int and reset pins.
> 
> Do disable_irq() and enable_irq() require to be paired,

Yes.

> and if so, are
> goodix_suspend() and goodix_resume() guaranteed to be paired?

Yes I believe they are, many i2c drivers call disable / enable_irq
from there suspend/resume handler.

> Other than that, looks good to me. Please add the name of the device(s)
> you tested this on in the changelog and add your tested-by, to show
> it's not a "compile-only check" kind of commit.

Ok, v2 with amended commit messages coming up.

Regards,

Hans

> 
> Cheers
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/input/touchscreen/goodix.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/goodix.c
>> b/drivers/input/touchscreen/goodix.c
>> index 69d0b8cbc71f..ecec8eb17f28 100644
>> --- a/drivers/input/touchscreen/goodix.c
>> +++ b/drivers/input/touchscreen/goodix.c
>> @@ -878,8 +878,10 @@ static int __maybe_unused goodix_suspend(struct
>> device *dev)
>>   	int error;
>>   
>>   	/* We need gpio pins to suspend/resume */
>> -	if (!ts->gpiod_int || !ts->gpiod_rst)
>> +	if (!ts->gpiod_int || !ts->gpiod_rst) {
>> +		disable_irq(client->irq);
>>   		return 0;
>> +	}
>>   
>>   	wait_for_completion(&ts->firmware_loading_complete);
>>   
>> @@ -919,8 +921,10 @@ static int __maybe_unused goodix_resume(struct
>> device *dev)
>>   	struct goodix_ts_data *ts = i2c_get_clientdata(client);
>>   	int error;
>>   
>> -	if (!ts->gpiod_int || !ts->gpiod_rst)
>> +	if (!ts->gpiod_int || !ts->gpiod_rst) {
>> +		enable_irq(client->irq);
>>   		return 0;
>> +	}
>>   
>>   	/*
>>   	 * Exit sleep mode by outputting HIGH level to INT pin
