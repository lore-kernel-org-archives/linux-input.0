From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: imx_keypad - Fix missing clk conversions
Date: Tue, 4 Sep 2012 23:06:31 -0700
Message-ID: <20120905060631.GB25962@core.coreip.homeip.net>
References: <1346765945-31453-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34956 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2IEGGf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Sep 2012 02:06:35 -0400
Received: by dady13 with SMTP id y13so120798dad.19
        for <linux-input@vger.kernel.org>; Tue, 04 Sep 2012 23:06:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346765945-31453-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org

On Tue, Sep 04, 2012 at 10:39:05AM -0300, Fabio Estevam wrote:
> commit a1e636e6d3 (Input: imx_keypad - adapt the new kpp clock name)
> missed to update clk_enable/clk_disable from imx_keypad_probe().
> 
> Fix it so that we do not get clk warnings at boot.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thank you Fabio.

> ---
> Changes since v1:
> - Add commit id
>  drivers/input/keyboard/imx_keypad.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index ce68e36..cdc2526 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -516,9 +516,9 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
>  	input_set_drvdata(input_dev, keypad);
>  
>  	/* Ensure that the keypad will stay dormant until opened */
> -	clk_enable(keypad->clk);
> +	clk_prepare_enable(keypad->clk);
>  	imx_keypad_inhibit(keypad);
> -	clk_disable(keypad->clk);
> +	clk_disable_unprepare(keypad->clk);
>  
>  	error = request_irq(irq, imx_keypad_irq_handler, 0,
>  			    pdev->name, keypad);
> -- 
> 1.7.9.5
> 
> 

-- 
Dmitry
