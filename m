From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : Change Raydium firmware update parameter
Date: Thu,  4 May 2017 09:43:06 +0800
Message-ID: <20170504014306.417-1-jeffrey.lin@rad-ic.com>
References: <20170503153717.328-1-jeffrey.lin@rad-ic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33336 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbdEDBnQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 3 May 2017 21:43:16 -0400
In-Reply-To: <20170503153717.328-1-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, bleung@chromium.org, groeck@chromium.org, Katherine.Hsieh@quantatw.com
Cc: jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, calvin.tseng@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org

Hi Guenter:
>> Change boot mode trigger parameter of Raydium firmware update.
>>

>That is a bit vague. What is changed to what, and why ?

>In other words, what prevents someone else from changing it back to
>the old value, using the same description ?

This bit control erase type as doing firmware update. We want just reserve more infomation after pass through production line. This's convenient
 for debug, so that it's okay as some one use old version.

>> Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
>> ---
>>  drivers/input/touchscreen/raydium_i2c_ts.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
>> index a99fb5cac5a0..8a81257634ba 100644
>> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
>> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
>> @@ -450,7 +450,7 @@ static bool raydium_i2c_boot_trigger(struct i2c_client *client)
>>                 { 0x08, 0x04, 0x09, 0x00, 0x50, 0xA5 },
>>                 { 0x08, 0x0C, 0x09, 0x00, 0x50, 0x00 },
>>                 { 0x06, 0x01, 0x00, 0x00, 0x00, 0x00 },
>> -               { 0x02, 0xA2, 0x00, 0x00, 0x00, 0x00 },
>> +               { 0x02, 0xA1, 0x00, 0x00, 0x00, 0x00 },
>>         };


Thanks.

Jeffrey
