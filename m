From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 12/13] input: max77650: add onkey support
Date: Tue, 12 Feb 2019 20:34:08 +0000
Message-ID: <20190212203408.GA1863@dell>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-13-brgl@bgdev.pl>
 <20190119090318.GB187380@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190119090318.GB187380@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Add support for the push- and slide-button events for max77650.
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/input/misc/Kconfig          |   9 ++
> >  drivers/input/misc/Makefile         |   1 +
> >  drivers/input/misc/max77650-onkey.c | 135 ++++++++++++++++++++++++++++
> >  3 files changed, 145 insertions(+)
> >  create mode 100644 drivers/input/misc/max77650-onkey.c

[...]

Moving things around a bit:

> > +static int max77650_onkey_probe(struct platform_device *pdev)
> > +{

> > +	irq_f = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_F);
> > +	if (irq_f <= 0)
> > +		return -EINVAL;
> > +
> > +	irq_r = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_R);
> > +	if (irq_r <= 0)
> > +		return -EINVAL;
> 
> Ugh, it would be better if you handled IRQ mapping in the MFD piece and
> passed it as resources of platform device. Then you'd simply call
> platform_get_irq() here and did not have to reach into parent device for
> "irq_dara".

These device IRQs were defined and registered with the Regmap *set*
(actually init()) APIs and thus should be pulled out using the
appropriate reverse Regmap *get* APIs here in the device.

Registering them with Regmap *and* pulling them back out again in the
same (MFD in this case) driver, only to register them as platform data
is certainly not how I see the API being designed/used.

> > +	struct regmap_irq_chip_data *irq_data;
> > +	struct device *dev, *parent;

> > +	dev = &pdev->dev;
> > +	parent = dev->parent;
> > +	i2c = to_i2c_client(parent);
> > +	irq_data = i2c_get_clientdata(i2c);
> > +
> > +	map = dev_get_regmap(parent, NULL);
> > +	if (!map)
> > +		return -ENODEV;

However, this hoop jumping is a bit crazy and for the most part
superfluous.  Instead, create a struct of attributes you wish to share
with the child devices (containing both regmap (which you should call
regmap and not map by the way) and irq_data) and pass it as either
platform data (preferred) or as device data.

If you choose the latter, you do not need to convert from 'device' to
'i2c' to do the look-up.  Since this function (probe()) is provided
with a platform_device, you can just use platform_get_drvdata() to
achieve the same as above.

If you go the preferred (platform data) route, then you should use
dev_get_platdata() instead.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
