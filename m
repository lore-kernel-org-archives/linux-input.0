From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
Date: Fri, 18 Dec 2015 15:46:51 +0100
Message-ID: <CACRpkdb+jJyt1DLqsMfbFJ+md1mUrFprzG1m+6W2S-9pZV+PxA@mail.gmail.com>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
	<20151209193034.GE27131@dtor-ws>
	<CACRpkdZDFPFOH=9FfYzLeKo5b-oXG4rPjoU4Rpq9Wv1-RvY6uQ@mail.gmail.com>
	<CAKdAkRR6kEzEOtjxXqS4BPToEzKGBsLb=SzePFAiLSDhh+=qnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdAkRR6kEzEOtjxXqS4BPToEzKGBsLb=SzePFAiLSDhh+=qnw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Linux MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 15, 2015 at 8:25 AM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Dec 14, 2015 at 1:18 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

>> At this point we have to cross-reference the pointer to my chip to
>> find the chip to remove. This goes for anything that takes the struct
>> gpio_chip *
>> as parameter, like gpiochip_add_pin_range(), gpiochip_request_own_desc()
>> etc etc. So something inside gpiolib must take a gpio_chip * pointer and
>> turn that into the actual state container, e.g, a struct gpio_device.
>> Since struct gpio_chip needs to be static and stateless, it cannot contain
>> a pointer back to its struct gpio_device.
>
> Why does gpio_chip have to be stateless? I am not saying that it
> should or should not, I just want to better understand what you are
> trying to achieve.

Because the allocation of gpio_chip is currently inside each driver
(often as part of their own state struct) and will go away with the
driver. I want to make that const parameter that the drivers supply
to the core gpiolib, and the gpiolib handled all states using something
like that struct gpio_device you suggested or a more elaborate
solution.

>> If I compare to how struct input_dev is done, you appear to also use the
>> pattern Russell suggested with input_dev_allocate() akin to
>> netdev_alloc(), and the allocated struct holds all the vtable and states etc,
>> and I think it is a good pattern, and that GPIO should conform.
>
> The main difference between gpio_chip (at least as it stands
> currently) and input devices and corresponding private driver data is
> that input device and driver data has different lifetimes; input
> devices may stick around even though driver is unbound from
> corresponding device and driver's private data freed.

I would like to achieve something similar for GPIO devices.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
