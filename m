From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Wed, 28 Feb 2018 15:44:18 +0100
Message-ID: <CAK8P3a1v2GanneaFKpXWjWLt1YzibJ9Bh7vUcd_SH-4jGN_1+A@mail.gmail.com>
References: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, gregkh <gregkh@linuxfoundation.org>, lumotuwe@gmail.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, josephl@nvidia.com, kstewart@linuxfoundation.org, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 28, 2018 at 1:44 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On some platforms (such as Spreadtrum platform), the GPIO keys can only
> be triggered by level type. So this patch introduces one property to
> indicate if the GPIO trigger type is level trigger or edge trigger.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v2:
>  - Use 'interrupt' property to indicate the irq type.
>
> Changes since v1:
>  - Diable the GPIO irq until reversing the GPIO level type.

I've looked at your patch in more detail now, and given it a bit more thought.

I wonder if you could move that logic into your gpiochip/irqchip driver instead.
It seems that what you do in the gpio-keys driver is to emulate edge triggered
behavior on a level triggered irqchip.

If you put the same logic into the gpio driver, you could simply make it
pretend to support an edge trigger on both edges and call into the interrupt
handler whenever the state changes.

        Arnd
