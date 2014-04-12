From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: Re: [PATCH] gpio/at91: free GPIO after configuring as input
Date: Sun, 13 Apr 2014 00:48:58 +0200
Message-ID: <20140412224857.GC2967@piout.net>
References: <1397226249-3922-1-git-send-email-alexanders83@web.de>
 <A08D29A3-2690-46C1-A317-41B17F365A81@jcrosoft.com>
 <4406073.7Z2odFudGD@kongar>
 <CABxcv=mdy_PmzgRN7SmBppS=8rDcP+jX0q1EwduwR0QOW=JWgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50891 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750833AbaDLWtB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Apr 2014 18:49:01 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=mdy_PmzgRN7SmBppS=8rDcP+jX0q1EwduwR0QOW=JWgg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Alexander Stein <alexanders83@web.de>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org

Hi,

On 11/04/2014 at 19:28:08 +0200, Javier Martinez Canillas wrote :
> On Fri, Apr 11, 2014 at 5:45 PM, Alexander Stein <alexanders83@web.de> wrote:
> > I'm CC'ing some input guys if this can't be solved in the pinctrl/irq side.
> >
> > On Friday 11 April 2014, 23:30:33 wrote Jean-Christophe PLAGNIOL-VILLARD:
> >>
> >> On Apr 11, 2014, at 10:24 PM, Alexander Stein <alexanders83@web.de> wrote:
> >>
> >> >
> >> > If the GPIO stays requested a device driver can't request it again.
> >> > e.g. Without this patch the ads7846 driver returns the following error:
> >> > ads7846 spi32766.3: failed to request/setup pendown GPIO15: -16
> >> > ads7846: probe of spi32766.3 failed with error -16
> >> >
> >> > /sys/kernel/debug/gpio shows this:
> >> > GPIOs 0-31, platform/fffff200.gpio, fffff200.gpio:
> >> > [/ahb/apb/pinctrl@fffff200/gpio@fffff200] GPIOfffff200.gpio15: [gpio] set
> >> >
> >> > Signed-off-by: Alexander Stein <alexanders83@web.de>
> >> > ---
> >> > I'm aware that it makes sense this GPIO is/stays requested, but either the
> >> > pinctl or device driver have to be adjusted as both can't request this GPIO.
> >> > I think the latter shouldn't change.
> >> >
> >> > drivers/pinctrl/pinctrl-at91.c | 2 ++
> >> > 1 file changed, 2 insertions(+)
> >> >
> >> > diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> >> > index d990e33..63176f2 100644
> >> > --- a/drivers/pinctrl/pinctrl-at91.c
> >> > +++ b/drivers/pinctrl/pinctrl-at91.c
> >> > @@ -1493,6 +1493,8 @@ static int at91_gpio_irq_domain_xlate(struct irq_domain *d,
> >> >     if (ret)
> >> >             return ret;
> >> >
> >> > +   gpio_free(pin);
> >> > +
> >>
> >> NACK it the whole key point the gpio use as a IRQ so the irq generic code request it
> >> >     return 0;
> >> > }
> >> >
> >>
> 
> The problem is that the GPIO and IRQ subsystems are somehow related
> but completely independent. A GPIO pin used as an IRQ line is
> completely orthogonal to requesting a GPIO pin.
> 
> Is true that here is a common pattern in the kernel that is:
> 
> gpio_request(gpio,...);
> gpio_direction_input()
> request[_threaded]_irq(gpio_to_irq(gpio), ...);
> 
> But one should not assume that requesting a GPIO to be used as an IRQ
> line implies requesting the GPIO first. It is completely legal to only
> request the IRQ without requesting the GPIO before.
> 
> Of course at a hardware level the pin has to be configured as input if
> needed by the chip controller and also a following call to
> gpio_request() as output should not be supported.
> 
> After a long discussion the agreement is that the driver should be
> able to setup as a hw level if another driver wants to use a GPIO pin
> as an IRQ line but not requesting the GPIO. So, I think that is wrong
> to call gpio_request() and gpio_direction_input() on a irq_domain_ops
> .xlate() function handler since by doing that a subsequent call to
> gpio_request() is failing like you are reporting.
> 
> The GPIO subsystem has a new gpio_lock_as_irq() helper function to
> mark a GPIO pin as already used as a IRQ line and only allowing to
> request a GPIO as input if is already marked as an IRQ.
> 
> Please take a look to commit 2f56e0a ("gpio/omap: use gpiolib API to
> mark a GPIO used as an IRQ") for an example on how to use this helper
> function.
> 
> Also, there is a new GPIOLIB_IRQCHIP infrastructure in gpiolib that
> are a set of helper functions to associate an IRQ chip to a GPIO
> controller. This should cover the most common use case and most
> probably this driver and can be converted to use it.
> 
> Please refer to commits:
> 
> 1425052 ("gpio: add IRQ chip helpers in gpiolib")
> e0bc34a ("pinctrl: nomadik: convert driver to use gpiolib irqchip")
> 
> for an example on how to use it.
> 

You probably want to have a look at:
https://lkml.org/lkml/2014/3/3/110


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
