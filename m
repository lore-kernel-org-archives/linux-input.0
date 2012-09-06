From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] Input: imx_keypad - Fix missing clk conversions
Date: Thu, 6 Sep 2012 09:26:48 +0200
Message-ID: <20120906072648.GP26594@pengutronix.de>
References: <1346765081-30443-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52225 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab2IFH0v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 03:26:51 -0400
Content-Disposition: inline
In-Reply-To: <1346765081-30443-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: dmitry.torokhov@gmail.com, kernel@pengutronix.de, linux-input@vger.kernel.org

On Tue, Sep 04, 2012 at 10:24:41AM -0300, Fabio Estevam wrote:
> commit (Input: imx_keypad - adapt the new kpp clock name) missed to update
> clk_enable/clk_disable from imx_keypad_probe().
> 
> Fix it so that we do not get clk warnings at boot.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> ---
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
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
