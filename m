From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 8/8] Input: olpc_apsp: allocate the GPIOs used
Date: Wed, 10 Oct 2018 10:11:21 -0700
Message-ID: <20181010171121.GE47260@dtor-ws>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-9-lkundrak@v3.sk>
 <20181010171013.GD47260@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010171013.GD47260@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>, Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 10, 2018 at 10:10:13AM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 10, 2018 at 04:25:04PM +0200, Lubomir Rintel wrote:
> > Take the GPIO lines are used by the SP. The driver doesn't touch the
> > lines -- this is done to disallow anything else from fiddling with
> > them because that would confuse the SP firmware.
> > 
> > Also, the lines are now nicely visible in /sys/kernel/debug/gpio.
> 
> Linus, is this something that should be handled by GPIO "hogs"?

Argh, meant to add Linus Walleij here.

> 
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/input/serio/olpc_apsp.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> > index fe9e19014e70..287759c5f36d 100644
> > --- a/drivers/input/serio/olpc_apsp.c
> > +++ b/drivers/input/serio/olpc_apsp.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/delay.h>
> >  #include <linux/clk.h>
> > +#include <linux/gpio/consumer.h>
> >  
> >  /*
> >   * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 controller.
> > @@ -76,6 +77,8 @@ struct olpc_apsp {
> >  	struct serio *padio;
> >  	void __iomem *base;
> >  	struct clk *clk;
> > +	struct gpio_desc *clk_gpio;
> > +	struct gpio_desc *data_gpio;
> >  	int open_count;
> >  	int irq;
> >  };
> > @@ -211,6 +214,16 @@ static int olpc_apsp_probe(struct platform_device *pdev)
> >  	if (IS_ERR(priv->clk))
> >  		return PTR_ERR(priv->clk);
> >  
> > +	priv->clk_gpio = devm_gpiod_get_optional(&pdev->dev, "clk",
> > +							GPIOD_ASIS);
> > +	if (IS_ERR(priv->clk_gpio))
> > +		return PTR_ERR(priv->clk_gpio);
> > +
> > +	priv->data_gpio = devm_gpiod_get_optional(&pdev->dev, "data",
> > +							GPIOD_ASIS);
> > +	if (IS_ERR(priv->data_gpio))
> > +		return PTR_ERR(priv->data_gpio);
> > +
> >  	/* KEYBOARD */
> >  	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
> >  	if (!kb_serio)
> > -- 
> > 2.19.0
> > 
> 
> -- 
> Dmitry

-- 
Dmitry
