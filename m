From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: st1232 - switch to using SIMPLE_DEV_PM_OPS
Date: Sun, 01 Apr 2012 17:41:40 -0700
Message-ID: <b9a9f8b3-9b97-47f2-a845-76b4613ec6ca@email.android.com>
References: <20120331061801.GA20441@core.coreip.homeip.net> <20120401232808.GA2336@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65120 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab2DBBGV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Apr 2012 21:06:21 -0400
In-Reply-To: <20120401232808.GA2336@verge.net.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-input@vger.kernel.org



Hi Simon,

Simon Horman <horms@verge.net.au> wrote:

>Hi,
>
>I'm not sure that I follow why st1232_ts_pm_ops is needed
>if CONFIG_PM_SLEEP isn't defined.
>

In case of !CONFIG_PM_SLEEP dev_pm_ops is an empty structure; having it allows us to drop some ifdefs.

Thanks.

>On Fri, Mar 30, 2012 at 11:18:02PM -0700, Dmitry Torokhov wrote:
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> ---
>> 
>> Just compiled, not tested...
>> 
>>  drivers/input/touchscreen/st1232.c |   11 ++++-------
>>  1 files changed, 4 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/input/touchscreen/st1232.c
>b/drivers/input/touchscreen/st1232.c
>> index e22e27e..a9be39f 100644
>> --- a/drivers/input/touchscreen/st1232.c
>> +++ b/drivers/input/touchscreen/st1232.c
>> @@ -218,7 +218,7 @@ static int __devexit st1232_ts_remove(struct
>i2c_client *client)
>>  	return 0;
>>  }
>>  
>> -#ifdef CONFIG_PM
>> +#ifdef CONFIG_PM_SLEEP
>>  static int st1232_ts_suspend(struct device *dev)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>> @@ -243,12 +243,11 @@ static int st1232_ts_resume(struct device *dev)
>>  	return 0;
>>  }
>>  
>> -static const struct dev_pm_ops st1232_ts_pm_ops = {
>> -	.suspend	= st1232_ts_suspend,
>> -	.resume		= st1232_ts_resume,
>> -};
>>  #endif
>>  
>> +static SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
>> +			 st1232_ts_suspend, st1232_ts_resume);
>> +
>>  static const struct i2c_device_id st1232_ts_id[] = {
>>  	{ ST1232_TS_NAME, 0 },
>>  	{ }
>> @@ -269,9 +268,7 @@ static struct i2c_driver st1232_ts_driver = {
>>  		.name	= ST1232_TS_NAME,
>>  		.owner	= THIS_MODULE,
>>  		.of_match_table = st1232_ts_dt_ids,
>> -#ifdef CONFIG_PM
>>  		.pm	= &st1232_ts_pm_ops,
>> -#endif
>>  	},
>>  };
>>  
>> -- 
>> 1.7.7.6
>> 
>> 
>> -- 
>> Dmitry
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
