From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx6ul_tsc - fix error handling
Date: Wed, 12 Apr 2017 08:43:50 -0700
Message-ID: <20170412154350.GD6297@dtor-ws>
References: <1491996010-19947-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35160 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbdDLPnx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Apr 2017 11:43:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id a188so5804760pfa.2
        for <linux-input@vger.kernel.org>; Wed, 12 Apr 2017 08:43:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1491996010-19947-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: haibo.chen@nxp.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

On Wed, Apr 12, 2017 at 08:20:10AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> If imx6ul_tsc_init() fails we should not return directly.
> 
> We should disable the previously acquired clocks in this case.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/imx6ul_tsc.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
> index 7098e0a..ee82a97 100644
> --- a/drivers/input/touchscreen/imx6ul_tsc.c
> +++ b/drivers/input/touchscreen/imx6ul_tsc.c
> @@ -337,11 +337,20 @@ static int imx6ul_tsc_open(struct input_dev *input_dev)
>  		dev_err(tsc->dev,
>  			"Could not prepare or enable the tsc clock: %d\n",
>  			err);
> -		clk_disable_unprepare(tsc->adc_clk);
> -		return err;
> +		goto disable_adc_clk;
>  	}
>  
> -	return imx6ul_tsc_init(tsc);
> +	err = imx6ul_tsc_init(tsc);
> +	if (err)
> +		goto disable_tsc_clk;
> +
> +	return 0;
> +
> +disable_tsc_clk:
> +	clk_disable_unprepare(tsc->tsc_clk);
> +disable_adc_clk:
> +	clk_disable_unprepare(tsc->adc_clk);
> +	return err;
>  }
>  
>  static void imx6ul_tsc_close(struct input_dev *input_dev)
> -- 
> 2.7.4
> 

-- 
Dmitry
