From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v2 10/17] i2c: add locomo i2c driver
Date: Tue, 12 May 2015 22:27:07 +0300
Message-ID: <CALT56yNHvJ1Swj2pp2JrBaJBensSP703JXQKfvivFrJOYf85QA@mail.gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-11-git-send-email-dbaryshkov@gmail.com>
	<20150512192413.GE4449@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20150512192413.GE4449@schokonusskuchen.bad>
Sender: linux-leds-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.org>, linux-spi <linux-spi@vger.kern>
List-Id: linux-input@vger.kernel.org

2015-05-12 22:24 GMT+03:00 Wolfram Sang <wsa@the-dreams.de>:
> On Tue, Apr 28, 2015 at 02:55:47AM +0300, Dmitry Eremin-Solenikov wrote:
>> LoCoMo chip contains a tiny i2c controller destined to control
>> M62332 DAC. Provide a separate I2C driver for this cell.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> Thanks for the submission!
>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/mfd/locomo.h>
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/i2c-algo-bit.h>
>
> To avoid duplicates, I prefer the includes to be sorted. No need to
> resend because of that, though.
>
> Kudos for brushing up old code! Do you want the drivers go via the
> subsystem trees? Or is there a dependency so it should go in via some
> other tree in one go?

There is a header dependency -- <linux/mfd/locomo.h> is a new header.
I'd prefer for these patches to go in via one of MFD, arm-soc or ARM trees
as a whole series (if that would be ok with respective maintainers).


-- 
With best wishes
Dmitry
