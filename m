From: Alexander Stein <alexanders83@web.de>
Subject: Re: Re: [PATCH] gpio/at91: free GPIO after configuring as input
Date: Fri, 11 Apr 2014 17:45:31 +0200
Message-ID: <4406073.7Z2odFudGD@kongar>
References: <1397226249-3922-1-git-send-email-alexanders83@web.de> <A08D29A3-2690-46C1-A317-41B17F365A81@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:57419 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754992AbaDKPpg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2014 11:45:36 -0400
In-Reply-To: <A08D29A3-2690-46C1-A317-41B17F365A81@jcrosoft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

I'm CC'ing some input guys if this can't be solved in the pinctrl/irq side.

On Friday 11 April 2014, 23:30:33 wrote Jean-Christophe PLAGNIOL-VILLARD:
> 
> On Apr 11, 2014, at 10:24 PM, Alexander Stein <alexanders83@web.de> wrote:
> 
> > 
> > If the GPIO stays requested a device driver can't request it again.
> > e.g. Without this patch the ads7846 driver returns the following error:
> > ads7846 spi32766.3: failed to request/setup pendown GPIO15: -16
> > ads7846: probe of spi32766.3 failed with error -16
> > 
> > /sys/kernel/debug/gpio shows this:
> > GPIOs 0-31, platform/fffff200.gpio, fffff200.gpio:
> > [/ahb/apb/pinctrl@fffff200/gpio@fffff200] GPIOfffff200.gpio15: [gpio] set
> > 
> > Signed-off-by: Alexander Stein <alexanders83@web.de>
> > ---
> > I'm aware that it makes sense this GPIO is/stays requested, but either the
> > pinctl or device driver have to be adjusted as both can't request this GPIO.
> > I think the latter shouldn't change.
> > 
> > drivers/pinctrl/pinctrl-at91.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> > index d990e33..63176f2 100644
> > --- a/drivers/pinctrl/pinctrl-at91.c
> > +++ b/drivers/pinctrl/pinctrl-at91.c
> > @@ -1493,6 +1493,8 @@ static int at91_gpio_irq_domain_xlate(struct irq_domain *d,
> > 	if (ret)
> > 		return ret;
> > 
> > +	gpio_free(pin);
> > +
> 
> NACK it the whole key point the gpio use as a IRQ so the irq generic code request it
> > 	return 0;
> > }
> > 
> 

