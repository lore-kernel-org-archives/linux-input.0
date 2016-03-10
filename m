From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 05/13] input: convert sun4i-ts to use
 devm_thermal_zone_of_sensor_register
Date: Thu, 10 Mar 2016 14:19:49 +0100
Message-ID: <56E17475.8010506@redhat.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-6-git-send-email-edubezval@gmail.com>
 <20160310093438.GL30994@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55236 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbcCJNUC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 08:20:02 -0500
In-Reply-To: <20160310093438.GL30994@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Jens Thiele <karme@karme.de>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 10-03-16 10:34, Sascha Hauer wrote:
> On Wed, Mar 09, 2016 at 01:35:27PM -0800, Eduardo Valentin wrote:
>> This changes the driver to use the devm_ version
>> of thermal_zone_of_sensor_register and cleans
>> up the  local points and unregister calls.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Lukasz Majewski <l.majewski@samsung.com>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Jens Thiele <karme@karme.de>
>> Cc: linux-input@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
>> ---
>>   drivers/input/touchscreen/sun4i-ts.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
>> index 4857943..d07dd29 100644
>> --- a/drivers/input/touchscreen/sun4i-ts.c
>> +++ b/drivers/input/touchscreen/sun4i-ts.c
>> @@ -115,7 +115,6 @@
>>   struct sun4i_ts_data {
>>   	struct device *dev;
>>   	struct input_dev *input;
>> -	struct thermal_zone_device *tz;
>>   	void __iomem *base;
>>   	unsigned int irq;
>>   	bool ignore_fifo_data;
>> @@ -366,10 +365,7 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>>   	if (IS_ERR(hwmon))
>>   		return PTR_ERR(hwmon);
>>
>> -	ts->tz = thermal_zone_of_sensor_register(ts->dev, 0, ts,
>> -						 &sun4i_ts_tz_ops);
>> -	if (IS_ERR(ts->tz))
>> -		ts->tz = NULL;
>> +	devm_thermal_zone_of_sensor_register(ts->dev, 0, ts, &sun4i_ts_tz_ops);
>
> Shouldn't we check the return value? There are a few possibilities for
> thermal_zone_of_sensor_register to fail.

Note thee old code also was not checking this, it was simply continuing
without having registered a tz-sensor.

I guess we could log an error in that case, but that should be done in a
seperate follow-up patch.

The current patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
