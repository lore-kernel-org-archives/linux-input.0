From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Wed, 4 Jul 2018 11:53:06 +0100
Message-ID: <20180704105002.GD496@dell>
References: <cover.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <18a04e42debb2a23aec855cac3bcf3d6ab6c55fd.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_533te3UuY9V9U+Z0yxTkW==3wsK22uzB4G=aWGour7Quw@mail.gmail.com>
 <20180704083911.GH2118@localhost.localdomain>
 <20180704095257.GJ2118@localhost.localdomain>
 <20180704101102.GA496@dell>
 <20180704103430.GA13087@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180704103430.GA13087@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com, Andrey Smirnov <andrew.smirnov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sboyd@kernel.org, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>linux-kernel <li>
List-Id: linux-input@vger.kernel.org

On Wed, 04 Jul 2018, Matti Vaittinen wrote:

> On Wed, Jul 04, 2018 at 11:11:02AM +0100, Lee Jones wrote:
> > On Wed, 04 Jul 2018, Matti Vaittinen wrote:
> > 
> > > On Wed, Jul 04, 2018 at 11:39:11AM +0300, Matti Vaittinen wrote:
> > > > On Tue, Jul 03, 2018 at 11:26:00AM +0200, Enric Balletbo Serra wrote:
> > > > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > > > dia dv., 29 de juny 2018 a les 11:47:
> > > > > 
> > > > > Now that you use devm calls and you don't need to unwind things I
> > > > > think is better to use plain returns. So,
> > > > > 
> > > > > return -ENOMEM;
> > > > 
> > > > I have never really understood why use of gotos in error handling is
> > > > discouraged.
> > 
> > They're not.
> > 
> > > > Personally I would always choose single point of exit from
> > > > a function when it is simple enough to achieve (like in this case). I've
> > > > written and fixed way too many functions which leak resources or
> > > > accidentally keep a lock when exiting from error branches. But I know
> > > > many colleagues like you who prefer not to have gotos but  in place returns
> > > > instead. So I guess I'll leave the final call on this to the one who is
> > > > maintainer for this code. And it is true there is no things to unwind
> > > > now - which does not mean that next updater won't add such. But as I
> > > > said, I know plenty of people share your view - and even though I rather
> > > > maintain code with only one exit the final call is on subsystem maintainer
> > > > here.
> > 
> > Please use gotos in the error path.
> > 
> > IMO, it's the nicest way to unwind (as you call it).
> 
> I'll keep the gotos but clean other stuff for patch v9 then.

Sounds good.

> > > Actually, If it was completely my call the probe would look something
> > > like this:
> > > 
> > > +static int bd71837_i2c_probe(struct i2c_client *i2c,
> > > +                           const struct i2c_device_id *id)
> > > +{

[...]

> > > +}
> > > 
> > > What do you think of this? To my eye it is nice. It keeps single point of
> > > exit and introduces only simple if-statements without the need of curly
> > > brackets. And finally the error prints string works as a comment too.
> > > I've seen bunch of constructs like this on the networking side but I
> > > have no idea if this is frowned on this subsystem =) Oh, and probe abowe
> > > is just to illustrate the idea, I did not even try compiling it yet.
> > 
> > That is horrible.  I nearly vomited on my keyboard. 
> 
> Note to self: Never to buy second hand keyboard from Lee =)

That is sound advice.

Not sure I would buy 2nd-hand keyboard from anyone - ewe! :\

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
