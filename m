From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Wed, 28 Feb 2018 13:53:43 +0100
Message-ID: <CACRpkdad4ZYa27Xd73QAsxvhJmBZnFRhDk-10yiitKYSrvxzWQ@mail.gmail.com>
References: <7fc26df245d56fd2014532b56e67630e76e2c513.1518316248.git.baolin.wang@linaro.org>
 <20180219181159.tzbhhvbvpc236qma@rob-hp-laptop> <CAMz4kuL-VZ8XY5-ZLWfXLVXWb4zmxD-aaLQ-ka9M8V83y1B7Ag@mail.gmail.com>
 <CAMz4ku+0uzSDiM3AOnDcnVDqAjoV47nVAK+yQAw2CzgO6Yw-Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4ku+0uzSDiM3AOnDcnVDqAjoV47nVAK+yQAw2CzgO6Yw-Bg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <gregkh@linuxfoundation.org>, stephen lu <lumotuwe@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Joseph Lo <josephl@nvidia.com>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Linux Input <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 26, 2018 at 7:24 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On 21 February 2018 at 19:35, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 20 February 2018 at 02:11, Rob Herring <robh@kernel.org> wrote:

>>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>> index a949404..e3104bd 100644
>>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>> @@ -29,6 +29,8 @@ Optional subnode-properties:
>>>>       - linux,can-disable: Boolean, indicates that button is connected
>>>>         to dedicated (not shared) interrupt which can be disabled to
>>>>         suppress events from the button.
>>>> +     - gpio-key,level-trigger: Boolean, indicates that button's interrupt
>>>> +       type is level trigger. Otherwise it is edge trigger as default.
>>>
>>> No. Just use 'interrupts' instead of 'gpios' and specify the trigger
>>> type. Or put both if you need to read the state.
>>
>> Okay, so something as below to get the level type from the
>> 'interrupts' property.
>> if (fwnode_property_read_u32(child, "interrupts", &button->level_type))
>>         button->level_type = IRQ_TYPE_NONE;
>
> After more thinking, if we use 'interrupts' to indicate the irq type
> for this case, we cannot specify the irq number due to the irq number
> should be get by gpiod_to_irq(). So the device nodes look weird, since
> we should define the index of the interrupt controller instead of the
> irq type if the #interrupt_cells is set to 1 according to the
> interrupt controller documentation. What do you think about this?

I think what you're ultimately seeing is a bad fit between this
GPIO/irq-controller and the Linux gpio keys driver, it doesn't
have very much to do with the device tree bindings.

What I think is appropriate is to try to create a new input driver
in Linux that just takes an interrupt, not a GPIO, and let the
GPIO chip only act as an irqchip for this.

This avoid the complicated step of converting a GPIO to an
interrupt in order to use it, when all you really want to
do is use an interrupt, you don't really care about the
GPIO here, correct?

So we would create
drivers/input/keyboard/interrupt_keys.c
however I suspect a bunch of code would need to be shared
with gpio_keys.c so maybe it is necessary to break out the
parts of gpio_keys.c into its own helper file.

Or maybe even have the
pure interrupt handling as part of gpio_keys.c, i.e. if the
driver can't find any associated GPIO, it goes on to
check if there is an interrupt assigned to the device node
and use that directly instead.

Either way, Dmitry must be involved.

Yours,
Linus Walleij
