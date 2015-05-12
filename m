From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v2 02/17] leds: port locomo leds driver to new locomo core
Date: Tue, 12 May 2015 18:35:41 +0300
Message-ID: <CALT56yNJWapNw1XLrzfbUDUz1LF_BB9DfF94H6GhbnBUEP80_w@mail.gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-3-git-send-email-dbaryshkov@gmail.com>
	<554A2DB4.3020000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <554A2DB4.3020000@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.or>
List-Id: linux-input@vger.kernel.org

2015-05-06 18:05 GMT+03:00 Jacek Anaszewski <j.anaszewski@samsung.com>:
> On 04/28/2015 01:55 AM, Dmitry Eremin-Solenikov wrote:
>>
>> Adapt locomo leds driver to new locomo core setup.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>   drivers/leds/Kconfig       |   1 -
>>   drivers/leds/leds-locomo.c | 119
>> +++++++++++++++++++++++----------------------
>>   2 files changed, 61 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index 966b960..4b4650b 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -79,7 +79,6 @@ config LEDS_LM3642
>>   config LEDS_LOCOMO
>>         tristate "LED Support for Locomo device"
>>         depends on LEDS_CLASS
>> -       depends on SHARP_LOCOMO
>
>
> Why do you remove this dependency?

Because SHARP_LOCOMO is a Kconfig symbol for the old driver. New driver
uses MFD_LOCOMO Kconfig entry. Also the driver now uses generic platform
device and regmap interfaces, so there is no direct dependency on main
LoCoMo driver. And the policy (IIRC) was not to have such dependencies.

>
>>         help
>>           This option enables support for the LEDs on Sharp Locomo.
>>           Zaurus models SL-5500 and SL-5600.
>> diff --git a/drivers/leds/leds-locomo.c b/drivers/leds/leds-locomo.c
>> index 80ba048..7fde812 100644
>> --- a/drivers/leds/leds-locomo.c
>> +++ b/drivers/leds/leds-locomo.c
>> @@ -9,89 +9,92 @@
>>    */
>>
>>   #include <linux/kernel.h>
>> -#include <linux/init.h>
>> -#include <linux/module.h>
>> -#include <linux/device.h>
>>   #include <linux/leds.h>
>> -
>> -#include <mach/hardware.h>
>> -#include <asm/hardware/locomo.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/locomo.h>
>
>
> Please keep alphabetical order.

Ack

>
>> +
>> +struct locomo_led {
>> +       struct led_classdev led;
>> +       struct regmap *regmap;
>> +       unsigned int reg;
>> +};
>>
>>   static void locomoled_brightness_set(struct led_classdev *led_cdev,
>> -                               enum led_brightness value, int offset)
>> +                               enum led_brightness value)
>>   {
>> -       struct locomo_dev *locomo_dev = LOCOMO_DEV(led_cdev->dev->parent);
>> -       unsigned long flags;
>> +       struct locomo_led *led = container_of(led_cdev, struct locomo_led,
>> led);
>>
>> -       local_irq_save(flags);
>> -       if (value)
>> -               locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase +
>> offset);
>> -       else
>> -               locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase +
>> offset);
>> -       local_irq_restore(flags);
>> +       regmap_write(led->regmap, led->reg,
>> +                       value ? LOCOMO_LPT_TOFH : LOCOMO_LPT_TOFL);
>>   }
>
>
> Please use work queue for setting brightness. This is required for the
> driver to be compatible with led triggers. You can refer to the
> existing LED drivers on how to implement this.

Hmm. Why? The regmap here uses MMIO access, so it is atomic operation
and doesn't need to be wrapped into work queue, does it?


[skipped]

-- 
With best wishes
Dmitry
