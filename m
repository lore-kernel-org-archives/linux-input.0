From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] gpiolib: handle probe deferrals better
Date: Fri, 01 Apr 2016 16:35:22 +0200
Message-ID: <3328895.pnRVlrd6Vm@ws-stein>
References: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org> <3233696.TZ7kbb7G3F@ws-stein> <56FE7F9C.9050902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <56FE7F9C.9050902@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Linux Input <linux-input@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

On Friday 01 April 2016 17:03:08, Grygorii Strashko wrote:
> > So in my case, I would expect that gpio-keys probe fails due to missing
> > IRQ
> > parent and gets deferred. Once the IRQ parent happen to be probed
> > successfully at some point gpio-keys is probed again and succeeds.
> 
> I assume in your case It's devm_gpio_request_one() first of all, which
> follows by gpio_to_irq.

I think nothing is wrong with that. The problem is that the former succeeds 
while the latter doesn't although from a device view point the GPIO chip is 
already there.

> > Consider the following cascading GPIO chips:
> >   /-------\                /---------\                 /--------\
> > |
> > |MCP23S17 + Pin1 <--> IRQ-+ PCA9555 + Pin 1 <--> IRQ + MCP23S17 +
> > |
> >   \-------/                 \-------/                  \--------/
> > 
> > Probing should still work for this scenario. This is something modprobe
> > cannot fix.
> 
> What I can see from my boot log is that at module loading time log output
> from many drivers is mixed which makes me think that this parallel process
> (udev) - and no I've not hit this issue..yet.

I think parallel device probing is expectable and reasonable. I guess to hit 
this issue you need a device which requires GPIOs and their corresponding IRQ 
and probing of that must be done while GPIO chip is attached but not it's IRQ 
chip.

Best regards,
Alexander

