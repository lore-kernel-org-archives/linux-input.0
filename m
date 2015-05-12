From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v2 01/17] mfd: add new driver for Sharp LoCoMo
Date: Tue, 12 May 2015 23:39:01 +0300
Message-ID: <CALT56yP6FPhGRZFJZkyjjpqGJ6bofg+a1BTC9KcVAgpmt2htoA@mail.gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-2-git-send-email-dbaryshkov@gmail.com>
	<20150428184525.GJ9169@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150428184525.GJ9169@x1>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.org>, linux-spi <linux-spi@vger.kern>
List-Id: linux-input@vger.kernel.org

2015-04-28 21:45 GMT+03:00 Lee Jones <lee.jones@linaro.org>:
> On Tue, 28 Apr 2015, Dmitry Eremin-Solenikov wrote:
>
>> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does has
>> several design issues (special bus instead of platform bus, doesn't use
>> mfd-core, etc).
>>
>> Implement 'core' parts of locomo support as an mfd driver.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---

Thanks for the review. I agree (and have implemented) with most of
your comments.
However I have few questions. See below.

>
>> +/* the following is the overall data for the locomo chip */
>> +struct locomo {
>> +     struct device *dev;
>> +     unsigned int irq;
>> +     spinlock_t lock;
>> +     struct irq_domain *domain;
>> +     struct regmap *regmap;
>> +};
>> +
>> +static struct resource locomo_kbd_resources[] = {
>> +     DEFINE_RES_IRQ(IRQ_LOCOMO_KEY),
>> +};
>> +
>> +static struct resource locomo_gpio_resources[] = {
>> +     DEFINE_RES_IRQ(IRQ_LOCOMO_GPIO),
>> +};
>> +
>> +/* Filled in locomo_probe() function. */
>> +static struct locomo_gpio_platform_data locomo_gpio_pdata;
>
> I'd prefer you didn't use globals for this.

Just for platform data, or for all the structures?

