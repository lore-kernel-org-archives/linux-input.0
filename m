From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH 5/7] ARM: S3C64XX: Add s3c64xx support to touchscreen
 driver
Date: Mon, 08 Mar 2010 21:04:58 +0100
Message-ID: <4B95586A.2080806@gmail.com>
References: <b2e8f9f71003081038v5096204dm8bb4bfaeadb3203d@mail.gmail.com> <20100308200126.GH24864@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:46329 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523Ab0CHUFC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Mar 2010 15:05:02 -0500
In-Reply-To: <20100308200126.GH24864@trinity.fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Op 08-03-10 21:01, Ben Dooks schreef:
> On Mon, Mar 08, 2010 at 07:38:59PM +0100, Maurus Cuelenaere wrote:
>    
>> This ack's the extra interrupt s3c64xx platforms have in the touchscreen driver.
>>      
> This acks, no need for an ' here.
>
> You'd have been better off sayinh:
>
> Add support for the S3C64XX touchscreen to the s3c2410_ts driver, ensuring
> it compiles and supports the extra features such as the interrupt generation.
>    

Ok, should I resend this?

>> Signed-off-by: Maurus Cuelenaere<mcuelenaere@gmail.com>
>> ---
>>   drivers/input/touchscreen/Kconfig      |    6 +++---
>>   drivers/input/touchscreen/s3c2410_ts.c |   26 ++++++++++++++++++++++----
>>   2 files changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/Kconfig
>> b/drivers/input/touchscreen/Kconfig
>> index dfafc76..0378b3d 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -146,11 +146,11 @@ config TOUCHSCREEN_FUJITSU
>>   	  module will be called fujitsu-ts.
>>
>>   config TOUCHSCREEN_S3C2410
>> -	tristate "Samsung S3C2410 touchscreen input driver"
>> -	depends on ARCH_S3C2410
>> +	tristate "Samsung S3C touchscreen input driver"
>> +	depends on ARCH_S3C2410 || ARCH_S3C64XX
>>   	select S3C24XX_ADC
>>   	help
>> -	  Say Y here if you have the s3c2410 touchscreen.
>> +	  Say Y here if you have the s3c touchscreen.
>>
>>   	  If unsure, say N.
>>
>> diff --git a/drivers/input/touchscreen/s3c2410_ts.c
>> b/drivers/input/touchscreen/s3c2410_ts.c
>> index 0cd0ca6..04c990e 100644
>> --- a/drivers/input/touchscreen/s3c2410_ts.c
>> +++ b/drivers/input/touchscreen/s3c2410_ts.c
>> @@ -40,7 +40,9 @@
>>   #include<plat/regs-adc.h>
>>   #include<plat/ts.h>
>>
>>      
> OA>  +#ifdef PLAT_S3C24XX
>    
>>   #include<mach/regs-gpio.h>
>> +#endif
>>      
> hmm, does this correct a compile error?
>    

It does, this has been mentioned in a previous version of this patch.
Last time I checked, this file wasn't available for S3C64xx targets.
Also, see below.

>>   #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
>>
>> @@ -88,6 +90,12 @@ struct s3c2410ts {
>>
>>   static struct s3c2410ts ts;
>>
>> +enum s3c_cpu_type {
>> +	TYPE_S3C2410,
>> +	TYPE_S3C2440,
>> +	TYPE_S3C64XX,
>> +};
>> +
>>   /**
>>    * s3c2410_ts_connect - configure gpio for s3c2410 systems
>>    *
>> @@ -97,10 +105,12 @@ static struct s3c2410ts ts;
>>   */
>>   static inline void s3c2410_ts_connect(void)
>>   {
>> +#ifdef PLAT_S3C24XX
>>   	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
>>   	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
>>   	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
>>   	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
>> +#endif
>>   }

The s3c2410_gpio_cfgpin() and S3C2410_* aren't defined for S3C64xx builds.

-- 
Maurus Cuelenaere

