From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
Date: Fri, 31 Oct 2014 13:39:59 +0400
Message-ID: <CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
	<CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo
List-Id: linux-input@vger.kernel.org

2014-10-31 10:48 GMT+03:00 Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> On Tue, Oct 28, 2014 at 1:01 AM, Dmitry Eremin-Solenikov
> <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> Add gpiolib driver for gpio pins placed on the LoCoMo GA.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>

[skipped]

> (etc, everywhere this pattern occurs).
>> +static void locomo_gpio_set(struct gpio_chip *chip,
>> +               unsigned offset, int value)
>> +{
>> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&lg->lock, flags);
>> +
>> +       __locomo_gpio_set(chip, offset, value);
>> +
>> +       spin_unlock_irqrestore(&lg->lock, flags);
>
> If you actually always have to be getting and releasing a spin lock around
> the register writes, contemplate using regmap-mmio because that
> is part of what it does.
>
> But is this locking really necessary?

I have a custom of doing such locking and never having to think about
somebody breaking into RMW cycles.

Also isn't regmap an overkill here? Wouldn't regmap also do a lock/unlock
around each register read/write/RMW?

>> +static int locomo_gpio_remove(struct platform_device *pdev)
>> +{
>> +       struct locomo_gpio *lg = platform_get_drvdata(pdev);
>> +       int ret;
>> +
>> +       ret = gpiochip_remove(&lg->gpio);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Can't remove gpio chip: %d\n", ret);
>> +               return ret;
>> +       }
>
> The return value from gpiochip_remove() has been removed in v3.18-rc1
> so this will not compile.

Yes, the fix will be in the next iteration. This patchset was based on 3.17

-- 
With best wishes
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
