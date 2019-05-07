From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH][next] Input: qt1050: fix less than zero comparison on an
 unsigned int
Date: Tue, 7 May 2019 09:46:03 +0100
Message-ID: <e2a30ae6-da97-1abe-3385-d86bc81406f0@canonical.com>
References: <20190507082135.21538-1-colin.king@canonical.com>
 <20190507083214.rcew5cjfvlbwbov5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507083214.rcew5cjfvlbwbov5@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 07/05/2019 09:32, Marco Felsch wrote:
> Hi Ian,
> 
> On 19-05-07 09:21, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the less than zero comparison of val is always false because
>> val is an unsigned int. Fix this by making val a signed int.
> 
> Thanks for covering that, was an copy 'n' paste failure..
>>
>> Addresses-Coverity: ("Unsigned compared against zero")
>> Fixes: a33ff45923c8 ("Input: qt1050 - add Microchip AT42QT1050 support")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/input/keyboard/qt1050.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
>> index 6b1603cb7515..4debddb13972 100644
>> --- a/drivers/input/keyboard/qt1050.c
>> +++ b/drivers/input/keyboard/qt1050.c
>> @@ -222,7 +222,7 @@ static struct regmap_config qt1050_regmap_config = {
>>  
>>  static bool qt1050_identify(struct qt1050_priv *ts)
>>  {
>> -	unsigned int val;
>> +	int val;
> 
> I think the proper solution is to add a ret val, because this covers the
> success/fail. I will send a patch to fix this.

OK, thanks for the follow-up fix.

Regards,
Colin

> 
> Regards,
>   Marco
> 
>>  	/* Read Chip ID */
>>  	regmap_read(ts->regmap, QT1050_CHIP_ID, &val);
>> -- 
>> 2.20.1
>>
>>
> 
