From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 2/12] pxa: remove the pin configuration from the keypad driver
Date: Tue, 29 Jan 2008 01:24:56 -0500
Message-ID: <200801290124.56565.dtor@insightbb.com>
References: <f17812d70801222317k641d55fy8f94c436770a8b0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxsf07.insightbb.com ([74.128.0.77]:21452 "EHLO
	mxsf07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYA2GY7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jan 2008 01:24:59 -0500
In-Reply-To: <f17812d70801222317k641d55fy8f94c436770a8b0a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: eric miao <eric.y.miao@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Eric,

On Wednesday 23 January 2008 02:17, eric miao wrote:
> From dbd62bced0f789765d1823f66af792933c6b46a1 Mon Sep 17 00:00:00 2001
> From: eric miao <eric.miao@marvell.com>
> Date: Tue, 22 Jan 2008 16:34:12 +0800
> Subject: [PATCH] pxa: remove the pin configuration from the keypad driver
> 
> The pin configurations will slowly be moved to the board specific code
> at initialization thus to make the driver more generic.
> 
> Signed-off-by: eric miao <eric.miao@marvell.com>
> ---
>  drivers/input/keyboard/pxa27x_keypad.c   |    4 ----
>  include/asm-arm/arch-pxa/pxa27x_keypad.h |    1 -
>  2 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c
> b/drivers/input/keyboard/pxa27x_keypad.c
> index 06c1d5a..43fb63d 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -208,10 +208,6 @@ static int __devinit pxa27x_keypad_probe(struct
> platform_device *pdev)
>  	if (error)
>  		goto err_free_irq;
> 
> -	/* Setup GPIOs. */
> -	for (i = 0; i < pdata->nr_rows + pdata->nr_cols; i++)
> -		pxa_gpio_mode(pdata->gpio_modes[i]);
> -

That would require GPIO code to be replicated in every subarch piece. Do you
expect many boards require special GPIO setup or maybe it would make sense
to keep something similar to the code above (possibly have pointer to array
of gpio modes and array size in pdata)? This way simpler boards will just
supply the list and more complex setups can still do it themselves?

-- 
Dmitry
