From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] generic driver for rotary encoders on GPIOs
Date: Fri, 27 Feb 2009 07:43:14 +0100
Message-ID: <20090227064314.GB32470@buzzloop.caiaq.de>
References: <1235671228-29552-1-git-send-email-daniel@caiaq.de> <1235673764-5540-1-git-send-email-daniel@caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901348F62@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:43528 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbZB0Gn2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 01:43:28 -0500
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901348F62@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Thu, Feb 26, 2009 at 10:18:40PM -0500, hartleys wrote:
> +static struct rotary_encoder_platform_data my_rotary_encoder_info = {
> +	.steps = 24,
> +	.gpio_a = GPIO_ROTARY_A,
> +	.gpio_b = GPIO_ROTARY_B,
> +	.inverted_a = 0,
> +	.inverted_b = 0,
> +};
> +
> +static struct platform_device rotary_encoder_device = {
> +	.name		= "rotary-encoder",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(rotary_encoder_resources),
> +	.resource	= rotary_encoder_resources,
> +	.dev		= {
> +		.platform_data = &my_rotary_encoder_info,
> +	}
> +};
> +
> 
> IRQ_GPIO appears to be only defined for mach-imx and mach-pxa.
> 
> Why not just use the platform_data information to get the irq for the
> gpio at runtime with gpio_to_irq()?

Yes, true. But wouldn't be using the resources only and irq_to_gpio() be
the even cleaner solution?

> +#include <linux/rotary-encoder.h>
> 
> This file is missing in the patch.

Will be added in the next version.

Thanks,
Daniel
