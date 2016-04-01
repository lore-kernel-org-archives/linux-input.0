From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: gpio irqchip initialization race
Date: Fri, 1 Apr 2016 10:43:30 +0200
Message-ID: <CACRpkdbfidnokJ2WyagdcEycDu3dXKVon2z4TKM7KhNg_Hyf9w@mail.gmail.com>
References: <44236018.b6N0xPzKYW@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33292 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbcDAInb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2016 04:43:31 -0400
Received: by mail-oi0-f47.google.com with SMTP id d205so96548582oia.0
        for <linux-input@vger.kernel.org>; Fri, 01 Apr 2016 01:43:31 -0700 (PDT)
In-Reply-To: <44236018.b6N0xPzKYW@ws-stein>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Fri, Apr 1, 2016 at 10:28 AM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:

> I suspect this depends on the time when gpio-keys is being probed. It will not
> be probed (or actually deferred) before mcp23s08_probe_one calls
> gpiochip_add_data as the parent GPIo controller to buttons is not present yet.
> I guess those error messages raise when gpio-keys is probed after
> gpiochip_add_data but before gpiochip_irqchip_add or
> gpiochip_set_chained_irqchip (in mcp23s08_irq_setup).
>
> The comment to _gpiochip_irqchip_add states the gpiochip has to be registered
> when calling. So to me this opens a rather small window where childs to
> gpiochip can be probed (parent is registered) but registering an interrupt
> will fail as the parent IRQ setup has not finished yet.
> Any suggestions how to fix that?

If that is what is happening it is indeed a very annoying race condition.
Strange we haven't seen it before!

So the problem doesn't exist when just using the gpiolib API or
the irqchip side independently, as we have been careful to make sure
that at least in modern drivers, these two are orthogonal.

I think the problem is that gpio-keys is calling gpio_to_irq(), and at that
point between gpiochip_add_data() but before gpiochip_irqchip_add()
it gets a bogus IRQ when it should be getting -EPROBE_DEFER.

I think we need to make sure that for drivers using gpiolib_irqchip_add()
-EPROBE_DEFER is returned for gpio[d]_to_irq() for this interrim
period.

What happens if you just apply this oneliner?

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b747c76fd2b1..838643d2d976 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2004,7 +2004,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
        VALIDATE_DESC(desc);
        chip = desc->gdev->chip;
        offset = gpio_chip_hwgpio(desc);
-       return chip->to_irq ? chip->to_irq(chip, offset) : -ENXIO;
+       return chip->to_irq ? chip->to_irq(chip, offset) : -EPROBE_DEFER;
 }
 EXPORT_SYMBOL_GPL(gpiod_to_irq);


Yours,
Linus Walleij
