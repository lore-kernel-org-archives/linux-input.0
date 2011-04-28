From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: sh_keysc: Switch to threaded IRQ handler
Date: Wed, 27 Apr 2011 23:29:52 -0700
Message-ID: <20110428062952.GF31734@core.coreip.homeip.net>
References: <20110421133824.8698.22092.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110421133824.8698.22092.sendpatchset@t400s>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, simon@horms.net, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 21, 2011 at 10:38:24PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the KEYSC driver to make use of threaded IRQs
> with IRQF_ONESHOT.
> 

Explanation of why this is needed is missing.

Thanks.

> Also pass dev_name() as string for /proc/interrupts.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/input/keyboard/sh_keysc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- 0011/drivers/input/keyboard/sh_keysc.c
> +++ work/drivers/input/keyboard/sh_keysc.c	2011-04-21 19:42:33.000000000 +0900
> @@ -231,7 +231,8 @@ static int __devinit sh_keysc_probe(stru
>  	input->keycodesize = sizeof(pdata->keycodes[0]);
>  	input->keycodemax = ARRAY_SIZE(pdata->keycodes);
>  
> -	error = request_irq(irq, sh_keysc_isr, 0, pdev->name, pdev);
> +	error = request_threaded_irq(irq, NULL, sh_keysc_isr, IRQF_ONESHOT,
> +				     dev_name(&pdev->dev), pdev);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>  		goto err3;

-- 
Dmitry
