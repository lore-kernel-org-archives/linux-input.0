From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] input: silead: Disable interrupt during suspend
Date: Tue, 23 May 2017 08:47:16 +0200
Message-ID: <1df3a5ed-e11e-fcbc-70e6-0ae4759eaf0c@redhat.com>
References: <20170519140642.31800-1-hdegoede@redhat.com>
 <20170523002139.GF12016@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965775AbdEWGrS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 May 2017 02:47:18 -0400
In-Reply-To: <20170523002139.GF12016@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On 23-05-17 02:21, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Fri, May 19, 2017 at 04:06:42PM +0200, Hans de Goede wrote:
>> When we put the touchscreen controller in low-power mode the irq
>> pin may trigger (float) and if we then try to read a data packet we
>> get the following error in dmesg:
>>
>> [  478.801017] silead_ts i2c-MSSL1680:00: Data read error -121
>>
>> This commit disables the irq during suspend/resume fixing this error.
> 
> Out of curiosity, what interrupt type does silead device use on your
> platform?

On the tablet where I was seeing this problem the irq is declared as:

                         GpioInt (Edge, ActiveHigh, Shared, PullDefault, 0x0000,

In the DSDT.

Regards,

Hans


> 
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/input/touchscreen/silead.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
>> index 9b36f2750b9f..52c878a20a92 100644
>> --- a/drivers/input/touchscreen/silead.c
>> +++ b/drivers/input/touchscreen/silead.c
>> @@ -536,6 +536,7 @@ static int __maybe_unused silead_ts_suspend(struct device *dev)
>>   {
>>   	struct i2c_client *client = to_i2c_client(dev);
>>   
>> +	disable_irq(client->irq);
>>   	silead_ts_set_power(client, SILEAD_POWER_OFF);
>>   	return 0;
>>   }
>> @@ -561,6 +562,8 @@ static int __maybe_unused silead_ts_resume(struct device *dev)
>>   		return -ENODEV;
>>   	}
>>   
>> +	enable_irq(client->irq);
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.12.2
>>
> 
> Thanks.
> 
