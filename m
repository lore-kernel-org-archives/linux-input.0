From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpiolib: add support for fetching descriptors from
 static properties
Date: Mon, 29 Jul 2019 00:15:07 +0200
Message-ID: <CACRpkdYLLYbcvi89LGeTSu-qXxM=sxrwYFniJwDW1-9BtODWrw@mail.gmail.com>
References: <20190713075259.243565-1-dmitry.torokhov@gmail.com> <20190713075259.243565-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190713075259.243565-3-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Linux Input <linux-input@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Sat, Jul 13, 2019 at 9:53 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Now that static device properties understand notion of child nodes, let's
> teach gpiolib to tie such children and machine GPIO descriptor tables.
> We will continue using a single table for entire device, but instead of
> using connection ID as a lookup key in the GPIO descriptor table directly,
> we will perform additional translation: fwnode_get_named_gpiod() when
> dealing with property_set-backed fwnodes will try parsing string property
> with name matching connection ID and use result of the lookup as the key in
> the table:
>
> static const struct property_entry dev_child1_props[] __initconst = {
>         ...
>         PROPERTY_ENTRY_STRING("gpios",          "child-1-gpios"),
>         { }
> };
>
> static struct gpiod_lookup_table dev_gpiod_table = {
>         .dev_id = "some-device",
>         .table = {
>                 ...
>                 GPIO_LOOKUP_IDX("B", 1, "child-1-gpios", 1, GPIO_ACTIVE_LOW),
>                 ...
>         },
> };
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I'm pretty grateful for this since I think at one point I provoked this whole
series. :)

> +static struct gpio_desc *__fwnode_get_named_gpiod(struct fwnode_handle *fwnode,

I am allergic to __underscore_with_unclear_semantics() so I will
change this when applying to something with meaning (I even
like "inner_" better.)

Otherwise it's good to go when I get an ACK on the first patch.

Yours,
Linus Walleij
