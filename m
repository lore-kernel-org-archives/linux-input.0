From: Y Vo <yvo@apm.com>
Subject: Re: [PATCH v0] gpio_keys: fix gpio key driver to proper support GIC interrupt
Date: Mon, 8 Jun 2015 09:48:29 +0700
Message-ID: <CAL4ahLeMm_Qvk0BWxOYTc973_4=TPjZStgTNe5uJL53FBhMRvg@mail.gmail.com>
References: <1433402712-21399-1-git-send-email-yvo@apm.com>
	<2953428.ar7Re29b0L@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <2953428.ar7Re29b0L@wuerfel>
Sender: linux-gpio-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Phong Vo <pvo@apm.com>, Toan Le <toanle@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, patches <patches@apm.com>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 5, 2015 at 7:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 04 June 2015 14:25:12 Y Vo wrote:
>> GIC is designed to support two of trigger mechanisms - active level
>> high or edge rising. But in the gpio_keys driver, it tries to use both
>> edge rising and edge falling trigger. This patch fixes the gpio_keys
>> driver to request only the edge rising event when failed to configure the
>> interrupt.
>>
>> Signed-off-by: Y Vo <yvo@apm.com>
>
> I think you want to use an 'interrupts' property instead of a 'gpios'
> property (or possibly both), so you can pass the right polarity.

        gpio-keys {
                compatible = "gpio-keys";
                apm_ctrl_name = "Power Button";
                btn2 {
                        label = "EXT_INT2";
                        gpios = <&sbgpio 13 0x0>;
                        linux,code = <116>;
                        linux,input-type = <0x1>;     /* EV_KEY */
                };
        };

         sbgpio: sbgpio@17001000{
                        compatible = "apm,xgene-gpio-sb";
                        reg = <0x0 0x17001000 0x0 0x400>;
                        #gpio-cells = <2>;
                        gpio-controller;
                        interrupts =    <0x0 0x28 0x1>,
                                        <0x0 0x29 0x1>,
                                        <0x0 0x2a 0x1>,
                                        <0x0 0x2b 0x1>,
                                        <0x0 0x2c 0x1>,
                                        <0x0 0x2d 0x1>;
                };
I can change the polarity of interrupt in the sbgpio node, but the
issue here is the gpio_key driver always set interrupt type to
(irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING). And the GIC
driver only support edge rising or level high. So that's our issue.

>
>         Arnd