>> +static struct resource locomo_lt_resources[] = {
>> +     DEFINE_RES_IRQ(IRQ_LOCOMO_LT),
>> +};
>> +
>> +static struct resource locomo_spi_resources[] = {
>> +     DEFINE_RES_IRQ(IRQ_LOCOMO_SPI),
>> +};
>> +
>> +/* Filled in locomo_probe() function. */
>> +static struct locomo_lcd_platform_data locomo_lcd_pdata;
>> +
>> +static struct mfd_cell locomo_cells[] = {
>> +     {
>> +             .name = "locomo-kbd",
>> +             .resources = locomo_kbd_resources,
>> +             .num_resources = ARRAY_SIZE(locomo_kbd_resources),
>> +     },
>> +     {
>> +             .name = "locomo-gpio",
>> +             .resources = locomo_gpio_resources,
>> +             .num_resources = ARRAY_SIZE(locomo_gpio_resources),
>> +             .platform_data = &locomo_gpio_pdata,
>> +             .pdata_size = sizeof(locomo_gpio_pdata),
>> +     },
>> +     {
>> +             .name = "locomo-lt", /* Long time timer */
>> +             .resources = locomo_lt_resources,
>> +             .num_resources = ARRAY_SIZE(locomo_lt_resources),
>> +     },
>> +     {
>> +             .name = "locomo-spi",
>> +             .resources = locomo_spi_resources,
>> +             .num_resources = ARRAY_SIZE(locomo_spi_resources),
>> +     },
>> +     {
>> +             .name = "locomo-led",
>> +     },
>> +     {
>> +             .name = "locomo-backlight",
>> +     },
>
> Please make these:
>
>> +     { .name = "locomo-led" },
>> +     { .name = "locomo-backlight" },
>
> ... and put them at the bottom.

They will be populated by of_compatible lines, so it makes little sense
to me. What about adding of compatibility lines to this patch?

>> +     while (1) {
>> +             regmap_read(lchip->regmap, LOCOMO_ICR, &req);
>> +             req &= 0x0f00;
>
> What is this magic number?  Please #define it.

Adding comments to this function instead.

>
>> +             if (!req)
>> +                     break;
>> +
>> +             irq = ffs(req) - 9;
>
> Minus another random number?  Either define it or enter a comment.
>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int locomo_suspend(struct device *dev)
>> +{
>> +     struct locomo *lchip = dev_get_drvdata(dev);
>> +
>> +     /* AUDIO */
>
> WHY ARE YOU SHOUTING?  Ironic eh? ;)
>
>> +     regmap_write(lchip->regmap, LOCOMO_PAIF, 0x00);
>> +
>> +     /*
>> +      * Original code disabled the clock depending on leds settings
>> +      * However we disable leds before suspend, thus it's safe
>> +      * to just assume this setting.
>> +      */
>> +     /* CLK32 off */
>> +     regmap_write(lchip->regmap, LOCOMO_C32K, 0x00);
>> +
>> +     /* 22MHz/24MHz clock off */
>> +     regmap_write(lchip->regmap, LOCOMO_ACC, 0x00);
>> +
>> +     return 0;
>> +}
>> +
>> +static int locomo_resume(struct device *dev)
>> +{
>> +     struct locomo *lchip = dev_get_drvdata(dev);
>
> Do audio and clk sort themselves out?

PAIF and ACC registers are used only by audio parts of the device. However
there is no current Linux driver for those parts. The registers are cleared
in case the firmware has set something in them, but in future it will
be the task
of the audio driver to properly clear and restore them.

>> +     regmap_write(lchip->regmap, LOCOMO_C32K, 0x00);
>> +
>> +     return 0;
>> +}
>> +

[skipped]
>> +
>> +     if (pdata) {
>> +             locomo_gpio_pdata.gpio_base = pdata->gpio_base;
>> +             locomo_lcd_pdata.comadj = pdata->comadj;
>> +     } else {
>> +             locomo_gpio_pdata.gpio_base = -1;
>> +             locomo_lcd_pdata.comadj = 128;
>> +     }
>
> struct locomo_gpio_platform_data locomo_gpio_pdata;
>
> locomo_gpio_pdata = devm_kzalloc(<blah>);
>
> locomo_cells[GPIO].platform_data = locomo_gpio_pdata;

I do not quite agree with you at this place. The passed platform_data
will be kmemdup()'ed inside platform core. So the whole struct will be
duplicated twice inside kmallocate'd memory. Ideally I'd like to drop
the whole platform_data busyness, but that requires switching to DTS
first.

>> diff --git a/include/linux/mfd/locomo.h b/include/linux/mfd/locomo.h
>> new file mode 100644
>> index 0000000..6729767
>> --- /dev/null
>> +++ b/include/linux/mfd/locomo.h

>> +/* MCS decoder for boot selecting */
>> +#define LOCOMO_MCSX0 0x10
>> +#define LOCOMO_MCSX1 0x14
>> +#define LOCOMO_MCSX2 0x18
>> +#define LOCOMO_MCSX3 0x1c
>
> These are pretty cryptic.  Any way of making them easier to identify.

No way. The names are based on old Sharp code. The drivers do not use
them, but I'd like to still keep the registers for the reference purposes.

>> +struct locomo_gpio_platform_data {
>> +     unsigned int gpio_base;
>> +};
>
> A struct for a single int seems overkill.
>
>> +struct locomo_lcd_platform_data {
>> +     u8 comadj;
>> +};
>> +
>> +struct locomo_platform_data {
>> +     unsigned int gpio_base;
>> +     u8 comadj;
>> +};
>
> Why do you need to pass gpio_base twice?

First: machine file -> core driver
Second: core driver -> gpio driver

The other way to do the same would be:

struct locomo_gpio_platform_data {
     unsigned int gpio_base;
};

struct locomo_lcd_platform_data {
     u8 comadj;
};

struct locomo_platform_data {
     struct locomo_gpio_platform_data gpio_pdata;
     struct locomo_lcd_platform_data lcd_pdata;
};

And to assign pointers to the passed data in the mfd_cells
during locomo_probe. Does that look better to you?

-- 
With best wishes
Dmitry
