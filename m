From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
Date: Mon, 7 Aug 2017 11:03:53 +0200
Message-ID: <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170731222452.22887-1-danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 1, 2017 at 12:24 AM, Danilo Krummrich
<danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org> wrote:

> This driver provides PS2 serio bus support by implementing bit banging
> with the GPIO API. The GPIO pins, data and clock, can be configured with
> a node in the device tree or by static platform data.
>
> Writing to a device is supported as well, though it is not recommended as
> the timings to be halt given by libps2 are very tough and difficult to
> reach with bit banging. Therefore it can be configured (also in DT and
> pdata) whether the serio write function should be available for clients.
>
> This driver is for development purposes and not for productive use.
> However, this driver can be useful e.g. when no USB port is available or
> using old peripherals is desired as PS2 controllers getting rare.
>
> This driver was tested on a RPI1 and on Hikey960 and it worked well
> together with the atkbd driver.
>
> Signed-off-by: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>

> +++ b/Documentation/devicetree/bindings/serio/ps2-gpio.txt

When you add DT bindings you have to CC devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> @@ -0,0 +1,20 @@
> +Device-Tree bindings for ps2 gpio driver
> +
> +Required properties:
> +       - compatible = "ps2-gpio";
> +       - gpios: data and clock gpio
> +
> +Optional properties:
> +       - ps2-gpio,write-enable: Indicates whether write function is provided
> +       to serio device. Most probably providing the write fn will not work,
> +       because of the tough timing libps2 requires.
> +
> +Example nodes:
> +
> +ps2@0 {
> +       compatible = "ps2-gpio";
> +       gpios = <&gpio 24 0 /* data */
> +                &gpio 23 0 /* clock */
> +               >;
> +       i2c-gpio,write-enable = <0>;
> +};

These look fine to me though.

> diff --git a/Documentation/gpio/drivers-on-gpio.txt b/Documentation/gpio/drivers-on-gpio.txt

Thanks for patching this!

> +config SERIO_GPIO_PS2
> +       tristate "GPIO PS/2 bit banging driver"
> +       help
> +         Say Y here if you want PS/2 bit banging support via GPIO.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called gpio-ps2.
> +
> +         If you are unsure, say N.

As mentioned

depends on GPIOLIB
depends on OF

> +#include <linux/gpio.h>

Use only:

#include <linux/gpio/consumer.h>

> +#include <linux/of_gpio.h>

Should not be needed.


> +struct ps2_gpio_data {
> +       struct device *dev;
> +       struct serio *serio;
> +       unsigned char mode;
> +       unsigned int gpio_clk;
> +       unsigned int gpio_data;
> +       unsigned int write_enable;

Do not use the global GPIO number space, use GPIO descriptors.

Example:
drivers/input/keyboard/gpio_keys.c

> +static int ps2_gpio_write(struct serio *serio, unsigned char val)
> +{
> +       struct ps2_gpio_data *drvdata = serio->port_data;
> +
> +       drvdata->mode = PS2_MODE_TX;
> +       drvdata->tx_byte = val;
> +       /* Make sure ISR running on other CPU notice changes. */
> +       barrier();

This seems overengineered, is this really needed?

If we have races like this, the error is likely elsewhere, and should be
fixed in the GPIO driver MMIO access or so.

> +       disable_irq_nosync(drvdata->irq);
> +       gpio_direction_output(drvdata->gpio_clk, 0);

No use GPIO descriptors please.

> +       // dev_info(drvdata->dev, "recv bit %u: %u\n", cnt, data);

Delete comments or convert to dev_dbg()

> +static int of_ps2_gpio_get_props(struct device *dev,
> +                                struct ps2_gpio_data *drvdata)
> +{
> +       if (of_gpio_count(dev->of_node) < 2)
> +               return -ENODEV;
> +
> +       drvdata->gpio_data = of_get_gpio(dev->of_node, 0);
> +       drvdata->gpio_clk = of_get_gpio(dev->of_node, 1);
> +
> +       if (drvdata->gpio_data == -EPROBE_DEFER ||
> +           drvdata->gpio_clk == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +
> +       if (!gpio_is_valid(drvdata->gpio_data) ||
> +           !gpio_is_valid(drvdata->gpio_clk)) {
> +               dev_err(dev, "invalid GPIOs, data=%d, clk=%d\n",
> +                       drvdata->gpio_data, drvdata->gpio_clk);
> +               return -ENODEV;
> +       }

With GPIO descriptors you should just gpiod_get(dev, "foo", FLAG);
No need to poke around in the device tree like this.

Error checks and deferrals apply as usual though.

> +       error = devm_gpio_request(dev, drvdata->gpio_clk, "ps2 clk");
> +       if (error) {
> +               dev_err(dev, "failed to request gpio %u: %d",
> +                               drvdata->gpio_clk, error);
> +               goto err_free_serio;
> +       }
> +
> +       error = devm_gpio_request(dev, drvdata->gpio_data, "ps2 data");
> +       if (error) {
> +               dev_err(dev, "failed to request gpio %u: %d",
> +                               drvdata->gpio_data, error);
> +               goto err_free_serio;
> +       }

So devm_gpiod_get(...)

> +       gpio_direction_input(drvdata->gpio_clk);
> +       gpio_direction_input(drvdata->gpio_data);

And incidentallt then you can just specify GPIOD_IN as flag and
it will be set up for you.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
