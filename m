From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 12/12] pinctrl: dt-bindings: add bindings for Rockchip
 RK805 PMIC
Date: Thu, 3 Aug 2017 09:42:31 +0200
Message-ID: <CACRpkdYrG1sUcfaP8xVWNKjqWB8jCsZ0yPFjP-DMkT1ni+V37w@mail.gmail.com>
References: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com> <1500635941-12930-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500635941-12930-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joseph Chen <chenjh@rock-chips.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, Tony Xie <tony.xie@rock-chips.com>, zhangqing@rock-chips.com, David Wu <wdc@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, w.egorov@phytec.de, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 21, 2017 at 1:19 PM, Joseph Chen <chenjh@rock-chips.com> wrote:

(...)

> +Following are optional properties defined as pinmux DT binding document
> +<pinctrl-bindings.txt>. Absence of properties will leave the configuration
> +on default.
> +       function,
> +       output-low,
> +       output-high.
> +
> +Valid values for function properties are: gpio.
> +
> +Theres is also not customised properties for any GPIO.
> +
> +Example:
> +--------
> +rk805: rk805@18 {
> +       compatible = "rockchip,rk805";
> +       ...
> +       gpio-controller;
> +       #gpio-cells = <2>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pmic_int_l>, <&rk805_default>;
> +
> +       rk805_default: pinmux {
> +               gpio01 {
> +                       pins = "gpio0", "gpio1";
> +                       function = "gpio";
> +                       output-high.

That should be a semicolon.

With that fixed:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
