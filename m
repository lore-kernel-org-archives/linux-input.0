From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] touchscreen: stmpe-ts: enable module autoload
Date: Fri, 22 May 2015 23:02:38 +0200
Message-ID: <555F996E.8080802@gmail.com>
References: <555E4BF8.80401@web.de> <20150521230612.GA39517@dtor-ws> <555EBFF3.1010602@gmail.com> <20150522182922.GF40101@dtor-ws> <555F7D1E.7020701@gmail.com> <20150522201725.GI40101@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34906 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983AbbEVVC4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 17:02:56 -0400
Received: by wicmx19 with SMTP id mx19so58710033wic.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2015 14:02:55 -0700 (PDT)
In-Reply-To: <20150522201725.GI40101@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Am 22.05.2015 um 22:17 schrieb Dmitry Torokhov:
> On Fri, May 22, 2015 at 09:01:50PM +0200, Heiner Kallweit wrote:
>> Am 22.05.2015 um 20:29 schrieb Dmitry Torokhov:
>>> On Fri, May 22, 2015 at 07:34:43AM +0200, Heiner Kallweit wrote:
>>>> Am 22.05.2015 um 01:06 schrieb Dmitry Torokhov:
>>>>> Hi Heiner,
>>>>>
>>>>> On Thu, May 21, 2015 at 11:19:52PM +0200, Heiner Kallweit wrote:
>>>>>> Even with poper DT config the module didn't autoload.
>>>>>> That's fixed by this additional alias.
>>>>>>
>>>>>> Tested successfully with a STMPE610-based Adafruit PITFT Plus 3.5"
>>>>>> on RPI2 under Arch Linux ARM (kernel 3.18.13).
>>>>>>
>>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>>> ---
>>>>>>  drivers/input/touchscreen/stmpe-ts.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
>>>>>> index e4c3125..1940e3c 100644
>>>>>> --- a/drivers/input/touchscreen/stmpe-ts.c
>>>>>> +++ b/drivers/input/touchscreen/stmpe-ts.c
>>>>>> @@ -393,4 +393,5 @@ module_platform_driver(stmpe_ts_driver);
>>>>>>  MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
>>>>>>  MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
>>>>>>  MODULE_LICENSE("GPL");
>>>>>> +MODULE_ALIAS("spi:" STMPE_TS_NAME);
>>>>>>  MODULE_ALIAS("platform:" STMPE_TS_NAME);
>>>>>
>>>>> Bit this is not an SPI driver, it is a platform driver for a MFD cell.
>>>>> Why does adding SPI alias help?
>>>>>
>>>>> Thanks.
>>>>>
>>>> The STMPE610 in my case is used on a small touchscreen for the Raspberry Pi
>>>> and touchscreen controller as well as display controller are connected via
>>>> SPI + a few GPIOs to the RPI.
>>>>
>>>> The display controller is supported by the fbtft driver and the drivers
>>>> for the respective display controllers have similar aliases.
>>>> see e.g. drivers/staging/fbtft/fb_hx8353d.c
>>>>
>>>> MODULE_ALIAS("spi:hx8353d");
>>>> MODULE_ALIAS("platform:hx8353d");
>>>
>>> I understand why both platform and spi aliases are needed for
>>> fb_hx8353d: FBTFT_REGISTER_DRIVER macro does register 2 separate
>>> drivers, one SPI and another platform, and so needs both aliases. You
>>> still have not explained why we need SPI alias for stmpe-ts which is MFD
>>> cell represented by a platform device/driver no matter what bus is used
>>> to connect stmpe itself, I2C or SPI.
>>>
>>> What is the modalias on the stmpe-ts device in sysfs?
>>>
>>> Thanks.
>>>
>> These are the stmpe-related entries under /sys/devices:
>>
>> ./soc/3f204000.spi/spi_master/spi0/spi0.1/stmpe-gpio
>> ./soc/3f204000.spi/spi_master/spi0/spi0.1/stmpe-ts
>>
>> stmpe-ts/modalias is:
>> of:Nstmpe_touchscreenT<NULL>Cst,stmpe-ts
> 
> OK, that explains it. Does the patch below help?
> 
> Thanks.
> 
Yes, with your patch autoloading works. Thanks.

