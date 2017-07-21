From: Jianhong Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH v6 08/12] gpio: Add GPIO driver for the RK805 PMIC
Date: Fri, 21 Jul 2017 10:00:29 +0800
Message-ID: <67c2e8bb-dadd-faa3-dcd0-0f325b3cbfce@rock-chips.com>
References: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com>
 <2451251.ri2bNrhWeM@phil>
 <e74942d4-2e64-045b-7cb4-ab79af0bc850@rock-chips.com>
 <1617153.S9fhFArdpW@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:44881 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964809AbdGUB6p (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Jul 2017 21:58:45 -0400
In-Reply-To: <1617153.S9fhFArdpW@diego>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Tao Huang <huangtao@rock-chips.com>, Alexandre Courbot <gnurou@gmail.com>, zhangqing@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, tony.xie@rock-chips.com, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, w.egorov@phytec.de



在 2017/6/29 18:29, Heiko Stübner 写道:

> Hi,
>
> Am Mittwoch, 14. Juni 2017, 20:11:06 CEST schrieb Jianhong Chen:
>> 在 2017/6/9 20:17, Heiko Stuebner 写道:
>>> Am Freitag, 9. Juni 2017, 13:37:26 CEST schrieb Linus Walleij:
>>>> Heiko, can you please look at this patch.
>>>>
>>>> On Thu, Jun 8, 2017 at 9:30 AM, Jianhong Chen <chenjh@rock-chips.com>
> wrote:
>>>>> From: chenjh <chenjh@rock-chips.com>
>>>> Full name please.
>>> git config --global user.name "John Doe"
>>>
>>> might do the and make this permanent for all your commits :-)
>>>
>>>>> RK805 has two configurable GPIOs that can be used for several
>>>>> purposes. These are output only.
>>>>>
>>>>> This driver is generic for other Rockchip PMICs to be added.
>>>>>
>>>>> Signed-off-by: chenjh <chenjh@rock-chips.com>
>>>> Dito.
>>>>
>>>> Your commit message says they are output-only, yet you implement
>>>> .direction_input(). So what is is going to be?
>>> So far, I've only seen the rk808 and rk818. Both do not have any
>>> configurable pins.
>>>
>>> The rk805 which is a sort of variant of the above, does have the two
>>> pins defined below, but in the manual I could also only find them as
>>> output-only and having no other function than being output-pins.
>>>
>>> So I don't really know if all the input- or "gpio-mode"- handling is only
>>> an oversight (copy'n'paste) or if there are yet other rk808 variants
>>> around
>>> that can actually be configured as inputs or even non-gpio modes?
>>>
>>> I hope Jianhong will be able to answer that.
>>>
>>>
>>> Heiko
>> This driver is not only for rk805, but also intend for rk816 and furtrue
>> PMICs.
>> The rk816 has one multi function pin(TS/GPIO), when setting as gpio, it
>> can be configured as output or input.
>> Here is simple description from manual: "Thermistor input. Connect a
>> thermistor from this pin to ground. The thermistor is usually inside the
>> battery pack. (multi-function for GPIO) ".
> As Linus suggested, this sounds like you want a pinctrl driver that
> also handles the gpios.
>
> Ideally you might also directly provide support for this rk816 in the
> same patch series, so reviewers can see the full extend of what is
> supported.
>
>
> Heiko
>

Hi, Heiko:

      I have moved gpio-rk805.c to drivers/pinctrl/pinctrl-rk805.c, this 
driver is also designed for rk816 or furture PMICs to extend.
      RK816 is not in our team's plan at this porting, it will be added 
at next time, so I don't directly provide rk816 in this driver. I will 
add more descriptions in commit message to express my design purpose.

      Are you agreed ?  If so, I will send [PATCH v7] today.


-- 
Best Regards
----------------------------------------------------------------------------
陈健洪 (Joseph Chen)
E-mail：chenjh@rock-chips.com
福州瑞芯微电子股份有限公司
Fuzhou Rockchip Electronics Co.Ltd
福建省福州市铜盘路软件大道89号软件园A区21号楼 (350003)
No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
TEL：0591-83991906/07-8573


