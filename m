From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad - check for clk_prepare_enable() error
Date: Mon, 22 Jun 2015 09:23:03 -0700
Message-ID: <20150622162303.GA2350@dtor-ws>
References: <1434945678-8027-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33955 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbbFVQXH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2015 12:23:07 -0400
Received: by iebmu5 with SMTP id mu5so118557461ieb.1
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2015 09:23:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434945678-8027-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Mon, Jun 22, 2015 at 01:01:18AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> clk_prepare_enable() may fail, so we should better check its return value
> and propagate it in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/imx_keypad.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index 2e855e6..d2ea863 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -506,7 +506,9 @@ static int imx_keypad_probe(struct platform_device *pdev)
>  	input_set_drvdata(input_dev, keypad);
>  
>  	/* Ensure that the keypad will stay dormant until opened */
> -	clk_prepare_enable(keypad->clk);
> +	error = clk_prepare_enable(keypad->clk);
> +	if (error)
> +		return error;
>  	imx_keypad_inhibit(keypad);
>  	clk_disable_unprepare(keypad->clk);
>  
> -- 
> 1.9.1
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
