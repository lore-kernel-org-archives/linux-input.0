From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 08/12] pinctrl: Add pinctrl driver for the RK805 PMIC
Date: Thu, 3 Aug 2017 09:40:10 +0200
Message-ID: <CACRpkdbqNoa3jwLQ0781ZYjW0pBx1aoBYNGqnsJqiOuQ_0ijLg@mail.gmail.com>
References: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com> <1500635890-12714-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500635890-12714-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joseph Chen <chenjh@rock-chips.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, Tony Xie <tony.xie@rock-chips.com>, zhangqing@rock-chips.com, David Wu <wdc@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, w.egorov@phytec.de, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 21, 2017 at 1:18 PM, Joseph Chen <chenjh@rock-chips.com> wrote:

> RK805 is one of Rockchip PMICs family, it has 2 output only GPIOs.
>
> This driver is also designed for other Rockchip PMICs to expend.
> Different PMIC maybe have different pin features, for example,
> RK816 has one pin which can be used for TS or GPIO(input/out).
> The mainly difference between PMICs pins are pinmux, direction
> and output value, that is 'struct rk805_pin_config'.
>
> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>

OK nice! Some comments:

> +config PINCTRL_RK805
> +       tristate "Pinctrl and GPIO driver for RK805 PMIC"
> +       depends on MFD_RK808 && GPIOLIB

Nowadays I would recommend simply:

depends on MFD_RK808
select GPIOLIB

> +#include <linux/delay.h>
> +#include <linux/gpio.h>

Just #include <linux/gpio/driver.h>

> +#define FUNCTION_GROUP(fname, mux, gname)                      \
> +       {                                                       \
> +               .name = #fname,                                 \
> +               .groups = gname##_gpio_groups,                  \
> +               .ngroups = ARRAY_SIZE(gname##_gpio_groups),     \
> +               .mux_option = RK805_PINMUX_##mux,               \
> +       }
> +
> +#define PINGROUP(pg_name, pin_id)                              \
> +       {                                                       \
> +               .name = #pg_name,                               \
> +               .pins = {RK805_##pin_id},                       \
> +               .npins = 1,                                     \
> +       }
> +
> +/* RK805: 2 output only GPIOs */
> +static const struct pinctrl_pin_desc rk805_pins_desc[] = {
> +       PINCTRL_PIN(RK805_GPIO0, "gpio0"),
> +       PINCTRL_PIN(RK805_GPIO1, "gpio1"),
> +};
> +
> +static const struct rk805_pin_function rk805_pin_functions[] = {
> +       FUNCTION_GROUP(gpio, GPIO, rk805),
> +};
> +
> +static const struct rk805_pin_group rk805_pin_groups[] = {
> +       PINGROUP(gpio0, GPIO0),
> +       PINGROUP(gpio1, GPIO1),
> +};

It looks like the macros just obscure things? Why not simply inline the data
and open code it as it is just two pins?

Apart from this it looks nice and complete.

Yours,
Linus Walleij
