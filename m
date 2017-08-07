From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 08/12] pinctrl: Add pinctrl driver for the RK805 PMIC
Date: Mon, 7 Aug 2017 14:49:14 +0200
Message-ID: <CACRpkdbrDdfU4fxpx2Yb2EFkx2Sw05CWnfK863f3-NwUmg3QQQ@mail.gmail.com>
References: <1501762841-20262-1-git-send-email-chenjh@rock-chips.com> <1501763123-20486-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501763123-20486-1-git-send-email-chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Tony Xie <tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, David Wu <wdc-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 3, 2017 at 2:25 PM, Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:

> RK805 is one of Rockchip PMICs family, it has 2 output only GPIOs.
>
> This driver is also designed for other Rockchip PMICs to expend.
> Different PMIC maybe have different pin features, for example,
> RK816 has one pin which can be used for TS or GPIO(input/out).
> The mainly difference between PMICs pins are pinmux, direction
> and output value, that is 'struct rk805_pin_config'.
>
> Signed-off-by: Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
