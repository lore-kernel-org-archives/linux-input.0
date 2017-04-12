From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: lpc32xx_ts - check for clk_prepare_enable() error
Date: Wed, 12 Apr 2017 08:44:00 -0700
Message-ID: <20170412154400.GE6297@dtor-ws>
References: <1491996563-23095-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33102 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdDLPoD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Apr 2017 11:44:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id c198so5827909pfc.0
        for <linux-input@vger.kernel.org>; Wed, 12 Apr 2017 08:44:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1491996563-23095-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: vz@mleia.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

On Wed, Apr 12, 2017 at 08:29:23AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> clk_prepare_enable() may fail, so we better check its return value and
> propagate it in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/lpc32xx_ts.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
> index e0baa7d..4eb31ec 100644
> --- a/drivers/input/touchscreen/lpc32xx_ts.c
> +++ b/drivers/input/touchscreen/lpc32xx_ts.c
> @@ -142,11 +142,14 @@ static void lpc32xx_stop_tsc(struct lpc32xx_tsc *tsc)
>  	clk_disable_unprepare(tsc->clk);
>  }
>  
> -static void lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
> +static int lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
>  {
>  	u32 tmp;
> +	int err;
>  
> -	clk_prepare_enable(tsc->clk);
> +	err = clk_prepare_enable(tsc->clk);
> +	if (err)
> +		return err;
>  
>  	tmp = tsc_readl(tsc, LPC32XX_TSC_CON) & ~LPC32XX_TSC_ADCCON_POWER_UP;
>  
> @@ -184,15 +187,15 @@ static void lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
>  
>  	/* Enable automatic ts event capture */
>  	tsc_writel(tsc, LPC32XX_TSC_CON, tmp | LPC32XX_TSC_ADCCON_AUTO_EN);
> +
> +	return 0;
>  }
>  
>  static int lpc32xx_ts_open(struct input_dev *dev)
>  {
>  	struct lpc32xx_tsc *tsc = input_get_drvdata(dev);
>  
> -	lpc32xx_setup_tsc(tsc);
> -
> -	return 0;
> +	return lpc32xx_setup_tsc(tsc);
>  }
>  
>  static void lpc32xx_ts_close(struct input_dev *dev)
> -- 
> 2.7.4
> 

-- 
Dmitry
