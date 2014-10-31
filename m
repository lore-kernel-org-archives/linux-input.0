From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 11/15] sound: soc: poodle: make use of new locomo GPIO interface
Date: Fri, 31 Oct 2014 13:58:47 +0400
Message-ID: <CALT56yP6K-sXOGM4z-WRsvFVjOi-13wM+Ewqn6WpDmNB4xcOEg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-12-git-send-email-dbaryshkov@gmail.com>
	<20141028145850.GU18557@sirena.org.uk>
	<CAAVeFuKgARoMFzf+663iP6cULs93d4WSQS8ESjUb9VcxguWurA@mail.gmail.com>
	<CACRpkdY-RDuxGMWe_SD613ovsEoHhxjP1+3T-m_zKQSx=mkFjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY-RDuxGMWe_SD613ovsEoHhxjP1+3T-m_zKQSx=mkFjA@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jingoo
List-Id: linux-input@vger.kernel.org

2014-10-31 12:52 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Oct 29, 2014 at 4:03 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
>> On Tue, Oct 28, 2014 at 11:58 PM, Mark Brown <broonie@kernel.org> wrote:
>>> On Tue, Oct 28, 2014 at 03:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
>>>> Since LoCoMo driver has been converted to provide proper gpiolib
>>>> interface, make poodle ASoC platform driver use gpiolib API.
>>>
>>> Please use subject lines matching the style for the subsystem.
>>>
>>>> +     ret = gpio_request_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
>>>> +     if (ret) {
>>>> +             dev_err(&pdev->dev, "gpio_request_array() failed: %d\n",
>>>> +                             ret);
>>>> +             return ret;
>>>> +     }
>>>
>>> I sense a need for devm_gpio_request_array() here.  Otherwise this looks
>>> fine - ideally it'd move to gpiod but moving to gpiolib is a clear win
>>> so no need to block on this.
>>
>> I wish Dmitry took the opportunity to move this driver to the gpiod
>> API, especially since doing so would be trivial for this driver.
>
> +1 on this.
>
> However this platform is not device tree, so this implies setting up
> a descriptor table for the affected driver(s) to work properly.
> See Documentation/gpio/board.txt

I checked the gpiod interfaces after original suggestion by Alexandre.

Introducing those mapping tables (much like pinctrl tables) look like
a duplicate effort if Russell will permit adding a DT support. So
I thought that I will reconsider gpiod/pinctrl/etc after fixing
LoCoMo, reiterating IRQ patches, possibly switching to COMMON_CLK
and (finally) thinking about device tree support.

-- 
With best wishes
Dmitry
