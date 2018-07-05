From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v9 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Thu, 5 Jul 2018 10:04:48 +0200
Message-ID: <CAFqH_531ob=uY7x-SK1tXyRZXdd1qFT+O5pUVnnnJcucC7_fig@mail.gmail.com>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com> <a304164cc3c1b31c7c6b62f8e233ce321a82cdd6.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a304164cc3c1b31c7c6b62f8e233ce321a82cdd6.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matti.vaittinen@fi.rohmeurope.com
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com, Andrey Smirnov <andrew.smirnov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sboyd@kernel.org, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@v>
List-Id: linux-input@vger.kernel.org

Hi Matti,
Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
dia dj., 5 de jul. 2018 a les 9:46:
>
> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for three subsystems:
> - clk
> - Regulators
> - input/power-key
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/mfd/Kconfig         |  13 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/bd71837.c       | 215 ++++++++++++++++++++++++
>  include/linux/mfd/bd71837.h | 391 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 620 insertions(+)
>  create mode 100644 drivers/mfd/bd71837.c
>  create mode 100644 include/linux/mfd/bd71837.h
>

(snip)

Looks good to me.
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Best Regards,
 Enric
