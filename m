From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH] input: zforce_ts: add DT support for reset GPIO polarity
Date: Wed, 24 Jun 2015 07:18:38 +0200
Message-ID: <558A3DAE.8090203@de.bosch.com>
References: <1434347665-24396-1-git-send-email-dirk.behme@de.bosch.com> <20150616235755.GE17610@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:10654 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbbFXFSn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2015 01:18:43 -0400
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 7CE3DC0564
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2015 07:18:41 +0200 (CEST)
In-Reply-To: <20150616235755.GE17610@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

On 17.06.2015 01:57, Dmitry Torokhov wrote:
> On Mon, Jun 15, 2015 at 07:54:25AM +0200, Dirk Behme wrote:
>> From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
>>
>> According to
>>
>> Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
>>
>> the RST GPIO is supposed to provide a polarity flag parameter
>>
>> gpios = <&GPIO_BANK GPIO_NUMBER GPIO_POLARITY>
>>
>> with GPIO_POLARITY
>>
>> reset active low  = 1 (GPIO_ACTIVE_LOW)
>> reset active high = 0 (GPIO_ACTIVE_HIGH)
>>
>> Example for GPIO_ACTIVE_LOW (1) reset GPIO:
>>
>> 	zforce_ts@50 { /* Neonode zForce I2C */
>> 		compatible = "neonode,zforce-ts";
>> 		...
>> 		gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>, /* INT */
>> 			<&gpio1 29 GPIO_ACTIVE_LOW>; /* RST */
>> 		...
>> 	};
>>
>> Add the missing polarity flag evaluation to the driver.
>>
>> Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
>> Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>>   drivers/input/touchscreen/zforce_ts.c   | 27 +++++++++++++++++++++++----
>>   include/linux/platform_data/zforce_ts.h |  3 +++
>>   2 files changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
>> index 19880c7..125311d 100644
>> --- a/drivers/input/touchscreen/zforce_ts.c
>> +++ b/drivers/input/touchscreen/zforce_ts.c
>> @@ -162,6 +162,20 @@ static int zforce_command(struct zforce_ts *ts, u8 cmd)
>>   	return 0;
>>   }
>>
>> +static void zforce_reset_assert(struct zforce_ts *ts)
>> +{
>> +	const struct zforce_ts_platdata *pdata = ts->pdata;
>> +
>> +	gpio_set_value(pdata->gpio_rst, pdata->reset_active_low ? 0 : 1);
>
> Instead of doing this I'd rather we converted the driver to use gpiod
> that handles polarity automatically.


Thanks, we'll look into that.

Just to understand correctly: Converting this driver to gpiod will be an 
additional patch on top of this patch as it doesn't change any 
functionality provided by this patch, but does some clean up. Correct?


Best regards

Dirk
