From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 5/7] Input: pwm-beeper - suppress error message on
 probe defer
Date: Fri, 20 Jan 2017 12:43:21 -0600
Message-ID: <6bd9d060-507a-7bb1-9dd8-47be99de976b@lechnology.com>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
 <20170119224057.9995-5-dmitry.torokhov@gmail.com>
 <20170120101621.GE3824@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120101621.GE3824@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org

On 01/20/2017 04:16 AM, Thierry Reding wrote:
> On Thu, Jan 19, 2017 at 02:40:55PM -0800, Dmitry Torokhov wrote:
>> From: David Lechner <david@lechnology.com>
>>
>> This suppress printing an error message when pwm_get returns -EPROBE_DEFER.
>> Otherwise you get a bunch of noise in the kernel log.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> Patchwork-Id: 9499915
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>  drivers/input/misc/pwm-beeper.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
>> index 04c8ad3827d9..9964c46468d3 100644
>> --- a/drivers/input/misc/pwm-beeper.c
>> +++ b/drivers/input/misc/pwm-beeper.c
>> @@ -108,7 +108,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>>  	beeper->pwm = devm_pwm_get(dev, NULL);
>>  	if (IS_ERR(beeper->pwm)) {
>>  		error = PTR_ERR(beeper->pwm);
>> -		dev_err(dev, "Failed to request pwm device: %d\n", error);
>> +		if (error != -EPROBE_DEFER)
>> +			dev_err(dev, "Failed to request pwm device\n");
>
> This also drops the error code from the message. I suspect that this was
> intentional because failure to probe will print out the error code
> anyway. Might be worth mentioning that in the commit message?

Yes, it was intentional for that reason. And in fact we could do the 
same thing to the error messages that are touched in patch 2/7 of this 
series.

>
> Either way:
>
> Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
>
