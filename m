From: Ashish Jangam <Ashish.Jangam@kpitcummins.com>
Subject: RE: [Patch v1 4/7] DA9055 GPIO driver
Date: Fri, 12 Oct 2012 09:55:50 +0000
Message-ID: <C3AE124F08223B42BC95AEB82F0F6CED38A8502F@KCHJEXMB03.kpit.com>
References: <1347629416.18587.15.camel@dhruva>
 <CACRpkdYQutaM2aHyJOmtYZtZ8w6c-pQ4xm5adUAia1UH-SM88Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:59741
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933654Ab2JLKAO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Oct 2012 06:00:14 -0400
In-Reply-To: <CACRpkdYQutaM2aHyJOmtYZtZ8w6c-pQ4xm5adUAia1UH-SM88Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Dajun Chen <dchen@diasemi.com>

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij@linaro.org]
> Sent: Friday, September 14, 2012 7:44 PM
> To: Ashish Jangam; Mark Brown
> Cc: Grant Likely; Samuel Ortiz; linux-input@vger.kernel.org; David Dajun
> Chen
> Subject: Re: [Patch v1 4/7] DA9055 GPIO driver
> 
> On Fri, Sep 14, 2012 at 3:30 PM, Ashish Jangam
> <ashish.jangam@kpitcummins.com> wrote:
> 
> > This is the GPIO patch for the DA9055 PMIC. This patch has got
> > dependency on the DA9055 MFD core.
> >
> > This patch is functionally tested on SMDK6410 board.
> >
> > Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> > Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>
> 
> This looks OK
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> But I want Marks comment on this, for example:
> 
> > +static int da9055_gpio_get(struct gpio_chip *gc, unsigned offset)
> > +{
> > +       struct da9055_gpio *gpio = to_da9055_gpio(gc);
> > +       int gpio_direction = 0;
> > +       int ret;
> > +
> > +       /* Get GPIO direction */
> > +       ret = da9055_reg_read(gpio->da9055, (offset >> 1) +
> DA9055_REG_GPIO0_1);
> > +       if (ret < 0)
> > +               return ret;
> 
> So unique functions to read/write registers (as I'm used to).
> 
> But the parent driver is using regmap, sand you seem not to use the
> struct da9055
> for anything else than passing reads/writes, so isn't it simpler to just
> pass
> the struct regmap * and use update_bits etc directly and remove a layer of
> indirection?
> 
> I'm very uncertain but Mark will know the proper design pattern.
> 
As Mark was fine with this then will it be possible to upstream this patch?

> Yours,
> Linus Walleij


