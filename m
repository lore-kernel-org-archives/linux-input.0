From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 11/15] sound: soc: poodle: make use of new locomo GPIO interface
Date: Sat, 1 Nov 2014 14:42:33 +0900
Message-ID: <CAAVeFuKuBeoF0i4RpuXo=H1G4C6BfjC0hEUyN2TO02UM0DsHfg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-12-git-send-email-dbaryshkov@gmail.com> <20141028145850.GU18557@sirena.org.uk>
 <CAAVeFuKgARoMFzf+663iP6cULs93d4WSQS8ESjUb9VcxguWurA@mail.gmail.com>
 <CACRpkdY-RDuxGMWe_SD613ovsEoHhxjP1+3T-m_zKQSx=mkFjA@mail.gmail.com> <CALT56yP6K-sXOGM4z-WRsvFVjOi-13wM+Ewqn6WpDmNB4xcOEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CALT56yP6K-sXOGM4z-WRsvFVjOi-13wM+Ewqn6WpDmNB4xcOEg@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Ji
List-Id: linux-input@vger.kernel.org

On Fri, Oct 31, 2014 at 6:58 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> 2014-10-31 12:52 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Wed, Oct 29, 2014 at 4:03 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
>>> On Tue, Oct 28, 2014 at 11:58 PM, Mark Brown <broonie@kernel.org> wrote:
>>>> On Tue, Oct 28, 2014 at 03:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
>>>>> Since LoCoMo driver has been converted to provide proper gpiolib
>>>>> interface, make poodle ASoC platform driver use gpiolib API.
>>>>
>>>> Please use subject lines matching the style for the subsystem.
>>>>
>>>>> +     ret = gpio_request_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
>>>>> +     if (ret) {
>>>>> +             dev_err(&pdev->dev, "gpio_request_array() failed: %d\n",
>>>>> +                             ret);
>>>>> +             return ret;
>>>>> +     }
>>>>
>>>> I sense a need for devm_gpio_request_array() here.  Otherwise this looks
>>>> fine - ideally it'd move to gpiod but moving to gpiolib is a clear win
>>>> so no need to block on this.
>>>
>>> I wish Dmitry took the opportunity to move this driver to the gpiod
>>> API, especially since doing so would be trivial for this driver.
>>
>> +1 on this.
>>
>> However this platform is not device tree, so this implies setting up
>> a descriptor table for the affected driver(s) to work properly.
>> See Documentation/gpio/board.txt
>
> I checked the gpiod interfaces after original suggestion by Alexandre.
>
> Introducing those mapping tables (much like pinctrl tables) look like
> a duplicate effort if Russell will permit adding a DT support. So
> I thought that I will reconsider gpiod/pinctrl/etc after fixing
> LoCoMo, reiterating IRQ patches, possibly switching to COMMON_CLK
> and (finally) thinking about device tree support.

Note that the mapping tables are likely not going to end up being
huge, and taking that step will allow you to convert to the gpiod
interface, something you would probably want to do later when adding
DT support anyway. So at the end of the day there would be very little
wasted effort: once converting to DT, just add the GPIO properties
into the appropriate node, remove the mapping tables, and you're done.
