From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 04/12] input: matrix-keypad: push/pull, separate polarity
Date: Fri, 28 Jun 2013 09:01:13 -0600
Message-ID: <51CDA539.1020405@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-5-git-send-email-gsi@denx.de> <51C4C6C9.6030000@wwwdotorg.org> <20130622093649.GF24305@book.gsilab.sittig.org> <51C8D2BC.9010507@wwwdotorg.org> <20130628083354.GW24305@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51780 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab3F1PBO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 11:01:14 -0400
In-Reply-To: <20130628083354.GW24305@book.gsilab.sittig.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/28/2013 02:33 AM, Gerhard Sittig wrote:
> On Mon, Jun 24, 2013 at 17:14 -0600, Stephen Warren wrote:
>>
>> [ active low pins, individually for sets or even single pins ]
>>
>> Can't you add this enhancement as follows:
>>
>> Update the driver to look at the per-pin GPIO flags in all cases.
>> Presumably in any existing cases, those flags all say "active high"
>> anyway, since specifying anything else was useless. In the very unlikely
>> case this isn't true, one could always add a quirk based on the
>> HW-specific compatible value.
> 
> Maybe I missed something, but
> - is "the 'active low' property of a GPIO pin" something platform
>   specific? (maybe ARM inspired, introduced with pinctrl features)
> - is it only available for specific GPIO controller drivers
>   ("chips" or "banks"), or is it in some layer on top of gpiolib?

The way this property is represented is technically defined by each
individual GPIO controller's DT binding. However, at least on ARM (and
in fact I'd guess everywhere), many/most controllers do this in the same
way; by adding an additional cell to #gpio-cells, which holds flags
data, with values in that cell containing:

include/linux/of_gpio.h:

> /*
>  * This is Linux-specific flags. By default controllers' and Linux' mapping
>  * match, but GPIO controllers are free to translate their own flags to
>  * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
>  */
> enum of_gpio_flags {
>         OF_GPIO_ACTIVE_LOW = 0x1,
> };

include/dt-bindings/gpio/gpio.h:

> #define GPIO_ACTIVE_HIGH 0
> #define GPIO_ACTIVE_LOW 1

I'm not sure how new this is; it's possible older bindings don't have
this extra cell. A quick grep of arch/*/boot/dts shows that almost all
values of #gpio-cells are 2, so likely this is almost everywhere though.

> - is it in some other tree or branch than mainline?

It's been in mainline for quite a while now; a good number of kernel
releases.

> Documentation/gpio.txt suggests and eyeballing the gpiolib.c
> source supports (v3.10-rc7) that the in-kernel API doesn't have
> an 'active-low' for pins.  There is one for the sysfs API and
> pins that were exported to user space, but not for in-kernel use.
> 
> This fits with my observation that application drivers on top of
> gpiolib often take care of such a property which actually looks
> like it would belong to the physical attachment.
> 
> I understand that a chip's driver will hide when a SoC's pin is
> inverted, but I cannot see where gpiolib provides a means to hide
> an externally connected inverting driver.

With the current gpiolib APIs, gpiolib only provides a way for GPIO
clients to retrieve the GPIO flags from DT. It's then up to the GPIO
client to actually make use of the flag, by inverting the value passed
to gpio_set(), or returned from gpio_get().

Flags are retrieved by calling of_get_named_gpio_flags() rather than
of_get_named_gpio().

There is a new GPIO API under development which I /think/ will hide this
flag inside the GPIO core, so that GPIO clients don't have to care about
it, and it all works automatically. I'm not sure what the status of this
is though. Search Google for "gpio_get()".
