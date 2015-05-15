From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: wm831x-on - pass the IRQF_ONESHOT flag
Date: Fri, 15 May 2015 15:59:06 -0700
Message-ID: <20150515225906.GI696@dtor-ws>
References: <1431726191-11466-1-git-send-email-festevam@gmail.com>
 <1431726191-11466-4-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37433 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161046AbbEOW7L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 18:59:11 -0400
Received: by igbsb11 with SMTP id sb11so9523865igb.0
        for <linux-input@vger.kernel.org>; Fri, 15 May 2015 15:59:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431726191-11466-4-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, Julia.Lawall@lip6.fr, Fabio Estevam <fabio.estevam@freescale.com>

On Fri, May 15, 2015 at 06:43:11PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
> bogus threaded irq requests") threaded IRQs without a primary handler
> need to be requested with IRQF_ONESHOT, otherwise the request will fail.
> 
> So pass the IRQF_ONESHOT flag in this case.
> 
> The semantic patch that makes this change is available
> in scripts/coccinelle/misc/irqf_oneshot.cocci.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied all 4, thank you.

> ---
>  drivers/input/misc/wm831x-on.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
> index 59d4f7b..1b44de2 100644
> --- a/drivers/input/misc/wm831x-on.c
> +++ b/drivers/input/misc/wm831x-on.c
> @@ -99,7 +99,8 @@ static int wm831x_on_probe(struct platform_device *pdev)
>  	wm831x_on->dev->dev.parent = &pdev->dev;
>  
>  	ret = request_threaded_irq(irq, NULL, wm831x_on_irq,
> -				   IRQF_TRIGGER_RISING, "wm831x_on",
> +				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +				   "wm831x_on",
>  				   wm831x_on);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Unable to request IRQ: %d\n", ret);
> -- 
> 1.9.1
> 

-- 
Dmitry
