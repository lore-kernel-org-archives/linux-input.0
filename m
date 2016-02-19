From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Fri, 19 Feb 2016 11:46:42 +0100
Message-ID: <CAMuHMdX653Zzkv3Rz3_Exibomc7cmmDyatYGNr10msMsXFNi1Q@mail.gmail.com>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
	<1455876982-6743-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1455876982-6743-4-git-send-email-geert+renesas@glider.be>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 19, 2016 at 11:16 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Make use of the device property API in this driver so that both OF based
> systems and ACPI based systems can use this driver.
>
> Based on commits b26d4e2283b6d9b6 ("input: gpio_keys_polled: Make use of
> device property API"), 99b4ffbd84ea4191 ("Input: gpio_keys[_polled] -
> change name of wakeup property"), and 1feb57a245a4910b ("gpio: add
> parameter to allow the use named gpios").
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested with DT only.
> ---
>  drivers/input/keyboard/gpio_keys.c | 77 +++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index b6262d94aff19f70..5764308e3b26314a 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c

> @@ -655,32 +646,29 @@ gpio_keys_get_devtree_pdata(struct platform_device *pdev)
>                 return ERR_PTR(-ENOMEM);
>
>         pdata->buttons = (struct gpio_keys_button *)(pdata + 1);
> -       pdata->nbuttons = nbuttons;
> -
> -       pdata->rep = !!of_get_property(node, "autorepeat", NULL);
>
> -       of_property_read_string(node, "label", &pdata->name);
> +       pdata->rep = device_property_present(dev, "autorepeat");
> +       device_property_read_string(dev, "label", &pdata->name);
>
> -       i = 0;
> -       for_each_available_child_of_node(node, pp) {
> -               enum of_gpio_flags flags;
> +       device_for_each_child_node(dev, child) {
> +               struct gpio_desc *desc;
>
> -               button = &pdata->buttons[i++];
> -
> -               button->gpio = of_get_gpio_flags(pp, 0, &flags);
> -               if (button->gpio < 0) {
> -                       error = button->gpio;
> +               desc = devm_get_gpiod_from_child(dev, NULL, child);
> +               if (IS_ERR(desc)) {
> +                       error = PTR_ERR(desc);
>                         if (error != -ENOENT) {
>                                 if (error != -EPROBE_DEFER)
>                                         dev_err(dev,
>                                                 "Failed to get gpio flags, error: %d\n",
>                                                 error);
> +                               fwnode_handle_put(child);
>                                 return ERR_PTR(error);
>                         }
> -               } else {
> -                       button->active_low = flags & OF_GPIO_ACTIVE_LOW;
>                 }
>
> +               button = &pdata->buttons[pdata->nbuttons++];
> +               button->gpiod = desc;
> +
>                 button->irq = platform_get_irq(pdev, 0);
>
>                 if (!gpio_is_valid(button->gpio) && button->irq < 0) {

Woops, I missed to convert one check. The above line should become:

        if (IS_ERR(button->gpiod) && button->irq < 0) {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
