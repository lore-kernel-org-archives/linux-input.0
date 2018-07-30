From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v10 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Mon, 30 Jul 2018 09:52:00 +0300
Message-ID: <20180730065200.GA8862@localhost.localdomain>
References: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <e737bb13d17b75ea5e55f59005ef3181d428e704.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <20180712130013.GJ4641@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180712130013.GJ4641@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com, linus.walleij@linaro.org, kstewart@linuxfoundation.org, heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

Hello Lee & All others,

I'm physically back from my vacations so I can once again reach the
keyboard. So it's time to try address these issues =)

On Thu, Jul 12, 2018 at 02:00:13PM +0100, Lee Jones wrote:
> On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> 
> > +	ret = regmap_read(bd71837->regmap, BD71837_REG_REV, &val);
> > +	if (ret) {
> > +		dev_err(&i2c->dev, "Read BD71837_REG_DEVICE failed\n");
> > +		return ret;
> > +	}
> 
> You never do anything with the value here.
> 
> Please either utilise it, read something useful or remove it.

Right. I'll add check that the chip revision is known and supported by
driver. Later I'll also use this value to distinguish between BD71837
and BD71847.

> > +struct bd71837_pmic;
> > +struct bd71837_clk;
> > +
> > +struct bd71837 {
> > +	struct device *dev;
> > +	struct i2c_client *i2c_client;
> 
> Are these both being used?
> 
> If you save one, you tend not to need the other.
> 

That's what I would call experience. I indeed only use the dev pointer
in subdevices - and what's even more ugly is that I use
dev_get_drvdata(pdev->dev.parent) - in regulator while I use
i2c_set_clientdata(i2c, bd71837); in MFD. This works because
i2c_set_clientdata actually calls dev_set_drvdata - buit that's not
pretty.

I think it would be more appropriate to drop the i2c_client because
subdevices need not to know the chip is connected via i2c. I'll do that
and also replace the call to i2c_set_clientdata with direct use of
dev_set_drvdata. Thanks!

> > +	struct regmap *regmap;
> > +	unsigned long int id;
> > +
> > +	int chip_irq;
> > +	struct regmap_irq_chip_data *irq_data;
> > +
> > +	struct bd71837_pmic *pmic;
> > +	struct bd71837_clk *clk;
> > +};
> > +
> > +#endif /* __LINUX_MFD_BD71837_H__ */
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
