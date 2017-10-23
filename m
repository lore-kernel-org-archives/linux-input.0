From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio-keys: Convert timers to use timer_setup()
Date: Mon, 23 Oct 2017 14:50:56 -0700
Message-ID: <20171023215056.kclz7l5lagngh2qh@dtor-ws>
References: <CABCPcVWqeiJNWfow34ouSwvtKoDF+egFQjXtqt+iPwNUKwgc7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:56375 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbdJWVvA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 23 Oct 2017 17:51:00 -0400
Content-Disposition: inline
In-Reply-To: <CABCPcVWqeiJNWfow34ouSwvtKoDF+egFQjXtqt+iPwNUKwgc7g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: stephen lu <lumotuwe@gmail.com>
Cc: linus.walleij@linaro.org, linux@roeck-us.net, jacek.anaszewski@gmail.com, boris.brezillon@free-electrons.com, andriy.shevchenko@linux.intel.com, alexander.stein@systec-electronic.com, hdegoede@redhat.com, geert+renesas@glider.be, josephl@nvidia.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Oct 23, 2017 at 04:21:51PM +0800, stephen lu wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Signed-off-by: Stephen Lu <lumotuwe@gmail.com>
> 
> ---
>  drivers/input/keyboard/gpio_keys.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c
> b/drivers/input/keyboard/gpio_keys.c
> index e9f0ebf..25ddc33 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -419,9 +419,9 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
> 
> -static void gpio_keys_irq_timer(unsigned long _data)
> +static void gpio_keys_irq_timer(struct timer_list *t)
>  {
> -       struct gpio_button_data *bdata = (struct gpio_button_data *)_data;
> +       struct gpio_button_data *bdata = from_timer(bdata, t, release_timer);
>         struct input_dev *input = bdata->input;
>         unsigned long flags;
> 
> @@ -584,6 +584,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>                 bdata->release_delay = button->debounce_interval;
>                 setup_timer(&bdata->release_timer,
>                             gpio_keys_irq_timer, (unsigned long)bdata);
> +               timer_setup(&bdata->release_timer,
> +                           gpio_keys_irq_timer, 0);

Why are you keeping the original call to setup_timer()?

Also, your patch was line-wrapped, with tabs converted to spaces. I
fixed this all up, but please make sure you do not send mangled patches
next time. Look into git send-email.

Thanks.

-- 
Dmitry
