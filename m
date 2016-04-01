From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: gpio irqchip initialization race
Date: Fri, 01 Apr 2016 10:56:12 +0200
Message-ID: <1587936.Xd43Z6OAxQ@ws-stein>
References: <44236018.b6N0xPzKYW@ws-stein> <CACRpkdbfidnokJ2WyagdcEycDu3dXKVon2z4TKM7KhNg_Hyf9w@mail.gmail.com> <CACRpkdZ32AAq2BfoEeyiBm1RiXQVkTO6gxsEuuMGhm7wuUXxgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZ32AAq2BfoEeyiBm1RiXQVkTO6gxsEuuMGhm7wuUXxgQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Friday 01 April 2016 10:47:42, Linus Walleij wrote:
> On Fri, Apr 1, 2016 at 10:43 AM, Linus Walleij <linus.walleij@linaro.org> 
wrote:
> > I think the problem is that gpio-keys is calling gpio_to_irq(), and at
> > that
> > point between gpiochip_add_data() but before gpiochip_irqchip_add()
> > it gets a bogus IRQ when it should be getting -EPROBE_DEFER.
> 
> Or not a bogus irqnumber really, it get -ENXIO (-6)
> 
> as in your example:
> > gpio-keys user_sw: Unable to get irq number for GPIO 376, error -6
> 
> And in this case (if gpio_keys handle -EPROBE_DEFER gracefully)
> all should be fine with my oneliner patch.
> 
> I am more uncertain about the -EINVAL (-22) we might need some
> more analysis there.

I did 10 runs and got the following results:
> 3x  gpio-keys user_sw: Unable to claim irq 0; error -22
> 2x  gpio-keys user_sw: Unable to get irq number for GPIO 376, error -517
> 5x  ok

So, for one gpio-keys seems not to handle -EPROBE_DEFER gracefully and it seem 
still possible to get an invalid irq number.

Best regards,
Alexander

