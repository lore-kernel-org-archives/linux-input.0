From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2 02/17] leds: port locomo leds driver to new locomo core
Date: Thu, 14 May 2015 08:35:01 +0200
Message-ID: <55544215.3010401@samsung.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-3-git-send-email-dbaryshkov@gmail.com>
 <554A2DB4.3020000@samsung.com>
 <CALT56yNJWapNw1XLrzfbUDUz1LF_BB9DfF94H6GhbnBUEP80_w@mail.gmail.com>
 <555327EA.5060402@samsung.com>
 <CALT56yOJyZvWF9neC2A09Y_w1Ej41uwWvU=aOOM0idbzUkBiFQ@mail.gmail.com>
 <5553654F.4010608@samsung.com> <20150513164248.GB11891@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32515 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbENGfG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2015 02:35:06 -0400
In-reply-to: <20150513164248.GB11891@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, linux-leds <linux-leds@vger.kernel>

On 05/13/2015 06:42 PM, Dmitry Torokhov wrote:
> On Wed, May 13, 2015 at 04:53:03PM +0200, Jacek Anaszewski wrote:
>> On 05/13/2015 04:14 PM, Dmitry Eremin-Solenikov wrote:
>>> 2015-05-13 13:31 GMT+03:00 Jacek Anaszewski <j.anaszewski@samsung.com>:
>>>> On 05/12/2015 05:35 PM, Dmitry Eremin-Solenikov wrote:
>>>>>
>>>>> 2015-05-06 18:05 GMT+03:00 Jacek Anaszewski <j.anaszewski@samsung.com>:
>>>>>>
>>>>>> On 04/28/2015 01:55 AM, Dmitry Eremin-Solenikov wrote:
>>>>>>>
>>>>>>>
>>>>>>> Adapt locomo leds driver to new locomo core setup.
>>>>>>>
>>>>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>>>>> ---
>>>>>>>     drivers/leds/Kconfig       |   1 -
>>>>>>>     drivers/leds/leds-locomo.c | 119
>>>>>>> +++++++++++++++++++++++----------------------
>>>>>>>     2 files changed, 61 insertions(+), 59 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>>>>>>> index 966b960..4b4650b 100644
>>>>>>> --- a/drivers/leds/Kconfig
>>>>>>> +++ b/drivers/leds/Kconfig
>>>>>>> @@ -79,7 +79,6 @@ config LEDS_LM3642
>>>>>>>     config LEDS_LOCOMO
>>>>>>>           tristate "LED Support for Locomo device"
>>>>>>>           depends on LEDS_CLASS
>>>>>>> -       depends on SHARP_LOCOMO
>>>>>>
>>>>>>
>>>>>>
>>>>>> Why do you remove this dependency?
>>>>>
>>>>>
>>>>> Because SHARP_LOCOMO is a Kconfig symbol for the old driver. New driver
>>>>> uses MFD_LOCOMO Kconfig entry. Also the driver now uses generic platform
>>>>> device and regmap interfaces, so there is no direct dependency on main
>>>>> LoCoMo driver. And the policy (IIRC) was not to have such dependencies.
>>>>
>>>>
>>>> Ack. Shouldn't you also need "select REGMAP_MMIO" ?
>>>
>>> No. Maybe I should add "select REGMAP" instead.
>>
>> REGMAP is enabled by default if REGMAP_MMIO is enabled. Having
>
> That is unfortunately not how select works: it does not automatically
> select parents for the selected symbol.

Please look at config REGMAP declaration in the file
drivers/base/regmap/Kconfig:

config REGMAP
         default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || 
REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
         select LZO_COMPRESS
         select LZO_DECOMPRESS
         select IRQ_DOMAIN if REGMAP_IRQ
         bool

-- 
Best Regards,
Jacek Anaszewski
