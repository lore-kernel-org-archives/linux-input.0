From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2 02/17] leds: port locomo leds driver to new locomo core
Date: Wed, 13 May 2015 16:53:03 +0200
Message-ID: <5553654F.4010608@samsung.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-3-git-send-email-dbaryshkov@gmail.com>
 <554A2DB4.3020000@samsung.com>
 <CALT56yNJWapNw1XLrzfbUDUz1LF_BB9DfF94H6GhbnBUEP80_w@mail.gmail.com>
 <555327EA.5060402@samsung.com>
 <CALT56yOJyZvWF9neC2A09Y_w1Ej41uwWvU=aOOM0idbzUkBiFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:11550 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934074AbbEMOxJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 10:53:09 -0400
In-reply-to: <CALT56yOJyZvWF9neC2A09Y_w1Ej41uwWvU=aOOM0idbzUkBiFQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.or>

On 05/13/2015 04:14 PM, Dmitry Eremin-Solenikov wrote:
> 2015-05-13 13:31 GMT+03:00 Jacek Anaszewski <j.anaszewski@samsung.com>:
>> On 05/12/2015 05:35 PM, Dmitry Eremin-Solenikov wrote:
>>>
>>> 2015-05-06 18:05 GMT+03:00 Jacek Anaszewski <j.anaszewski@samsung.com>:
>>>>
>>>> On 04/28/2015 01:55 AM, Dmitry Eremin-Solenikov wrote:
>>>>>
>>>>>
>>>>> Adapt locomo leds driver to new locomo core setup.
>>>>>
>>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>>> ---
>>>>>     drivers/leds/Kconfig       |   1 -
>>>>>     drivers/leds/leds-locomo.c | 119
>>>>> +++++++++++++++++++++++----------------------
>>>>>     2 files changed, 61 insertions(+), 59 deletions(-)
>>>>>
>>>>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>>>>> index 966b960..4b4650b 100644
>>>>> --- a/drivers/leds/Kconfig
>>>>> +++ b/drivers/leds/Kconfig
>>>>> @@ -79,7 +79,6 @@ config LEDS_LM3642
>>>>>     config LEDS_LOCOMO
>>>>>           tristate "LED Support for Locomo device"
>>>>>           depends on LEDS_CLASS
>>>>> -       depends on SHARP_LOCOMO
>>>>
>>>>
>>>>
>>>> Why do you remove this dependency?
>>>
>>>
>>> Because SHARP_LOCOMO is a Kconfig symbol for the old driver. New driver
>>> uses MFD_LOCOMO Kconfig entry. Also the driver now uses generic platform
>>> device and regmap interfaces, so there is no direct dependency on main
>>> LoCoMo driver. And the policy (IIRC) was not to have such dependencies.
>>
>>
>> Ack. Shouldn't you also need "select REGMAP_MMIO" ?
>
> No. Maybe I should add "select REGMAP" instead.

REGMAP is enabled by default if REGMAP_MMIO is enabled. Having
REGMAP_MMIO selected would also allow to notice at first glance which
regmap backend is used. This would in turn provide a straightforward
explanation on why brightness_set op is not delegated to work queue.

>>>>>    static void locomoled_brightness_set(struct led_classdev *led_cdev,
>>>>> -                               enum led_brightness value, int offset)
>>>>> +                               enum led_brightness value)
>>>>>     {
>>>>> -       struct locomo_dev *locomo_dev =
>>>>> LOCOMO_DEV(led_cdev->dev->parent);
>>>>> -       unsigned long flags;
>>>>> +       struct locomo_led *led = container_of(led_cdev, struct
>>>>> locomo_led,
>>>>> led);
>>>>>
>>>>> -       local_irq_save(flags);
>>>>> -       if (value)
>>>>> -               locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase +
>>>>> offset);
>>>>> -       else
>>>>> -               locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase +
>>>>> offset);
>>>>> -       local_irq_restore(flags);
>>>>> +       regmap_write(led->regmap, led->reg,
>>>>> +                       value ? LOCOMO_LPT_TOFH : LOCOMO_LPT_TOFL);
>>>>>     }
>>>>
>>>>
>>>>
>>>> Please use work queue for setting brightness. This is required for the
>>>> driver to be compatible with led triggers. You can refer to the
>>>> existing LED drivers on how to implement this.
>>>
>>>
>>> Hmm. Why? The regmap here uses MMIO access, so it is atomic operation
>>> and doesn't need to be wrapped into work queue, does it?
>>
>>
>> Triggers can call brightness_set op in the interrupt context, so it
>> cannot sleep. I see "map->lock(map->lock_arg)" in regmap_write, thus
>> I am inferring that it can sleep.
>>
>> I am not sure if regmap implements its 'lock' op when using MMIO.
>>
>> The best way to figure this out is turning "LED Timer Trigger" on
>> in the config and execute:
>>
>> echo "timer" > trigger
>
> It works without any "might sleep/sleeping in atomic context" warnings.
>
> Technically I'd agree with you. If I'm using regmaps, ideally I should not
> depend on the exact backend and put working with it to the work queue.
> However as this is a driver for quite old IP block, it is not used with
> regmap backends other than MMIO, I'd deduce, it's ok to do things
> in a more relaxed way and to call regmap_write even from atomic
> contexts.

Ack.

-- 
Best Regards,
Jacek Anaszewski
