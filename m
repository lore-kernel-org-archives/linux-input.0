From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Mon, 8 Feb 2010 12:33:06 +0100
Message-ID: <20100208113306.GN9007@buzzloop.caiaq.de>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
 <f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
 <bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
 <bf0eec9a1002080308v77c9c026j302767e41cd660f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:34222 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0BHLdL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 06:33:11 -0500
Content-Disposition: inline
In-Reply-To: <bf0eec9a1002080308v77c9c026j302767e41cd660f2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jebediah Huang <jebediah.huang@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Feb 08, 2010 at 07:08:06PM +0800, Jebediah Huang wrote:
> Is it correct that max732x driver will take i2c configuration from my
> setup info and make each max7319 input signel into a gpio?
> 
> Hardware work correctly because without max732x driver, above i2c-dev
> code can read max7319 input signel. Configuration is correct.
> 
> gpio_base is starting where max732x driver will add new gpio number
> for max7319 signel.

Yes, that should be right. After the driver is probed successfully, you
should be able to access the GPIOs with generic functions as described
in include/linux/gpio.h. Can you try if that works?

And if you can, you should really hook up an I2C analyzer to your bus
and see what is happening electrically and which messages pass the bus.

> static struct max732x_platform_data max7319_data[] = {
>        [0] = {
>                .gpio_base      =  NR_BUILTIN_GPIO,
>        },
> };
> 
> static struct i2c_board_info i2c_board_info[] =
> {
>        {
>                .type           = "max7319",
>                .addr           = 0x6C,
>                .irq            = IRQ_GPIO(125), <= this is my irq pin
> for max7319 INT_N

I just saw that there is indeed no support for irq line handling in this
driver. In order to use these lines as input for something like the
gpio_keys driver, support for that should be added. I never used this
driver and can't say whether it is under active development.

> Is my understanding wrong?

One thing you should also know is that once the kernel driver is active,
it blocks the address it is configured to, so you can't access the same
address via the userspace API. That might be confusing if you're not
aware of that.

Daniel
