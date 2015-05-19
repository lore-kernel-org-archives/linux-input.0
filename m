From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v3 06/17] video: lcd: add LoCoMo LCD driver
Date: Tue, 19 May 2015 12:45:00 +0300
Message-ID: <CALT56yMwGngNvRWiCux962B=EQODUHW3=-ed6SZWJ9PnSPm09A@mail.gmail.com>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
	<1431880077-26321-7-git-send-email-dbaryshkov@gmail.com>
	<20150519093644.GT22418@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150519093644.GT22418@x1>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, linux-fbdev@vger.
List-Id: linux-input@vger.kernel.org

2015-05-19 12:36 GMT+03:00 Lee Jones <lee.jones@linaro.org>:
> On Sun, 17 May 2015, Dmitry Eremin-Solenikov wrote:
>
>> LoCoMo has some special handling for TFT screens attached to Collie and
>> Poodle. Implement that as a separate driver.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  drivers/video/backlight/Kconfig      |  10 ++
>>  drivers/video/backlight/Makefile     |   1 +
>>  drivers/video/backlight/locomo_lcd.c | 285 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 296 insertions(+)
>>  create mode 100644 drivers/video/backlight/locomo_lcd.c
>
> This looks like it should be part of patch 16.
>
> How much of this file is the same as the one removed later in the set?

This is a completely new driver. Only few comments remained from old
locomolcd.c.

-- 
With best wishes
Dmitry
