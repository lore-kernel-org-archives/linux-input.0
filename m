From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] gpiolib: handle probe deferrals better
Date: Fri, 01 Apr 2016 14:16:57 +0200
Message-ID: <1766024.riJEdmHPZI@ws-stein>
References: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:54430 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754808AbcDAMRI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Apr 2016 08:17:08 -0400
In-Reply-To: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, linux-input@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Guenter Roeck <linux@roeck-us.net>

On Friday 01 April 2016 13:44:08, Linus Walleij wrote:
> The gpiolib does not currently return probe deferrals from the
> .to_irq() hook while the GPIO drivers are being initialized.
> Further: it keeps returning -EPROBE_DEFER for gpio[d]_get()
> even after all builtin drivers have initialized.
> 
> Fix this thusly:
> 
> - Move the assignment of .to_irq() to the last step when
>   using gpiolib_irqchip_add() so we can't get spurious calls
>   into the .to_irq() function until all set-up is finished.
> 
> - Put in a late_initcall_sync() to set a boolean state variable to
>   indicate that we're not gonna defer any longer. Since deferred
>   probe happens at late_initcall() time, using late_initcall_sync()
>   should be fine.
> 
> - After this point, return hard errors (-ENXIO) from both
>   gpio[d]_get() and .to_irq().
> 
> This way we should (at least for all drivers using GPIOLIB_IRQCHIP)
> be getting proper deferrals from both gpio[d]_get() and .to_irq()
> until the irqchip side is properly set up, and then proper
> errors after all drivers should have been probed.
> 
> This problem was first seen with gpio-keys.
> 
> Cc: linux-input@vger.kernel.org
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Alexander: please test this, you need Guether's patches too,
> I have it all on my "fixes" branch in the GPIO git:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/log/?h=fi
> xes

I cherry-picked the top most 3 patches:
7f41f039a096a957eaa3e0ef0b040d96e7ad200d
2f126cda38e0614b3e8d211047b18e831b110f82
e6918cd02fd84402311f3fab4b218d9c911e70d6

Unfortunately it does not fix it. At least I do not get an IRQ of 0. After 10 
boots:
4x  gpio-keys user_sw: Unable to get irq number for GPIO 376, error -6
1x  gpio-keys dip: Unable to get irq number for GPIO 352, error -6
5x  ok

user_sw and dip are essientially the same, just different devices in DT with 
different gpiochip parents (MCP23S18 and PCA9555).

I noticed you fiddle with late_initcall_sync. Sorry, I did not mention it: 
gpio_mcp23s08 as well as gpio_keys are loaded as modules, so late_initcall_* 
should not affect it.

Best regards,
Alexander

