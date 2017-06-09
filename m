From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v6 08/12] gpio: Add GPIO driver for the RK805 PMIC
Date: Fri, 09 Jun 2017 14:17:42 +0200
Message-ID: <2451251.ri2bNrhWeM@phil>
References: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com> <1496907001-27107-1-git-send-email-chenjh@rock-chips.com> <CACRpkdZRKWPgFoM=Owo+EXU3bA_oymn5_3WRS9cuMr3G7Hdi6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZRKWPgFoM=Owo+EXU3bA_oymn5_3WRS9cuMr3G7Hdi6Q@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Jianhong Chen <chenjh@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, Alexandre Courbot <gnurou@gmail.com>, zhangqing@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, tony.xie@rock-chips.com, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, w.egorov@phytec.de
List-Id: linux-input@vger.kernel.org

Hi,

Am Freitag, 9. Juni 2017, 13:37:26 CEST schrieb Linus Walleij:
> Heiko, can you please look at this patch.
> 
> On Thu, Jun 8, 2017 at 9:30 AM, Jianhong Chen <chenjh@rock-chips.com> wrote:
> 
> > From: chenjh <chenjh@rock-chips.com>
> 
> Full name please.

git config --global user.name "John Doe"

might do the trick and make this permanent for all your commits :-)


> > RK805 has two configurable GPIOs that can be used for several
> > purposes. These are output only.
> >
> > This driver is generic for other Rockchip PMICs to be added.
> >
> > Signed-off-by: chenjh <chenjh@rock-chips.com>
> 
> Dito.
> 
> Your commit message says they are output-only, yet you implement
> .direction_input(). So what is is going to be?

So far, I've only seen the rk808 and rk818. Both do not have any
configurable pins.

The rk805 which is a sort of variant of the above, does have the two
pins defined below, but in the manual I could also only find them as
output-only and having no other function than being output-pins.

So I don't really know if all the input- or "gpio-mode"- handling is only
an oversight (copy'n'paste) or if there are yet other rk808 variants around
that can actually be configured as inputs or even non-gpio modes?

I hope Jianhong will be able to answer that.


Heiko

> 
> > +#include <linux/i2c.h>
> > +#include <linux/gpio.h>
> 
> Only use:
> #include <linux/gpio/driver.h>
> 
> > +/*
> > + * @mode: supported modes for this gpio, i.e. OUTPUT_MODE, OUTPUT_MODE...
> 
> Are you saying this should be an enum or a set of flags?
> 
> > +static int rk805_gpio_get(struct gpio_chip *chip, unsigned offset)
> > +{
> > +       int ret, val;
> > +       struct rk805_gpio *gpio = gpiochip_get_data(chip);
> > +
> > +       ret = regmap_read(gpio->rk808->regmap, gpio->pins[offset].reg, &val);
> > +       if (ret) {
> > +               dev_err(gpio->dev, "gpio%d not support output mode\n", offset);
> > +               return ret;
> > +       }
> > +
> > +       return (val & gpio->pins[offset].val_msk) ? 1 : 0;
> 
> Do this:
> 
> return !!(val & gpio->pins[offset].val_msk)
> 
> > +static int rk805_gpio_request(struct gpio_chip *chip, unsigned offset)
> > +{
> > +       int ret;
> > +       struct rk805_gpio *gpio = gpiochip_get_data(chip);
> > +
> > +       /* switch to gpio mode */
> > +       if (gpio->pins[offset].func_mask) {
> > +               ret = regmap_update_bits(gpio->rk808->regmap,
> > +                                        gpio->pins[offset].reg,
> > +                                        gpio->pins[offset].func_mask,
> > +                                        gpio->pins[offset].func_mask);
> > +               if (ret) {
> > +                       dev_err(gpio->dev, "set gpio%d func failed\n", offset);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> 
> This is pin control. Why don't you implement a proper pin control
> driver for this chip?
> 
> If you don't, this will just come back and haunt you.
> 
> Why not merge the driver into drivers/pinctrl/* and name it
> pinctrl-rk805.c to begin with?
> 
> > +static const struct gpio_chip rk805_chip = {
> > +       .label                  = "rk805-gpio",
> > +       .owner                  = THIS_MODULE,
> > +       .direction_input        = rk805_gpio_direction_input,
> > +       .direction_output       = rk805_gpio_direction_output,
> 
> Please implement .get_direction()
> 
> > +       .get                    = rk805_gpio_get,
> > +       .set                    = rk805_gpio_set,
> > +       .request                = rk805_gpio_request,
> > +       .base                   = -1,
> > +       .ngpio                  = 2,
> > +       .can_sleep              = true,
> 
> Consider assigning the .names[] array some pin names.
> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 


