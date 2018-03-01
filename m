From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Thu, 1 Mar 2018 14:09:06 +0200
Message-ID: <CAHp75VcgUmOoo-jRbM-Gyp1JTY-2rJri8e7u2miYSvRM_4HmPg@mail.gmail.com>
References: <9ea2faf9c1cf8439f3a8ad495c6a2b49dacad7bd.1519889208.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9ea2faf9c1cf8439f3a8ad495c6a2b49dacad7bd.1519889208.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stephen lu <lumotuwe@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Joseph Lo <josephl@nvidia.com>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, linux-input <linux-input@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 1, 2018 at 9:36 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On some platforms (such as Spreadtrum platform), the GPIO keys can only
> be triggered by level type. So this patch introduces one trigger_type to
> indicate if the button's interrupt type is level trigger or edge trigger.

>                         button->irq =
>                                 irq_of_parse_and_map(to_of_node(child), 0);

AFAIU, 0 means NO_IRQ, thus,

> +                       if (button->irq)
> +                               button->trigger_type =
> +                                       irq_get_trigger_type(button->irq);

irq_get_trigger_type(NO_IRQ) should return 0.

Therefore, if (button->irq) is redundant.
Did I miss anything?

-- 
With Best Regards,
Andy Shevchenko
