From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
Date: Fri, 31 Oct 2014 13:54:08 +0400
Message-ID: <CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>
	<CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo
List-Id: linux-input@vger.kernel.org

Hello,

Thank you for the review of patches.

2014-10-31 10:42 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Oct 28, 2014 at 1:01 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does has
>> several design issues (special bus instead of platform bus, doesn't use
>> mfd-core, etc).
>>
>> Implement 'core' parts of locomo support as an mfd driver.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> (...)
>
>> +/* DAC send data */
>> +#define        M62332_SLAVE_ADDR       0x4e    /* Slave address  */
>> +#define        M62332_W_BIT            0x00    /* W bit (0 only) */
>> +#define        M62332_SUB_ADDR         0x00    /* Sub address    */
>> +#define        M62332_A_BIT            0x00    /* A bit (0 only) */
>> +
>> +/* DAC setup and hold times (expressed in us) */
>> +#define DAC_BUS_FREE_TIME      5       /*   4.7 us */
>> +#define DAC_START_SETUP_TIME   5       /*   4.7 us */
>> +#define DAC_STOP_SETUP_TIME    4       /*   4.0 us */
>> +#define DAC_START_HOLD_TIME    5       /*   4.7 us */
>> +#define DAC_SCL_LOW_HOLD_TIME  5       /*   4.7 us */
>> +#define DAC_SCL_HIGH_HOLD_TIME 4       /*   4.0 us */
>> +#define DAC_DATA_SETUP_TIME    1       /*   250 ns */
>> +#define DAC_DATA_HOLD_TIME     1       /*   300 ns */
>> +#define DAC_LOW_SETUP_TIME     1       /*   300 ns */
>> +#define DAC_HIGH_SETUP_TIME    1       /*  1000 ns */
> (...)
>
> It seems some DAC handling is part of the MFD driver, and we recently
> discussed that MFD should not be doing misc stuff but mainly act as
> arbiter and switching station.
>
> Can you please move the DAC parts of the driver to
> drivers/iio/dac?
>
> The IIO DAC subsystem will likely add other goodies to
> the driver for free and give a nice API to consumers.

I wanted this part to be as simple as possible. I will look into IIO
DAC subsystem.
The DAC is as simple 2 channel 8-bit i2c device connected to a separate i2c bus
controlled through a register in LoCoMo device. One channel is used
for backlight,
other will be used for volume control. So (in theory) I can add the
following device
chain:  locomo -> i2c-locomo -> m62332 -> IIO DAC client.  However isn't that
quite an overkill for just backlight & volume control? Please advice me on this.


[skipped the irqdomain part - I will use them, thanks for the suggestion.]

>> +       /* Longtime timer */
>> +       writew(0, lchip->base + LOCOMO_LTINT);
>> +       /* SPI */
>> +       writew(0, lchip->base + LOCOMO_SPI + LOCOMO_SPIIE);
>> +
>> +       writew(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);
>
> That's a few magic numbers and calculation don't you think?
>
> A comment stating what's going on would be helpful.

Unfortunately little is known here - these values are c&p from old 2.4
Lineo code.
This part is related to generating synchronization pulses for accessing
touchscreen.

-- 
With best wishes
Dmitry
