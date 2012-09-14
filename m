From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [Patch v1 4/7] DA9055 GPIO driver
Date: Fri, 14 Sep 2012 16:13:57 +0200
Message-ID: <CACRpkdYQutaM2aHyJOmtYZtZ8w6c-pQ4xm5adUAia1UH-SM88Q@mail.gmail.com>
References: <1347629416.18587.15.camel@dhruva>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50038 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab2INON6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 10:13:58 -0400
Received: by wibhi8 with SMTP id hi8so8380055wib.1
        for <linux-input@vger.kernel.org>; Fri, 14 Sep 2012 07:13:57 -0700 (PDT)
In-Reply-To: <1347629416.18587.15.camel@dhruva>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ashish Jangam <ashish.jangam@kpitcummins.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org, David Dajun Chen <dchen@diasemi.com>

On Fri, Sep 14, 2012 at 3:30 PM, Ashish Jangam
<ashish.jangam@kpitcummins.com> wrote:

> This is the GPIO patch for the DA9055 PMIC. This patch has got
> dependency on the DA9055 MFD core.
>
> This patch is functionally tested on SMDK6410 board.
>
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>

This looks OK
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But I want Marks comment on this, for example:

> +static int da9055_gpio_get(struct gpio_chip *gc, unsigned offset)
> +{
> +       struct da9055_gpio *gpio = to_da9055_gpio(gc);
> +       int gpio_direction = 0;
> +       int ret;
> +
> +       /* Get GPIO direction */
> +       ret = da9055_reg_read(gpio->da9055, (offset >> 1) + DA9055_REG_GPIO0_1);
> +       if (ret < 0)
> +               return ret;

So unique functions to read/write registers (as I'm used to).

But the parent driver is using regmap, sand you seem not to use the
struct da9055
for anything else than passing reads/writes, so isn't it simpler to just pass
the struct regmap * and use update_bits etc directly and remove a layer of
indirection?

I'm very uncertain but Mark will know the proper design pattern.

Yours,
Linus Walleij
