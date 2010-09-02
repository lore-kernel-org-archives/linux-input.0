From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: tps6507x-ts - add missing platform_set_drvdata() in
 tps6507x_ts_probe()
Date: Thu, 2 Sep 2010 08:55:26 -0700
Message-ID: <20100902155525.GB16914@core.coreip.homeip.net>
References: <1283419241.19272.9.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1283419241.19272.9.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Todd Fischer <todd.fischer@ridgerun.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Sep 02, 2010 at 05:20:41PM +0800, Axel Lin wrote:
> We call platform_get_drvdata() in tps6507x_ts_remove(),
> thus we should call platform_set_drvdata() in tps6507x_ts_probe().
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks Axel.

> ---
>  drivers/input/touchscreen/tps6507x-ts.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
> index a644d18..7286209 100644
> --- a/drivers/input/touchscreen/tps6507x-ts.c
> +++ b/drivers/input/touchscreen/tps6507x-ts.c
> @@ -335,6 +335,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>  		dev_err(tsc->dev, "schedule failed");
>  		goto err2;
>  	 }
> +	platform_set_drvdata(pdev, tps6507x_dev);
>  
>  	return 0;
>  
> -- 
> 1.7.2
> 
> 
> 

-- 
Dmitry
