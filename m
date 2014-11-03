From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
Date: Mon, 3 Nov 2014 14:41:28 +0100
Message-ID: <CACRpkdaKUZjbSEH75M9xudTF9HefwOCVEe5otv9-9f2UG8=hVg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>
	<CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>
	<CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo
List-Id: linux-input@vger.kernel.org

On Fri, Oct 31, 2014 at 10:54 AM, Dmitry Eremin-Solenikov
<dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 2014-10-31 10:42 GMT+03:00 Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:

>> It seems some DAC handling is part of the MFD driver, and we recently
>> discussed that MFD should not be doing misc stuff but mainly act as
>> arbiter and switching station.
>>
>> Can you please move the DAC parts of the driver to
>> drivers/iio/dac?
>>
>> The IIO DAC subsystem will likely add other goodies to
>> the driver for free and give a nice API to consumers.
>
> I wanted this part to be as simple as possible. I will look into IIO
> DAC subsystem.
> The DAC is as simple 2 channel 8-bit i2c device connected to a separate i2c bus
> controlled through a register in LoCoMo device. One channel is used
> for backlight,
> other will be used for volume control. So (in theory) I can add the
> following device
> chain:  locomo -> i2c-locomo -> m62332 -> IIO DAC client.  However isn't that
> quite an overkill for just backlight & volume control? Please advice me on this.

The point is still the same: no unrelated code in drivers/mfd,
then either use IIO DAC as a middle layer or sink the DAC handling
into respective subdriver, i.e. push it into the backlight or
volume directly then.

>>> +       /* Longtime timer */
>>> +       writew(0, lchip->base + LOCOMO_LTINT);
>>> +       /* SPI */
>>> +       writew(0, lchip->base + LOCOMO_SPI + LOCOMO_SPIIE);
>>> +
>>> +       writew(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);
>>
>> That's a few magic numbers and calculation don't you think?
>>
>> A comment stating what's going on would be helpful.
>
> Unfortunately little is known here - these values are c&p from old 2.4
> Lineo code.
> This part is related to generating synchronization pulses for accessing
> touchscreen.

OK we have to live with reverse engineering results, that's OK.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
