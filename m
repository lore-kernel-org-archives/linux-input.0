From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 08/12] gpio: Add GPIO driver for the RK805 PMIC
Date: Fri, 9 Jun 2017 13:37:26 +0200
Message-ID: <CACRpkdZRKWPgFoM=Owo+EXU3bA_oymn5_3WRS9cuMr3G7Hdi6Q@mail.gmail.com>
References: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com> <1496907001-27107-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496907001-27107-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianhong Chen <chenjh@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, tony.xie@rock-chips.com, zhangqing@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, w.egorov@phytec.de, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Heiko, can you please look at this patch.

On Thu, Jun 8, 2017 at 9:30 AM, Jianhong Chen <chenjh@rock-chips.com> wrote:

> From: chenjh <chenjh@rock-chips.com>

Full name please.

> RK805 has two configurable GPIOs that can be used for several
> purposes. These are output only.
>
> This driver is generic for other Rockchip PMICs to be added.
>
> Signed-off-by: chenjh <chenjh@rock-chips.com>

Dito.

Your commit message says they are output-only, yet you implement
.direction_input(). So what is is going to be?

> +#include <linux/i2c.h>
> +#include <linux/gpio.h>

Only use:
#include <linux/gpio/driver.h>

> +/*
> + * @mode: supported modes for this gpio, i.e. OUTPUT_MODE, OUTPUT_MODE...

Are you saying this should be an enum or a set of flags?

> +static int rk805_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       int ret, val;
> +       struct rk805_gpio *gpio = gpiochip_get_data(chip);
> +
> +       ret = regmap_read(gpio->rk808->regmap, gpio->pins[offset].reg, &val);
> +       if (ret) {
> +               dev_err(gpio->dev, "gpio%d not support output mode\n", offset);
> +               return ret;
> +       }
> +
> +       return (val & gpio->pins[offset].val_msk) ? 1 : 0;

Do this:

return !!(val & gpio->pins[offset].val_msk)

> +static int rk805_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +       int ret;
> +       struct rk805_gpio *gpio = gpiochip_get_data(chip);
> +
> +       /* switch to gpio mode */
> +       if (gpio->pins[offset].func_mask) {
> +               ret = regmap_update_bits(gpio->rk808->regmap,
> +                                        gpio->pins[offset].reg,
> +                                        gpio->pins[offset].func_mask,
> +                                        gpio->pins[offset].func_mask);
> +               if (ret) {
> +                       dev_err(gpio->dev, "set gpio%d func failed\n", offset);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}

This is pin control. Why don't you implement a proper pin control
driver for this chip?

If you don't, this will just come back and haunt you.

Why not merge the driver into drivers/pinctrl/* and name it
pinctrl-rk805.c to begin with?

> +static const struct gpio_chip rk805_chip = {
> +       .label                  = "rk805-gpio",
> +       .owner                  = THIS_MODULE,
> +       .direction_input        = rk805_gpio_direction_input,
> +       .direction_output       = rk805_gpio_direction_output,

Please implement .get_direction()

> +       .get                    = rk805_gpio_get,
> +       .set                    = rk805_gpio_set,
> +       .request                = rk805_gpio_request,
> +       .base                   = -1,
> +       .ngpio                  = 2,
> +       .can_sleep              = true,

Consider assigning the .names[] array some pin names.

Yours,
Linus Walleij
