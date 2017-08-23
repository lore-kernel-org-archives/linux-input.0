From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v9 1/2] serio: PS/2 gpio bit banging driver for serio bus
Date: Wed, 23 Aug 2017 10:29:23 +0200
Message-ID: <CACRpkdZ6RJurzXnOzsG=b3cO0LhapE_kV2ds=U-Gpv3e84x1nw@mail.gmail.com>
References: <20170821193142.29688-1-danilokrummrich@dk-develop.de> <20170821193142.29688-2-danilokrummrich@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821193142.29688-2-danilokrummrich@dk-develop.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 21, 2017 at 9:31 PM, Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:

> +static int __ps2_gpio_write(struct serio *serio, unsigned char val)
> +static int ps2_gpio_write(struct serio *serio, unsigned char val)

I never like the random use of __prefixes as they have unclear
semantics.

I would name it something concise.

Anyways, that is up to the subsystem maintainer.
>From a GPIO point of view:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
