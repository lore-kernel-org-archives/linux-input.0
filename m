From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Tue, 26 Jun 2018 09:54:23 +0200
Message-ID: <CACRpkdb9M7eN6JSk8yz=K90s1+S0cY9OcD_pDBCbQ3GuzfNWGA@mail.gmail.com>
References: <cover.1529067662.git.matti.vaittinen@fi.rohmeurope.com> <e6b215db77c8203704c9d1216a9e8747de1b5779.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e6b215db77c8203704c9d1216a9e8747de1b5779.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matti.vaittinen@fi.rohmeurope.com
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Jianhong Chen <chenjh@rock-chips.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Greg KH <gregkh@linuxfoundation.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel@v
List-Id: linux-input@vger.kernel.org

On Fri, Jun 15, 2018 at 3:29 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for two subsystems:
> - clk
> - Regulators
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

This looks like a clean and nice MFD core driver to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
