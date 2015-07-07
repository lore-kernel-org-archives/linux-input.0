From: Dirk Behme <dirk.behme@gmail.com>
Subject: Re: [PATCH 2/2] Input: zforce - convert to use the gpiod interface
Date: Tue, 07 Jul 2015 20:38:51 +0200
Message-ID: <559C1CBB.2070000@gmail.com>
References: <1435914469-8955-1-git-send-email-dirk.behme@de.bosch.com> <1435914469-8955-3-git-send-email-dirk.behme@de.bosch.com> <20150706232551.GD32140@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33064 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933172AbbGGSi6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2015 14:38:58 -0400
Received: by wiwl6 with SMTP id l6so323158400wiw.0
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2015 11:38:56 -0700 (PDT)
In-Reply-To: <20150706232551.GD32140@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-input@vger.kernel.org

On 07.07.2015 01:25, Dmitry Torokhov wrote:
> Hi Dirk,
>
> On Fri, Jul 03, 2015 at 11:07:49AM +0200, Dirk Behme wrote:
>> diff --git a/include/linux/platform_data/zforce_ts.h b/include/linux/platform_data/zforce_ts.h
>> index 44cd90f..1794268 100644
>> --- a/include/linux/platform_data/zforce_ts.h
>> +++ b/include/linux/platform_data/zforce_ts.h
>> @@ -15,12 +15,9 @@
>>   #ifndef _LINUX_INPUT_ZFORCE_TS_H
>>   #define _LINUX_INPUT_ZFORCE_TS_H
>>
>> -#include <linux/of_gpio.h>
>> -
>>   struct zforce_ts_platdata {
>> -	int gpio_int;
>> -	int gpio_rst;
>> -	enum of_gpio_flags reset_active_low;
>> +	struct gpio_desc *gpio_int;
>> +	struct gpio_desc *gpio_rst;
>>
>>   	unsigned int x_max;
>>   	unsigned int y_max;
>
> I do not think we should be plumbing GPIO descriptors directly into
> platform data. If board doe snot want to use DT/ACPI they will simply
> have to attach GPIO lookup table to the device (via
> gpiod_add_lookup_table).
>
> So I intend to apply the version below...

While it's technically fine, it seems to mix the two parts I've done 
in separate patches (adding the missing polarity handling and 
converting to gpiod) in one patch. Which might be less obvious to 
reviewers and in case of regressions. But anyway, if you like this, 
I'm fine with it.

Thanks!

Best regards

Dirk

