From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 08/17] gpio: locomo: implement per-pin irq handling
Date: Tue, 12 May 2015 13:15:25 +0200
Message-ID: <CACRpkdYQFYaA87N2f1uizRo=sDj2P4k4m1O_0_cQsi4BZbeGkg@mail.gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-9-git-send-email-dbaryshkov@gmail.com>
	<CACRpkdZt+rjzVSqXE6MDaY5S9gezeTu+2QWu31xKsg08TpXibw@mail.gmail.com>
	<CALT56yNJutWTW5zsos+=Uh+BDvO4o_tqBEj+H621TncVK6eD_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CALT56yNJutWTW5zsos+=Uh+BDvO4o_tqBEj+H621TncVK6eD_Q@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, linux-leds@vger.kernel.or
List-Id: linux-input@vger.kernel.org

On Wed, May 6, 2015 at 6:42 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> 2015-05-06 17:15 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Tue, Apr 28, 2015 at 1:55 AM, Dmitry Eremin-Solenikov
>> <dbaryshkov@gmail.com> wrote:
>>
>>> LoCoMo has a possibility to generate per-GPIO edge irqs. Support for
>>> that was there in old locomo driver, got 'cleaned up' during old driver
>>> IRQ cascading cleanup and is now reimplemented. It is expected that
>>> SL-5500 (collie) will use locomo gpio irqs for mmc detection irq.
>>>
>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks for review of the patches.
>
>> Assume this will also go through MFD.
>>
>>> +       irq_set_chained_handler(lg->irq, NULL);
>>> +       irq_set_handler_data(lg->irq, NULL);
>>
>> Why is this needed? If the GPIOLIB_IRQCHIP code in
>> gpiolib.c is not doing this then maybe it's the core code that
>> needs fixing rather than having this in the driver.
>
> I have skimmed through the rest of drivers using
> gpiochip_set_chained_irqchip(). Indeed none of the drivers NULL
> the chained handled and handler data. However I couldn't locate
> the code where they would be cleared.
>
> Should I still send the patch fixing the GPIOLIB_IRQCHIP?

Yes I guess you need to save parent_irq in struct gpio_chip and
remove it in gpiochip_irqchip_remove() if it's != 0.

Yours,
Linus Walleij
