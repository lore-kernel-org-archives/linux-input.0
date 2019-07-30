From: Yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] Input: applespi - Fix build error
Date: Tue, 30 Jul 2019 15:22:43 +0800
Message-ID: <59344451-4752-8610-22cd-2aa9b34e21ed@huawei.com>
References: <20190729031455.59400-1-yuehaibing@huawei.com>
 <20190729140438.GA2372@penguin> <20190730070117.GB20206@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730070117.GB20206@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nikolas@gnu.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2019/7/30 15:01, Life is hard, and then you die wrote:
> 
> On Mon, Jul 29, 2019 at 04:04:38PM +0200, Dmitry Torokhov wrote:
>> On Mon, Jul 29, 2019 at 11:14:55AM +0800, YueHaibing wrote:
>>> If CONFIG_KEYBOARD_APPLESPI=y but CONFIG_LEDS_CLASS=m
>>> building fails:
>>>
>>> drivers/input/keyboard/applespi.o: In function `applespi_probe':
>>> applespi.c:(.text+0x1fcd): undefined reference to `devm_led_classdev_register_ext'
>>>
>>> Wrap it in LEDS_CLASS macro to fix this.
>>
>> No, we should add "depends on LEDS_CLASS" to the Konfig instead.
> 
> While the loss of keyboard-backlight functionality is certainly not
> critical, in practice when building a kernel for desktops/laptops
> (i.e. where this module would be used) I see no real reason why you'd
> not have/want LEDS_CLASS enabled. So I'd agree with Dmitry that a
> Kconfig depends-on is probably the preferred approach.

Thanks, will send v2 as suggestion.

> 
> 
>   Cheers,
> 
>   Ronald
> 
> 
> .
> 
