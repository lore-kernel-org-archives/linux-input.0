From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: stmpe-ts - enforce device tree only mode
Date: Sat, 23 May 2015 09:41:50 -0700
Message-ID: <3ECB4834-2EEF-471A-B634-EFC95DFF725F@gmail.com>
References: <20150522225832.GA19831@dtor-ws> <201505231838.54349.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34634 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964806AbbEWQl6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 May 2015 12:41:58 -0400
In-Reply-To: <201505231838.54349.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-input@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org

On May 23, 2015 9:38:54 AM PDT, Marek Vasut <marex@denx.de> wrote:
>On Saturday, May 23, 2015 at 12:58:32 AM, Dmitry Torokhov wrote:
>> The STMPE MFD is only used with device tree configured systems (and
>STMPE
>> MFD core depends on OF), so force the configuration to come from
>device
>> tree only.
>> 
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>
>Hi!
>
>[...]
>
>> @@ -351,14 +336,13 @@ static int stmpe_input_probe(struct
>platform_device
>> *pdev) idev->name = STMPE_TS_NAME;
>>  	idev->phys = STMPE_TS_NAME"/input0";
>>  	idev->id.bustype = BUS_I2C;
>> -	idev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>> -	idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
>> 
>>  	idev->open = stmpe_ts_open;
>>  	idev->close = stmpe_ts_close;
>> 
>>  	input_set_drvdata(idev, ts);
>> 
>> +	input_set_capability(idev, EV_KEY, BTN_TOUCH);
>
>Isn't this part of the patch dropping the EV_ABS evbit ?

No, on newer kernels input_set_abs_paramd() takes care of setting we EV_ABS in evbit as well.

>
>>  	input_set_abs_params(idev, ABS_X, 0, XY_MASK, 0, 0);
>>  	input_set_abs_params(idev, ABS_Y, 0, XY_MASK, 0, 0);
>>  	input_set_abs_params(idev, ABS_PRESSURE, 0x0, 0xff, 0, 0);
>
>
>[...]
>
>Best regards,
>Marek Vasut

Hi Marek,
Thanks.

-- 
Dmitry
