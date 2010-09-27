From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH] keyboard: tnetv107x: fix input_device leak
Date: Mon, 27 Sep 2010 10:55:24 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF0594C8@dbde02.ent.ti.com>
References: <1285491584-32664-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49579 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab0I0FZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Sep 2010 01:25:31 -0400
In-Reply-To: <1285491584-32664-1-git-send-email-segooon@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vasiliy Kulikov <segooon@gmail.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Chemparathy, Cyril" <cyril@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-
> owner@vger.kernel.org] On Behalf Of Vasiliy Kulikov
> Sent: Sunday, September 26, 2010 2:30 PM
> To: kernel-janitors@vger.kernel.org
> Cc: Dmitry Torokhov; Chemparathy, Cyril; Kevin Hilman; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] keyboard: tnetv107x: fix input_device leak
> 
> keypad_probe() calls input_free_device() on error, but keypad_remove()
> doesn't.
> ---
>  Compile tested.
> 
>  drivers/input/keyboard/tnetv107x-keypad.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tnetv107x-keypad.c
> b/drivers/input/keyboard/tnetv107x-keypad.c
> index b4a81eb..1ea20e1 100644
> --- a/drivers/input/keyboard/tnetv107x-keypad.c
> +++ b/drivers/input/keyboard/tnetv107x-keypad.c
> @@ -305,6 +305,7 @@ static int __devexit keypad_remove(struct
> platform_device *pdev)
>  	free_irq(kp->irq_press, kp);
>  	free_irq(kp->irq_release, kp);
>  	input_unregister_device(kp->input_dev);
> +	input_free_device(kp->input_dev);
It does not seem to be correct.

>  	clk_put(kp->clk);
>  	iounmap(kp->regs);
>  	release_mem_region(kp->res->start, resource_size(kp->res));
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
