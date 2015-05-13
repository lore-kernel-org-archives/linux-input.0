From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 02/17] leds: port locomo leds driver to new locomo core
Date: Wed, 13 May 2015 17:14:01 +0300
Message-ID: <CALT56yOJyZvWF9neC2A09Y_w1Ej41uwWvU=aOOM0idbzUkBiFQ@mail.gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-3-git-send-email-dbaryshkov@gmail.com>
	<554A2DB4.3020000@samsung.com>
	<CALT56yNJWapNw1XLrzfbUDUz1LF_BB9DfF94H6GhbnBUEP80_w@mail.gmail.com>
	<555327EA.5060402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <555327EA.5060402-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-leds <linux-leds-u79uwXL29TaqPxH82wqD4g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

2015-05-13 13:31 GMT+03:00 Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
> On 05/12/2015 05:35 PM, Dmitry Eremin-Solenikov wrote:
>>
>> 2015-05-06 18:05 GMT+03:00 Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
>>>
>>> On 04/28/2015 01:55 AM, Dmitry Eremin-Solenikov wrote:
>>>>
>>>>
>>>> Adapt locomo leds driver to new locomo core setup.
>>>>
>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>    drivers/leds/Kconfig       |   1 -
>>>>    drivers/leds/leds-locomo.c | 119
>>>> +++++++++++++++++++++++----------------------
>>>>    2 files changed, 61 insertions(+), 59 deletions(-)
>>>>
>>>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>>>> index 966b960..4b4650b 100644
>>>> --- a/drivers/leds/Kconfig
>>>> +++ b/drivers/leds/Kconfig
>>>> @@ -79,7 +79,6 @@ config LEDS_LM3642
>>>>    config LEDS_LOCOMO
>>>>          tristate "LED Support for Locomo device"
>>>>          depends on LEDS_CLASS
>>>> -       depends on SHARP_LOCOMO
>>>
>>>
>>>
>>> Why do you remove this dependency?
>>
>>
>> Because SHARP_LOCOMO is a Kconfig symbol for the old driver. New driver
>> uses MFD_LOCOMO Kconfig entry. Also the driver now uses generic platform
>> device and regmap interfaces, so there is no direct dependency on main
>> LoCoMo driver. And the policy (IIRC) was not to have such dependencies.
>
>
> Ack. Shouldn't you also need "select REGMAP_MMIO" ?

No. Maybe I should add "select REGMAP" instead.

>>>>   static void locomoled_brightness_set(struct led_classdev *led_cdev,
>>>> -                               enum led_brightness value, int offset)
>>>> +                               enum led_brightness value)
>>>>    {
>>>> -       struct locomo_dev *locomo_dev =
>>>> LOCOMO_DEV(led_cdev->dev->parent);
>>>> -       unsigned long flags;
>>>> +       struct locomo_led *led = container_of(led_cdev, struct
>>>> locomo_led,
>>>> led);
>>>>
>>>> -       local_irq_save(flags);
>>>> -       if (value)
>>>> -               locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase +
>>>> offset);
>>>> -       else
>>>> -               locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase +
>>>> offset);
>>>> -       local_irq_restore(flags);
>>>> +       regmap_write(led->regmap, led->reg,
>>>> +                       value ? LOCOMO_LPT_TOFH : LOCOMO_LPT_TOFL);
>>>>    }
>>>
>>>
>>>
>>> Please use work queue for setting brightness. This is required for the
>>> driver to be compatible with led triggers. You can refer to the
>>> existing LED drivers on how to implement this.
>>
>>
>> Hmm. Why? The regmap here uses MMIO access, so it is atomic operation
>> and doesn't need to be wrapped into work queue, does it?
>
>
> Triggers can call brightness_set op in the interrupt context, so it
> cannot sleep. I see "map->lock(map->lock_arg)" in regmap_write, thus
> I am inferring that it can sleep.
>
> I am not sure if regmap implements its 'lock' op when using MMIO.
>
> The best way to figure this out is turning "LED Timer Trigger" on
> in the config and execute:
>
> echo "timer" > trigger

It works without any "might sleep/sleeping in atomic context" warnings.

Technically I'd agree with you. If I'm using regmaps, ideally I should not
depend on the exact backend and put working with it to the work queue.
However as this is a driver for quite old IP block, it is not used with
regmap backends other than MMIO, I'd deduce, it's ok to do things
in a more relaxed way and to call regmap_write even from atomic
contexts.

-- 
With best wishes
Dmitry
