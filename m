From: Jianhong Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH v6 08/12] gpio: Add GPIO driver for the RK805 PMIC
Date: Wed, 14 Jun 2017 20:11:06 +0800
Message-ID: <e74942d4-2e64-045b-7cb4-ab79af0bc850@rock-chips.com>
References: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com>
 <1496907001-27107-1-git-send-email-chenjh@rock-chips.com>
 <CACRpkdZRKWPgFoM=Owo+EXU3bA_oymn5_3WRS9cuMr3G7Hdi6Q@mail.gmail.com>
 <2451251.ri2bNrhWeM@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <2451251.ri2bNrhWeM@phil>
Sender: linux-gpio-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Tao Huang <huangtao@rock-chips.com>, Alexandre Courbot <gnurou@gmail.com>, zhangqing@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, tony.xie@rock-chips.com, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, w.egorov@phytec.de
List-Id: linux-input@vger.kernel.org



在 2017/6/9 20:17, Heiko Stuebner 写道:
> Hi,
>
> Am Freitag, 9. Juni 2017, 13:37:26 CEST schrieb Linus Walleij:
>> Heiko, can you please look at this patch.
>>
>> On Thu, Jun 8, 2017 at 9:30 AM, Jianhong Chen <chenjh@rock-chips.com> wrote:
>>
>>> From: chenjh <chenjh@rock-chips.com>
>> Full name please.
> git config --global user.name "John Doe"
>
> might do the and make this permanent for all your commits :-)
>
>>> RK805 has two configurable GPIOs that can be used for several
>>> purposes. These are output only.
>>>
>>> This driver is generic for other Rockchip PMICs to be added.
>>>
>>> Signed-off-by: chenjh <chenjh@rock-chips.com>
>> Dito.
>>
>> Your commit message says they are output-only, yet you implement
>> .direction_input(). So what is is going to be?
> So far, I've only seen the rk808 and rk818. Both do not have any
> configurable pins.
>
> The rk805 which is a sort of variant of the above, does have the two
> pins defined below, but in the manual I could also only find them as
> output-only and having no other function than being output-pins.
>
> So I don't really know if all the input- or "gpio-mode"- handling is only
> an oversight (copy'n'paste) or if there are yet other rk808 variants around
> that can actually be configured as inputs or even non-gpio modes?
>
> I hope Jianhong will be able to answer that.
>
>
> Heiko
This driver is not only for rk805, but also intend for rk816 and furtrue 
PMICs.
The rk816 has one multi function pin(TS/GPIO), when setting as gpio, it 
can be configured as output or input.
Here is simple description from manual: "Thermistor input. Connect a 
thermistor from this pin to ground. The thermistor is usually inside the 
battery pack. (multi-function for GPIO) ".

At beginning, I want to name it "gpio-rk8xx.c", but I found rk808 and 
rk818 don't have gpio function. So I abandon this name and use 
"gpio-rk805.c", but still implement
it as a generic driver for furture PMICs to be added.
>>> +#include <linux/i2c.h>
>>> +#include <linux/gpio.h>
>> Only use:
>> #include <linux/gpio/driver.h>
>>
>>> +/*
>>> + * @mode: supported modes for this gpio, i.e. OUTPUT_MODE, OUTPUT_MODE...
>> Are you saying this should be an enum or a set of flags?
Yes, as explain above,  these "OUTPUT_MODE, INPUTOUT" flags are prepared 
for RK816 or furture PMICs.  Maybe these should be enum are better.
>>> +static int rk805_gpio_get(struct gpio_chip *chip, unsigned offset)
>>> +{
>>> +       int ret, val;
>>> +       struct rk805_gpio *gpio = gpiochip_get_data(chip);
>>> +
>>> +       ret = regmap_read(gpio->rk808->regmap, gpio->pins[offset].reg, &val);
>>> +       if (ret) {
>>> +               dev_err(gpio->dev, "gpio%d not support output mode\n", offset);
>>> +               return ret;
>>> +       }
>>> +
>>> +       return (val & gpio->pins[offset].val_msk) ? 1 : 0;
>> Do this:
>>
>> return !!(val & gpio->pins[offset].val_msk)
>>
>>> +static int rk805_gpio_request(struct gpio_chip *chip, unsigned offset)
>>> +{
>>> +       int ret;
>>> +       struct rk805_gpio *gpio = gpiochip_get_data(chip);
>>> +
>>> +       /* switch to gpio mode */
>>> +       if (gpio->pins[offset].func_mask) {
>>> +               ret = regmap_update_bits(gpio->rk808->regmap,
>>> +                                        gpio->pins[offset].reg,
>>> +                                        gpio->pins[offset].func_mask,
>>> +                                        gpio->pins[offset].func_mask);
>>> +               if (ret) {
>>> +                       dev_err(gpio->dev, "set gpio%d func failed\n", offset);
>>> +                       return ret;
>>> +               }
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>> This is pin control. Why don't you implement a proper pin control
>> driver for this chip?
>>
>> If you don't, this will just come back and haunt you.
>>
>> Why not merge the driver into drivers/pinctrl/* and name it
>> pinctrl-rk805.c to begin with?

Becuase I refered to other PMICs, I see most of their gpio driver is 
merged into drivers/gpio/*,  Only a few are added in drivers/pinctrl/*.
So, it is better to merge the driver into drivers/pinctrl/* ?

>>> +static const struct gpio_chip rk805_chip = {
>>> +       .label                  = "rk805-gpio",
>>> +       .owner                  = THIS_MODULE,
>>> +       .direction_input        = rk805_gpio_direction_input,
>>> +       .direction_output       = rk805_gpio_direction_output,
>> Please implement .get_direction()
>>
>>> +       .get                    = rk805_gpio_get,
>>> +       .set                    = rk805_gpio_set,
>>> +       .request                = rk805_gpio_request,
>>> +       .base                   = -1,
>>> +       .ngpio                  = 2,
>>> +       .can_sleep              = true,
>> Consider assigning the .names[] array some pin names.
>>
>> Yours,
>> Linus Walleij
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>>
>
>

-- 
陈健洪
E-mail：chenjh@rock-chips.com
福州瑞芯微电子股份有限公司
Fuzhou Rockchip Electronics Co.Ltd
福建省福州市铜盘路软件大道89号软件园A区21号楼 (350003)
No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
TEL：0591-83991906/07-8573


