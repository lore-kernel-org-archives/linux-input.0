From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/13] Input: keyboard - Use local variables consistently
Date: Thu, 26 Jan 2017 11:31:01 +0100
Message-ID: <CACRpkdZW1CEmn-bKYNY_gExkMSS1CtA5ggR-ULz=xDe9j8JMqg@mail.gmail.com>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net> <1485024365-3368-5-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485024365-3368-5-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-input@vger.kernel.org

On Sat, Jan 21, 2017 at 7:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> If a function declares a variable to access a structure element,
> use it conssistently.

Weird spelling :)

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

> -               error = devm_gpio_request_one(&pdev->dev, button->gpio, flags,
> -                                             desc);
> +               error = devm_gpio_request_one(dev, button->gpio, flags, desc);

I think I have changes in the GPIO tree touching these code sites.

I put those on an immutable branch so Dmitry can pull it if he needs
it as a base for this patch:
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/commit/?h=ib-gpiod-flags

Yours,
Linus Walleij
