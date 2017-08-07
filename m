From: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: Re: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
Date: Mon, 7 Aug 2017 18:21:07 +0200
Message-ID: <20170807182107.6b25804213443850c157c123@dk-develop.de>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
        <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Linus,

thanks for reviewing. Commented the ones which still holds.

On Mon, 7 Aug 2017 11:03:53 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Aug 1, 2017 at 12:24 AM, Danilo Krummrich
> <danilokrummrich@dk-develop.de> wrote:
> 
> 
> When you add DT bindings you have to CC devicetree@vger.kernel.org
> 
I will do prospectively.

> > +#include <linux/gpio.h>
> 
> Use only:
> 
> #include <linux/gpio/consumer.h>
> 
Done in v6.

> > +#include <linux/of_gpio.h>
> 
> Should not be needed.
> 
> 
Removed in v6.

> > +static int ps2_gpio_write(struct serio *serio, unsigned char val)
> > +{
> > +       struct ps2_gpio_data *drvdata = serio->port_data;
> > +
> > +       drvdata->mode = PS2_MODE_TX;
> > +       drvdata->tx_byte = val;
> > +       /* Make sure ISR running on other CPU notice changes. */
> > +       barrier();
> 
> This seems overengineered, is this really needed?
> 
> If we have races like this, the error is likely elsewhere, and should be
> fixed in the GPIO driver MMIO access or so.
> 
Yes, seems it can be removed. I didn't saw any explicit barriers in the GPIO
driver (I'm testing on bcm2835), but it seems MMIO operations on SMP archs
does contain barriers. Not sure if all do. If some do not this barrier might
be needed to ensure ISR on other CPU notice the correct mode and byte to send.

-- 
Danilo Krummrich <danilokrummrich@dk-develop.de>
